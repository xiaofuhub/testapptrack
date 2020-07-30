$PBExportHeader$u_cst_operations.sru
forward
global type u_cst_operations from u_base
end type
type st_count from statictext within u_cst_operations
end type
type st_total from statictext within u_cst_operations
end type
type st_show from statictext within u_cst_operations
end type
type rb_other from radiobutton within u_cst_operations
end type
type rb_pb from radiobutton within u_cst_operations
end type
type dw_operations from u_dw within u_cst_operations
end type
end forward

global type u_cst_operations from u_base
integer width = 1842
integer height = 648
event ue_totalcountchange ( )
st_count st_count
st_total st_total
st_show st_show
rb_other rb_other
rb_pb rb_pb
dw_operations dw_operations
end type
global u_cst_operations u_cst_operations

forward prototypes
public function integer of_retrieve ()
public function integer of_loadidletimes ()
public function integer of_initialize ()
public function integer of_loadappinfo ()
public function integer of_discardremoteconnections ()
public function integer of_settotalcount (long al_count)
end prototypes

event ue_totalcountchange();Long	ll_TotalCount

ll_TotalCount = dw_operations.Rowcount() + dw_operations.FilteredCount()

This.of_SetTotalCount(ll_TotalCount)
end event

public function integer of_retrieve ();Integer	li_Return

li_Return = dw_Operations.Retrieve()

This.Event ue_TotalCountChange()

Return li_Return
end function

public function integer of_loadidletimes ();Integer 	li_Return = 1
Integer	li_ConnId
Long		ll_MinIdle
Long		ll_SecIdle
String	ls_LastRequest
String	ls_LastReqDate
String	ls_LastReqTime
DateTime	ldt_LastRequest
DateTime	ldt_Now
Long		ll_RowCount
Long		i

n_cst_DateTime		lnv_DateTime

ldt_Now = DateTime(Today(),Now())

ll_RowCount = dw_operations.RowCount()

FOR i = 1 TO ll_RowCount
	ll_MinIdle = 0
	li_ConnId = dw_operations.GetItemNumber(i, "conn_id")
	
	SELECT connection_property ('LastReqTime', :li_ConnId) INTO :ls_LastRequest FROM Dummy;
	Commit;
		
	ls_LastReqDate = Left(ls_LastRequest, 10)
	ls_LastReqTime = Mid(ls_LastRequest, 12, 8)
	
	IF isDate(ls_LastReqDate) AND isTime(ls_LastReqTime) THEN
		
		ldt_LastRequest = DateTime(Date(ls_LastReqDate), Time(ls_LastReqTime))
		
		ll_SecIdle = lnv_DateTime.of_SecondsAfter(ldt_LastRequest, ldt_Now)

		IF ll_SecIdle > 0 THEN
			ll_MinIdle = ll_SecIdle / 60
		END IF
		
		dw_Operations.SetItem(i, "conn_idletime", String(ll_MinIdle) + " min.")
		
	END IF
	
NEXT

Return li_Return

end function

public function integer of_initialize ();Integer	li_Return = 1

dw_operations.SetSort("em_ref A")
dw_operations.Sort()


rb_pb.Checked = TRUE
rb_pb.TriggerEvent(clicked!) //this will filter to trucking.exe connections

This.Event ue_TotalCountChange() //update count

Return li_Return
end function

public function integer of_loadappinfo ();Integer	li_Return
Long		ll_Rowcount
Long		ll_AppInfoCount
Long		ll_AppInfoLen
Long		li_StartPos
Long		i, j
String	lsa_AppInfo[]
String	ls_AppInfo
String	ls_Exe
String	ls_Host

n_cst_String	lnv_String

ll_RowCount = dw_operations.RowCount()
FOR i = 1 TO ll_RowCount
	
	ls_AppInfo = dw_operations.GetItemString(i, "conn_appinfo")
	lnv_String.of_Parsetoarray( ls_AppInfo, ";", lsa_AppInfo)
	
	ll_AppInfoCount = UpperBound(lsa_AppInfo)
	FOR j = 1 TO ll_AppInfoCount
		
		ll_AppInfoLen = Len(lsa_AppInfo[j])
		
		IF Pos(lsa_AppInfo[j], "HOST=") > 0 THEN
			li_StartPos = Pos(lsa_AppInfo[j],"=")
			ls_Host = Trim( Right(lsa_AppInfo[j], ll_AppInfoLen - li_StartPos) )
		ELSEIF Pos(lsa_AppInfo[j], "EXE=") > 0 THEN
			li_StartPos = Pos(lsa_AppInfo[j],"=")
			ls_Exe = Trim( Right(lsa_AppInfo[j], ll_AppInfoLen - li_StartPos) )
			li_StartPos = LastPos(ls_Exe, "\")
			IF li_StartPos > 0 THEN
				ls_Exe = Right(ls_Exe, Len(ls_Exe) - li_StartPos)
			END IF
		END IF
		
	NEXT
	
	IF Len(ls_Host) > 0 THEN
		dw_operations.SetItem(i, "conn_host", ls_Host)
	END IF
	
	IF Len(ls_Exe) > 0 THEN
		dw_operations.SetItem(i, "conn_exe", ls_Exe)
	END IF

	
NEXT

Return li_Return
end function

public function integer of_discardremoteconnections ();Integer	li_Return = 1
Long		ll_RowCount
Long		i
Long		ll_ConnId
String	ls_ConnName

ll_RowCount = dw_operations.RowCount()
FOR i = ll_RowCount TO 1 STEP - 1
	ll_ConnId = dw_operations.GetItemNumber(i, "conn_id")
	SELECT connection_property ('Name', :ll_ConnId) INTO :ls_ConnName FROM Dummy;
	Commit;
	IF Pos(ls_ConnName, "ASACIS_") > 0 THEN
		IF dw_operations.RowsDiscard(i,i,Primary!) <> 1 THEN
			li_Return = -1
			EXIT
		END IF
	END IF
	
NEXT

This.Event ue_TotalCountChange()

Return li_Return
end function

public function integer of_settotalcount (long al_count);st_count.Text = String(al_count)

Return 1
end function

on u_cst_operations.create
int iCurrent
call super::create
this.st_count=create st_count
this.st_total=create st_total
this.st_show=create st_show
this.rb_other=create rb_other
this.rb_pb=create rb_pb
this.dw_operations=create dw_operations
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_count
this.Control[iCurrent+2]=this.st_total
this.Control[iCurrent+3]=this.st_show
this.Control[iCurrent+4]=this.rb_other
this.Control[iCurrent+5]=this.rb_pb
this.Control[iCurrent+6]=this.dw_operations
end on

on u_cst_operations.destroy
call super::destroy
destroy(this.st_count)
destroy(this.st_total)
destroy(this.st_show)
destroy(this.rb_other)
destroy(this.rb_pb)
destroy(this.dw_operations)
end on

event constructor;call super::constructor;dw_operations.of_SetInsertable(False)
dw_operations.of_SetDeleteable(False)

dw_operations.of_SetAutoSort ( TRUE )

dw_operations.SetTransObject(SQLCA)



end event

type st_count from statictext within u_cst_operations
integer x = 613
integer y = 8
integer width = 544
integer height = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_total from statictext within u_cst_operations
integer x = 23
integer y = 4
integer width = 585
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Connections In Use:"
boolean focusrectangle = false
end type

type st_show from statictext within u_cst_operations
integer x = 23
integer y = 80
integer width = 178
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Show:"
boolean focusrectangle = false
end type

type rb_other from radiobutton within u_cst_operations
integer x = 951
integer y = 84
integer width = 686
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "&Other Connections"
end type

event clicked;IF This.checked = TRUE THEN
	dw_operations.SetFilter ("lower(conn_exe) <> 'trucking.exe'")
	dw_operations.Filter ( )
	dw_operations.Sort ( )
	dw_operations.SetFocus ( )
END IF
end event

type rb_pb from radiobutton within u_cst_operations
integer x = 201
integer y = 84
integer width = 768
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "&Profit Tools Connections"
end type

event clicked;IF This.checked = TRUE THEN
	dw_operations.SetFilter ("lower(conn_exe) = 'trucking.exe'")
	dw_operations.Filter ( )
	dw_operations.Sort ( )
	dw_operations.SetFocus ( )
END IF
end event

type dw_operations from u_dw within u_cst_operations
event ue_disconnect ( long al_row )
integer x = 18
integer y = 168
integer width = 1797
integer height = 468
integer taborder = 10
string dataobject = "d_operations"
boolean hscrollbar = true
end type

event ue_disconnect(long al_row);Integer 	li_ConnId
String	ls_User
String	ls_ConnHost
String	ls_CurrentConn
String	ls_UserInfo
String	ls_Sql

li_ConnId = This.GetItemNumber(al_row, "conn_id")

//Get Current connection id
SELECT connection_property ('Number') INTO :ls_CurrentConn FROM Dummy;

IF li_ConnId <> Integer(ls_CurrentConn) THEN
	
	ls_User = This.GetItemString(al_row, "em_ref")
	ls_ConnHost = This.GetItemString(al_row, "conn_host")
	
	IF NOT isNull(ls_User) AND Len(ls_User) > 0 THEN
		ls_UserInfo = ls_User
	ELSEIF NOT isNull(ls_ConnHost) AND Len(ls_ConnHost) > 0 THEN
		ls_UserInfo = ls_ConnHost
	ELSE
		ls_UserInfo = "<unknown>"
	END IF
	
	IF MessageBox("Disconnect", "This will drop the database connection for user " + ls_UserInfo + ".~r~n" + &
						"Any pending changes for this user/connection will be lost.~r~n" + &
						"Any current db processing for this user/connection will be interrupted.~r~n~r~n" + &
						"Are you sure you want to drop the connection?", Question!, YesNo!, 2) = 1 THEN
	
	
		ls_Sql = "DROP CONNECTION " + String(li_ConnId)
		
		Execute Immediate :ls_Sql;
			
		IF SQLCA.sqlcode = 0 THEN
			IF This.RowsDiscard(al_Row, al_Row, Primary!) = 1 THEN //remove from view, db disconnect event will delete it from table 
				Parent.Event ue_TotalCountChange()
			END IF
		ELSE
			MessageBox("Disconnect", "Could not drop connection " + String(li_ConnId) + ".")
		END IF
		
	END IF
	
ELSE
	MessageBox("Disconnect", "Disconnect of current Profit Tools session is not permitted.")
END IF



end event

event rbuttondown;call super::rbuttondown;String	ls_PopRtn
String	lsa_parm_labels[]
Any		laa_parm_values[]

n_cst_privileges		lnv_Privileges

IF row > 0 THEN
	
	

	IF lnv_Privileges.of_HasSysAdminRights() THEN
		
		dw_operations.SelectRow(row, True)
		
		lsa_parm_labels[ UpperBound ( lsa_Parm_Labels ) + 1 ] = "XPOS"
		laa_parm_values[UpperBound ( laa_parm_values ) + 1] = Parent.x + Parent.PointerX() + 10
		lsa_parm_labels[ UpperBound ( lsa_Parm_Labels ) + 1 ] = "YPOS"
		laa_parm_values[UpperBound ( laa_parm_values ) + 1] = Parent.y + Parent.PointerY() + 10
		lsa_parm_labels[ UpperBound ( lsa_Parm_Labels ) + 1 ] = "ADD_ITEM"
		laa_parm_values[UpperBound ( laa_parm_values ) + 1] = "&Disconnect"
				
		
		ls_PopRtn = f_Pop_Standard ( lsa_Parm_Labels, laa_Parm_Values )
		
		
		CHOOSE CASE ls_PopRtn
			
			CASE "DISCONNECT"
				This.Event ue_Disconnect(row)
		END CHOOSE
		
		dw_operations.SelectRow(row, False)
		
	END IF
	
END IF
end event

