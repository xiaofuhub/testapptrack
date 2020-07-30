$PBExportHeader$n_cst_dlkc_employee.sru
$PBExportComments$Employee (DataLink from PBL map PTData) //@(*)[84888599|1474:bdm]<nosync>
forward
global type n_cst_dlkc_employee from n_cst_dlk
end type
end forward

global type n_cst_dlkc_employee from n_cst_dlk
end type
global n_cst_dlkc_employee n_cst_dlkc_employee

forward prototypes
public function integer modifywhereclause ()
end prototypes

public function integer modifywhereclause ();//@(*)[84888599|1474:cdwc]<nosync>//@(-)Do not edit, move or copy this line//
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
      ls_append = " WHERE ~"employees~".~"em_id~" = " + String(la_quotedargs[1])
   case "entity"
      ls_append = " WHERE ~"employees~".~"em_id~" = " + String(la_quotedargs[1])

END CHOOSE
if ls_append <> "" then
   ls_syntax = ls_syntax + ls_append
   if ids_view.SetSqlSelect(ls_syntax) < 0 then
      this.PushException("modifywhereclause")
      return -1
   end if
 end if
//@(text)--

//Custom Retrieval Extensions //RDT 2-21-03

Boolean	lb_Custom
n_cst_Sql	lnv_Sql
Constant String		ls_AppendBase = " WHERE "

CHOOSE CASE is_dlk_relation

CASE "Ids"
	lb_Custom = TRUE
	ls_Append = " WHERE ~"employees~".~"em_id~"" + lnv_Sql.of_MakeInClause ( la_QuotedArgs[1] )

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

on n_cst_dlkc_employee.create
TriggerEvent( this, "constructor" )
end on

on n_cst_dlkc_employee.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;call super::constructor;//@(data)(recreate=yes)<init>
this.SetDataSource("d_dlkc_employee")
this.SetIsClassDLK(TRUE)
inv_bcm.AddClass("n_cst_beo_employee", TRUE)
//@(data)--

//@(data)(recreate=yes)<Column Map>
this.MapAttribute("employee_id", "n_cst_beo_employee", "id")
this.MapAttribute("employee_salutation", "n_cst_beo_employee", "salutation")
this.MapAttribute("employee_firstname", "n_cst_beo_employee", "firstname")
this.MapAttribute("employee_middlename", "n_cst_beo_employee", "middlename")
this.MapAttribute("employee_lastname", "n_cst_beo_employee", "lastname")
this.MapAttribute("employee_nickname", "n_cst_beo_employee", "nickname")
this.MapAttribute("employee_employeeid", "n_cst_beo_employee", "employeeid")
this.MapAttribute("employee_status", "n_cst_beo_employee", "status")
this.MapAttribute("employee_onhold", "n_cst_beo_employee", "onhold")
this.MapAttribute("employee_type", "n_cst_beo_employee", "type")
this.MapAttribute("employee_class", "n_cst_beo_employee", "class")
this.MapAttribute("employee_password", "n_cst_beo_employee", "password")
this.MapAttribute("employee_title", "n_cst_beo_employee", "title")
this.MapAttribute("employee_maxpermit", "n_cst_beo_employee", "maxpermit")
this.MapAttribute("employee_itinpermit", "n_cst_beo_employee", "itinpermit")
this.MapAttribute("employee_ssn", "n_cst_beo_employee", "ssn")
this.MapAttribute("employee_dob", "n_cst_beo_employee", "dob")
this.MapAttribute("employee_startdate", "n_cst_beo_employee", "startdate")
this.MapAttribute("employee_stopdate", "n_cst_beo_employee", "stopdate")
this.MapAttribute("employee_phone", "n_cst_beo_employee", "phone")
this.MapAttribute("employee_sex", "n_cst_beo_employee", "sex")
this.MapAttribute("employee_address1", "n_cst_beo_employee", "address1")
this.MapAttribute("employee_city", "n_cst_beo_employee", "city")
this.MapAttribute("employee_state", "n_cst_beo_employee", "state")
this.MapAttribute("employee_zip", "n_cst_beo_employee", "zip")
this.MapAttribute("employee_email", "n_cst_beo_employee", "email")
this.MapAttribute("employee_pager", "n_cst_beo_employee", "pager")
this.MapAttribute("employee_emergcontactname", "n_cst_beo_employee", "emergcontactname")
this.MapAttribute("employee_emergcontactrelation", "n_cst_beo_employee", "emergcontactrelation")
this.MapAttribute("employee_emergcontacthomephone", "n_cst_beo_employee", "emergcontacthomephone")
this.MapAttribute("employee_emergcontactworkphone", "n_cst_beo_employee", "emergcontactworkphone")
this.MapAttribute("employee_comments", "n_cst_beo_employee", "comments")
this.MapAttribute("employee_restrictedcomments", "n_cst_beo_employee", "restrictedcomments")
//@(data)--

//@(data)(recreate=yes)<map>
this.RegisterUpdateTable("employees")
this.MapDBColumn("employee_id", "employees", "em_id", 1)
this.MapDBColumn("employee_salutation", "employees", "em_sal", 0)
this.MapDBColumn("employee_firstname", "employees", "em_fn", 0)
this.MapDBColumn("employee_middlename", "employees", "em_mn", 0)
this.MapDBColumn("employee_lastname", "employees", "em_ln", 0)
this.MapDBColumn("employee_nickname", "employees", "em_nickname", 0)
this.MapDBColumn("employee_employeeid", "employees", "em_ref", 0)
this.MapDBColumn("employee_status", "employees", "em_status", 0)
this.MapDBColumn("employee_onhold", "employees", "em_on_hold", 0)
this.MapDBColumn("employee_type", "employees", "em_type", 0)
this.MapDBColumn("employee_class", "employees", "em_class", 0)
this.MapDBColumn("employee_password", "employees", "em_password", 0)
this.MapDBColumn("employee_title", "employees", "em_title", 0)
this.MapDBColumn("employee_maxpermit", "employees", "em_max_permit", 0)
this.MapDBColumn("employee_itinpermit", "employees", "em_itin_permit", 0)
this.MapDBColumn("employee_ssn", "employees", "em_ss", 0)
this.MapDBColumn("employee_dob", "employees", "em_dob", 0)
this.MapDBColumn("employee_startdate", "employees", "em_start_date", 0)
this.MapDBColumn("employee_stopdate", "employees", "em_stop_date", 0)
this.MapDBColumn("employee_phone", "employees", "em_tele", 0)
this.MapDBColumn("employee_sex", "employees", "em_sex", 0)
this.MapDBColumn("employee_address1", "employees", "em_street", 0)
this.MapDBColumn("employee_city", "employees", "em_city", 0)
this.MapDBColumn("employee_state", "employees", "em_state", 0)
this.MapDBColumn("employee_zip", "employees", "em_zip", 0)
this.MapDBColumn("employee_email", "employees", "em_email", 0)
this.MapDBColumn("employee_pager", "employees", "em_pager", 0)
this.MapDBColumn("employee_emergcontactname", "employees", "em_emerg_name", 0)
this.MapDBColumn("employee_emergcontactrelation", "employees", "em_emerg_rel", 0)
this.MapDBColumn("employee_emergcontacthomephone", "employees", "em_emerg_h", 0)
this.MapDBColumn("employee_emergcontactworkphone", "employees", "em_emerg_w", 0)
this.MapDBColumn("employee_comments", "employees", "em_comments", 0)
this.MapDBColumn("employee_restrictedcomments", "employees", "em_restrictedcomments", 0)
//@(data)--

end event

