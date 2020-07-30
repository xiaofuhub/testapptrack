$PBExportHeader$n_cst_printsrvc.sru
forward
global type n_cst_printsrvc from n_cst_base
end type
end forward

global type n_cst_printsrvc from n_cst_base
end type
global n_cst_printsrvc n_cst_printsrvc

forward prototypes
public function boolean of_isprintdialogtobeshown ()
public function integer of_print (n_ds anv_nds)
public function integer of_decideobjecttoprint (powerobject apo_object)
public function integer of_print (datawindow adw_target)
public function integer of_printudw (u_dw anv_target)
public function integer of_printdw (datawindow adw_target)
public function integer of_print (datastore ads_target)
public function integer of_printnds (n_ds anv_target)
public function integer of_printdatastore (datastore ads_target)
public function integer of_print (window aw_print)
public function string of_selectprinter ()
end prototypes

public function boolean of_isprintdialogtobeshown ();Boolean lb_RtnVal

n_cst_setting_ShowPrintDialog lnv_ShowPrintDialog
lnv_ShowPrintDialog = CREATE n_cst_setting_ShowPrintDialog


IF Upper(lnv_ShowPrintDialog.of_GetValue()) = Upper(lnv_ShowPrintDialog.cs_Yes) THEN
	lb_RtnVal = TRUE
END IF

DESTROY(lnv_ShowPrintDialog)
Return lb_RtnVal
end function

public function integer of_print (n_ds anv_nds);Int li_RtnVal = 1
Long ll_rc
Window lw_Parent

s_PrintdlgAttrib lstr_PrintDlg
n_cst_PlatForm lnv_platform

IF This.of_IsPrintDialogToBeShown( ) THEN
	f_SetPlatForm(lnv_platform,True)
	IF anv_nds.of_GetParentWindow(lw_Parent) = 1 THEN
		ll_rc = lnv_platform.of_PrintDlg(lstr_printdlg,lw_Parent)
		IF ll_rc = -1  THEN
			li_RtnVal = -1
		ELSE
			anv_nds.Print()
		END IF
	END IF
	f_SetPlatForm(lnv_platform,False)
ELSE
	anv_nds.Print()
END IF
Return li_RtnVal


end function

public function integer of_decideobjecttoprint (powerobject apo_object);Int	li_RtnVal = 1

Window 		lw_Target
DataStore	lds_Target
DataWindow	ldw_Target

CHOOSE CASE apo_object.typeof()
	CASE DataWindow!
		ldw_Target	= apo_object
		IF IsValid(ldw_Target) THEN
			IF This.of_Print(ldw_Target) <> 1 THEN
				li_RtnVal = -1
			END IF
		END IF

	CASE DataStore!
		lds_Target	= apo_object
		IF IsValid(lds_Target) THEN
			IF This.of_Print(lds_Target) <> 1 THEN
				li_RtnVal = -1
			END IF
		END IF
		
	CASE Window!
		lw_Target = apo_object
		IF IsValid(lw_Target) THEN
			IF This.of_Print(lw_target) <> 1 THEN
				li_RtnVal = -1
			END IF
		END IF
 		
	CASE ElSE
		li_RtnVal = -1
END CHOOSE

Return li_RtnVal
end function

public function integer of_print (datawindow adw_target);Int	li_RtnVal = 1
Int	li_IsUdw

li_IsUdw = adw_target.TriggerEvent('pfc_descendant')

IF li_IsUdw = 1 THEN
	IF This.of_PrintUDW(adw_target) <> 1 THEN
		li_RtnVal = -1
	END IF
ELSE
	IF This.of_PrintDW(adw_target) <> 1 THEN
		li_RtnVal = -1
	END IF
END IF

Return li_RtnVal
end function

public function integer of_printudw (u_dw anv_target);Int li_RtnVal = 1
Long		ll_Result
Window	lw_Parent

s_PrintdlgAttrib lstr_PrintDlg
n_cst_PlatForm lnv_platform

IF This.of_IsPrintDialogToBeShown( ) THEN
	f_SetPlatForm(lnv_platform,True)
	IF anv_target.of_GetParentWindow(lw_Parent) = 1 THEN
		ll_Result = lnv_platform.of_PrintDlg(lstr_printdlg,lw_Parent)
		IF ll_Result = -1  THEN
			li_RtnVal = -1
		ELSE
			anv_target.Print()
		END IF
	END IF
	f_SetPlatForm(lnv_platform,False)		
ELSE
	anv_target.Print()
END IF

Return li_RtnVal
end function

public function integer of_printdw (datawindow adw_target);Int 		li_RtnVal = 1
Int 		li_result
Long 		ll_pj
String	ls_jobname 

ls_jobname = 'Print'

IF This.of_IsPrintDialogToBeShown( ) THEN
	IF PrintSetup() <> 1 THEN
		li_RtnVal = -1
	END IF
END IF

IF li_RtnVal = 1 THEN
	ll_pj = PrintOpen(ls_jobname)
	
	IF ll_pj = -1 THEN
		li_RtnVal = -1 
	END IF
END IF

IF li_RtnVal = 1 THEN
	li_result = PrintDataWindow(ll_pj, adw_target)
END IF
	
IF li_result = -1 THEN
	PrintCancel(ll_pj)
	li_RtnVal = -1 
ELSE
	IF PrintClose(ll_pj) = -1 THEN
		PrintCancel(ll_pj)
		li_RtnVal = -1
	END IF
END IF

Return li_RtnVal
end function

public function integer of_print (datastore ads_target);Int		li_RtnVal = 1
Int		li_IsUdw

li_IsUdw = ads_target.TriggerEvent('pfc_descendant') 

IF li_IsUdw = 1 THEN
	IF This.of_PrintNDS(ads_target) <> 1 THEN 
		li_RtnVal = -1
	END IF	
ELSE
	IF This.of_PrintDataStore(ads_target) <> 1 THEN
		li_RtnVal = -1
	END IF
END IF

Return li_RtnVal


end function

public function integer of_printnds (n_ds anv_target);Int li_RtnVal = 1
Long		ll_Result
Window	lw_Parent

s_PrintdlgAttrib lstr_PrintDlg
n_cst_PlatForm lnv_platform

IF This.of_IsPrintDialogToBeShown( ) THEN
	
	f_SetPlatForm(lnv_platform,True)
	IF anv_target.of_GetParentWindow(lw_Parent) = 1 THEN
		ll_Result = lnv_platform.of_PrintDlg(lstr_printdlg,lw_Parent)
		IF ll_Result = -1  THEN
			li_RtnVal = -1
		ELSE
			anv_target.Print()
		END IF
	END IF
	f_SetPlatForm(lnv_platform,False)		
ELSE
	anv_target.Print()
END IF



Return li_RtnVal
end function

public function integer of_printdatastore (datastore ads_target);Int 		li_RtnVal = 1
Int 		li_result
Long 		ll_pj
String	ls_jobname

ls_jobname = 'Print'

IF This.of_IsPrintDialogToBeShown( ) THEN
	IF PrintSetup() <> 1 THEN
		li_RtnVal = -1
	END IF
END IF

IF li_RtnVal = 1 THEN
	ll_pj = PrintOpen(ls_jobname)
	 
	IF ll_pj = -1 THEN
		li_RtnVal = -1
	END IF
END IF	
	
IF li_RtnVal = 1 THEN
	li_result = PrintDataWindow(ll_pj, ads_target)
END IF
	
IF li_result = -1 THEN
	PrintCancel(ll_pj)
	li_RtnVal = -1
ELSE
	IF PrintClose(ll_pj) = -1 THEN
		PrintCancel(ll_pj)
		li_RtnVal = -1
	END IF
END IF

Return li_RtnVal
end function

public function integer of_print (window aw_print);Int		li_RtnVal = 1
Long		ll_PrintJob
String	ls_JobName

ls_JobName = 'Print'

IF This.of_IsPrintDialogToBeShown( ) THEN 
	IF PrintSetupPrinter() <> 1 THEN
		li_RtnVal = -1
	END IF
END IF

IF li_RtnVal = 1 THEN

	ll_PrintJob = PrintOpen(ls_JobName)
	
	IF aw_Print.Print(ll_PrintJob,1,1) = -1 THEN
		PrintCancel(ll_PrintJob)
	ELSE
		IF PrintClose(ll_PrintJob) = -1 THEN
			PrintCancel(ll_PrintJob)
		END IF
	END IF
END IF

Return li_RtnVal
end function

public function string of_selectprinter ();string	ls_response, &
			ls_printerlist, &
			lsa_list[]
			
integer	li_selected, &
			li_ndx, &
			li_count

n_ds			lds_list
s_strings 	lstr_SelectionList
n_cst_string	lnv_string

w_list_sel	lw_selectionlist

ls_printerlist = printgetprinters()

lds_list = create n_ds
lds_list.settransobject( sqlca)
lds_list.dataobject = 'd_printerlist'
lds_list.settransobject( sqlca)
lds_list.importstring( ls_printerlist)

for li_ndx = 1 to lds_list.rowcount()
	lsa_list[li_ndx] = lds_list.object.printername[li_ndx]
next

//lnv_string.of_parsetoarray(ls_printerlist, "~n", lsa_list)
li_count=upperbound(lsa_list)

if li_count > 0 then
	
	//Build the message header for the selection dialog.
	lstr_SelectionList.strar[1] = "Printer Selection" 
	
	//Build the message text for the selection dialog.
	lstr_SelectionList.strar[2] = "Please select a printer. Cancel will print to the default printer."
	for li_ndx = 1 to li_count
		lstr_SelectionList.strar[li_ndx + 4] = lsa_list[li_ndx]
	next
	
	openwithparm(lw_selectionlist, lstr_Selectionlist)

	ls_response = message.stringparm
	
	if len(ls_response) > 0 then 
		li_selected = integer(left(ls_response, len(ls_response) - 1))
	end if

	if li_selected > 0 then
		ls_response = lsa_list[li_selected]
	end if
	
end if


return ls_response
end function

on n_cst_printsrvc.create
call super::create
end on

on n_cst_printsrvc.destroy
call super::destroy
end on

