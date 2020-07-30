$PBExportHeader$n_cst_dlkc_trip.sru
$PBExportComments$Trip (DataLink from PBL map PTDisp) //@(*)[152122892|1127:bdm]<nosync>
forward
global type n_cst_dlkc_trip from n_cst_dlk
end type
end forward

global type n_cst_dlkc_trip from n_cst_dlk
end type
global n_cst_dlkc_trip n_cst_dlkc_trip

forward prototypes
public function Integer ModifyWhereClause ()
end prototypes

public function Integer ModifyWhereClause ();//@(*)[152122892|1127:cdwc]<nosync>//@(-)Do not edit, move or copy this line//
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
      ls_append = " WHERE ~"brok_trips~".~"bt_id~" = " + String(la_quotedargs[1])
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

on n_cst_dlkc_trip.create
TriggerEvent(this, "constructor")
end on

on n_cst_dlkc_trip.destroy
TriggerEvent(this, "destructor")
end on

event constructor;call super::constructor;//@(data)(recreate=yes)<init>
this.SetDataSource("d_dlkc_trip")
this.SetIsClassDLK(TRUE)
inv_bcm.AddClass("n_cst_beo_trip", TRUE)
//@(data)--

//@(data)(recreate=yes)<Column Map>
this.MapAttribute("trip_id", "n_cst_beo_trip", "id")
this.MapAttribute("trip_tripdate", "n_cst_beo_trip", "tripdate")
this.MapAttribute("trip_carriertripnumber", "n_cst_beo_trip", "carriertripnumber")
this.MapAttribute("trip_driver", "n_cst_beo_trip", "driver")
this.MapAttribute("trip_equipmenttype", "n_cst_beo_trip", "equipmenttype")
this.MapAttribute("trip_equipmentnumber", "n_cst_beo_trip", "equipmentnumber")
this.MapAttribute("trip_chassisnumber", "n_cst_beo_trip", "chassisnumber")
this.MapAttribute("trip_originid", "n_cst_beo_trip", "originid")
this.MapAttribute("trip_destinationid", "n_cst_beo_trip", "destinationid")
this.MapAttribute("trip_miles", "n_cst_beo_trip", "miles")
this.MapAttribute("trip_totalweight", "n_cst_beo_trip", "totalweight")
this.MapAttribute("trip_internalnote", "n_cst_beo_trip", "internalnote")
this.MapAttribute("trip_payablestotal", "n_cst_beo_trip", "payablestotal")
this.MapAttribute("trip_status", "n_cst_beo_trip", "status")
//@(data)--

//Special handling of CarrierId

//CarrierId is custom implemented, because HOW wouldn't generate it as an attribute
//because it's a foreign key.  For other references, browse this object and the beo 
//for carrierid.  The column is also forced into the dlkc.

this.MapAttribute("trip_carrierid", "n_cst_beo_trip", "carrierid")

//@(data)(recreate=yes)<map>
this.RegisterUpdateTable("brok_trips")
this.MapDBColumn("trip_id", "brok_trips", "bt_id", 1)
this.MapDBColumn("trip_tripdate", "brok_trips", "bt_tripdate", 0)
this.MapDBColumn("trip_carriertripnumber", "brok_trips", "bt_tripnum", 0)
this.MapDBColumn("trip_driver", "brok_trips", "bt_driver", 0)
this.MapDBColumn("trip_equipmenttype", "brok_trips", "bt_eq_type", 0)
this.MapDBColumn("trip_equipmentnumber", "brok_trips", "bt_eq_ref", 0)
this.MapDBColumn("trip_chassisnumber", "brok_trips", "bt_chassis_ref", 0)
this.MapDBColumn("trip_originid", "brok_trips", "bt_origin_id", 0)
this.MapDBColumn("trip_destinationid", "brok_trips", "bt_findest_id", 0)
this.MapDBColumn("trip_miles", "brok_trips", "bt_miles", 0)
this.MapDBColumn("trip_totalweight", "brok_trips", "bt_weight", 0)
this.MapDBColumn("trip_internalnote", "brok_trips", "bt_trip_comment", 0)
this.MapDBColumn("trip_payablestotal", "brok_trips", "bt_paycar_tot", 0)
this.MapDBColumn("trip_status", "brok_trips", "bt_pmtstatus", 0)
//@(data)--

//Special handling of CarrierId  (see note above)

this.MapDBColumn("trip_carrierid", "brok_trips", "bt_carrier_id", 0)
end event

