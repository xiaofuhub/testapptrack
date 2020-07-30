$PBExportHeader$ofr_n_cst_pfctxsrv.sru
forward
global type ofr_n_cst_pfctxsrv from ofr_n_cst_txsrv
end type
end forward

global type ofr_n_cst_pfctxsrv from ofr_n_cst_txsrv
end type
global ofr_n_cst_pfctxsrv ofr_n_cst_pfctxsrv

forward prototypes
protected function integer loadlinkeddatawindows (u_dw adw_datawindow)
public function integer loadupdatelist (readonly powerobject apo_control[])
end prototypes

protected function integer loadlinkeddatawindows (u_dw adw_datawindow);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		LoadLinkedDatawindows
//
//	Arguments:		Datawindow	-	adw_datawindow
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Makes necessary calls to PFC's linkage service
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
// 1.3   Fixed variable names because "c" conflicted with a CornerStone object.
//
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////


u_dw ldw_d[]
integer li_i, li_c, li_dwcount

li_c = adw_datawindow.inv_linkage.of_GetDetails(ldw_d)

for li_i = 1 to li_c
	if ldw_d[li_i] <> adw_datawindow then
		RegisterDataWindow(ldw_d[li_i])
		LoadLinkedDataWindows(ldw_d[li_i])
	end if
next

return 1
end function

public function integer loadupdatelist (readonly powerobject apo_control[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		LoadUpdateList
//
//	Arguments:		apo_control[]	Presentation object control array
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Integrates PFC with ofr transaction services
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
Int			li_rc = 1
Int 			li_max, li_i
DataWindow	ldw_dw
Tab			ltab_tab
UserObject	luo_controlgroup 
u_dw			ldw_pfc_dw

li_max = UpperBound(apo_control)

FOR li_i = 1 TO li_max
	CHOOSE CASE apo_control[li_i].TypeOf()
		CASE DataWindow! 
			ldw_dw = apo_control[li_i]	
			// Determine if this is a PFC Datawindow
			IF ldw_dw.TriggerEvent("pfc_descendant") = 1 THEN
				// This is a PFC datawindow, recast it to u_dw so we can check 
				// pfc attributes and invoke pfc methods
				ldw_pfc_dw 	= ldw_dw
				// A PFC Datawindow can either be Linked or NotLinked
				IF IsValid(ldw_pfc_dw.inv_Linkage) THEN
					// This is a PFC Datawindow that is Linked
					IF ldw_pfc_dw.inv_linkage.of_IsRoot() = TRUE THEN
						li_rc = this.Register(ldw_pfc_dw)
						IF li_rc = 1 THEN
							IF this.LoadLinkedDataWindows(ldw_pfc_dw) = 1 THEN
								li_rc = 1
							ELSE
								li_rc = -1
							END IF
						END IF
					ELSE
						// Skip this.  We will register it when we find the root.			   
					END IF
				ELSE
					// This is a PFC datawindow that is not linked
					li_rc = this.Register(ldw_pfc_dw)
				END IF
			ELSE
				// This is not a PFC datawindow
				li_rc = this.Register(ldw_dw)
			END IF
		CASE Tab!
			ltab_tab = apo_control[li_i]
			this.LoadUpdateList(ltab_tab.control)
		CASE UserObject!
			luo_controlgroup = apo_control[li_i]
			IF luo_controlgroup.ObjectType = CustomVisual! THEN
				this.LoadUpdateList(luo_controlgroup.control)
			END IF
	END CHOOSE
NEXT
 
return li_rc


end function

on ofr_n_cst_pfctxsrv.create
TriggerEvent( this, "constructor" )
end on

on ofr_n_cst_pfctxsrv.destroy
TriggerEvent( this, "destructor" )
end on

