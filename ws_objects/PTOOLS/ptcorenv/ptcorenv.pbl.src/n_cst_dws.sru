$PBExportHeader$n_cst_dws.sru
forward
global type n_cst_dws from nonvisualobject
end type
end forward

global type n_cst_dws from nonvisualobject autoinstantiate
end type

forward prototypes
public function integer of_get_column_list (powerobject apo_source, ref string asa_column_list[])
public function integer of_copy_by_column (powerobject apo_source, long al_source_row, powerobject apo_target, long al_target_row)
public function integer of_get_extent (datawindow adw_target, string as_direction, string as_band, ref long al_extent)
public function integer of_create_header (ref string asa_parm_labels[], ref any aaa_parm_values[])
public function boolean of_get_tag_value (powerobject apo_target, string as_object_name, string as_tag_label, ref string as_tag_value)
public function integer of_get_object_syntax (powerobject apo_target, ref string asa_list[])
public function integer of_get_object_list (powerobject apo_target, ref string asa_list[])
public function integer of_find_object_syntax (ref string asa_list[], string as_name)
public function boolean of_set_segment (ref string as_syntax, string as_label, string as_value)
public function boolean of_columnexists (powerobject apo_target, string as_column)
public function object of_resolvepowerobject (powerobject apo_target, ref datawindow adw_target, ref datastore ads_target)
public function double of_getitemnumber (powerobject apo_target, long al_row, string as_column)
public function string of_getitemstring (powerobject apo_target, long al_row, string as_column)
public function date of_getitemdate (powerobject apo_target, long al_row, string as_column)
public function time of_getitemtime (powerobject apo_target, long al_row, string as_column)
public function datetime of_getitemdatetime (powerobject apo_target, long al_row, string as_column)
public function decimal of_getitemdecimal (powerobject apo_target, long al_row, string as_column)
public function datastore of_createdatastore (string as_select)
public function long of_selectedcount (datawindow adw_target, ref long al_selectedrows[])
public function integer of_getmaxvalue (string as_table, string as_column, ref long al_value)
public function dwbuffer of_getbuffer (integer ai_index)
public function long of_find (powerobject apo_target, string as_expression, long al_start, long al_end)
public function long of_find (powerobject apo_target, string as_expression)
public function long of_rowcount (powerobject apo_target)
public function integer of_setitem (powerobject apo_target, long al_row, string as_column, any aa_value)
public function long of_insertrow (powerobject apo_target, long al_row)
public function string of_modify (powerobject apo_target, string as_command)
public function integer of_copy_by_column (powerobject apo_source, long al_sourcerow, powerobject apo_target, long al_targetrow, readonly string asa_sourcealias[], readonly string asa_targetalias[])
public function string of_describe (powerobject apo_target, string as_command)
public function integer of_selectrow (powerobject apo_target, long al_row, boolean ab_selection)
public function integer of_rowsdiscard (powerobject apo_target, long al_start, long al_end, dwbuffer ae_buffer)
public function integer of_createhighlight (datawindow adw_target)
public function datastore of_createdatastore (string asa_columnlist[])
public function datastore of_createdatastore (integer ai_columncount)
public function integer of_getrowfromrowid (powerobject apo_target, long al_rowid, ref long al_row, ref dwbuffer ae_buffer)
public function date of_getitemdate (powerobject apo_target, long al_row, string as_column, dwbuffer ae_buffer, boolean ab_originalvalue)
public function datetime of_getitemdatetime (powerobject apo_target, long al_row, string as_column, dwbuffer ae_buffer, boolean ab_originalvalue)
public function decimal of_getitemdecimal (powerobject apo_target, long al_row, string as_column, dwbuffer ae_buffer, boolean ab_originalvalue)
public function double of_getitemnumber (powerobject apo_target, long al_row, string as_column, dwbuffer ae_buffer, boolean ab_originalvalue)
public function string of_getitemstring (powerobject apo_target, long al_row, string as_column, dwbuffer ae_buffer, boolean ab_originalvalue)
public function time of_getitemtime (powerobject apo_target, long al_row, string as_column, dwbuffer ae_buffer, boolean ab_originalvalue)
public function long of_getrowidfromrow (powerobject apo_target, long al_row, dwbuffer ae_buffer)
public function long of_filteredcount (powerobject apo_target)
public function long of_deletedcount (powerobject apo_target)
public function integer of_createdatastorebydataobject (readonly string as_dataobject, ref datastore ads_target, readonly boolean ab_pfc)
public function long of_selectedcount (datawindow adw_target)
public function integer of_rowsmove (powerobject apo_source, long al_start, long al_end, dwbuffer ae_sourcebuffer, powerobject apo_target, long al_before, dwbuffer ae_targetbuffer)
public function string of_getdataobject (powerobject apo_target)
public function integer of_rowscopy (powerobject apo_source, long al_start, long al_end, dwbuffer ae_sourcebuffer, powerobject apo_target, long al_before, dwbuffer ae_targetbuffer)
public function long of_getobjectsatposition (datawindow adw_target, long al_x, long al_y, string as_band, ref string asa_objects[])
public function integer of_setitemnull (powerobject apo_target, long al_row, string as_column)
public function integer of_update (powerobject apo_target, boolean ab_accepttext, boolean ab_resetupdate)
public function integer of_update (powerobject apo_target, boolean ab_accepttext)
public function integer of_update (powerobject apo_target)
public function long of_getcustomviewlist (string as_viewname, ref string asa_displaynames[])
public function integer of_setcustomview (datawindow adw_target, string as_viewname, string as_displayname, boolean ab_handleredraw, ref string as_sort, ref string as_filter)
public function any of_getitemany (powerobject apo_source, long al_row, string as_column)
public function integer of_rowscopy (datastore ads_source, long al_startrow, long al_endrow, dwbuffer ae_sourcebuffer, ref datastore ads_target, dwbuffer ae_targetbuffer)
end prototypes

public function integer of_get_column_list (powerobject apo_source, ref string asa_column_list[]);integer li_column_count, li_ndx
datawindow ldw_source
datastore lds_source

choose case apo_source.typeof()
case datawindow!
	ldw_source = apo_source
case datastore!
	lds_source = apo_source
case else
	return -1
end choose

if isvalid(ldw_source) then
	li_column_count = integer(ldw_source.object.datawindow.column.count)
elseif isvalid(lds_source) then
	li_column_count = integer(lds_source.object.datawindow.column.count)
else
	return -1
end if

for li_ndx = 1 to li_column_count
	if isvalid(ldw_source) then
		asa_column_list[li_ndx] = ldw_source.describe("#" + string(li_ndx) + ".name")
	elseif isvalid(lds_source) then
		asa_column_list[li_ndx] = lds_source.describe("#" + string(li_ndx) + ".name")
	end if
next

return li_column_count
end function

public function integer of_copy_by_column (powerobject apo_source, long al_source_row, powerobject apo_target, long al_target_row);string lsa_source_alias[], lsa_target_alias[]

return this.of_copy_by_column(apo_source, al_source_row, apo_target, al_target_row, &
	lsa_source_alias, lsa_target_alias)
end function

public function integer of_get_extent (datawindow adw_target, string as_direction, string as_band, ref long al_extent);string ls_objects, lsa_parsed[], ls_work, ls_position_extension, ls_span_extension
integer li_ndx
long ll_check, ll_max, ll_position, ll_span

setnull(al_extent)

if not isvalid(adw_target) then return -1

choose case as_direction
case "VERTICAL!"
	ls_position_extension = ".y"
	ls_span_extension = ".height"
case "HORIZONTAL!"
	ls_position_extension = ".x"
	ls_span_extension = ".width"
case else
	return -1
end choose

ls_objects = adw_target.describe("datawindow.objects")

n_cst_string lnv_string
lnv_string.of_ParseToArray(ls_objects, "~t", lsa_parsed)

for li_ndx = 1 to upperbound(lsa_parsed)
	if adw_target.describe(lsa_parsed[li_ndx] + ".band") = as_band then

		ls_work = adw_target.describe(lsa_parsed[li_ndx] + ls_position_extension)
		ll_check = pos(ls_work, "~t")
		if ll_check > 0 then ls_work = left(ls_work, ll_check - 1)
		if isnumber(ls_work) then ll_position = long(ls_work) else continue

		ls_work = adw_target.describe(lsa_parsed[li_ndx] + ls_span_extension)
		ll_check = pos(ls_work, "~t")
		if ll_check > 0 then ls_work = left(ls_work, ll_check - 1)
		if isnumber(ls_work) then ll_span = long(ls_work) else continue

		ll_max = max(ll_max, ll_position + ll_span)

	end if
next

al_extent = ll_max
return 1
end function

public function integer of_create_header (ref string asa_parm_labels[], ref any aaa_parm_values[]);//What ought to replace this technique is a function that would take a "template" 
//datawindow object and duplicate the objects in it in the target dw.  That way, if
//we wanted to change the layout or properties of those objects, we could do so 
//graphically and have the changes roll through automatically.

n_cst_numerical lnv_numerical
integer li_num_labels, li_num_values, li_ndx
string ls_report_name, ls_report_label, ls_range_01, ls_range_02, ls_work
powerobject lpo_target

li_num_labels = upperbound(asa_parm_labels)
li_num_values = upperbound(aaa_parm_values)

if lnv_numerical.of_IsNullOrNotPos(li_num_labels) or lnv_numerical.of_IsNullOrNotPos(li_num_values) then return -1

for li_ndx = 1 to li_num_labels
	if li_ndx > li_num_values then exit
	choose case asa_parm_labels[li_ndx]
	case "TARGET!"
		lpo_target = aaa_parm_values[li_ndx]
	case "REPORT_NAME!"
		ls_report_name = aaa_parm_values[li_ndx]
	case "REPORT_LABEL!"
		ls_report_label = aaa_parm_values[li_ndx]
	case "RANGE_01!"
		ls_range_01 = aaa_parm_values[li_ndx]
	case "RANGE_02!"
		ls_range_02 = aaa_parm_values[li_ndx]
	end choose
next

if not isvalid(lpo_target) then return -1

choose case lpo_target.typeof()
case datawindow!, datastore!
	//Valid types.  No processing needed.
case else
	return -1
end choose

ls_work = 'CREATE rectangle(band=header x="5" y="8" height="397" width="3484"  NAME_SEGMENT!  hidesnaked=1  brush.hatch="7" brush.color="553648127" pen.style="0" pen.width="10" pen.color="0"  background.mode="2" background.color="0" )'

ls_work = substitute(ls_work, "NAME_SEGMENT!", "name=dyn_r_header_box")
of_Modify ( lpo_Target, ls_Work )


ls_work = 'CREATE compute(band=header alignment="2" expression="EXPRESSION_VALUE!" border="0" color="0" x="37" y="304" height="77" width="3420" format="[general]"  NAME_SEGMENT!  hidesnaked=1  font.face="Arial" font.height="-12" font.weight="700"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="553648127" )'

ls_work = substitute(ls_work, "EXPRESSION_VALUE!", "gf_global_str('g_compname')")
ls_work = substitute(ls_work, "NAME_SEGMENT!", "name=dyn_cf_coname")
of_Modify ( lpo_Target, ls_Work )


ls_work = 'CREATE compute(band=header alignment="0" expression="EXPRESSION_VALUE!" border="0" color="0" x="37" y="108" height="61" width="929" format="[general]"  NAME_SEGMENT!  hidesnaked=1  font.face="Arial" font.height="-9" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="553648127" )'

ls_work = substitute(ls_work, "EXPRESSION_VALUE!", "'Printed:  ' + string(today(), 'm/d/yy  h:mm AM/PM')")
ls_work = substitute(ls_work, "NAME_SEGMENT!", "name=dyn_cf_datetime")
of_Modify ( lpo_Target, ls_Work )


ls_work = 'CREATE text(band=header alignment="2" text="TEXT_VALUE!" border="2" color="0" x="1166" y="156" height="81" width="1162"  NAME_SEGMENT!  hidesnaked=1  font.face="Arial" font.height="-12" font.weight="700"  font.family="2" font.pitch="2" font.charset="0" background.mode="2" background.color="65535" )'

ls_work = substitute(ls_work, "TEXT_VALUE!", ls_report_label)
ls_work = substitute(ls_work, "NAME_SEGMENT!", "name=dyn_st_report_label")
of_Modify ( lpo_Target, ls_Work )


ls_work = 'CREATE compute(band=header alignment="0" expression="EXPRESSION_VALUE!" border="0" color="0" x="37" y="176" height="61" width="929" format="[general]"  NAME_SEGMENT!  hidesnaked=1  font.face="Arial" font.height="-9" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="553648127" )'

ls_work = substitute(ls_work, "EXPRESSION_VALUE!", "'Page ' + page() + ' of ' + pageCount()")
ls_work = substitute(ls_work, "NAME_SEGMENT!", "name=dyn_cf_pages")
of_Modify ( lpo_Target, ls_Work )


ls_work = 'CREATE text(band=header alignment="2" text="TEXT_VALUE!" border="2" color="16777215" x="1166" y="36" height="93" width="1162"  NAME_SEGMENT!  hidesnaked=1  font.face="Arial" font.height="-14" font.weight="700"  font.family="2" font.pitch="2" font.charset="0" background.mode="2" background.color="0" )'

ls_work = substitute(ls_work, "TEXT_VALUE!", ls_report_name)
ls_work = substitute(ls_work, "NAME_SEGMENT!", "name=dyn_st_report_name")
of_Modify ( lpo_Target, ls_Work )


ls_work = 'CREATE text(band=header alignment="0" text="TEXT_VALUE!" border="0" color="0" x="37" y="40" height="61" width="929"  NAME_SEGMENT!  hidesnaked=1  font.face="Arial" font.height="-9" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="553648127" )'

ls_work = substitute(ls_work, "TEXT_VALUE!", gnv_App.of_GetAppName ( ) )
ls_work = substitute(ls_work, "NAME_SEGMENT!", "name=dyn_st_appname")
of_Modify ( lpo_Target, ls_Work )


ls_work = 'CREATE compute(band=header alignment="1" expression="EXPRESSION_VALUE!" border="0" color="0" x="2332" y="36" height="93" width="1125" format="[general]"  NAME_SEGMENT!  hidesnaked=1  font.face="Arial" font.height="-14" font.weight="700"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="553648127" )'

ls_work = substitute(ls_work, "EXPRESSION_VALUE!", ls_range_01)
ls_work = substitute(ls_work, "NAME_SEGMENT!", "name=dyn_cf_range_01")
of_Modify ( lpo_Target, ls_Work )


ls_work = 'CREATE compute(band=header alignment="1" expression="EXPRESSION_VALUE!" border="0" color="0" x="2332" y="156" height="81" width="1125" format="[general]"  NAME_SEGMENT!  hidesnaked=1  font.face="Arial" font.height="-12" font.weight="700"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="553648127" )'

ls_work = substitute(ls_work, "EXPRESSION_VALUE!", ls_range_02)
ls_work = substitute(ls_work, "NAME_SEGMENT!", "name=dyn_cf_range_02")
of_Modify ( lpo_Target, ls_Work )

return 1
end function

public function boolean of_get_tag_value (powerobject apo_target, string as_object_name, string as_tag_label, ref string as_tag_value);//Note : As of 2/2/99, this function wasn't being used anywhere.  Eliminate?

string ls_tag
long ll_start, ll_label, ll_equals, ll_semicolon

setnull(as_tag_value)

ls_Tag = of_Describe ( apo_Target, as_Object_Name + ".tag" )
//We may need to use describe("evaluate ...) since tag can be a quoted expression

IF IsNull ( ls_Tag ) THEN
	RETURN FALSE
END IF


ll_label = 0
ll_start = 0

do
	ll_label = max(pos(upper(ls_tag), upper(as_tag_label) + "=", ll_start + 1), &
		pos(upper(ls_tag), upper(as_tag_label) + ";", ll_start + 1))
	ll_start = 0

	if ll_label > 1 then
		if mid(ls_tag, ll_label - 1, 1) = ";" then
			//Proceed -- The found instance is not an accidental substring
		else
			//The found instance is an accidental substring
			ll_start = ll_label
			ll_label = 0
		end if
	end if
loop while ll_start > 0

if ll_label > 0 then
	ll_equals = pos(ls_tag, "=", ll_label)
	ll_semicolon = pos(ls_tag, ";", ll_equals)
	if ll_equals > 0 and ll_semicolon > ll_equals then
		//This takes into account:  BoolValue1;VarValue2=xxx;
		as_tag_value = mid(ls_tag, ll_equals + 1, ll_semicolon - (ll_equals + 1))
	end if
	return true
else
	return false
end if
end function

public function integer of_get_object_syntax (powerobject apo_target, ref string asa_list[]);integer li_count, li_ndx
datawindow ldw_target
datastore lds_target
string ls_syntax, lsa_list[], lsa_types[]
long ll_start, ll_end

asa_list = lsa_list

choose case apo_target.typeof()
case datawindow!
	ldw_target = apo_target
case datastore!
	lds_target = apo_target
case else
	return -1
end choose

lsa_types = {"bitmap", "column", "compute", "graph", "line", "ole", "ellipse", "rectangle", "report", "roundrectangle", "tableblob", "text"}

if isvalid(ldw_target) then
	ls_syntax = ldw_target.object.datawindow.syntax
elseif isvalid(lds_target) then
	ls_syntax = lds_target.object.datawindow.syntax
else
	return -1
end if

for li_ndx = 1 to upperbound(lsa_types)

	do
		ll_start = pos(ls_syntax, "~r~n" + lsa_types[li_ndx] + "(" )
	
		if ll_start > 0 then

			ll_start += 2
			ll_end = pos(ls_syntax, ")~r~n", ll_start)

			if ll_end > 0 then

				asa_list[upperbound(asa_list) + 1] = &
					mid(ls_syntax, ll_start, ll_end - ll_start + 1)

				ls_syntax = replace(ls_syntax, ll_start, ll_end - ll_start + 3, "")

			end if

		end if
	loop while ll_start > 0

next

li_count = upperbound(asa_list)

return li_count
end function

public function integer of_get_object_list (powerobject apo_target, ref string asa_list[]);integer li_count
datawindow ldw_target
datastore lds_target
string ls_work, lsa_list[]

asa_list = lsa_list

choose case apo_target.typeof()
case datawindow!
	ldw_target = apo_target
case datastore!
	lds_target = apo_target
case else
	return -1
end choose

if isvalid(ldw_target) then
	ls_work = ldw_target.describe("datawindow.objects")
elseif isvalid(lds_target) then
	ls_work = lds_target.describe("datawindow.objects")
else
	return -1
end if

n_cst_string lnv_string
li_count = lnv_string.of_ParseToArray(ls_work, "~t", lsa_list)

asa_list = lsa_list
return li_count
end function

public function integer of_find_object_syntax (ref string asa_list[], string as_name);//The asa_list[] is an array of object create syntaxes, presumably gotten earlier by 
//of_get_object_syntax().

string ls_find[2]
integer li_find, li_ndx

ls_find[1] = upper("(name=" + as_name + " ")
ls_find[2] = upper(" name=" + as_name + " ")

for li_find = 1 to upperbound(ls_find)
	for li_ndx = 1 to upperbound(asa_list)
		if pos(upper(asa_list[li_ndx]), ls_find[li_find]) > 0 then return li_ndx
	next
next

return 0
end function

public function boolean of_set_segment (ref string as_syntax, string as_label, string as_value);//This function will not work properly if the existing segment being set contains
//spaces (such as would likely be the case in an expression) or if the segment does
//not currently exist and should be added.  This is written to the narrow current 
//requirements of n_cst_dws_dynamic.of_dynamic_create, and will either need to be
//revised or (hopefully) replaced by something more general in the PFC.

string ls_segment
long ll_start, ll_end

ls_segment = lower(as_label) + "=" + as_value

ll_start = pos(upper(as_syntax), " " + upper(as_label) + "=")
if ll_start = 0 then pos(upper(as_syntax), "(" + upper(as_label) + "=")

if ll_start > 0 then
	ll_start ++
	ll_end = pos(as_syntax, " ", ll_start)
	if ll_end > 0 then ll_end --
end if

if ll_start > 0 and ll_end > ll_start then
	as_syntax = replace(as_syntax, ll_start, ll_end - ll_start + 1, ls_segment)
	return true
else
	return false
end if
end function

public function boolean of_columnexists (powerobject apo_target, string as_column);DataWindow	ldw_Target
DataStore	lds_Target

CHOOSE CASE of_ResolvePowerObject ( apo_Target, ldw_Target, lds_Target )

CASE DataWindow!
	IF Upper ( ldw_Target.Describe ( as_Column + ".Type" ) ) = "COLUMN" THEN
		RETURN TRUE
	ELSE
		RETURN FALSE
	END IF

CASE DataStore!
	IF Upper ( lds_Target.Describe ( as_Column + ".Type" ) ) = "COLUMN" THEN
		RETURN TRUE
	ELSE
		RETURN FALSE
	END IF

CASE ELSE
	RETURN FALSE

END CHOOSE
end function

public function object of_resolvepowerobject (powerobject apo_target, ref datawindow adw_target, ref datastore ads_target);Object	le_Type

IF IsValid ( apo_Target ) THEN
	le_Type = apo_Target.TypeOf ( )
END IF

CHOOSE CASE le_Type

CASE DataWindow!
	adw_Target = apo_Target

CASE DataStore!
	ads_Target = apo_Target

END CHOOSE

RETURN le_Type
end function

public function double of_getitemnumber (powerobject apo_target, long al_row, string as_column);RETURN This.of_GetItemNumber ( apo_Target, al_Row, as_Column, Primary!, FALSE )
end function

public function string of_getitemstring (powerobject apo_target, long al_row, string as_column);RETURN This.of_GetItemString ( apo_Target, al_Row, as_Column, Primary!, FALSE )
end function

public function date of_getitemdate (powerobject apo_target, long al_row, string as_column);RETURN This.of_GetItemDate ( apo_Target, al_Row, as_Column, Primary!, FALSE )
end function

public function time of_getitemtime (powerobject apo_target, long al_row, string as_column);RETURN This.of_GetItemTime ( apo_Target, al_Row, as_Column, Primary!, FALSE )
end function

public function datetime of_getitemdatetime (powerobject apo_target, long al_row, string as_column);RETURN This.of_GetItemDateTime ( apo_Target, al_Row, as_Column, Primary!, FALSE )
end function

public function decimal of_getitemdecimal (powerobject apo_target, long al_row, string as_column);RETURN This.of_GetItemDecimal ( apo_Target, al_Row, as_Column, Primary!, FALSE )
end function

public function datastore of_createdatastore (string as_select);String	ls_Presentation, &
			ls_Error, &
			ls_Syntax
DataStore	lds_New

ls_Syntax = SQLCA.SyntaxFromSQL ( as_Select, ls_Presentation, ls_Error )

lds_New = CREATE DataStore
lds_New.Create ( ls_Syntax )
lds_New.SetTransObject ( SQLCA )

RETURN lds_New
end function

public function long of_selectedcount (datawindow adw_target, ref long al_selectedrows[]);//Note:  This is a copy of the PFC function, with the addition of the adw_Target
//argument, which takes the place of idw_Requestor.

//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_SelectedCount
//
//	Access:  		Public
//
//	Arguments:  	none
//
//	Returns:  		Long
//						The number of selected rows in the datawindow.
//						-1 if an error occurs
//
//	Description:  	Count selected rows.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996 Powersoft Corporation.  All Rights Reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Powersoft is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
long	ll_selected=0
long	ll_counter=0

//Check for any requirements.
If IsNull(adw_Target) Or Not IsValid(adw_Target) Then Return -1

//Loop and count the number of selected rows.
DO
	ll_selected = adw_Target.GetSelectedRow ( ll_selected )
	IF ll_selected > 0 THEN
		ll_counter++
		al_selectedrows[ll_counter] = ll_selected
	END IF
LOOP WHILE ll_selected > 0

Return ll_counter

end function

public function integer of_getmaxvalue (string as_table, string as_column, ref long al_value);Long		ll_Value
String	ls_Select
Integer	li_Return

li_Return = -1

ls_Select = "SELECT Max ( COLUMN_NAME ) FROM TABLE_NAME"
ls_Select = Substitute ( ls_Select, "TABLE_NAME", as_Table )
ls_Select = Substitute ( ls_Select, "COLUMN_NAME", as_Column )

DECLARE cur_Work DYNAMIC CURSOR FOR SQLSA ;
IF SQLCA.SqlCode <> 0 THEN GOTO CleanUp

PREPARE SQLSA FROM :ls_Select ;
IF SQLCA.SqlCode <> 0 THEN GOTO CleanUp

OPEN DYNAMIC cur_Work ;
IF SQLCA.SqlCode <> 0 THEN GOTO CleanUp

FETCH cur_Work INTO :ll_Value ;
IF SQLCA.SqlCode <> 0 THEN GOTO CleanUp

al_Value = ll_Value
li_Return = 1

CleanUp:

CLOSE cur_Work ;
COMMIT ;

RETURN li_Return
end function

public function dwbuffer of_getbuffer (integer ai_index);DWBuffer	le_Buffer

CHOOSE CASE ai_Index
CASE 1
	le_Buffer = Primary!
CASE 2
	le_Buffer = Filter!
CASE 3
	le_Buffer = Delete!
CASE ELSE
	SetNull ( le_Buffer )
END CHOOSE

RETURN le_Buffer
end function

public function long of_find (powerobject apo_target, string as_expression, long al_start, long al_end);DataWindow	ldw_Target
DataStore	lds_Target
Long			ll_Null

CHOOSE CASE of_ResolvePowerObject ( apo_Target, ldw_Target, lds_Target )

CASE DataWindow!
	RETURN ldw_Target.Find ( as_Expression, al_Start, al_End )
CASE DataStore!
	RETURN lds_Target.Find ( as_Expression, al_Start, al_End )
CASE ELSE
	SetNull ( ll_Null )
	RETURN ll_Null

END CHOOSE
end function

public function long of_find (powerobject apo_target, string as_expression);DataWindow	ldw_Target
DataStore	lds_Target
Long			ll_Null

CHOOSE CASE of_ResolvePowerObject ( apo_Target, ldw_Target, lds_Target )

CASE DataWindow!
	RETURN of_Find ( apo_Target, as_Expression, 1, ldw_Target.RowCount ( ) )

CASE DataStore!
	RETURN of_Find ( apo_Target, as_Expression, 1, lds_Target.RowCount ( ) )

CASE ELSE
	SetNull ( ll_Null )
	RETURN ll_Null

END CHOOSE
end function

public function long of_rowcount (powerobject apo_target);DataWindow	ldw_Target
DataStore	lds_Target
Long			ll_Null

CHOOSE CASE of_ResolvePowerObject ( apo_Target, ldw_Target, lds_Target )

CASE DataWindow!
	RETURN ldw_Target.RowCount ( )
CASE DataStore!
	RETURN lds_Target.RowCount ( )
CASE ELSE
	SetNull ( ll_Null )
	RETURN ll_Null
END CHOOSE
end function

public function integer of_setitem (powerobject apo_target, long al_row, string as_column, any aa_value);//Returns:  1, -1, Null (Cannot resolve arguments)

DataWindow	ldw_Target
DataStore	lds_Target
Integer		li_Result

Integer		li_Return

IF IsNull ( aa_Value ) THEN

	//Any value will not be typed, so setitem will fail.  Need to call of_SetItemNull
	//in order to apply proper datatype to value so set will succeed.

	li_Result = This.of_SetItemNull ( apo_Target, al_Row, as_Column )

	IF li_Result = 1 THEN
		li_Return = 1
	ELSEIF IsNull ( li_Result ) THEN
		SetNull ( li_Return )
	ELSE //-1
		li_Return = -1
	END IF

ELSE

	CHOOSE CASE of_ResolvePowerObject ( apo_Target, ldw_Target, lds_Target )
	
	CASE DataWindow!
		li_Return = ldw_Target.SetItem ( al_Row, as_Column, aa_Value )
	
	CASE DataStore!
		li_Return = lds_Target.SetItem ( al_Row, as_Column, aa_Value )
	
	CASE ELSE
		SetNull ( li_Return )
	
	END CHOOSE

END IF

RETURN li_Return
end function

public function long of_insertrow (powerobject apo_target, long al_row);DataWindow	ldw_Target
DataStore	lds_Target
Long			ll_Null

CHOOSE CASE of_ResolvePowerObject ( apo_Target, ldw_Target, lds_Target )

CASE DataWindow!
	RETURN ldw_Target.InsertRow ( al_Row )
CASE DataStore!
	RETURN lds_Target.InsertRow ( al_Row )
CASE ELSE
	SetNull ( ll_Null )
	RETURN ll_Null

END CHOOSE
end function

public function string of_modify (powerobject apo_target, string as_command);DataWindow	ldw_Target
DataStore	lds_Target
String		ls_Null

CHOOSE CASE of_ResolvePowerObject ( apo_Target, ldw_Target, lds_Target )

CASE DataWindow!
	RETURN ldw_Target.Modify ( as_Command )
CASE DataStore!
	RETURN lds_Target.Modify ( as_Command )
CASE ELSE
	SetNull ( ls_Null )
	RETURN ls_Null

END CHOOSE
end function

public function integer of_copy_by_column (powerobject apo_source, long al_sourcerow, powerobject apo_target, long al_targetrow, readonly string asa_sourcealias[], readonly string asa_targetalias[]);//Return Values:  1 = Success, -1 = Failure

//This used to be coded using dynamic function calls, but I switched it on 2/1/99 b.c.
//that may have been causing gpfs.  I've used direct resolutions here, rather than the
//various apo functions, for performance reasons.

n_cst_numerical lnv_numerical
n_cst_anyarraysrv lnv_anyarray

Integer	li_SourceCount, &
			li_TargetCount, &
			li_AliasCount, &
			li_SourceNdx, &
			li_TargetNdx, &
			li_alias_ndx
String	lsa_SourceColumns[], &
			lsa_TargetColumns[], &
			ls_SourceColumn, &
			ls_TargetColumn, &
			ls_ColumnType
DataWindow	ldw_Source, &
				ldw_Target
DataStore	lds_Source, &
				lds_Target
Object	le_SourceType, &
			le_TargetType
Any	la_Value


li_AliasCount = upperbound(asa_TargetAlias)
if li_AliasCount <> upperbound(asa_SourceAlias) then return -1


le_SourceType = of_ResolvePowerObject ( apo_Source, ldw_Source, lds_Source )

CHOOSE CASE le_SourceType

CASE DataWindow!, DataStore!
	//Type is ok
CASE ELSE
	RETURN -1
END CHOOSE


le_TargetType = of_ResolvePowerObject ( apo_Target, ldw_Target, lds_Target )

CHOOSE CASE le_TargetType

CASE DataWindow!, DataStore!
	//Type is ok
CASE ELSE
	RETURN -1
END CHOOSE


if lnv_numerical.of_IsNullOrNotPos(al_SourceRow) then return -1

li_SourceCount = of_get_column_list(apo_source, lsa_SourceColumns)
li_TargetCount = of_get_column_list(apo_target, lsa_TargetColumns)


IF lnv_numerical.of_IsNullOrNotPos ( al_TargetRow ) THEN

	CHOOSE CASE le_TargetType

	CASE DataWindow!
		al_TargetRow = ldw_Target.InsertRow ( 0 )

	CASE DataStore!
		al_TargetRow = lds_Target.InsertRow ( 0 )

	END CHOOSE

END IF


for li_TargetNdx = 1 to li_TargetCount

	ls_TargetColumn = lsa_TargetColumns[li_TargetNdx]

	if li_AliasCount > 0 then
		li_alias_ndx = lnv_anyarray.of_Find(asa_TargetAlias, ls_TargetColumn, 1, li_AliasCount)
	else
		li_alias_ndx = 0
	end if

	if li_alias_ndx > 0 then
		ls_SourceColumn = asa_SourceAlias[li_alias_ndx]
	else
		ls_SourceColumn = ls_TargetColumn
	end if

	li_SourceNdx = lnv_anyarray.of_Find(lsa_SourceColumns, ls_SourceColumn, 1, li_SourceCount)

	if li_SourceNdx > 0 then

		if isvalid(lds_source) then
			ls_ColumnType = lds_source.describe(ls_SourceColumn + ".coltype")
		elseif isvalid(ldw_source) then
			ls_ColumnType = ldw_source.describe(ls_SourceColumn + ".coltype")
		end if

		ls_ColumnType = upper(trim(ls_ColumnType))

		//Get the value from the source, being sensitive to column type

		if pos(ls_ColumnType, "CHAR") > 0 then

			CHOOSE CASE le_SourceType
	
			CASE DataWindow!
				la_Value = ldw_Source.GetItemString ( al_SourceRow, ls_SourceColumn )
	
			CASE DataStore!
				la_Value = lds_Source.GetItemString ( al_SourceRow, ls_SourceColumn )
	
			END CHOOSE

		elseif pos(ls_ColumnType, "NUMBER") > 0 or ls_ColumnType = "LONG" then
			//NOTE:  LONG is not a value of .coltype advertised in the online help, 
			//but it is the value you get.  I'm not sure if NUMBER exists or not.
			//I did a straight comparison with LONG out of concern for LONG VARCHAR
			//(which I think reports as CHAR(32766).

			CHOOSE CASE le_SourceType
	
			CASE DataWindow!
				la_Value = ldw_Source.GetItemNumber ( al_SourceRow, ls_SourceColumn )
	
			CASE DataStore!
				la_Value = lds_Source.GetItemNumber ( al_SourceRow, ls_SourceColumn )
	
			END CHOOSE

		elseif pos(ls_ColumnType, "DECIMAL") > 0 then

			CHOOSE CASE le_SourceType
	
			CASE DataWindow!
				la_Value = ldw_Source.GetItemDecimal ( al_SourceRow, ls_SourceColumn )
	
			CASE DataStore!
				la_Value = lds_Source.GetItemDecimal ( al_SourceRow, ls_SourceColumn )
	
			END CHOOSE

		elseif pos(ls_ColumnType, "DATETIME") > 0 then

			CHOOSE CASE le_SourceType
	
			CASE DataWindow!
				la_Value = ldw_Source.GetItemDateTime ( al_SourceRow, ls_SourceColumn )
	
			CASE DataStore!
				la_Value = lds_Source.GetItemDateTime ( al_SourceRow, ls_SourceColumn )
	
			END CHOOSE

		elseif pos(ls_ColumnType, "TIMESTAMP") > 0 then

			//timestamp columns are regarded as STRINGS by PB

			CHOOSE CASE le_SourceType
	
			CASE DataWindow!
				la_Value = ldw_Source.GetItemString ( al_SourceRow, ls_SourceColumn )
	
			CASE DataStore!
				la_Value = lds_Source.GetItemString ( al_SourceRow, ls_SourceColumn )
	
			END CHOOSE

		elseif pos(ls_ColumnType, "DATE") > 0 then

			CHOOSE CASE le_SourceType
	
			CASE DataWindow!
				la_Value = ldw_Source.GetItemDate ( al_SourceRow, ls_SourceColumn )
	
			CASE DataStore!
				la_Value = lds_Source.GetItemDate ( al_SourceRow, ls_SourceColumn )
	
			END CHOOSE

		elseif pos(ls_ColumnType, "TIME") > 0 then

			CHOOSE CASE le_SourceType
	
			CASE DataWindow!
				la_Value = ldw_Source.GetItemTime ( al_SourceRow, ls_SourceColumn )
	
			CASE DataStore!
				la_Value = lds_Source.GetItemTime ( al_SourceRow, ls_SourceColumn )
	
			END CHOOSE

		ELSE
			CONTINUE

		end if


		//Set the value into the target

		CHOOSE CASE le_TargetType

		CASE DataWindow!
			ldw_Target.SetItem ( al_TargetRow, ls_TargetColumn, la_Value )

		CASE DataStore!
			lds_Target.SetItem ( al_TargetRow, ls_TargetColumn, la_Value )

		END CHOOSE

	end if

next

return 1
end function

public function string of_describe (powerobject apo_target, string as_command);DataWindow	ldw_Target
DataStore	lds_Target
String		ls_Null

CHOOSE CASE of_ResolvePowerObject ( apo_Target, ldw_Target, lds_Target )

CASE DataWindow!
	RETURN ldw_Target.Describe ( as_Command )
CASE DataStore!
	RETURN lds_Target.Describe ( as_Command )
CASE ELSE
	SetNull ( ls_Null )
	RETURN ls_Null

END CHOOSE
end function

public function integer of_selectrow (powerobject apo_target, long al_row, boolean ab_selection);DataWindow	ldw_Target
DataStore	lds_Target
Integer		li_Null

CHOOSE CASE of_ResolvePowerObject ( apo_Target, ldw_Target, lds_Target )

CASE DataWindow!
	RETURN ldw_Target.SelectRow ( al_Row, ab_Selection )
CASE DataStore!
	RETURN lds_Target.SelectRow ( al_Row, ab_Selection )
CASE ELSE
	SetNull ( li_Null )
	RETURN li_Null
END CHOOSE
end function

public function integer of_rowsdiscard (powerobject apo_target, long al_start, long al_end, dwbuffer ae_buffer);DataWindow	ldw_Target
DataStore	lds_Target
Integer		li_Null

CHOOSE CASE of_ResolvePowerObject ( apo_Target, ldw_Target, lds_Target )

CASE DataWindow!
	RETURN ldw_Target.RowsDiscard ( al_Start, al_End, ae_Buffer )
CASE DataStore!
	RETURN lds_Target.RowsDiscard ( al_Start, al_End, ae_Buffer )
CASE ELSE
	SetNull ( li_Null )
	RETURN li_Null
END CHOOSE
end function

public function integer of_createhighlight (datawindow adw_target);Long		ll_Height, &
			ll_Width, &
			ll_X, &
			ll_Y
String	ls_Command

ll_X = 5
ll_Y = 1
ll_Height = Long ( adw_Target.Describe ( "DataWindow.Detail.Height" ) ) - ll_Y + 1
ll_Width = adw_Target.Width - ll_X - 8

ls_Command = 'CREATE rectangle(band=detail x="XValue" y="YValue" height="HeightValue" width="WidthValue"  name=r_hlt visible="1~tif ( currentrow() = getrow(), 1, 0 )" brush.hatch="7" brush.color="553648127" pen.style="0" pen.width="10" pen.color="15780518"  background.mode="2" background.color="0" )'
ls_Command = Substitute ( ls_Command, "XValue", String ( ll_X ) )
ls_Command = Substitute ( ls_Command, "YValue", String ( ll_Y ) )
ls_Command = Substitute ( ls_Command, "HeightValue", String ( ll_Height ) )
ls_Command = Substitute ( ls_Command, "WidthValue", String ( ll_Width ) )

adw_Target.Modify ( ls_Command )

adw_Target.SetPosition ( "r_hlt", "", FALSE )

RETURN 1
end function

public function datastore of_createdatastore (string asa_columnlist[]);//Set up datastore with the specified column names  (all columns will be long varchar type)

String	ls_Select
Integer	li_Count, &
			li_Ndx
n_cst_String	lnv_String

SetPointer ( HourGlass! )

li_Count = UpperBound ( asa_ColumnList )
ls_Select = ""

FOR li_Ndx = 1 TO li_Count

	asa_ColumnList [ li_Ndx ] = "convert(long varchar, null) AS " + asa_ColumnList [ li_Ndx ]
	lnv_String.of_ArrayToString ( asa_ColumnList, ", ", ls_Select )

NEXT

ls_Select = "SELECT " + ls_Select + " FROM dummy"

RETURN of_CreateDataStore ( ls_Select )




////////////////////////////

//	CHOOSE CASE asa_ColumnList [ li_Ndx ]
//
//	CASE "TmpNumbers", "RefNumbers", "RefList"
//		asa_ColumnList [ li_Ndx ] = "convert(long varchar, null) AS " + asa_ColumnList [ li_Ndx ]
//
//	CASE ELSE
//		asa_ColumnList [ li_Ndx ] = "convert(char(45), null) AS " + asa_ColumnList [ li_Ndx ]
//
//	END CHOOSE


/////////////


//	ls_ColumnName = "xx_" + String ( li_Ndx, "00" )
//	IF li_Ndx > 1 THEN 
//		ls_Select += ", "
//	END IF
//	ls_Select += "convert(char(45), null) AS " + ls_ColumnName
end function

public function datastore of_createdatastore (integer ai_columncount);//Wrapper function to create a datastore with a specified number of generically named columns

Integer	li_Ndx
String	lsa_Columns[]

FOR li_Ndx = 1 TO ai_ColumnCount
	lsa_Columns [ li_Ndx ] = "Column" + String ( li_Ndx, "00" )
NEXT

RETURN of_CreateDataStore ( lsa_Columns )
end function

public function integer of_getrowfromrowid (powerobject apo_target, long al_rowid, ref long al_row, ref dwbuffer ae_buffer);DataWindow	ldw_Target
DataStore	lds_Target
Long			ll_Row
DWBuffer		le_Buffer

Integer		li_Return = 0

CHOOSE CASE This.of_ResolvePowerObject ( apo_Target, ldw_Target, lds_Target )

CASE DataWindow!

	le_Buffer = Primary!
	ll_Row = ldw_Target.GetRowFromRowId ( al_RowId, le_Buffer )

	IF ll_Row > 0 THEN
		//All Set
	ELSE
		le_Buffer = Filter!
		ll_Row = ldw_Target.GetRowFromRowId ( al_RowId, le_Buffer )
	END IF

	IF ll_Row > 0 THEN
		//All Set
	ELSE
		le_Buffer = Delete!
		ll_Row = ldw_Target.GetRowFromRowId ( al_RowId, le_Buffer )
	END IF

CASE DataStore!

	le_Buffer = Primary!
	ll_Row = lds_Target.GetRowFromRowId ( al_RowId, le_Buffer )

	IF ll_Row > 0 THEN
		//All Set
	ELSE
		le_Buffer = Filter!
		ll_Row = lds_Target.GetRowFromRowId ( al_RowId, le_Buffer )
	END IF

	IF ll_Row > 0 THEN
		//All Set
	ELSE
		le_Buffer = Delete!
		ll_Row = lds_Target.GetRowFromRowId ( al_RowId, le_Buffer )
	END IF

END CHOOSE


IF ll_Row > 0 THEN

	al_Row = ll_Row
	ae_Buffer = le_Buffer
	li_Return = 1

ELSE

	SetNull ( al_Row )
	SetNull ( ae_Buffer )
	li_Return = 0

END IF

RETURN li_Return
end function

public function date of_getitemdate (powerobject apo_target, long al_row, string as_column, dwbuffer ae_buffer, boolean ab_originalvalue);DataWindow	ldw_Target
DataStore	lds_Target
Date			ld_Null

CHOOSE CASE This.of_ResolvePowerObject ( apo_Target, ldw_Target, lds_Target )

CASE DataWindow!
	RETURN ldw_Target.GetItemDate ( al_Row, as_Column, ae_Buffer, ab_OriginalValue )
CASE DataStore!
	RETURN lds_Target.GetItemDate ( al_Row, as_Column, ae_Buffer, ab_OriginalValue )
CASE ELSE
	SetNull ( ld_Null )
	RETURN ld_Null

END CHOOSE
end function

public function datetime of_getitemdatetime (powerobject apo_target, long al_row, string as_column, dwbuffer ae_buffer, boolean ab_originalvalue);DataWindow	ldw_Target
DataStore	lds_Target
Datetime		ldt_Null

CHOOSE CASE This.of_ResolvePowerObject ( apo_Target, ldw_Target, lds_Target )

CASE DataWindow!
	RETURN ldw_Target.GetItemDatetime ( al_Row, as_Column, ae_Buffer, ab_OriginalValue )
CASE DataStore!
	RETURN lds_Target.GetItemDatetime ( al_Row, as_Column, ae_Buffer, ab_OriginalValue )
CASE ELSE
	SetNull ( ldt_Null )
	RETURN ldt_Null

END CHOOSE
end function

public function decimal of_getitemdecimal (powerobject apo_target, long al_row, string as_column, dwbuffer ae_buffer, boolean ab_originalvalue);DataWindow	ldw_Target
DataStore	lds_Target
Decimal		lc_Null

CHOOSE CASE This.of_ResolvePowerObject ( apo_Target, ldw_Target, lds_Target )

CASE DataWindow!
	RETURN ldw_Target.GetItemDecimal ( al_Row, as_Column, ae_Buffer, ab_OriginalValue )
CASE DataStore!
	RETURN lds_Target.GetItemDecimal ( al_Row, as_Column, ae_Buffer, ab_OriginalValue )
CASE ELSE
	SetNull ( lc_Null )
	RETURN lc_Null

END CHOOSE
end function

public function double of_getitemnumber (powerobject apo_target, long al_row, string as_column, dwbuffer ae_buffer, boolean ab_originalvalue);DataWindow	ldw_Target
DataStore	lds_Target
Double		ldbl_Null

CHOOSE CASE This.of_ResolvePowerObject ( apo_Target, ldw_Target, lds_Target )

CASE DataWindow!
	RETURN ldw_Target.GetItemNumber ( al_Row, as_Column, ae_Buffer, ab_OriginalValue )
CASE DataStore!
	RETURN lds_Target.GetItemNumber ( al_Row, as_Column, ae_Buffer, ab_OriginalValue )
CASE ELSE
	SetNull ( ldbl_Null )
	RETURN ldbl_Null

END CHOOSE
end function

public function string of_getitemstring (powerobject apo_target, long al_row, string as_column, dwbuffer ae_buffer, boolean ab_originalvalue);DataWindow	ldw_Target
DataStore	lds_Target
String		ls_Null

CHOOSE CASE This.of_ResolvePowerObject ( apo_Target, ldw_Target, lds_Target )

CASE DataWindow!
	RETURN ldw_Target.GetItemString ( al_Row, as_Column, ae_Buffer, ab_OriginalValue )
CASE DataStore!
	RETURN lds_Target.GetItemString ( al_Row, as_Column, ae_Buffer, ab_OriginalValue )
CASE ELSE
	SetNull ( ls_Null )
	RETURN ls_Null

END CHOOSE
end function

public function time of_getitemtime (powerobject apo_target, long al_row, string as_column, dwbuffer ae_buffer, boolean ab_originalvalue);DataWindow	ldw_Target
DataStore	lds_Target
Time			lt_Null

CHOOSE CASE This.of_ResolvePowerObject ( apo_Target, ldw_Target, lds_Target )

CASE DataWindow!
	RETURN ldw_Target.GetItemTime ( al_Row, as_Column, ae_Buffer, ab_OriginalValue )
CASE DataStore!
	RETURN lds_Target.GetItemTime ( al_Row, as_Column, ae_Buffer, ab_OriginalValue )
CASE ELSE
	SetNull ( lt_Null )
	RETURN lt_Null

END CHOOSE
end function

public function long of_getrowidfromrow (powerobject apo_target, long al_row, dwbuffer ae_buffer);DataWindow	ldw_Target
DataStore	lds_Target
Long			ll_Null

CHOOSE CASE This.of_ResolvePowerObject ( apo_Target, ldw_Target, lds_Target )

CASE DataWindow!
	RETURN ldw_Target.GetRowIdFromRow ( al_Row, ae_Buffer )

CASE DataStore!
	RETURN lds_Target.GetRowIdFromRow ( al_Row, ae_Buffer )

CASE ELSE
	SetNull ( ll_Null )
	RETURN ll_Null

END CHOOSE
end function

public function long of_filteredcount (powerobject apo_target);DataWindow	ldw_Target
DataStore	lds_Target
Long			ll_Null

CHOOSE CASE This.of_ResolvePowerObject ( apo_Target, ldw_Target, lds_Target )

CASE DataWindow!
	RETURN ldw_Target.FilteredCount ( )

CASE DataStore!
	RETURN lds_Target.FilteredCount ( )

CASE ELSE
	SetNull ( ll_Null )
	RETURN ll_Null

END CHOOSE
end function

public function long of_deletedcount (powerobject apo_target);DataWindow	ldw_Target
DataStore	lds_Target
Long			ll_Null

CHOOSE CASE This.of_ResolvePowerObject ( apo_Target, ldw_Target, lds_Target )

CASE DataWindow!
	RETURN ldw_Target.DeletedCount ( )

CASE DataStore!
	RETURN lds_Target.DeletedCount ( )

CASE ELSE
	SetNull ( ll_Null )
	RETURN ll_Null

END CHOOSE
end function

public function integer of_createdatastorebydataobject (readonly string as_dataobject, ref datastore ads_target, readonly boolean ab_pfc);n_ds			lds_Pfc
DataStore	lds_New
Integer	li_Return = -1

//Prevent orphaning any existing datastore in the reference variable.
DESTROY ads_Target


//Create the new datastore

IF ab_Pfc THEN
	lds_Pfc = CREATE n_ds
	lds_New = lds_Pfc
ELSE
	lds_New = CREATE DataStore
END IF


//If creation was successful, set up the datastore and pass it out.

IF IsValid ( lds_New ) THEN

	lds_New.DataObject = as_DataObject

	IF ab_Pfc THEN
		lds_Pfc.of_SetTransObject ( SQLCA )
	ELSE
		lds_New.SetTransObject ( SQLCA )
	END IF

	ads_Target = lds_New
	li_Return = 1

END IF


RETURN li_Return
end function

public function long of_selectedcount (datawindow adw_target);//Overload to avoid calling script having to declare the SelectedRows, if unwanted.

Long	ll_SelectedRows[]

RETURN This.of_SelectedCount ( adw_Target, ll_SelectedRows )
end function

public function integer of_rowsmove (powerobject apo_source, long al_start, long al_end, dwbuffer ae_sourcebuffer, powerobject apo_target, long al_before, dwbuffer ae_targetbuffer);DataWindow	ldw_Target, ldw_Source
DataStore	lds_Target, lds_Source
Integer		li_Return

CHOOSE CASE THIS.of_ResolvePowerObject ( apo_Source, ldw_Source, lds_Source )
		
	CASE DataWindow!
		
		CHOOSE CASE THIS.of_ResolvePowerObject ( apo_Target, ldw_Target, lds_Target )
		
			CASE DataWindow!
				li_Return = ldw_Source.RowsMove ( al_Start, al_End, ae_sourcebuffer, ldw_Target, al_before, ae_targetbuffer  )
				
			CASE DataStore!
				
				li_Return = ldw_Source.RowsMove ( al_Start, al_End, ae_sourcebuffer, lds_Target, al_before, ae_targetbuffer  )
			CASE ELSE
				
				SetNull ( li_Return )
				
			END CHOOSE
		
	CASE DataStore!
		
		CHOOSE CASE THIS.of_ResolvePowerObject ( apo_Target, ldw_Target, lds_Target )
		
			CASE DataWindow!
				li_Return = lds_Source.RowsMove ( al_Start, al_End, ae_sourcebuffer, ldw_Target, al_before, ae_targetbuffer  )
				
			CASE DataStore!
				
				li_Return = lds_Source.RowsMove ( al_Start, al_End, ae_sourcebuffer, lds_Target, al_before, ae_targetbuffer  )
			CASE ELSE
			
				SetNull ( li_Return )
			
		END CHOOSE
		
	CASE ELSE
		SetNull ( li_Return )
			
END CHOOSE


RETURN li_Return
end function

public function string of_getdataobject (powerobject apo_target);DataWindow	ldw_Target
DataStore	lds_Target
String		ls_Return

CHOOSE CASE This.of_ResolvePowerObject ( apo_Target, ldw_Target, lds_Target )

CASE DataWindow!
	ls_Return = ldw_Target.DataObject
CASE DataStore!
	ls_Return = lds_Target.DataObject
CASE ELSE
	SetNull ( ls_Return )

END CHOOSE

RETURN ls_Return
end function

public function integer of_rowscopy (powerobject apo_source, long al_start, long al_end, dwbuffer ae_sourcebuffer, powerobject apo_target, long al_before, dwbuffer ae_targetbuffer);DataWindow	ldw_Target, ldw_Source
DataStore	lds_Target, lds_Source
Integer		li_Return

CHOOSE CASE THIS.of_ResolvePowerObject ( apo_Source, ldw_Source, lds_Source )
		
	CASE DataWindow!
		
		CHOOSE CASE THIS.of_ResolvePowerObject ( apo_Target, ldw_Target, lds_Target )
		
			CASE DataWindow!
				li_Return = ldw_Source.RowsCopy ( al_Start, al_End, ae_sourcebuffer, ldw_Target, al_before, ae_targetbuffer  )
				
			CASE DataStore!
				
				li_Return = ldw_Source.RowsCopy ( al_Start, al_End, ae_sourcebuffer, lds_Target, al_before, ae_targetbuffer  )
			CASE ELSE
				
				SetNull ( li_Return )
				
			END CHOOSE
		
	CASE DataStore!
		
		CHOOSE CASE THIS.of_ResolvePowerObject ( apo_Target, ldw_Target, lds_Target )
		
			CASE DataWindow!
				li_Return = lds_Source.RowsCopy ( al_Start, al_End, ae_sourcebuffer, ldw_Target, al_before, ae_targetbuffer  )
				
			CASE DataStore!
				
				li_Return = lds_Source.RowsCopy ( al_Start, al_End, ae_sourcebuffer, lds_Target, al_before, ae_targetbuffer  )
			CASE ELSE
			
				SetNull ( li_Return )
			
		END CHOOSE
		
	CASE ELSE
		SetNull ( li_Return )
			
END CHOOSE


RETURN li_Return
end function

public function long of_getobjectsatposition (datawindow adw_target, long al_x, long al_y, string as_band, ref string asa_objects[]);string ls_objects, lsa_parsed[], ls_work
integer li_ndx
long ll_x, ll_y, ll_width, ll_height, ll_Check, ll_Count
String	lsa_Objects[]

if not isvalid(adw_target) then return -1

ls_objects = adw_target.describe("datawindow.objects")

n_cst_string lnv_string
lnv_string.of_ParseToArray(ls_objects, "~t", lsa_parsed)

for li_ndx = 1 to upperbound(lsa_parsed)
	if adw_target.describe(lsa_parsed[li_ndx] + ".band") = as_band then

		//Get x position
		ls_work = adw_target.describe(lsa_parsed[li_ndx] + ".x")
		ll_check = pos(ls_work, "~t")
		if ll_check > 0 then ls_work = left(ls_work, ll_check - 1)
		if isnumber(ls_work) then ll_x = long(ls_work) else continue

		IF ll_x > al_x THEN
			CONTINUE
		END IF

		ls_work = adw_target.describe(lsa_parsed[li_ndx] + ".y")
		ll_check = pos(ls_work, "~t")
		if ll_check > 0 then ls_work = left(ls_work, ll_check - 1)
		if isnumber(ls_work) then ll_y = long(ls_work) else continue

		IF ll_y > al_y THEN
			CONTINUE
		END IF

		ls_work = adw_target.describe(lsa_parsed[li_ndx] + ".width" )
		ll_check = pos(ls_work, "~t")
		if ll_check > 0 then ls_work = left(ls_work, ll_check - 1)
		if isnumber(ls_work) then ll_width = long(ls_work) else continue

		IF al_x > ll_x + ll_width THEN
			CONTINUE
		END IF

		ls_work = adw_target.describe(lsa_parsed[li_ndx] + ".height" )
		ll_check = pos(ls_work, "~t")
		if ll_check > 0 then ls_work = left(ls_work, ll_check - 1)
		if isnumber(ls_work) then ll_height = long(ls_work) else continue

		IF al_y > ll_y + ll_height THEN
			CONTINUE
		END IF

		ll_Count ++
		lsa_Objects [ ll_Count ] = lsa_Parsed [ li_Ndx ]

	end if
next

asa_Objects = lsa_Objects
return ll_Count
end function

public function integer of_setitemnull (powerobject apo_target, long al_row, string as_column);//Returns : 1, -1, Null ( could not resolve target)

DataWindow	ldw_Target
//Sets a column to null.  The calling script does not need to know the column type.

DataStore	lds_Target
Any			la_Value

String	ls_Null
SetNull ( ls_Null )

Integer	li_Return = 1


IF li_Return = 1 THEN

	//Note : The case logic used here is copied from n_cst_dwsrv / n_cst_dssrv of_SetItem

	CHOOSE CASE Lower ( Left ( This.of_Describe ( apo_Target, as_Column + ".ColType" ) , 5 ) )
	
	CASE "char("		//  CHARACTER DATATYPE
		la_Value = ls_Null
	
	CASE "date"			//  DATE DATATYPE
		la_Value = Date ( ls_Null )
	
	CASE "datet"		//  DATETIME DATATYPE
		la_Value = DateTime ( Date ( ls_Null ), Time ( ls_Null ) )	
	
	CASE "decim"		//  DECIMAL DATATYPE
		la_Value = Dec ( ls_Null ) 
	
	CASE "numbe", "doubl"			//  NUMBER DATATYPE	
		la_Value = Double ( ls_Null ) 
	
	CASE "real"				//  REAL DATATYPE	
		la_Value = Real ( ls_Null )
	
	CASE "long", "ulong"		//  LONG/INTEGER DATATYPE	
		la_Value = Long ( ls_Null )
	
	CASE "time", "times"		//  TIME DATATYPE
		la_Value = Time ( ls_Null )

	CASE ELSE			//UNEXPECTED DATATYPE
		li_Return = -1
	
	END CHOOSE

END IF


//Note : We're going to check li_Return INSIDE the case condition here, so that we can
//return null if failure above turns out to be because of unresolvable target.

CHOOSE CASE of_ResolvePowerObject ( apo_Target, ldw_Target, lds_Target )

CASE DataWindow!

	IF li_Return = 1 THEN

		IF ldw_Target.SetItem ( al_Row, as_Column, la_Value ) = 1 THEN
			li_Return = 1
		ELSE
			li_Return = -1
		END IF

	END IF

CASE DataStore!

	IF li_Return = 1 THEN

		IF lds_Target.SetItem ( al_Row, as_Column, la_Value ) = 1 THEN
			li_Return = 1
		ELSE
			li_Return = -1
		END IF

	END IF

CASE ELSE
	SetNull ( li_Return )

END CHOOSE


RETURN li_Return
end function

public function integer of_update (powerobject apo_target, boolean ab_accepttext, boolean ab_resetupdate);//Returns:  1, -1, Null (Cannot resolve arguments)

DataWindow	ldw_Target
DataStore	lds_Target

Integer		li_Return


CHOOSE CASE This.of_ResolvePowerObject ( apo_Target, ldw_Target, lds_Target )

CASE DataWindow!
	li_Return = ldw_Target.Update ( ab_AcceptText, ab_ResetUpdate )

CASE DataStore!
	li_Return = lds_Target.Update ( ab_AcceptText, ab_ResetUpdate )

CASE ELSE
	SetNull ( li_Return )

END CHOOSE


RETURN li_Return
end function

public function integer of_update (powerobject apo_target, boolean ab_accepttext);//Returns:  1, -1, Null (Cannot resolve arguments)

DataWindow	ldw_Target
DataStore	lds_Target

Integer		li_Return


CHOOSE CASE This.of_ResolvePowerObject ( apo_Target, ldw_Target, lds_Target )

CASE DataWindow!
	li_Return = ldw_Target.Update ( ab_AcceptText )

CASE DataStore!
	li_Return = lds_Target.Update ( ab_AcceptText )

CASE ELSE
	SetNull ( li_Return )

END CHOOSE


RETURN li_Return
end function

public function integer of_update (powerobject apo_target);//Returns:  1, -1, Null (Cannot resolve arguments)

DataWindow	ldw_Target
DataStore	lds_Target

Integer		li_Return


CHOOSE CASE This.of_ResolvePowerObject ( apo_Target, ldw_Target, lds_Target )

CASE DataWindow!
	li_Return = ldw_Target.Update ( )

CASE DataStore!
	li_Return = lds_Target.Update ( )

CASE ELSE
	SetNull ( li_Return )

END CHOOSE


RETURN li_Return
end function

public function long of_getcustomviewlist (string as_viewname, ref string asa_displaynames[]);//Returns : >= 0  The number of custom views defined for as_ViewName,  -1 = Error

DataStore	lds_List
String		lsa_Empty[]
Long			ll_RowCount

Long			ll_Return


//Clear the reference array.
asa_DisplayNames = lsa_Empty

//Initialize the DataStore
lds_List = CREATE DataStore
lds_List.DataObject = "d_CustomViewList"
lds_List.SetTransObject ( SQLCA )


IF ll_Return >= 0 THEN

	ll_RowCount = lds_List.Retrieve ( as_ViewName )	
	COMMIT ;
	
	CHOOSE CASE ll_RowCount
	
	CASE IS >= 0
		//Retrieve succeeded.  If we have values, read the list out into the array.
		//If we don't have values, don't do this, because it would cause a crash.
		//Return value will be the number of values in the list.

		IF ll_RowCount > 0 THEN
			asa_DisplayNames = lds_List.Object.DisplayName.Primary
			ll_Return = UpperBound ( asa_DisplayNames )
			//The upperbound value should be the same as ll_RowCount, but I'd rather 
			//read it directly off the array.
		ELSE
			ll_Return = 0
		END IF
	
	CASE ELSE
		ll_Return = -1
	
	END CHOOSE

END IF


DESTROY lds_List

RETURN ll_Return
end function

public function integer of_setcustomview (datawindow adw_target, string as_viewname, string as_displayname, boolean ab_handleredraw, ref string as_sort, ref string as_filter);DataStore	lds_ViewDefs
Long			ll_Row, &
				ll_RowCount
dwObject		ldwo_Defs
String		ls_Def, &
				ls_Name, &
				ls_Id
n_cst_String	lnv_String

//Null the reference parameters.  If a sort or filter request is part of the view definition,
//it will be passed out in these parameters.
SetNull ( as_Sort )
SetNull ( as_Filter )

lds_ViewDefs = CREATE DataStore
lds_ViewDefs.DataObject = "d_CustomViewDefinitions"
lds_ViewDefs.SetTransObject ( SQLCA )

ll_RowCount = lds_ViewDefs.Retrieve ( as_ViewName, as_DisplayName )

COMMIT ;

ldwo_Defs = lds_ViewDefs.Object.ObjectDefinition

IF ab_HandleRedraw = TRUE THEN
	adw_Target.SetRedraw ( FALSE )
END IF

FOR ll_Row = 1 TO ll_RowCount

	ls_Def = ldwo_Defs.Primary [ ll_Row ]

	IF Match ( Upper ( ls_Def ), "^CREATE COLUMN" ) THEN

		ls_Name = lnv_String.of_GetKeyValue ( ls_Def, "name", " " )

		ls_Id = adw_Target.Describe ( ls_Name + ".Id" )
	
		IF IsNumber ( ls_Id ) THEN
			lnv_String.of_SetKeyValue ( ls_Def, "id", ls_Id, " " )
		ELSE
			CONTINUE  //Can't identify column number.  Skip.
		END IF

	ELSEIF Match ( Upper ( ls_Def ), "^SORT=" ) THEN

		//Take everything after the = sign in the string.
		as_Sort = Mid ( ls_Def, 6 )
		CONTINUE  //No Modify necessary

	ELSEIF Match ( Upper ( ls_Def ), "^FILTER=" ) THEN

		//Take everything after the = sign in the string.
		as_Filter = Mid ( ls_Def, 8 )
		CONTINUE  //No modify necessary

	END IF

	adw_Target.Modify ( ls_Def )

NEXT

IF ab_HandleRedraw = TRUE THEN
	adw_Target.SetRedraw ( TRUE )
END IF

DESTROY lds_ViewDefs

RETURN 1
end function

public function any of_getitemany (powerobject apo_source, long al_row, string as_column);//	 GetItemxxx function and cast the returned value */
Any la_Value
String 	ls_computeexp
DataWindow	ldw_Target
DataStore	lds_Target


CHOOSE CASE This.of_ResolvePowerObject ( apo_source, ldw_Target, lds_Target )

CASE DataWindow!
		
	CHOOSE CASE Lower ( Left ( ldw_Target.Describe ( as_column + ".ColType" ) , 5 ) )

		CASE "char("				//  CHARACTER DATATYPE
			la_value = ldw_Target.GetItemString ( al_row, as_column ) 
	
		CASE "date"					//  DATE DATATYPE
			la_value = ldw_Target.GetItemDate ( al_row, as_column ) 

		CASE "datet"				//  DATETIME DATATYPE
			la_value = ldw_Target.GetItemDateTime ( al_row, as_column ) 
		CASE "decim"				//  DECIMAL DATATYPE
			la_value = ldw_Target.GetItemDecimal ( al_row, as_column ) 
	
		CASE "numbe", "long", "ulong", "real"				//  NUMBER DATATYPE	
			la_value = ldw_Target.GetItemNumber ( al_row, as_column ) 
	
		CASE "time", "times"		//  TIME DATATYPE
			la_value = ldw_Target.GetItemTime ( al_row, as_column ) 

		CASE ELSE 					//  MUST BE A COMPUTED COLUMN
			IF ldw_Target.Describe ( as_column + ".Type" ) = "compute" THEN 
				ls_computeexp = ldw_Target.Describe ( as_column + ".Expression" )
				la_value = ldw_Target.Describe( "Evaluate('" + ls_computeexp + "', " + string (al_row) + ")" )
			ELSE
				SetNull ( la_value ) 
			END IF 

	END CHOOSE
	
CASE DataStore!
	
	CHOOSE CASE Lower ( Left ( lds_Target.Describe ( as_column + ".ColType" ) , 5 ) )

		CASE "char("				//  CHARACTER DATATYPE
			la_value = lds_Target.GetItemString ( al_row, as_column ) 
	
		CASE "date"					//  DATE DATATYPE
			la_value = lds_Target.GetItemDate ( al_row, as_column ) 

		CASE "datet"				//  DATETIME DATATYPE
			la_value = lds_Target.GetItemDateTime ( al_row, as_column ) 
		CASE "decim"				//  DECIMAL DATATYPE
			la_value = lds_Target.GetItemDecimal ( al_row, as_column ) 
	
		CASE "numbe", "long", "ulong", "real"				//  NUMBER DATATYPE	
			la_value = lds_Target.GetItemNumber ( al_row, as_column ) 
	
		CASE "time", "times"		//  TIME DATATYPE
			la_value = lds_Target.GetItemTime ( al_row, as_column ) 

		CASE ELSE 					//  MUST BE A COMPUTED COLUMN
			IF ldw_Target.Describe ( as_column + ".Type" ) = "compute" THEN 
				ls_computeexp = ldw_Target.Describe ( as_column + ".Expression" )
				la_value = ldw_Target.Describe( "Evaluate('" + ls_computeexp + "', " + string (al_row) + ")" )
			ELSE
				SetNull ( la_value ) 
			END IF 

	END CHOOSE
	
	
CASE ELSE
	SetNull ( la_value )
	
END CHOOSE

Return la_value
end function

public function integer of_rowscopy (datastore ads_source, long al_startrow, long al_endrow, dwbuffer ae_sourcebuffer, ref datastore ads_target, dwbuffer ae_targetbuffer);
Long	ll_RowIndex
Long	ll_CurrentRow
Long	ll_RowCount
Int	li_Return = 1

dwItemStatus	le_Status

IF Not IsValid ( ads_Source ) OR Not IsValid ( ads_Target ) THEN
	li_Return = -1
END IF

IF li_Return = 1 THEN
	CHOOSE CASE ae_sourcebuffer
		CASE PRIMARY!
			ll_RowCount = ads_Source.RowCount ( )
		CASE FILTER!
			ll_RowCount = ads_Source.FilteredCount ( )
		CASE DELETE!
			ll_RowCount = ads_Source.DeletedCount ( )
		CASE ELSE
			li_Return = -1
	END CHOOSE
	
	IF al_StartRow <= 0 or al_StartRow > ll_RowCount THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	IF al_EndRow > ll_RowCount THEN
		li_Return = -1
	END IF	
END IF

IF li_Return = 1 THEN
	FOR ll_RowIndex = al_StartRow TO al_EndRow 
		
		le_Status = ads_Source.GetItemStatus ( ll_RowIndex, 0, ae_SourceBuffer )
		// Rowscopy always set the status to NewModified!
		ads_Source.RowsCopy (ll_RowIndex, ll_RowIndex, ae_SourceBuffer, ads_Target, 99999, 	ae_Targetbuffer )
		
		CHOOSE CASE ae_sourcebuffer
			CASE PRIMARY!
				ll_CurrentRow = ads_Target.RowCount ( )
			CASE FILTER!
				ll_CurrentRow = ads_Target.FilteredCount ( )				
			CASE DELETE!
				ll_CurrentRow = ads_Target.DeletedCount ( )
			CASE ELSE
				li_Return = -1
				EXIT
		END CHOOSE
		
		CHOOSE CASE le_Status
				
			CASE NEW!
				ads_Target.SetItemStatus ( ll_CurrentRow, 0, ae_Targetbuffer, NotModified! ) // this sets it to NEW!

				
			CASE NewModified!	
				// don't need to do anything
				
			CASE DataModified!
				ads_Target.SetItemStatus ( ll_CurrentRow, 0, ae_Targetbuffer, DataModified! ) 
				
			CASE NotModified!
				ads_Target.SetItemStatus ( ll_CurrentRow, 0, ae_Targetbuffer, DataModified! ) 
				ads_Target.SetItemStatus ( ll_CurrentRow, 0, ae_Targetbuffer, NotModified! ) 
				
			CASE ELSE
				EXIT
				li_Return = -1
		END CHOOSE
				
	NEXT
END IF



RETURN li_Return



end function

event constructor;//The functions included in this object should become part of the PFC datawindow service 
//objects when we implement PFC (or replaced by PFC functionality if PFC handles the issues
//here on its own.)
end event

on n_cst_dws.create
TriggerEvent( this, "constructor" )
end on

on n_cst_dws.destroy
TriggerEvent( this, "destructor" )
end on

