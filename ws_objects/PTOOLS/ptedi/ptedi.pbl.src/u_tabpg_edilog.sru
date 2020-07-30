$PBExportHeader$u_tabpg_edilog.sru
forward
global type u_tabpg_edilog from u_tabpg
end type
type dw_1 from u_dw within u_tabpg_edilog
end type
end forward

global type u_tabpg_edilog from u_tabpg
integer width = 3374
integer height = 1680
long backcolor = 12632256
long tabbackcolor = 12632256
dw_1 dw_1
end type
global u_tabpg_edilog u_tabpg_edilog

type variables
protected:
long		ila_Shipid[]
Long		il_CompanyID
end variables

forward prototypes
public subroutine of_setcompany (long ala_id)
public subroutine of_setshipment (long ala_shipid[])
public function long of_getshipment (ref long ala_shipid[])
public subroutine of_send ()
public function long of_getselectedid (ref long ala_id[])
public subroutine of_delete (long ala_id[])
public subroutine of_refresh ()
private function integer of_setcompanyid (long al_id)
public function long of_getcompany ()
end prototypes

public subroutine of_setcompany (long ala_id);
end subroutine

public subroutine of_setshipment (long ala_shipid[]);ila_Shipid = ala_shipid
end subroutine

public function long of_getshipment (ref long ala_shipid[]);ala_shipid = ila_shipid

return upperbound(ala_shipid)
end function

public subroutine of_send ();long	ll_ndx, &
		ll_count, &
		ll_found, &
		lla_id[], &
		ll_transactionSet
		
string	ls_TransactionSet		

n_cst_msg					lnv_msg
n_cst_edi_transaction	lnv_cst_edi_transaction

ls_TransactionSet = 'n_cst_edi_transaction_'

this.of_getSelectedId(lla_id)

ll_count = upperbound(lla_id)

for ll_ndx = 1 to ll_count
	
	ll_found = dw_1.find('edi_id = ' + string(lla_id[ll_ndx]), 1, dw_1.rowcount())
	
	if ll_found > 0 then
		
		ll_TransactionSet = dw_1.object.edi_transactionSet[ll_found]
		
		choose case ll_transactionSet
				
			case appeon_constant.cl_transaction_set_214
		
				ls_TransactionSet = ls_TransactionSet + string(ll_TransactionSet)
				lnv_cst_edi_transaction = CREATE USING ls_TransactionSet
						
				lnv_cst_edi_transaction.of_SetResend(true)
				lnv_cst_edi_transaction.of_SendTransaction({lla_id[ll_ndx]})
				lnv_cst_edi_transaction.of_UpdateEDICache()

				DESTROY lnv_cst_edi_transaction
		
			case appeon_constant.cl_transaction_set_322
		

			case appeon_constant.cl_transaction_set_210
				
				ls_TransactionSet = ls_TransactionSet + string(ll_TransactionSet)
				lnv_cst_edi_transaction = CREATE USING ls_TransactionSet
				lnv_cst_edi_transaction.of_SendTransaction({lla_id[ll_ndx]})
				lnv_cst_edi_transaction.of_UpdateEDICache()
				DESTROY lnv_cst_edi_transaction
				
			case else
				//create all transaction sets
				
		end choose

	end if
	
next


end subroutine

public function long of_getselectedid (ref long ala_id[]);long	ll_row, &
		ll_rowcount, &
		ll_count, &
		lla_id[]
		
ll_rowcount = dw_1.rowcount()

for ll_row = 1 to ll_rowcount
	if dw_1.isSelected(ll_row) then
		ll_count ++
		lla_id[ll_count] = dw_1.object.edi_id[ll_row]
	end if
next
	
if upperbound(lla_id) > 0 then
	ala_id = lla_id
end if

return upperbound(ala_id)
end function

public subroutine of_delete (long ala_id[]);long 	ll_ndx, &
		ll_count, &
		ll_found

ll_count = upperbound(ala_id)

if messagebox("Delete EDI", "Are you sure you want to delete the selected rows?", Question!, Yesno!) = 1 then
	for ll_ndx = 1 to ll_count
		ll_found = dw_1.find('edi_id = ' + string(ala_id[ll_ndx]), 1, dw_1.rowcount())
		if ll_found > 0 then
			dw_1.deleterow(ll_found)
		end if
		
	next

	if dw_1.update(true,true) = 1 then
		commit;
	end if
	
end if
	

end subroutine

public subroutine of_refresh ();//script in descendant 
end subroutine

private function integer of_setcompanyid (long al_id);il_companyid = al_id

RETURN 1
end function

public function long of_getcompany ();RETURN il_companyid
end function

on u_tabpg_edilog.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on u_tabpg_edilog.destroy
call super::destroy
destroy(this.dw_1)
end on

event constructor;call super::constructor;long	lla_Shipid[]

n_cst_msg	lnv_msg
s_parm		lstr_Parm

IF IsValid( Message.PowerObjectParm ) Then 
	If UPPER( Message.PowerObjectParm.ClassName ( ) ) = "N_CST_MSG" Then 
		lnv_msg = Message.PowerObjectParm	
	End If
END IF

if isvalid(lnv_msg) then
	IF lnv_msg.of_Get_Parm ( "SHIPMENTIDS" , lstr_Parm ) <> 0 THEN
		lla_Shipid = lstr_Parm.ia_Value
		this.of_setshipment(lla_Shipid) 
	END IF
end if


if isvalid(lnv_msg) then
	IF lnv_msg.of_Get_Parm ( "COMPANYID" , lstr_Parm ) <> 0 THEN
		THIS.of_SetCompanyid( lstr_Parm.ia_value )
		
	END IF
end if
end event

type dw_1 from u_dw within u_tabpg_edilog
integer x = 64
integer y = 108
integer width = 512
integer height = 328
integer taborder = 10
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event constructor;call super::constructor;// enable multi-row-select-ability
THIS.of_SetRowSelect ( TRUE ) 
inv_rowselect.of_SetStyle (2) //2 = extended row select service

of_setinsertable ( false )
of_setDeleteable ( false )

of_SetAutoSort ( TRUE )


end event

