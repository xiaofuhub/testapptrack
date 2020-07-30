$PBExportHeader$n_cst_dlkc_accountmap.sru
$PBExportComments$AccountMap (DataLink from PBL map PTSetl) //@(*)[75486947|1605:bdm]<nosync>
forward
global type n_cst_dlkc_accountmap from n_cst_dlk
end type
end forward

global type n_cst_dlkc_accountmap from n_cst_dlk
end type
global n_cst_dlkc_accountmap n_cst_dlkc_accountmap

forward prototypes
public function Integer ModifyWhereClause ()
end prototypes

public function Integer ModifyWhereClause ();//@(*)[75486947|1605:cdwc]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
   
string ls_syntax
string ls_append
integer li_loop,li_end
any la_quotedargs[]

ls_syntax = ids_view.GetSqlSelect()

li_end = UpperBound(iany_args)
for li_loop = 1 to li_end
   if not isNull(iany_args[li_loop]) then
      la_quotedargs[li_loop] = iany_args[li_loop]
   end if
next

this.SetQuotes(la_quotedargs[])

CHOOSE CASE is_dlk_relation
   case ""
      ls_append = " WHERE ~"accountmap~".~"amounttypeid~" = " + String(la_quotedargs[1])+ " AND ~"accountmap~".~"division~" = " + String(la_quotedargs[2])
   case "amounttype"
      ls_append = " WHERE ~"accountmap~".~"amounttypeid~" = " + String(la_quotedargs[1])

END CHOOSE
if ls_append <> "" then
   ls_syntax = ls_syntax + ls_append
   if ids_view.SetSqlSelect(ls_syntax) < 0 then
      this.PushException("modifywhereclause")
      return -1
   end if
 end if
//@(text)--

//@(text)(recreate=yes)<Return status>
return 1
//@(text)--

end function

on n_cst_dlkc_accountmap.create
TriggerEvent(this, "constructor")
end on

on n_cst_dlkc_accountmap.destroy
TriggerEvent(this, "destructor")
end on

event constructor;call super::constructor;//@(data)(recreate=yes)<init>
this.SetDataSource("d_dlkc_accountmap")
this.SetIsClassDLK(TRUE)
inv_bcm.AddClass("n_cst_beo_accountmap", TRUE)
//@(data)--

//@(data)(recreate=yes)<Column Map>
this.MapAttribute("accountmap_division", "n_cst_beo_accountmap", "division")
this.MapAttribute("accountmap_araccount", "n_cst_beo_accountmap", "araccount")
this.MapAttribute("accountmap_salesaccount", "n_cst_beo_accountmap", "salesaccount")
this.MapAttribute("accountmap_apaccount", "n_cst_beo_accountmap", "apaccount")
this.MapAttribute("accountmap_costaccount", "n_cst_beo_accountmap", "costaccount")
this.MapAttribute("accountmap_payrollcashaccount", "n_cst_beo_accountmap", "payrollcashaccount")
this.MapAttribute("accountmap_payrollexpenseaccount", "n_cst_beo_accountmap", "payrollexpenseaccount")
this.MapAttribute("accountmap_amounttypeid", "n_cst_beo_accountmap", "amounttypeid")
//@(data)--

//@(data)(recreate=yes)<map>
this.RegisterUpdateTable("AccountMap")
this.MapDBColumn("accountmap_division", "AccountMap", "Division", 1)
this.MapDBColumn("accountmap_araccount", "AccountMap", "ARAccount", 0)
this.MapDBColumn("accountmap_salesaccount", "AccountMap", "SalesAccount", 0)
this.MapDBColumn("accountmap_apaccount", "AccountMap", "APAccount", 0)
this.MapDBColumn("accountmap_costaccount", "AccountMap", "CostAccount", 0)
this.MapDBColumn("accountmap_payrollcashaccount", "AccountMap", "PayrollCashAccount", 0)
this.MapDBColumn("accountmap_payrollexpenseaccount", "AccountMap", "PayrollExpenseAccount", 0)
this.MapDBColumn("accountmap_amounttypeid", "AccountMap", "AmountTypeId", 1)
//@(data)--

end event

