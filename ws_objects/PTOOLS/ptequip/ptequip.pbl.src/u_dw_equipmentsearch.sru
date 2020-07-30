$PBExportHeader$u_dw_equipmentsearch.sru
forward
global type u_dw_equipmentsearch from u_dw
end type
end forward

global type u_dw_equipmentsearch from u_dw
integer width = 809
integer height = 284
string dataobject = "d_equipmentsearch"
event ue_key pbm_dwnkey
end type
global u_dw_equipmentsearch u_dw_equipmentsearch

type variables

end variables

event ue_key;
String	ls_ColumnName
ls_ColumnName = THIS.GetColumnName (  )
IF key = KeyDownArrow! THEN
	datawindowChild	ldwc_Child

	CHOOSE CASE Lower ( ls_ColumnName ) 
		CASE "outside_equip_originationsite"
			
			this.Modify("outside_equip_originationsite.dddw.name=d_company_list outside_equip_originationsite.dddw.displaycolumn=co_name outside_equip_originationsite.dddw.datacolumn=co_id outside_equip_originationsite.dddw.percentwidth=100 outside_equip_originationsite.dddw.lines=0 outside_equip_originationsite.dddw.limit=0 outside_equip_originationsite.dddw.allowedit=no outside_equip_originationsite.dddw.useasborder=no outside_equip_originationsite.dddw.case=any outside_equip_originationsite.dddw.vscrollbar=yes  outside_equip_originationsite.font.face='MS Sans Serif' outside_equip_originationsite.font.height='-8' outside_equip_originationsite.font.weight='400'  outside_equip_originationsite.font.family='2' outside_equip_originationsite.font.pitch='2' outside_equip_originationsite.font.charset='0' outside_equip_originationsite.background.mode='1' outside_equip_originationsite.background.color='536870912'" ) 
	
		CASE "outside_equip_terminationsite" 
			
			this.Modify("outside_equip_terminationsite.dddw.name=d_company_list outside_equip_terminationsite.dddw.displaycolumn=co_name outside_equip_terminationsite.dddw.datacolumn=co_id outside_equip_terminationsite.dddw.percentwidth=100 outside_equip_terminationsite.dddw.lines=0 outside_equip_terminationsite.dddw.limit=0 outside_equip_terminationsite.dddw.allowedit=no outside_equip_terminationsite.dddw.useasborder=no outside_equip_terminationsite.dddw.case=any outside_equip_terminationsite.dddw.vscrollbar=yes  outside_equip_terminationsite.font.face='MS Sans Serif' outside_equip_terminationsite.font.height='-8' outside_equip_terminationsite.font.weight='400'  outside_equip_terminationsite.font.family='2' outside_equip_terminationsite.font.pitch='2' outside_equip_terminationsite.font.charset='0' outside_equip_terminationsite.background.mode='1' outside_equip_terminationsite.background.color='536870912'" ) 
			
		CASE "outside_equip_oe_from"
			this.Modify("outside_equip_oe_from.dddw.name=d_company_list outside_equip_oe_from.dddw.displaycolumn=co_name outside_equip_oe_from.dddw.datacolumn=co_id  outside_equip_oe_from.dddw.percentwidth=100 outside_equip_oe_from.dddw.lines=0 outside_equip_oe_from.dddw.limit=0 outside_equip_oe_from.dddw.allowedit=no outside_equip_oe_from.dddw.useasborder=no outside_equip_oe_from.dddw.case=any outside_equip_oe_from.dddw.vscrollbar=yes  outside_equip_oe_from.font.face='MS Sans Serif' outside_equip_oe_from.font.height='-8' outside_equip_oe_from.font.weight='400'  outside_equip_oe_from.font.family='2' outside_equip_oe_from.font.pitch='2' outside_equip_oe_from.font.charset='0' outside_equip_oe_from.background.mode='1' outside_equip_oe_from.background.color='536870912'" ) 
			
		CASE "outside_equip_oe_for"
			this.Modify("outside_equip_oe_for.dddw.name=d_company_list outside_equip_oe_for.dddw.displaycolumn=co_name outside_equip_oe_for.dddw.datacolumn=co_id outside_equip_oe_for.dddw.percentwidth=100 outside_equip_oe_for.dddw.lines=0 outside_equip_oe_for.dddw.limit=0 outside_equip_oe_for.dddw.allowedit=no outside_equip_oe_for.dddw.useasborder=no outside_equip_oe_for.dddw.case=any  outside_equip_oe_for.dddw.vscrollbar=yes  outside_equip_oe_for.font.face='MS Sans Serif' outside_equip_oe_for.font.height='-8' outside_equip_oe_for.font.weight='400'  outside_equip_oe_for.font.family='2' outside_equip_oe_for.font.pitch='2' outside_equip_oe_for.font.charset='0' outside_equip_oe_for.background.mode='1' outside_equip_oe_for.background.color='536870912'" ) 
			
	//	CASE "id_line"
	//		this.Modify("id_line.dddw.name=d_equipmentlease_dddw id_line.dddw.displaycolumn=uniquelinename id_line.dddw.datacolumn=id id_line.dddw.percentwidth=100 id_line.dddw.lines=0 id_line.dddw.limit=0 id_line.dddw.allowedit=no id_line.dddw.useasborder=no id_line.dddw.case=any id_line.dddw.vscrollbar=yes id_line.font.face='MS Sans Serif' id_line.font.height='-8' id_line.font.weight='400'  id_line.font.family='2' id_line.font.pitch='2' id_line.font.charset='0' id_line.background.mode='1' id_line.background.color='536870912' )" ) 
	//		
	//	CASE "id_type"	
	//		this.Modify("id_type.dddw.name=d_equipmentlease_dddw id_type.dddw.displaycolumn=type id_type.dddw.datacolumn=id id_type.dddw.percentwidth=100 id_type.dddw.lines=0 id_type.dddw.limit=0 id_type.dddw.allowedit=no id_type.dddw.useasborder=no id_type.dddw.case=any  id_type.dddw.vscrollbar=yes id_type.font.face='MS Sans Serif' id_type.font.height='-8' id_type.font.weight='400'  id_type.font.family='2' id_type.font.pitch='2' id_type.font.charset='0' id_type.background.mode='1' id_type.background.color='536870912' )" ) 
	//		
	
		CASE "id_line", "id_type"   //Replaced the individual versions above in 3.5.18, so both columns would show a value.
			this.Modify("id_line.dddw.name=d_equipmentlease_dddw_unfiltered id_line.dddw.displaycolumn=uniquelinename id_line.dddw.datacolumn=id id_line.dddw.percentwidth=200 id_line.dddw.lines=0 id_line.dddw.limit=0 id_line.dddw.allowedit=no id_line.dddw.useasborder=no id_line.dddw.case=any id_line.dddw.vscrollbar=yes id_line.font.face='MS Sans Serif' id_line.font.height='-8' id_line.font.weight='400'  id_line.font.family='2' id_line.font.pitch='2' id_line.font.charset='0' id_line.background.mode='1' id_line.background.color='536870912' )" ) 	
			this.Modify("id_type.dddw.name=d_equipmentlease_dddw_unfiltered id_type.dddw.displaycolumn=type id_type.dddw.datacolumn=id id_type.dddw.percentwidth=200 id_type.dddw.lines=0 id_type.dddw.limit=0 id_type.dddw.allowedit=no id_type.dddw.useasborder=no id_type.dddw.case=any  id_type.dddw.vscrollbar=yes id_type.font.face='MS Sans Serif' id_type.font.height='-8' id_type.font.weight='400'  id_type.font.family='2' id_type.font.pitch='2' id_type.font.charset='0' id_type.background.mode='1' id_type.background.color='536870912' )" ) 
	
			
			THIS.Getchild( "id_line", ldwc_Child )
			ldwc_Child.SetTransObject (SQLCA )
			ldwc_Child.Retrieve () 
			
			THIS.Getchild( "id_type", ldwc_Child )
			ldwc_Child.SetTransObject (SQLCA )
			ldwc_Child.Retrieve () 
			
	END CHOOSE
	
	
	// added this retrieve code ( and the calls above ) because dddw were not populating. I could not find
	// where the retireve was supposed to be happening?????
	IF THIS.Getchild(  ls_ColumnName , ldwc_Child ) = 1 THEN
	
		IF ldwc_Child.RowCount ( ) = 0 THEN
			ldwc_Child.SetTransObject (SQLCA )
			ldwc_Child.Retrieve () 
		END IF
	
	END IF
END IF

RETURN 0


end event

event clicked;call super::clicked;datawindowChild	ldwc_Child

CHOOSE CASE Lower ( dwo.Name ) 
	CASE "outside_equip_originationsite"
		
		this.Modify("outside_equip_originationsite.dddw.name=d_company_list outside_equip_originationsite.dddw.displaycolumn=co_name outside_equip_originationsite.dddw.datacolumn=co_id outside_equip_originationsite.dddw.percentwidth=100 outside_equip_originationsite.dddw.lines=0 outside_equip_originationsite.dddw.limit=0 outside_equip_originationsite.dddw.allowedit=no outside_equip_originationsite.dddw.useasborder=no outside_equip_originationsite.dddw.case=any outside_equip_originationsite.dddw.vscrollbar=yes  outside_equip_originationsite.font.face='MS Sans Serif' outside_equip_originationsite.font.height='-8' outside_equip_originationsite.font.weight='400'  outside_equip_originationsite.font.family='2' outside_equip_originationsite.font.pitch='2' outside_equip_originationsite.font.charset='0' outside_equip_originationsite.background.mode='1' outside_equip_originationsite.background.color='536870912'" ) 

	CASE "outside_equip_terminationsite" 
		
		this.Modify("outside_equip_terminationsite.dddw.name=d_company_list outside_equip_terminationsite.dddw.displaycolumn=co_name outside_equip_terminationsite.dddw.datacolumn=co_id outside_equip_terminationsite.dddw.percentwidth=100 outside_equip_terminationsite.dddw.lines=0 outside_equip_terminationsite.dddw.limit=0 outside_equip_terminationsite.dddw.allowedit=no outside_equip_terminationsite.dddw.useasborder=no outside_equip_terminationsite.dddw.case=any outside_equip_terminationsite.dddw.vscrollbar=yes  outside_equip_terminationsite.font.face='MS Sans Serif' outside_equip_terminationsite.font.height='-8' outside_equip_terminationsite.font.weight='400'  outside_equip_terminationsite.font.family='2' outside_equip_terminationsite.font.pitch='2' outside_equip_terminationsite.font.charset='0' outside_equip_terminationsite.background.mode='1' outside_equip_terminationsite.background.color='536870912'" ) 
		
	CASE "outside_equip_oe_from"
		this.Modify("outside_equip_oe_from.dddw.name=d_company_list outside_equip_oe_from.dddw.displaycolumn=co_name outside_equip_oe_from.dddw.datacolumn=co_id  outside_equip_oe_from.dddw.percentwidth=100 outside_equip_oe_from.dddw.lines=0 outside_equip_oe_from.dddw.limit=0 outside_equip_oe_from.dddw.allowedit=no outside_equip_oe_from.dddw.useasborder=no outside_equip_oe_from.dddw.case=any outside_equip_oe_from.dddw.vscrollbar=yes  outside_equip_oe_from.font.face='MS Sans Serif' outside_equip_oe_from.font.height='-8' outside_equip_oe_from.font.weight='400'  outside_equip_oe_from.font.family='2' outside_equip_oe_from.font.pitch='2' outside_equip_oe_from.font.charset='0' outside_equip_oe_from.background.mode='1' outside_equip_oe_from.background.color='536870912'" ) 
		
	CASE "outside_equip_oe_for"
		this.Modify("outside_equip_oe_for.dddw.name=d_company_list outside_equip_oe_for.dddw.displaycolumn=co_name outside_equip_oe_for.dddw.datacolumn=co_id outside_equip_oe_for.dddw.percentwidth=100 outside_equip_oe_for.dddw.lines=0 outside_equip_oe_for.dddw.limit=0 outside_equip_oe_for.dddw.allowedit=no outside_equip_oe_for.dddw.useasborder=no outside_equip_oe_for.dddw.case=any  outside_equip_oe_for.dddw.vscrollbar=yes  outside_equip_oe_for.font.face='MS Sans Serif' outside_equip_oe_for.font.height='-8' outside_equip_oe_for.font.weight='400'  outside_equip_oe_for.font.family='2' outside_equip_oe_for.font.pitch='2' outside_equip_oe_for.font.charset='0' outside_equip_oe_for.background.mode='1' outside_equip_oe_for.background.color='536870912'" ) 
		
//	CASE "id_line"
//		this.Modify("id_line.dddw.name=d_equipmentlease_dddw id_line.dddw.displaycolumn=uniquelinename id_line.dddw.datacolumn=id id_line.dddw.percentwidth=100 id_line.dddw.lines=0 id_line.dddw.limit=0 id_line.dddw.allowedit=no id_line.dddw.useasborder=no id_line.dddw.case=any id_line.dddw.vscrollbar=yes id_line.font.face='MS Sans Serif' id_line.font.height='-8' id_line.font.weight='400'  id_line.font.family='2' id_line.font.pitch='2' id_line.font.charset='0' id_line.background.mode='1' id_line.background.color='536870912' )" ) 
//		
//	CASE "id_type"	
//		this.Modify("id_type.dddw.name=d_equipmentlease_dddw id_type.dddw.displaycolumn=type id_type.dddw.datacolumn=id id_type.dddw.percentwidth=100 id_type.dddw.lines=0 id_type.dddw.limit=0 id_type.dddw.allowedit=no id_type.dddw.useasborder=no id_type.dddw.case=any  id_type.dddw.vscrollbar=yes id_type.font.face='MS Sans Serif' id_type.font.height='-8' id_type.font.weight='400'  id_type.font.family='2' id_type.font.pitch='2' id_type.font.charset='0' id_type.background.mode='1' id_type.background.color='536870912' )" ) 
//		

	CASE "id_line", "id_type"   //Replaced the individual versions above in 3.5.18, so both columns would show a value.
		this.Modify("id_line.dddw.name=d_equipmentlease_dddw_unfiltered id_line.dddw.displaycolumn=uniquelinename id_line.dddw.datacolumn=id id_line.dddw.percentwidth=200 id_line.dddw.lines=0 id_line.dddw.limit=0 id_line.dddw.allowedit=no id_line.dddw.useasborder=no id_line.dddw.case=any id_line.dddw.vscrollbar=yes id_line.font.face='MS Sans Serif' id_line.font.height='-8' id_line.font.weight='400'  id_line.font.family='2' id_line.font.pitch='2' id_line.font.charset='0' id_line.background.mode='1' id_line.background.color='536870912' )" ) 	
		this.Modify("id_type.dddw.name=d_equipmentlease_dddw_unfiltered id_type.dddw.displaycolumn=type id_type.dddw.datacolumn=id id_type.dddw.percentwidth=200 id_type.dddw.lines=0 id_type.dddw.limit=0 id_type.dddw.allowedit=no id_type.dddw.useasborder=no id_type.dddw.case=any  id_type.dddw.vscrollbar=yes id_type.font.face='MS Sans Serif' id_type.font.height='-8' id_type.font.weight='400'  id_type.font.family='2' id_type.font.pitch='2' id_type.font.charset='0' id_type.background.mode='1' id_type.background.color='536870912' )" ) 

		
		THIS.Getchild( "id_line", ldwc_Child )
		ldwc_Child.SetTransObject (SQLCA )
		ldwc_Child.Retrieve () 
		
		THIS.Getchild( "id_type", ldwc_Child )
		ldwc_Child.SetTransObject (SQLCA )
		ldwc_Child.Retrieve () 
		
END CHOOSE


// added this retrieve code ( and the calls above ) because dddw were not populating. I could not find
// where the retireve was supposed to be happening?????
IF THIS.Getchild(  dwo.Name , ldwc_Child ) = 1 THEN

	IF ldwc_Child.RowCount ( ) = 0 THEN
		ldwc_Child.SetTransObject (SQLCA )
		ldwc_Child.Retrieve () 
	END IF

END IF

Return 0




end event

on u_dw_equipmentsearch.create
end on

on u_dw_equipmentsearch.destroy
end on

