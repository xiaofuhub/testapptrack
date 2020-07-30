$PBExportHeader$n_cst_dlkc_transaction.sru
$PBExportComments$Transaction (DataLink from PBL map PTSetl) //@(*)[104076276|61:bdm]<nosync>
forward
global type n_cst_dlkc_transaction from n_cst_dlk
end type
end forward

global type n_cst_dlkc_transaction from n_cst_dlk
end type
global n_cst_dlkc_transaction n_cst_dlkc_transaction

forward prototypes
public function integer modifywhereclause ()
end prototypes

public function integer modifywhereclause ();//@(*)[104076276|61:cdwc]<nosync>//@(-)Do not edit, move or copy this line//
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
      ls_append = " WHERE ~"transaction~".~"id~" = " + String(la_quotedargs[1])
   case "entity"
      ls_append = " WHERE ~"transaction~".~"fkentity~" = " + String(la_quotedargs[1])

   case "amountowed"
      ls_append = " WHERE ~"transaction~".~"id~" = " + String(la_quotedargs[1])

END CHOOSE
if ls_append <> "" then
   ls_syntax = ls_syntax + ls_append
   if ids_view.SetSqlSelect(ls_syntax) < 0 then
      this.PushException("modifywhereclause")
      return -1
   end if
 end if
//@(text)--


//Custom Retrieval Extensions

Boolean	lb_Custom
n_cst_Sql	lnv_Sql
Constant String		ls_AppendBase = " WHERE "

CHOOSE CASE is_dlk_relation

CASE "TransactionsOpen"
	lb_Custom = TRUE
	ls_Append = " WHERE ~"transaction~".~"open~" = 1"

CASE "EntityTransactionsOpen"
	lb_Custom = TRUE
	ls_Append = " WHERE ~"transaction~".~"fkentity~" = " + String(la_quotedargs[1]) +&
		" AND ~"transaction~".~"open~" = 1"

CASE "UnbatchedTransactions"
	lb_Custom = TRUE
	ls_Append = " WHERE ~"transaction~".~"batched~" = 0"

CASE "EntityUnbatchedTransactions"
	lb_Custom = TRUE
	ls_Append = " WHERE ~"transaction~".~"fkentity~" = " + String(la_quotedargs[1]) +&
		" AND ~"transaction~".~"batched~" = 0"

CASE "Ids"
	lb_Custom = TRUE
	ls_Append = " WHERE ~"transaction~".~"id~"" + lnv_Sql.of_MakeInClause ( la_QuotedArgs[1] )

CASE "BatchNumber"
	lb_Custom = TRUE
	ls_Append = " WHERE ~"transaction~".~"batchnumber~" = " + la_QuotedArgs[1]

CASE "DateRange", "EntityDateRange"

	lb_Custom = TRUE
	ls_Append = ls_AppendBase

	//Note: Date values are in la_QuotedArgs as strings.
	//We use ClassName to test whether the date values have been set.  If they aren't, 
	//they're anys, not strings, but isnull didn't seem to work.

	IF ClassName ( la_QuotedArgs[1] ) = "string" THEN

		IF NOT la_QuotedArgs[1] = "''" THEN
			ls_Append += "~"transaction~".~"enddate~" >= " + la_QuotedArgs[1] + " "
		END IF

	END IF


	IF ClassName ( la_QuotedArgs[2] ) = "string" THEN

		IF NOT la_QuotedArgs[2] = "''" THEN
	
			IF NOT ls_Append = ls_AppendBase THEN
				ls_Append += " AND "
			END IF
	
			ls_Append += "~"transaction~".~"startdate~" <= " + la_quotedargs[2] + " "
	
		END IF

	END IF


	IF is_dlk_relation = "EntityDateRange" THEN

		IF NOT IsNull ( la_QuotedArgs[3] ) THEN

			IF NOT ls_Append = ls_AppendBase THEN
				ls_Append += " AND "
			END IF

			ls_Append += "~"transaction~".~"fkentity~" = " + String(la_quotedargs[3]) + " "

		END IF

	END IF

	//Verify that at least one condition was added, and if not, clear the where clause
	//(Retrieval will not proceed)
	IF ls_Append = " WHERE " THEN
		ls_Append = ""
	END IF

END CHOOSE

IF lb_Custom = TRUE AND &
	ls_Append <> "" THEN

   ls_syntax = ls_syntax + ls_append
   if ids_view.SetSqlSelect(ls_syntax) < 0 then
      this.PushException("modifywhereclause")
      return -1
   end if

END IF

//@(text)(recreate=yes)<Return status>
return 1
//@(text)--

end function

on n_cst_dlkc_transaction.create
TriggerEvent( this, "constructor" )
end on

on n_cst_dlkc_transaction.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;call super::constructor;//@(data)(recreate=yes)<init>
this.SetDataSource("d_dlkc_transaction")
this.SetIsClassDLK(TRUE)
inv_bcm.AddClass("n_cst_beo_transaction", TRUE)
//@(data)--

//@(data)(recreate=yes)<Column Map>
this.MapAttribute("transaction_id", "n_cst_beo_transaction", "id")
this.MapAttribute("transaction_category", "n_cst_beo_transaction", "category")
this.MapAttribute("transaction_type", "n_cst_beo_transaction", "type")
this.MapAttribute("transaction_startdate", "n_cst_beo_transaction", "startdate")
this.MapAttribute("transaction_enddate", "n_cst_beo_transaction", "enddate")
this.MapAttribute("transaction_taxablegross", "n_cst_beo_transaction", "taxablegross")
this.MapAttribute("transaction_nontaxablegross", "n_cst_beo_transaction", "nontaxablegross")
this.MapAttribute("transaction_pretaxnet", "n_cst_beo_transaction", "pretaxnet")
this.MapAttribute("transaction_fixedamount", "n_cst_beo_transaction", "fixedamount")
this.MapAttribute("transaction_status", "n_cst_beo_transaction", "status")
this.MapAttribute("transaction_open", "n_cst_beo_transaction", "open")
this.MapAttribute("transaction_documentdate", "n_cst_beo_transaction", "documentdate")
this.MapAttribute("transaction_documentnumber", "n_cst_beo_transaction", "documentnumber")
this.MapAttribute("transaction_description", "n_cst_beo_transaction", "description")
this.MapAttribute("transaction_internalnote", "n_cst_beo_transaction", "internalnote")
this.MapAttribute("transaction_publicnote", "n_cst_beo_transaction", "publicnote")
this.MapAttribute("transaction_ref1type", "n_cst_beo_transaction", "ref1type")
this.MapAttribute("transaction_ref1text", "n_cst_beo_transaction", "ref1text")
this.MapAttribute("transaction_ref2type", "n_cst_beo_transaction", "ref2type")
this.MapAttribute("transaction_ref2text", "n_cst_beo_transaction", "ref2text")
this.MapAttribute("transaction_ref3type", "n_cst_beo_transaction", "ref3type")
this.MapAttribute("transaction_ref3text", "n_cst_beo_transaction", "ref3text")
this.MapAttribute("transaction_modlog", "n_cst_beo_transaction", "modlog")
this.MapAttribute("transaction_batched", "n_cst_beo_transaction", "batched")
this.MapAttribute("transaction_batchdate", "n_cst_beo_transaction", "batchdate")
this.MapAttribute("transaction_batchnumber", "n_cst_beo_transaction", "batchnumber")
this.MapAttribute("transaction_fkentity", "n_cst_beo_transaction", "fkentity")
//@(data)--

//@(data)(recreate=yes)<map>
this.RegisterUpdateTable("Transaction")
this.MapDBColumn("transaction_id", "Transaction", "Id", 1)
this.MapDBColumn("transaction_category", "Transaction", "Category", 0)
this.MapDBColumn("transaction_type", "Transaction", "Type", 0)
this.MapDBColumn("transaction_startdate", "Transaction", "StartDate", 0)
this.MapDBColumn("transaction_enddate", "Transaction", "EndDate", 0)
this.MapDBColumn("transaction_taxablegross", "Transaction", "TaxableGross", 0)
this.MapDBColumn("transaction_nontaxablegross", "Transaction", "NonTaxableGross", 0)
this.MapDBColumn("transaction_pretaxnet", "Transaction", "PreTaxNet", 0)
this.MapDBColumn("transaction_fixedamount", "Transaction", "FixedAmount", 0)
this.MapDBColumn("transaction_status", "Transaction", "Status", 0)
this.MapDBColumn("transaction_open", "Transaction", "Open", 0)
this.MapDBColumn("transaction_documentdate", "Transaction", "DocumentDate", 0)
this.MapDBColumn("transaction_documentnumber", "Transaction", "DocumentNumber", 0)
this.MapDBColumn("transaction_description", "Transaction", "Description", 0)
this.MapDBColumn("transaction_internalnote", "Transaction", "InternalNote", 0)
this.MapDBColumn("transaction_publicnote", "Transaction", "PublicNote", 0)
this.MapDBColumn("transaction_ref1type", "Transaction", "Ref1Type", 0)
this.MapDBColumn("transaction_ref1text", "Transaction", "Ref1Text", 0)
this.MapDBColumn("transaction_ref2type", "Transaction", "Ref2Type", 0)
this.MapDBColumn("transaction_ref2text", "Transaction", "Ref2Text", 0)
this.MapDBColumn("transaction_ref3type", "Transaction", "Ref3Type", 0)
this.MapDBColumn("transaction_ref3text", "Transaction", "Ref3Text", 0)
this.MapDBColumn("transaction_modlog", "Transaction", "ModLog", 0)
this.MapDBColumn("transaction_batched", "Transaction", "Batched", 0)
this.MapDBColumn("transaction_batchdate", "Transaction", "BatchDate", 0)
this.MapDBColumn("transaction_batchnumber", "Transaction", "BatchNumber", 0)
this.MapDBColumn("transaction_fkentity", "Transaction", "fkEntity", 0)
//@(data)--

end event

