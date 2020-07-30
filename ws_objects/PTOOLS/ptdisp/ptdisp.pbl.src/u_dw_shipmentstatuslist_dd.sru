$PBExportHeader$u_dw_shipmentstatuslist_dd.sru
forward
global type u_dw_shipmentstatuslist_dd from u_dw
end type
end forward

global type u_dw_shipmentstatuslist_dd from u_dw
int Width=562
int Height=84
string DataObject="d_shipstatus_dd"
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean VScrollBar=false
end type
global u_dw_shipmentstatuslist_dd u_dw_shipmentstatuslist_dd

forward prototypes
private function integer of_populatestatuslist ()
end prototypes

private function integer of_populatestatuslist ();String	lsa_Settings[]
Int		li_Index
Int		li_Count

n_cst_ShipmentManager	lnv_Manager

String	ls_CodeTable = &
	"TEMPLATE~t" + gc_Dispatch.cs_ShipmentStatus_Template + "/"+&
	"QUOTE~t" + gc_Dispatch.cs_ShipmentStatus_Quoted + "/"+&
	"OPEN~t" + gc_Dispatch.cs_ShipmentStatus_Open + "/"+&
	"AUTHORIZED~t" + gc_Dispatch.cs_ShipmentStatus_Authorized + "/"+&
	"AUDIT REQ.~t" + gc_Dispatch.cs_ShipmentStatus_AuditRequired + "/"+&
	"AUDITED~t" + gc_Dispatch.cs_ShipmentStatus_Audited + "/"
	
ls_CodeTable = "Values = '" + ls_CodeTable + "'"

lsa_Settings = { "Edit.CodeTable = Yes", ls_CodeTable , "ddlb.UseAsBorder = No", "ddlb.ShowList = No", "ddlb.VScrollBar = Yes" }

li_Count = UpperBound ( lsa_Settings )
	
FOR li_Index = 1 TO li_Count

	THIS.Modify ( "ds_Status." + lsa_Settings [ li_Index ] )

NEXT

RETURN 1
end function

event constructor;THIS.InsertRow ( 0 ) 
THIS.of_PopulateStatusList ( )
end event

