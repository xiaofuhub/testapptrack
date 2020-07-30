$PBExportHeader$u_dw_ediprofile_214.sru
forward
global type u_dw_ediprofile_214 from u_dw
end type
end forward

global type u_dw_ediprofile_214 from u_dw
integer width = 2624
integer height = 700
string dataobject = "d_ediprofilestatus_grid"
boolean border = false
event ue_clearblankrows ( )
end type
global u_dw_ediprofile_214 u_dw_ediprofile_214

event ue_clearblankrows();if this.accepttext() = 1 then
	this.setredraw(false)
	
	Long	ll_RowCount
	Long	i
	
	ll_RowCount = THIS.RowCount ( )
	FOR i = ll_RowCount TO 1 STEP -1
		IF IsNull (  THIS.GetItemString ( i , "eventtype", Primary!, false )  ) or &
			len ( trim ( THIS.GetItemString ( i , "eventtype", Primary!, false ) ) ) = 0 or &
			IsNull (  THIS.GetItemString ( i , "sitetype", Primary!, false )  ) or &
			len ( trim ( THIS.GetItemString ( i , "sitetype", Primary!, false ) ) ) = 0 or &
			IsNull (  THIS.GetItemString ( i , "action", Primary!, false )  ) or &
			len ( trim ( THIS.GetItemString ( i , "action", Primary!, false ) ) ) = 0 THEN
			THIS.RowsDiscard ( i, i, Primary! ) 
		END IF	
	NEXT			
	this.setredraw(true)
end if
end event

on u_dw_ediprofile_214.create
end on

on u_dw_ediprofile_214.destroy
end on

