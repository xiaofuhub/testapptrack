$PBExportHeader$n_cst_dlkc_equipmentleasetype.sru
$PBExportComments$EquipmentLeaseType (DataLink from PBL map PTData) //@(*)[72656228|583:bdm]<nosync>
forward
global type n_cst_dlkc_equipmentleasetype from n_cst_dlk
end type
end forward

global type n_cst_dlkc_equipmentleasetype from n_cst_dlk
end type
global n_cst_dlkc_equipmentleasetype n_cst_dlkc_equipmentleasetype

forward prototypes
public function Integer ModifyWhereClause ()
end prototypes

public function Integer ModifyWhereClause ();//@(*)[72656228|583:cdwc]<nosync>//@(-)Do not edit, move or copy this line//
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
      ls_append = " WHERE ~"equipmentleasetype~".~"id~" = " + String(la_quotedargs[1])
   case "equipmentlease"
      ls_append = " WHERE ~"equipmentleasetype~".~"id~" = " + String(la_quotedargs[1])

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

on n_cst_dlkc_equipmentleasetype.create
call super::create
end on

on n_cst_dlkc_equipmentleasetype.destroy
call super::destroy
end on

event constructor;call super::constructor;//@(data)(recreate=yes)<init>
this.SetDataSource("d_dlkc_equipmentleasetype")
this.SetIsClassDLK(TRUE)
inv_bcm.AddClass("n_cst_beo_equipmentleasetype", TRUE)
//@(data)--

//@(data)(recreate=yes)<Column Map>
this.MapAttribute("equipmentleasetype_id", "n_cst_beo_equipmentleasetype", "id")
this.MapAttribute("equipmentleasetype_line", "n_cst_beo_equipmentleasetype", "line")
this.MapAttribute("equipmentleasetype_type", "n_cst_beo_equipmentleasetype", "type")
this.MapAttribute("equipmentleasetype_freetimeunits", "n_cst_beo_equipmentleasetype", "freetimeunits")
this.MapAttribute("equipmentleasetype_freetimeperiod", "n_cst_beo_equipmentleasetype", "freetimeperiod")
this.MapAttribute("equipmentleasetype_chargedperiods", "n_cst_beo_equipmentleasetype", "chargedperiods")
this.MapAttribute("equipmentleasetype_firstchargedunits", "n_cst_beo_equipmentleasetype", "firstchargedunits")
this.MapAttribute("equipmentleasetype_firstchargedperiod", "n_cst_beo_equipmentleasetype", "firstchargedperiod")
this.MapAttribute("equipmentleasetype_firstchargedrate", "n_cst_beo_equipmentleasetype", "firstchargedrate")
this.MapAttribute("equipmentleasetype_secondchargedunits", "n_cst_beo_equipmentleasetype", "secondchargedunits")
this.MapAttribute("equipmentleasetype_secondchargedperiod", "n_cst_beo_equipmentleasetype", "secondchargedperiod")
this.MapAttribute("equipmentleasetype_secondchargedrate", "n_cst_beo_equipmentleasetype", "secondchargedrate")
this.MapAttribute("equipmentleasetype_thirdchargedunits", "n_cst_beo_equipmentleasetype", "thirdchargedunits")
this.MapAttribute("equipmentleasetype_thirdchargedperiod", "n_cst_beo_equipmentleasetype", "thirdchargedperiod")
this.MapAttribute("equipmentleasetype_thirdchargedrate", "n_cst_beo_equipmentleasetype", "thirdchargedrate")
this.MapAttribute("equipmentleasetype_fourthchargedunits", "n_cst_beo_equipmentleasetype", "fourthchargedunits")
this.MapAttribute("equipmentleasetype_fourthchargedperiod", "n_cst_beo_equipmentleasetype", "fourthchargedperiod")
this.MapAttribute("equipmentleasetype_fourthchargedrate", "n_cst_beo_equipmentleasetype", "fourthchargedrate")
this.MapAttribute("equipmentleasetype_spec1", "n_cst_beo_equipmentleasetype", "spec1")
this.MapAttribute("equipmentleasetype_spec2", "n_cst_beo_equipmentleasetype", "spec2")
this.MapAttribute("equipmentleasetype_spec3", "n_cst_beo_equipmentleasetype", "spec3")
this.MapAttribute("equipmentleasetype_spec4", "n_cst_beo_equipmentleasetype", "spec4")
this.MapAttribute("equipmentleasetype_spec5", "n_cst_beo_equipmentleasetype", "spec5")
this.MapAttribute("equipmentleasetype_user1", "n_cst_beo_equipmentleasetype", "user1")
this.MapAttribute("equipmentleasetype_user2", "n_cst_beo_equipmentleasetype", "user2")
this.MapAttribute("equipmentleasetype_notes", "n_cst_beo_equipmentleasetype", "notes")
// rdt 08/05/02
this.MapAttribute("equipmentleasetype_freetimestart", "n_cst_beo_equipmentleasetype", "freetimestart")
this.MapAttribute("equipmentleasetype_freetimefriday", "n_cst_beo_equipmentleasetype", "freetimefriday")
this.MapAttribute("equipmentleasetype_freetimeholiday", "n_cst_beo_equipmentleasetype", "freetimeholiday")
this.MapAttribute("equipmentleasetype_freetimeweekend", "n_cst_beo_equipmentleasetype", "freetimeweekend")
this.MapAttribute("equipmentleasetype_perdiemholiday", "n_cst_beo_equipmentleasetype", "perdiemholiday")
this.MapAttribute("equipmentleasetype_leasestatus", "n_cst_beo_equipmentleasetype", "leasestatus")
this.MapAttribute("equipmentleasetype_lineprefix", "n_cst_beo_equipmentleasetype", "lineprefix")
this.MapAttribute("equipmentleasetype_equipmentlength", "n_cst_beo_equipmentleasetype", "equipmentlength")
//<<*>>
this.MapAttribute("equipmentleasetype_scac", "n_cst_beo_equipmentleasetype", "scac")
this.MapAttribute("equipmentleasetype_dayofinterchangecounts", "n_cst_beo_equipmentleasetype", "dayofinterchangecounts")
//@(data)--

//@(data)(recreate=yes)<map>
this.RegisterUpdateTable("EquipmentLeaseType")
this.MapDBColumn("equipmentleasetype_id", "EquipmentLeaseType", "Id", 1)
this.MapDBColumn("equipmentleasetype_line", "EquipmentLeaseType", "Line", 0)
this.MapDBColumn("equipmentleasetype_type", "EquipmentLeaseType", "Type", 0)
this.MapDBColumn("equipmentleasetype_freetimeunits", "EquipmentLeaseType", "FreeTimeUnits", 0)
this.MapDBColumn("equipmentleasetype_freetimeperiod", "EquipmentLeaseType", "FreeTimePeriod", 0)
this.MapDBColumn("equipmentleasetype_chargedperiods", "EquipmentLeaseType", "ChargedPeriods", 0)
this.MapDBColumn("equipmentleasetype_firstchargedunits", "EquipmentLeaseType", "FirstChargedUnits", 0)
this.MapDBColumn("equipmentleasetype_firstchargedperiod", "EquipmentLeaseType", "FirstChargedPeriod", 0)
this.MapDBColumn("equipmentleasetype_firstchargedrate", "EquipmentLeaseType", "FirstChargedRate", 0)
this.MapDBColumn("equipmentleasetype_secondchargedunits", "EquipmentLeaseType", "SecondChargedUnits", 0)
this.MapDBColumn("equipmentleasetype_secondchargedperiod", "EquipmentLeaseType", "SecondChargedPeriod", 0)
this.MapDBColumn("equipmentleasetype_secondchargedrate", "EquipmentLeaseType", "SecondChargedRate", 0)
this.MapDBColumn("equipmentleasetype_thirdchargedunits", "EquipmentLeaseType", "ThirdChargedUnits", 0)
this.MapDBColumn("equipmentleasetype_thirdchargedperiod", "EquipmentLeaseType", "ThirdChargedPeriod", 0)
this.MapDBColumn("equipmentleasetype_thirdchargedrate", "EquipmentLeaseType", "ThirdChargedRate", 0)
this.MapDBColumn("equipmentleasetype_fourthchargedunits", "EquipmentLeaseType", "FourthChargedUnits", 0)
this.MapDBColumn("equipmentleasetype_fourthchargedperiod", "EquipmentLeaseType", "FourthChargedPeriod", 0)
this.MapDBColumn("equipmentleasetype_fourthchargedrate", "EquipmentLeaseType", "FourthChargedRate", 0)
this.MapDBColumn("equipmentleasetype_spec1", "EquipmentLeaseType", "Spec1", 0)
this.MapDBColumn("equipmentleasetype_spec2", "EquipmentLeaseType", "Spec2", 0)
this.MapDBColumn("equipmentleasetype_spec3", "EquipmentLeaseType", "Spec3", 0)
this.MapDBColumn("equipmentleasetype_spec4", "EquipmentLeaseType", "Spec4", 0)
this.MapDBColumn("equipmentleasetype_spec5", "EquipmentLeaseType", "Spec5", 0)
this.MapDBColumn("equipmentleasetype_user1", "EquipmentLeaseType", "User1", 0)
this.MapDBColumn("equipmentleasetype_user2", "EquipmentLeaseType", "User2", 0)
this.MapDBColumn("equipmentleasetype_notes", "EquipmentLeaseType", "Notes", 0)
// rdt 08/05/02
this.MapDBColumn("equipmentleasetype_freetimestart", "EquipmentLeaseType", "freetimestart", 0)
this.MapDBColumn("equipmentleasetype_freetimefriday", "EquipmentLeaseType", "freetimefriday", 0)
this.MapDBColumn("equipmentleasetype_freetimeholiday", "EquipmentLeaseType", "freetimeholiday", 0)
this.MapDBColumn("equipmentleasetype_freetimeweekend", "EquipmentLeaseType", "freetimeweekend", 0)
this.MapDBColumn("equipmentleasetype_perdiemholiday", "EquipmentLeaseType", "perdiemholiday", 0)
this.MapDBColumn("equipmentleasetype_leasestatus", "EquipmentLeaseType", "leasestatus", 0)
this.MapDBColumn("equipmentleasetype_lineprefix", "EquipmentLeaseType", "lineprefix", 0)
this.MapDBColumn("equipmentleasetype_equipmentlength", "EquipmentLeaseType", "equipmentlength", 0)
//<<*>>
this.MapDBColumn("equipmentleasetype_scac", "EquipmentLeaseType", "scac", 0)
this.MapDBColumn("equipmentleasetype_dayofinterchangecounts", "EquipmentLeaseType", "dayofinterchangecounts", 0)



//@(data)--

end event

