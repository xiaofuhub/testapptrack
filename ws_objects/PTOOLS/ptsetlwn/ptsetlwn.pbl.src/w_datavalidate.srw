$PBExportHeader$w_datavalidate.srw
forward
global type w_datavalidate from w_response
end type
type dw_statereport from datawindow within w_datavalidate
end type
type mle_instruct from u_mle within w_datavalidate
end type
type cb_3 from u_cbcancel within w_datavalidate
end type
type sle_total from u_sle within w_datavalidate
end type
type sle_oddiff from u_sle within w_datavalidate
end type
type sle_percentdiff from u_sle within w_datavalidate
end type
type st_1 from statictext within w_datavalidate
end type
type st_2 from statictext within w_datavalidate
end type
type st_3 from statictext within w_datavalidate
end type
type dw_tripreport from u_dw within w_datavalidate
end type
type cb_1 from u_cb within w_datavalidate
end type
end forward

global type w_datavalidate from w_response
int X=293
int Y=300
int Width=2606
int Height=1556
boolean TitleBar=true
string Title="Mileage Reports"
dw_statereport dw_statereport
mle_instruct mle_instruct
cb_3 cb_3
sle_total sle_total
sle_oddiff sle_oddiff
sle_percentdiff sle_percentdiff
st_1 st_1
st_2 st_2
st_3 st_3
dw_tripreport dw_tripreport
cb_1 cb_1
end type
global w_datavalidate w_datavalidate

type variables
Private:
n_cst_msg     inv_msg
datastore   ids_itin_quick

end variables

forward prototypes
public function integer wf_writefile (long al_id, string as_orig, string as_dest, date ad_min, date ad_max)
end prototypes

public function integer wf_writefile (long al_id, string as_orig, string as_dest, date ad_min, date ad_max);

Int 		li_FileNo
String	ls_StateList
String 	ls_OutPut
String 	ls_State
String	ls_Total
String	ls_Toll
String  	ls_NonToll
String	ls_TruckID
String 	ls_PCMMileage
String 	ls_PathName   
String 	ls_FileName 
String 	ls_CalcDiff
String	ls_CancelWarning
String	ls_Orig
String	ls_Dest
Long    	ll_NumRows
Long 		i
Long		ll_ID
Boolean 	lb_Adjustment = FALSE
Date		ld_StartDate
Date		ld_EndDate



Int		li_ReturnValue = 1



ls_Orig 		= as_Orig
ls_Dest 		= as_Dest
ld_StartDate	= ad_Min
ld_EndDate		= ad_Max
ll_id			= al_id



n_cst_EquipmentManager	lnv_EquipmentMgr

s_Parm lstr_Parm

s_eq_Info 			lstr_Equipment
pfc_n_cst_string 	lnv_string
n_cst_File			lnv_File

n_cst_OFRError_Collection lnv_ErrorCollection
n_cst_OFRError lnv_ErrorArray[]
n_cst_OFRError lnv_Error
string	ls_ErrorMessage
ls_ErrorMessage = "An unexpected error occurred while attempting to write the fuel tax file."


DataStore	lds_Source
IF inv_msg.of_get_Parm("STATEREPORT", lstr_parm ) <> 0 THEN
	lds_Source = lstr_Parm.ia_Value
ELSE 
	li_ReturnValue  = -1
END IF


IF NOT isValid (lds_Source) THEN
	
	li_ReturnValue = -1
END IF


IF li_ReturnValue = 1 THEN  //(1)
	
	If lnv_EquipmentMgr.of_Get_Info(ll_ID,lstr_Equipment,FALSE) = 1 THEN //(2)
	//	ls_CancelWarning = "Canceling file create will abandon fuel tax export."	
		ls_PathName = String(ld_startdate,"mmdd")+string(ld_enddate,"mmdd")
		
		IF lnv_File.of_getFileSaveName("Fuel Tax Export File Name",ls_PathName,ls_FileName,"STA","State files (*.STA), *.STA",ls_CancelWarning) <> 1 THEN
			li_ReturnValue = 0
//			since -1 indicates failure and user initiated cancel no message can/should be set
//			ls_ErrorMessage = "An error occurred while attempting to open the file " + STRING (ls_PathName )
		END IF
		

		IF li_ReturnValue = 1 THEN //(3)

			li_FileNo = FileOpen(ls_pathName,LineMode!,Write!,Shared!,Replace!) 

			IF li_FileNo = -1 THEN	//(4)
				li_ReturnValue = -1
				ls_ErrorMessage = "An error occurred while attempting to open the file " + STRING (ls_PathName )
			ELSE  //(-4-) 
				
				ls_TruckID = lnv_String.of_PadRight(lstr_Equipment.eq_Ref,15)
				ls_OutPut = ls_TruckID+" "+ ls_Orig + " " + ls_Dest + " " + String(ld_StartDate,"mm/dd/yyyy") + " " +String(ld_EndDate,"mm/dd/yyyy")
				// ls_orig and Dest are limited to 24 chars 
				// trimming takes place before being submitted to this function
				
			
				IF FileWrite(li_FileNo,ls_OutPut) < 0 THEN
					li_ReturnValue = -1
					ls_ErrorMessage = "An error occurred while writing the fuel tax file."
				END IF	
			
				ll_NumRows = lds_Source.RowCount()	
				
//				IF ll_NumRows <= 0 THEN
//					li_ReturnValue = -1
//					ls_ErrorMessage =  "No data was retieved from database." 
//				END IF
				
				IF li_ReturnValue = 1 THEN //(5)
					For i = 1 To ll_NumRows
						
						
						ls_State = lnv_String.of_padRight(string(lds_Source.object.State[i]),4)
						ls_Total = lnv_string.of_padRight(String(lds_Source.object.AdjustedMileage[i]),10)
						
						
						// the following control structure is to avoid having negative mileage in the non-toll mileage
						
						IF lds_Source.Object.Toll[i] > lds_Source.object.AdjustedMileage[i] THEN
							ls_Toll	 = lnv_string.of_padRight(String(lds_Source.Object.AdjustedMileage[i]),10)
							ls_NonToll =  lnv_string.of_padRight ( String (   ( lds_Source.object.AdjustedMileage[i] - lds_Source.object.AdjustedMileage[i] ) ) ,10) 
							ls_StateList = ls_StateList + "~r~n~t" + trim(ls_State)
							lb_adjustment = TRUE
							
						ELSE	
							
							ls_Toll	 = lnv_string.of_padRight(String(lds_Source.Object.Toll[i]),10)
							ls_NonToll =  lnv_string.of_padRight ( String (   ( lds_Source.object.AdjustedMileage[i] - lds_Source.Object.Toll[i]) ) ,10) 
						END IF					
						
						
						ls_PCMMileage = lnv_string.of_PadRight(String(lds_Source.object.Total[i]),10)
						ls_CalcDiff	= lnv_string.of_padRight(string(lds_Source.object.AdjustedMileage[i] - lds_Source.object.Total[i]),10)
						
						
						
						
						ls_OutPut =  ls_State + ls_Total +  ls_Toll +  ls_NonToll + ls_PCMMileage + ls_CalcDiff 
		
						IF FileWrite(li_FileNo,ls_OutPut) < 0 THEN
							li_ReturnValue = -1
							ls_ErrorMessage = "An error occurred while writing the fuel tax file."
						 	EXIT	 
						END IF				
					Next
					IF lb_adjustment THEN
						MessageBox ( "Mileage Adjustment" , "The reported toll mileage was greater than the adjusted mileage for the following state(s) " &
						+ ls_StateList + ". ~r~rTherefore an adjustment was made to the toll mileage in order to procede with the processing." , EXCLAMATION! )
					END IF	
					
				END IF //(5)
				
				FileClose(li_FileNo)
				
			END IF //(4)		
		END IF //(3)
	END IF //(2)
END IF //(1)

//* Error Processing *\\//\\//\\//\\//\\//\\//\\//\\//\\/\\//\\//\\//

IF li_ReturnValue = -1 THEN
	messageBox("Fuel Tax" , ls_ErrorMessage )

END IF

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//


Return li_ReturnValue
//@(text)--



end function

on w_datavalidate.create
int iCurrent
call super::create
this.dw_statereport=create dw_statereport
this.mle_instruct=create mle_instruct
this.cb_3=create cb_3
this.sle_total=create sle_total
this.sle_oddiff=create sle_oddiff
this.sle_percentdiff=create sle_percentdiff
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.dw_tripreport=create dw_tripreport
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_statereport
this.Control[iCurrent+2]=this.mle_instruct
this.Control[iCurrent+3]=this.cb_3
this.Control[iCurrent+4]=this.sle_total
this.Control[iCurrent+5]=this.sle_oddiff
this.Control[iCurrent+6]=this.sle_percentdiff
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.st_3
this.Control[iCurrent+10]=this.dw_tripreport
this.Control[iCurrent+11]=this.cb_1
end on

on w_datavalidate.destroy
call super::destroy
destroy(this.dw_statereport)
destroy(this.mle_instruct)
destroy(this.cb_3)
destroy(this.sle_total)
destroy(this.sle_oddiff)
destroy(this.sle_percentdiff)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.dw_tripreport)
destroy(this.cb_1)
end on

event open;call super::open;string 		ls_Text
string		ls_Result
Dec{1}		ld_total
Dec{1}		ld_ODDiff
dec{1}		ld_PercentDiff

blob	lblb_return, &
		lblb_return2

n_cst_msg 	lnv_msg
s_parm 		lstr_parm

dataStore	lds_States
dataStore	lds_Itin

lnv_msg = message.powerobjectparm
inv_msg = lnv_msg

If lnv_msg.of_Get_Count() > 0 THEN
	
	IF lnv_msg.of_get_parm("RESULT",lstr_Parm) <> 0 THEN
		ls_Result = lstr_Parm.ia_Value
	END IF
	
	Send(Handle(dw_TripReport), 274, 61472, 0) // open minimized
	
	IF ls_Result = appeon_constant.cs_Context_StateBreakDown OR &
		ls_Result = appeon_constant.cs_Context_HistoryReport THEN		

		sle_oddiff.Enabled = False
		sle_percentdiff.Enabled = False
		sle_total.Enabled = False
		cb_1.visible = FALSE 
		mle_Instruct.enabled = FALSE

		IF ls_Result = appeon_constant.cs_Context_HistoryReport THEN
			dw_StateReport.hide()
			cb_3.hide()
			Send(Handle(dw_TripReport), 274, 61488, 0) // open maximized		
		END IF
		
		IF ls_Result = appeon_constant.cs_Context_StateBreakDown THEN

			IF lnv_msg.of_Get_Parm("STATEREPORT",lstr_Parm) <> 0 THEN
				lds_States = lstr_parm.ia_Value
				lds_States.GetFullState(lblb_return)
				dw_StateReport.SetFullState(lblb_Return)
			END IF

		END IF
		
	ELSE
		
		IF lnv_msg.of_get_parm("MESSAGE",lstr_parm) <> 0 THEN
			ls_text = lstr_parm.ia_Value
		END IF
	
		IF lnv_msg.of_get_Parm("TOTALMILES",lstr_parm) <> 0 THEN
			ld_Total = lstr_parm.ia_Value
			sle_Total.text = string(ld_Total)
		END IF

		IF lnv_msg.of_get_Parm("ODDIFF",lstr_parm) <> 0 THEN
			ld_ODDiff = lstr_parm.ia_Value
			sle_ODDIFF.text = string(ld_ODDiff)
			if ld_Total > 0 THEN
				ld_PercentDiff = (( (ld_Total - ld_ODDiff) / ld_Total) * 100)
				sle_PercentDiff.text = string(Abs(ld_PercentDiff))
			ELSEIF ld_Total = 0 AND ld_ODDiff = 0 THEN
				sle_PercentDiff.Text = String(0)
			ELSE
				sle_PercentDiff.text = string(100)
			END IF
		END IF

		IF lnv_msg.of_Get_Parm("STATEREPORT",lstr_Parm) <> 0 THEN
			lds_States = lstr_parm.ia_Value
			lds_States.GetFullState(lblb_return)
			
			dw_StateReport.SetFullState(lblb_Return)
			
		END IF
		
		mle_Instruct.text = ls_text

		if ls_Result = "FAIL" THEN
			mle_Instruct.TextColor = 16777215
			mle_Instruct.BackColor = 255
		END IF
	END IF
	
	IF lnv_msg.of_Get_Parm("ITINREPORT",lstr_Parm) <> 0 THEN
		lds_itin = lstr_parm.ia_Value
		lds_itin.GetFullState(lblb_return2)	
		dw_TripReport.SetFullState(lblb_Return2)
	END IF
	
	dw_TripReport.Visible = TRUE
	
	ib_disableCloseQuery = TRUE
	
	dw_TripReport.Modify ( "DataWindow.Print.Preview=YES" )
	dw_TripReport.Modify ( "DataWindow.Print.Preview.Zoom=75" )
	dw_TripReport.Title = "Trip Details"

END IF
end event

event pfc_cancel;call super::pfc_cancel;

close ( This )

end event

event close;call super::close;
ib_DisableCloseQuery = True 

close ( this )
end event

type dw_statereport from datawindow within w_datavalidate
int X=87
int Y=352
int Width=2409
int Height=936
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event rbuttondown;string lsa_parm_labels[]
any laa_parm_values[]

//if upper(dwo.type) = "DATAWINDOW" then
	lsa_parm_labels[1] = "MENU_TYPE"
	laa_parm_values[1] = "PRINT"
	lsa_parm_labels[2] = "PRINT_OBJECT"
	laa_parm_values[2] = this
	f_pop_standard(lsa_parm_labels, laa_parm_values)
//end if

//RETURN AncestorReturnValue
end event

type mle_instruct from u_mle within w_datavalidate
int X=82
int Y=48
int Width=1330
int TabOrder=0
boolean BringToTop=true
boolean DisplayOnly=true
int TextSize=-9
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

type cb_3 from u_cbcancel within w_datavalidate
int X=1019
int Y=1332
int Width=352
int Height=92
int TabOrder=30
boolean BringToTop=true
string Text="Close"
end type

type sle_total from u_sle within w_datavalidate
int X=2030
int Y=40
int TabOrder=0
boolean BringToTop=true
boolean DisplayOnly=true
end type

type sle_oddiff from u_sle within w_datavalidate
int X=2030
int Y=132
int TabOrder=0
boolean BringToTop=true
boolean DisplayOnly=true
end type

type sle_percentdiff from u_sle within w_datavalidate
int X=2030
int Y=224
int TabOrder=0
boolean BringToTop=true
boolean DisplayOnly=true
end type

type st_1 from statictext within w_datavalidate
int X=1531
int Y=52
int Width=503
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Calculated Mileage:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_datavalidate
int X=1550
int Y=144
int Width=485
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Odometer Mileage:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_datavalidate
int X=1550
int Y=232
int Width=485
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Percent Difference:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_tripreport from u_dw within w_datavalidate
int X=55
int Y=328
int Width=2482
int Height=1100
int TabOrder=20
boolean Visible=false
boolean BringToTop=true
boolean TitleBar=true
string Title="Trip Details"
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean HScrollBar=true
end type

event rbuttondown;call super::rbuttondown;string lsa_parm_labels[]
any laa_parm_values[]

//if upper(dwo.type) = "DATAWINDOW" then
	lsa_parm_labels[1] = "MENU_TYPE"
	laa_parm_values[1] = "PRINT"
	lsa_parm_labels[2] = "PRINT_OBJECT"
	laa_parm_values[2] = this
	f_pop_standard(lsa_parm_labels, laa_parm_values)
//end if

//RETURN AncestorReturnValue
end event

event syscommand;// OverRide Ancestor Script to prevent closing if this window. If user selects close 
// the window will minimize instead

Constant ULong USERCLOSE = 61536
Constant ULong MINIMIZE  = 61472
Long	ll_Return

IF CommandType = USERCLOSE THEN
		
		post(Handle(THIS), 274, MINIMIZE , 0)

		ll_Return = 1  //Reject Action
END IF

RETURN ll_Return

end event

type cb_1 from u_cb within w_datavalidate
int X=1426
int Y=1332
int TabOrder=10
boolean BringToTop=true
string Text="E&xport"
end type

event clicked;string		ls_Result
String		ls_Orig
String		ls_Dest
long		ll_ID
Date		ld_min
Date		ld_Max
Boolean		lb_Export = FALSE

Int		li_ReturnValue = 1

s_parm		lstr_parm

dataStore lds_StateReport

n_cst_string lnv_string


 
 
IF inv_msg.of_Get_Parm("RESULT",lstr_parm) <> 0 THEN
	ls_Result = lstr_Parm.ia_Value

	IF ls_Result = "FAIL" THEN
			IF MessageBox("Fuel Tax Export","Are you sure you want to export data outside specified range?",QUESTION!,YESNO!,2) = 1 THEN
				lb_Export = TRUE
				
				
				
				
				
			Else
				// User canceled out of exporting data outside range
				
				lb_Export = FALSE
				
			END IF
	Else
		
		lb_Export = TRUE
		
	END IF
	
END IF

IF lb_Export THEN
	
		IF inv_msg.of_Get_Parm( "ID" , lstr_Parm ) <> 0 THEN 
			ll_id = long ( lstr_parm.ia_Value )
		ELSE 
			li_ReturnValue = -1
		END IF
		
		IF inv_msg.of_Get_Parm( "STARTDATE" , lstr_Parm ) <> 0 THEN 
			ld_min =  ( lstr_parm.ia_Value )
		ELSE 
			li_ReturnValue = -1
		END IF
		
		IF inv_msg.of_Get_Parm( "ENDDATE" , lstr_Parm ) <> 0 THEN 
			ld_max =  ( lstr_parm.ia_Value )
		ELSE 
			li_ReturnValue = -1
		END IF
				
		IF inv_msg.of_Get_Parm( "ITIN" , lstr_Parm ) <> 0 THEN 
			ids_itin_quick =  ( lstr_parm.ia_Value )
		ELSE 
			li_ReturnValue = -1
		END IF		
	
		IF inv_msg.of_Get_Parm( "ORIG" , lstr_Parm ) <> 0 THEN 
			ls_Orig =  ( lstr_parm.ia_Value )
		ELSE 
			li_ReturnValue = -1
		END IF		
		
		IF inv_msg.of_Get_Parm( "DESTINATION" , lstr_Parm ) <> 0 THEN 
			ls_Dest =  ( lstr_parm.ia_Value )
		ELSE 
			li_ReturnValue = -1
		END IF		
		
		IF  wf_WriteFile(ll_ID , lnv_String.of_padright(ls_Orig, 24), &	
							lnv_String.of_Padright( ls_Dest , 24) , ld_min , ld_max) = 1 THEN
			event close()
			
		END IF
		
		
END IF









end event

