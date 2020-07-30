$PBExportHeader$u_tabpg_sap.sru
forward
global type u_tabpg_sap from u_tabpg
end type
type st_star from statictext within u_tabpg_sap
end type
type dw_metadata from u_dw within u_tabpg_sap
end type
end forward

global type u_tabpg_sap from u_tabpg
integer width = 1824
integer height = 1436
long backcolor = 12632256
long tabbackcolor = 12632256
event ue_itemchanged ( )
st_star st_star
dw_metadata dw_metadata
end type
global u_tabpg_sap u_tabpg_sap

on u_tabpg_sap.create
int iCurrent
call super::create
this.st_star=create st_star
this.dw_metadata=create dw_metadata
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_star
this.Control[iCurrent+2]=this.dw_metadata
end on

on u_tabpg_sap.destroy
call super::destroy
destroy(this.st_star)
destroy(this.dw_metadata)
end on

event pfc_updateprep;call super::pfc_updateprep;Integer	li_Return = 1
Long		ll_RowCount
Long		i
String	ls_Name
String	ls_Value
String	ls_Status

ll_RowCount = dw_metadata.RowCount()
FOR i = 1 TO ll_RowCount
	ls_Name = dw_metadata.GetItemstring(i, "field_name")
	ls_Value = dw_metadata.GetItemstring(i, "value")
	ls_Status = dw_metadata.GetItemString(i, "field_status")
	IF ls_Status = appeon_constant.cs_STATUS_MANDATORY THEN
		IF isNull(ls_Value) OR Len(ls_Value) = 0 THEN
			IF MessageBox("SAP Validation", "One or more mandatory fields have been left blank.~r~n" + &
				"Would you like to provide the value(s) before saving?", Question!, YesNo!, 1) = 1 THEN
				dw_metadata.SetFocus()
				dw_metadata.SetRow(i)
				dw_metadata.SetColumn("value")
				li_Return = -1 //Do not allow save
			END IF
			EXIT //Warn them once
		END IF
	END IF
NEXT

Return li_Return
end event

type st_star from statictext within u_tabpg_sap
integer x = 55
integer y = 1360
integer width = 489
integer height = 72
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "( * ) = Mandatory"
boolean focusrectangle = false
end type

type dw_metadata from u_dw within u_tabpg_sap
integer x = 46
integer y = 40
integer width = 1714
integer height = 1300
integer taborder = 10
string dataobject = "d_batchmetadata_sap"
end type

event constructor;call super::constructor;This.of_SetInsertable(False)
This.of_SetDeleteable(False)
This.SetTransObject(SQLCA)
This.Retrieve()
end event

event itemchanged;call super::itemchanged;Integer	li_Return
String	ls_Status
String	ls_Name

li_Return = AncestorReturnValue

//IF dwo.Name = "value" THEN
//	IF isNull(data) OR Len(data) = 0 THEN 
//		ls_Status = This.GetItemString(row, "field_status")
//		IF ls_Status = "M" THEN//Mandatory
//			ls_Name = This.GetItemString(row, "field_name")
//			This.Object.value.ValidationMsg = ls_Name + " is a mandatory field. You must provide a value."
//			li_Return = 1
//		END IF
//	END IF
//END IF

IF li_Return = 0 THEN
	Parent.Event ue_ItemChanged()
END IF

Return li_Return
end event

