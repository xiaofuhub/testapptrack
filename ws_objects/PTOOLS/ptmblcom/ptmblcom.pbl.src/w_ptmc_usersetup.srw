$PBExportHeader$w_ptmc_usersetup.srw
forward
global type w_ptmc_usersetup from w_sheet
end type
type mle_instruct from multilineedit within w_ptmc_usersetup
end type
type cb_save from u_cb within w_ptmc_usersetup
end type
type dw_list from u_dw within w_ptmc_usersetup
end type
end forward

global type w_ptmc_usersetup from w_sheet
integer width = 3323
integer height = 1884
string title = "PT Mobile User Setup"
string menuname = "m_sheets"
long backcolor = 12632256
mle_instruct mle_instruct
cb_save cb_save
dw_list dw_list
end type
global w_ptmc_usersetup w_ptmc_usersetup

event open;call super::open;Long		ll_Retrieve

//	Check the Licensing
n_cst_LicenseManager lnv_LicenseManager 
IF NOT lnv_LicenseManager.of_HasNextelLicense ( ) THEN
	//OK
	ib_DisableCloseQuery = TRUE
	close (this)
	return
END IF

gf_Mask_Menu ( m_Sheets )


This.of_SetResize ( TRUE )

//Set size so that proper alignment will be kept when opening as layered (full screen)
inv_Resize.of_SetOrigSize ( This.Width - 16, This.Height - 144 )

inv_resize.of_SetMinSize(1300, 400)
inv_resize.of_Register (dw_List, 'ScaleToRight&Bottom')
inv_resize.of_Register (cb_Save, 'FixedToRight')


dw_List.SetTransObject ( SQLCA )
ll_Retrieve = dw_List.Retrieve ( )
COMMIT ;


IF ll_Retrieve >= 0 THEN
	//OK
ELSE
	MessageBox ( This.Title, "Error retrieving setup data." )
END IF
end event

on w_ptmc_usersetup.create
int iCurrent
call super::create
if this.MenuName = "m_sheets" then this.MenuID = create m_sheets
this.mle_instruct=create mle_instruct
this.cb_save=create cb_save
this.dw_list=create dw_list
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.mle_instruct
this.Control[iCurrent+2]=this.cb_save
this.Control[iCurrent+3]=this.dw_list
end on

on w_ptmc_usersetup.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mle_instruct)
destroy(this.cb_save)
destroy(this.dw_list)
end on

type mle_instruct from multilineedit within w_ptmc_usersetup
integer x = 46
integer y = 36
integer width = 2633
integer height = 404
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "To create a mobile login for a driver, specify UID and PWD.  If you specify UID and leave PWD blank, the last 4 digits of the driver~'s SSN will be used as the PWD.  Existing PWD~'s do not display in the list.  If you change a UID, you must specify the PWD again, just like you were setting up the login for the first time.  To revoke a login, clear the UID field for that driver.  Logins are revoked automatically if you deactivate a driver, so only active drivers are shown in the list."
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type cb_save from u_cb within w_ptmc_usersetup
integer x = 2743
integer y = 36
integer width = 503
integer taborder = 20
string text = "&Save Changes"
end type

event clicked;call super::clicked;//Parent.Event pt_Save ( )

Parent.Event pfc_Save ( )
end event

type dw_list from u_dw within w_ptmc_usersetup
integer x = 46
integer y = 468
integer width = 3200
integer height = 1204
integer taborder = 10
string dataobject = "d_ptmc_usersetup"
boolean hscrollbar = true
end type

event pfc_update;//Overriding ancestor.  The datawindow object is not updateable.  There are scripts that have to be
//executed in dynamic SQL based on the user's changes.

Long		ll_RowCount, &
			ll_ModifiedCount, &
			ll_Row, &
			ll_DriverId, &
			ll_SkippedCount

String	ls_UID_Original, &
			ls_UID, &
			ls_PWD_Original, &
			ls_PWD, &
			ls_SQL, &
			ls_LastName, &
			ls_DisplayRef, &
			ls_SkippedList, &
			ls_Null, &
			ls_SQLErrText
Boolean	lb_Revoke, &
			lb_Grant, &
			lb_NewGrant, &
			lb_RowProcessed
Integer	li_SQLCode

Integer	li_Return = 1

SetNull ( ls_Null )

ll_RowCount = This.RowCount ( )
ll_ModifiedCount = This.ModifiedCount ( )


IF ll_ModifiedCount > 0 THEN
	
	//If there are rows in the filter, unfilter them, so we can access the data more readily.
	
	IF This.FilteredCount ( ) > 0 THEN
		This.SetFilter ( "" )
		This.Filter ( )
		This.Sort ( )
	END IF
	

	DO

		//Clear the flags for the various actions we may need to perform.  These will be conditionally set below,
		//and then processed at the bottom of the loop.
		lb_Revoke = FALSE
		lb_Grant = FALSE
		lb_NewGrant = FALSE
		
		ll_Row = This.GetNextModified ( ll_Row, Primary! )
		
		IF ll_Row > 0 THEN
			
			ls_UID_Original = This.GetItemString ( ll_Row, "MobileUID", Primary!, TRUE /*Original Value*/ )
			ls_UID = Trim ( This.GetItemString ( ll_Row, "MobileUID", Primary!, FALSE /*Current Value*/ ) )
			
			ls_PWD_Original = This.GetItemString ( ll_Row, "MobilePWD", Primary!, TRUE /*Original Value*/ )
			ls_PWD = Trim ( This.GetItemString ( ll_Row, "MobilePWD", Primary!, FALSE /*Current Value*/ ) )
			
			ll_DriverId = This.GetItemNumber ( ll_Row, "employees_em_id" )
			
			
			//Build the ls_DisplayRef string, which will be used to refer to this driver if any messages have to be issued
			
			ls_LastName = This.Object.employees_em_ln [ ll_Row ]
			
			IF IsNull ( ls_LastName ) THEN
				ls_LastName = ""
			END IF
			
			ls_DisplayRef = ls_LastName + " (" + ls_UID + ")"
			
			
			
			IF IsNull ( ls_UID ) OR ls_UID = "" THEN
				
				IF ls_UID_Original > "" THEN
					
					lb_Revoke = TRUE
					
				END IF
				
			ELSE
				
				//We have a legitimate UID.  See if we have a legitimate PWD.
				
				IF ls_PWD > "" THEN
					//OK, user has specified a PWD
				ELSE
					
					//User has not specified a PWD.  We'll use the last 4 digits of the driver's SSN (if that's on file)
					
					ls_PWD = Trim ( This.GetItemString ( ll_Row, "Last4Digits" ) )
					
					IF Len ( ls_Pwd ) = 4 THEN
						//OK, use it
					ELSE
						
						ll_SkippedCount ++
						ls_SkippedList += ls_DisplayRef + "~n"
						
						CONTINUE
						
					END IF
					
				END IF
					
				
				
				IF ls_UID_Original > "" THEN
					
					IF ls_UID_Original = ls_UID THEN
						
						//User already exists, just changing PWD, not changing UID
						lb_Grant = TRUE
						
					ELSE
						
						//Changing UID.  Need to revoke old login and grant new one.
						lb_Revoke = TRUE
						lb_Grant = TRUE
						lb_NewGrant = TRUE
						
					END IF
					
				ELSE
					
					//Creating a login for a driver that did not have one before.
				
					lb_Grant = TRUE
					lb_NewGrant = TRUE
					
				END IF
		
		
			END IF


			lb_RowProcessed = TRUE

			IF lb_Revoke AND lb_RowProcessed THEN   //If lb_RowProcessed is ok so far...
				
				//REVOKE CONNECT deletes the User from the DB
				
				ls_SQL = "REVOKE CONNECT FROM ~"" + ls_UID_Original + "~"" 
				EXECUTE IMMEDIATE :ls_SQL ;

				li_SQLCode = SQLCA.SqlCode
				ls_SQLErrText = SQLCA.SQLErrText
				COMMIT ;
				
				IF li_SqlCode <> 0 THEN
					lb_RowProcessed = FALSE
					li_Return = -1
					MessageBox ( "Save Changes", "Could not revoke login " + ls_UID_Original + " for driver " + ls_LastName +&
						".~n~nThe database error message is:~n~n" + ls_SQLErrText, Exclamation! )
				END IF
				
			END IF
			
			IF lb_Grant AND lb_RowProcessed THEN   //If lb_RowProcessed is ok so far...
				
				//Note: GRANT CONNECT to a UID that already exists just changes the PWD for that user.
				
				ls_SQL = "GRANT CONNECT TO ~"" + ls_UID + "~" IDENTIFIED BY ~"" + ls_PWD + "~""
				EXECUTE IMMEDIATE :ls_SQL ;
				
				
				li_SQLCode = SQLCA.SqlCode
				ls_SQLErrText = SQLCA.SQLErrText
				COMMIT ;
				
				IF li_SqlCode <> 0 THEN
					lb_RowProcessed = FALSE
					li_Return = -1
					MessageBox ( "Save Changes", "Could not create login " + ls_UID + " for driver " + ls_LastName +&
						".~n~nThe database error message is:~n~n" + ls_SQLErrText, Exclamation! )
				END IF
				
				
				IF lb_NewGrant = TRUE AND lb_RowProcessed THEN   //If lb_RowProcessed is ok so far...
				
					//The DRIVERS group has the privileges to access the ptsp_MC_ stored procedures,
					//that serve up the mobile data pages.
					
					ls_SQL = "GRANT MEMBERSHIP IN GROUP DRIVERS TO ~"" + ls_UID + "~""
					EXECUTE IMMEDIATE :ls_SQL ;
					
					
					li_SQLCode = SQLCA.SqlCode
					ls_SQLErrText = SQLCA.SQLErrText
					COMMIT ;
					
					IF li_SqlCode = 0 THEN
						
						//The EmpId tag in the comment is read by the mobile system to know what employee the UID refers to.
						
						ls_SQL = "COMMENT ON USER ~"" + ls_UID + "~" IS 'EmpId=" + String ( ll_DriverId ) + "'"
						EXECUTE IMMEDIATE :ls_SQL ;
						
						li_SQLCode = SQLCA.SqlCode
						ls_SQLErrText = SQLCA.SQLErrText
						COMMIT ;

						IF li_SQLCode <> 0 THEN

							//We will leave lb_RowProcessed = TRUE since the login was in fact created, so that the user can attempt to revoke it.
							li_Return = -1
							MessageBox ( "Save Changes", "Could not assign Empid tag for driver " + ls_DisplayRef +&
								".  The driver's login UID was created, but will not be able to access the mobile functions.  "+&
								"Please revoke this login by clearing the UID and saving changes.  Then try creating the login "+&
								"again.~n~nThe database error message is:~n~n" + ls_SQLErrText, Exclamation! )
								
						END IF

					ELSE
						
						//We will leave lb_RowProcessed = TRUE since the login was in fact created, so that the user can attempt to revoke it.
						li_Return = -1
						MessageBox ( "Save Changes", "Could not assign group privileges for driver " + ls_DisplayRef +&
							".  The driver's login UID was created, but will not be able to access the mobile functions.  "+&
							"Please revoke this login by clearing the UID and saving changes.  Then try creating the login "+&
							"again.~n~nThe database error message is:~n~n" + ls_SQLErrText, Exclamation! )
					END IF
					
				END IF
				
			END IF
			

			//If successful then clear the PWD (as it would be if it were freshly retrieved) and set the modified 
			//status for the row to NotModified!
			
			IF lb_RowProcessed THEN
			
				This.SetItem ( ll_Row, "MobilePWD", ls_Null )
				This.SetItemStatus ( ll_Row, 0, Primary!, NotModified! )
				
			END IF
		
		END IF
	
	LOOP WHILE ll_Row > 0
	

	IF ll_SkippedCount > 0 THEN
		
		li_Return = -1
		MessageBox ( "Save Changes", "Logins were not created for the following " + String ( ll_SkippedCount ) +&
			" driver(s) because a PWD was not specified and the SSN for the employee was not available:~n~n" +&
			ls_SkippedList )
		
	END IF
	
END IF


// Couldn't get this to work....   Setting null as the message did not stop the message for this or the version below.
// Clear the error message variable.
//n_cst_dberrorattrib lnv_dberrorattrib
//lnv_dberrorattrib.is_errormsg = "Text"
//of_SetDBErrorMsg(lnv_dberrorattrib)

//I couldn't figure out how to make it NOT display the Red-X dberror processing message,
//so I'm going to display this message, so it's not just a blank box.  Maybe not an entirely bad thing...
Parent.of_SetDBErrorMsg ( "Not all requested changes were applied." )

RETURN li_Return
end event

event constructor;call super::constructor;//Set flags to take the Insert and Delete options out of the right mouse menu
This.of_SetInsertable ( FALSE )
This.of_SetDeleteable ( FALSE )
end event

