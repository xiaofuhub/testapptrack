$PBExportHeader$n_cst_accountingdata.sru
forward
global type n_cst_accountingdata from nonvisualobject
end type
end forward

global type n_cst_accountingdata from nonvisualobject
end type
global n_cst_accountingdata n_cst_accountingdata

type variables
constant string	cs_payables='PAYABLES'
constant string	cs_payroll='PAYROLL'
constant string	cs_mixed="MIXED"
constant string	cs_receivables="RECEIVABLES"

private:
boolean	ib_validated
date	id_Document, &
	id_end, &
	id_due
long	il_entityid, &
	il_shiptype
long	il_CompanyId     // RDT 5-26-03
string	is_PublicNote,&
	is_EntityName, &
	is_entitytype, &
	is_payrollid, &
	is_payablesid, &
	is_receivablesid, &
	is_DocumentNumber, &
	is_transactionAccount, &
	isa_distributionapaccount[],&
	isa_distributioncashaccount[],&
	isa_distributioncostaccount[], &
	isa_distributionexpenseaccount[],&
	is_category, &
	is_description, &
	is_batchid, &
	is_ref1text, &
	is_ref2text, &
	is_ref3text, &
	isa_DistributionNote[]
	
decimal	ic_pretaxnet, &
	ica_distributionamount[], &
	ica_quantity[]
	

end variables

forward prototypes
public function date of_getdocumentdate ()
public function string of_getpublicnote ()
public subroutine of_setdocumentdate (date ad_document)
public subroutine of_setpublicnote (string as_note)
public function string of_getentityname ()
public function string of_gettransactionaccount ()
public subroutine of_setentityname (string as_entity)
public subroutine of_settransactionaccount (string as_account)
public function decimal of_getpretaxnet ()
public subroutine of_setpretaxnet (decimal ac_pretaxnet)
public subroutine of_setdistributionamount (decimal aca_amount[])
public function string of_getdocumentnumber ()
public subroutine of_setdocumentnumber (string as_document)
public function string of_getcategory ()
public subroutine of_setcategory (string as_category)
public subroutine of_setdescription (string as_description)
public function string of_getdescription ()
public subroutine of_setenddate (date ad_value)
public function date of_getenddate ()
public function long of_getcostexpenseaccount (ref string asa_value[])
public function long of_getapcashaccount (ref string asa_value[])
public subroutine of_setdistributionapaccount (ref string asa_value[])
public subroutine of_setdistributioncostaccount (string asa_value[])
public subroutine of_setdistributioncashaccount (string asa_value[])
public subroutine of_setdistributionexpenseaccount (string asa_value[])
public function long of_getdistributionapaccount (ref string asa_value[])
public function long of_getdistributioncostaccount (ref string asa_value[])
public function long of_getdistributionexpenseaccount (ref string asa_value[])
public function string of_getbatchid ()
public subroutine of_setbatchid (string as_value)
public subroutine of_setentityid (long al_value)
public function long of_getentityid ()
public function long of_validateaccountmaps ()
public function long of_getdistributionamount (ref decimal aca_amount[])
public function long of_getdistributioncashaccount (ref string asa_value[])
public function long of_getdistributionquantity (ref decimal aca_quantity[])
public subroutine of_setdistributionquantity (decimal aca_value[])
public subroutine of_setduedate (date ad_value)
public function date of_getduedate ()
public subroutine of_setvalidated (boolean ab_value)
public function boolean of_isvalidated ()
public subroutine of_setpayablesid (string as_value)
public subroutine of_setpayrollid (string as_value)
public function string of_getpayablesid ()
public function string of_getpayrollid ()
public function string of_getreceivablesid ()
public subroutine of_setreceivablesid (string as_value)
public function string of_getaccountpayablestype ()
public function string of_getentitytype ()
public subroutine of_setentitytype ()
public subroutine of_setref1text (string as_value)
public subroutine of_setref2text (string as_value)
public subroutine of_setref3text (string as_value)
public function string of_getref1text ()
public function string of_getref2test ()
public function string of_getref3text ()
public function string of_getrefnumbers ()
public subroutine of_setshiptype (long al_value)
public function long of_getshiptype ()
public function long of_getcompanyid ()
public subroutine of_setcompanyid (long al_companyid)
public subroutine of_setdistributionnote (string asa_notes[])
public function integer of_getdistributionnotes (ref string asa_notes[])
end prototypes

public function date of_getdocumentdate ();//transaction date

return id_document
end function

public function string of_getpublicnote ();return is_publicnote
end function

public subroutine of_setdocumentdate (date ad_document);//transaction date

id_document = ad_document
end subroutine

public subroutine of_setpublicnote (string as_note);is_publicnote = as_note
end subroutine

public function string of_getentityname ();return is_entityname
end function

public function string of_gettransactionaccount ();return is_transactionaccount
end function

public subroutine of_setentityname (string as_entity);is_entityname = as_entity
end subroutine

public subroutine of_settransactionaccount (string as_account);is_transactionaccount = as_account
end subroutine

public function decimal of_getpretaxnet ();return ic_pretaxnet
end function

public subroutine of_setpretaxnet (decimal ac_pretaxnet);ic_pretaxnet = ac_pretaxnet
end subroutine

public subroutine of_setdistributionamount (decimal aca_amount[]);ica_distributionamount = aca_amount
end subroutine

public function string of_getdocumentnumber ();return is_DocumentNumber
end function

public subroutine of_setdocumentnumber (string as_document);is_documentnumber = as_document
end subroutine

public function string of_getcategory ();return is_category
end function

public subroutine of_setcategory (string as_category);is_category = as_category
end subroutine

public subroutine of_setdescription (string as_description);is_description = as_description
end subroutine

public function string of_getdescription ();return is_description
end function

public subroutine of_setenddate (date ad_value);id_end = ad_value
end subroutine

public function date of_getenddate ();return id_end
end function

public function long of_getcostexpenseaccount (ref string asa_value[]);//return the cost accounts for payable or the payrollexpense accounts for payroll
long	ll_return
choose case this.of_getcategory ()
		
	case cs_payables
		ll_return = this.of_getdistributioncostaccount(asa_value)		
	case cs_payroll
		ll_return = this.of_getdistributionexpenseaccount(asa_value)		
end choose

return ll_return
end function

public function long of_getapcashaccount (ref string asa_value[]);//return the ap accounts for payable or the payrollcash accounts for payroll
long	ll_return
choose case this.of_getcategory ()
		
	case cs_payables
		ll_return = this.of_getdistributionapaccount(asa_value)		
	case cs_payroll
		ll_return = this.of_getdistributioncashaccount(asa_value)		
end choose

return ll_return
end function

public subroutine of_setdistributionapaccount (ref string asa_value[]);isa_distributionapaccount = asa_value

end subroutine

public subroutine of_setdistributioncostaccount (string asa_value[]);isa_distributioncostaccount = asa_value
end subroutine

public subroutine of_setdistributioncashaccount (string asa_value[]);isa_distributioncashaccount = asa_value
end subroutine

public subroutine of_setdistributionexpenseaccount (string asa_value[]);isa_distributionexpenseaccount = asa_value
end subroutine

public function long of_getdistributionapaccount (ref string asa_value[]);asa_value = isa_distributionapaccount

return upperbound(asa_value)
end function

public function long of_getdistributioncostaccount (ref string asa_value[]);asa_value = isa_distributioncostaccount

return upperbound(asa_value)
end function

public function long of_getdistributionexpenseaccount (ref string asa_value[]);asa_value = isa_distributionexpenseaccount

return upperbound(asa_value)
end function

public function string of_getbatchid ();return is_batchid
end function

public subroutine of_setbatchid (string as_value);is_batchid = as_value
end subroutine

public subroutine of_setentityid (long al_value);il_entityid = al_value
end subroutine

public function long of_getentityid ();return il_entityid
end function

public function long of_validateaccountmaps ();long	ll_ndx, &
		ll_count, &
		ll_invalid, &
		ll_return = 1
		
string	lsa_apcashaccount[], &
			lsa_costexpenseaccount[]
			
ll_count = this.of_getapcashaccount(lsa_apcashaccount)
for ll_ndx = 1 to ll_count
	
	if len(trim(lsa_apcashaccount[ll_ndx])) = 0 or isnull(lsa_apcashaccount[ll_ndx]) then
		ll_invalid ++
	end if
	
next
ll_count = this.of_getcostexpenseaccount(lsa_costexpenseaccount)
for ll_ndx = 1 to ll_count
	
	if len(trim(lsa_costexpenseaccount[ll_ndx])) = 0 or isnull(lsa_costexpenseaccount[ll_ndx]) then
		ll_invalid ++
	end if
	
next

if ll_invalid > 0 then
	ll_return = -1
end if

return ll_return
end function

public function long of_getdistributionamount (ref decimal aca_amount[]);aca_amount = ica_distributionamount

return upperbound(aca_amount)
end function

public function long of_getdistributioncashaccount (ref string asa_value[]);asa_value = isa_distributioncashaccount

return upperbound(asa_value)
end function

public function long of_getdistributionquantity (ref decimal aca_quantity[]);aca_quantity = ica_quantity

return upperbound(aca_quantity)
end function

public subroutine of_setdistributionquantity (decimal aca_value[]);ica_quantity = aca_value
end subroutine

public subroutine of_setduedate (date ad_value);id_due = ad_value
end subroutine

public function date of_getduedate ();return id_due
end function

public subroutine of_setvalidated (boolean ab_value);ib_validated = ab_value
end subroutine

public function boolean of_isvalidated ();return ib_validated
end function

public subroutine of_setpayablesid (string as_value);is_payablesid = as_value
end subroutine

public subroutine of_setpayrollid (string as_value);is_payrollid = as_value
end subroutine

public function string of_getpayablesid ();return is_payablesid
end function

public function string of_getpayrollid ();return is_payrollid
end function

public function string of_getreceivablesid ();return is_receivablesid
end function

public subroutine of_setreceivablesid (string as_value);is_receivablesid = as_value
end subroutine

public function string of_getaccountpayablestype ();/*
	Derive the type based on the ids in the instance variables
*/

boolean	lb_payables, &
			lb_payroll
	
string	ls_type

if isnull(is_payablesid) then
	lb_payables = false
else
	if len(trim(is_payablesid)) = 0 then
		lb_payables = false
	else
		lb_payables = true
	end if
end if

if isnull(is_payrollid) then
	lb_payroll = false
else
	if len(trim(is_payrollid)) = 0 then
		lb_payroll = false
	else
		lb_payroll = true
	end if
end if

if lb_payroll and lb_payables then
	ls_type = cs_mixed
else
	if lb_payables then
		ls_type = cs_payables
	elseif lb_payroll then
		ls_type = cs_payroll
	else
		ls_type = ''
	end if
end if

return ls_type
end function

public function string of_getentitytype ();return is_entitytype
end function

public subroutine of_setentitytype ();string	ls_APType, &
			ls_ARType

ls_APType = this.of_GetAccountPayablesType()

ls_ARType = this.of_GetReceivablesId()

if len(trim(ls_ARType)) > 0 then
	if len(trim(ls_APType)) > 0 then
		is_entitytype = cs_mixed
	end if
else
	is_entitytype = ls_APType
end if


end subroutine

public subroutine of_setref1text (string as_value);is_ref1text  = as_value
end subroutine

public subroutine of_setref2text (string as_value);is_ref2text  = as_value
end subroutine

public subroutine of_setref3text (string as_value);is_ref3text  = as_value
end subroutine

public function string of_getref1text ();return is_ref1text
end function

public function string of_getref2test ();return is_ref2text
end function

public function string of_getref3text ();return is_ref3text
end function

public function string of_getrefnumbers ();string ls_refnumbers

if len(is_ref1text) > 0 then
	ls_refnumbers = is_ref1text
end if

if len(is_ref2text) > 0 then
	if len(ls_refnumbers) > 0 then
		ls_refnumbers += ", "
	end if
	ls_refnumbers += is_ref2text
end if

if len(is_ref3text) > 0 then
	if len(ls_refnumbers) > 0 then
		ls_refnumbers += ", "
	end if
	ls_refnumbers += is_ref3text
end if

return ls_refnumbers
end function

public subroutine of_setshiptype (long al_value);il_shiptype = al_value
end subroutine

public function long of_getshiptype ();return il_shiptype
end function

public function long of_getcompanyid ();Return il_CompanyId  
end function

public subroutine of_setcompanyid (long al_companyid);il_CompanyId  = al_companyid
end subroutine

public subroutine of_setdistributionnote (string asa_notes[]);isa_Distributionnote = asa_notes[]
end subroutine

public function integer of_getdistributionnotes (ref string asa_notes[]);asa_notes = isa_distributionnote
RETURN 1
end function

on n_cst_accountingdata.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_accountingdata.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

