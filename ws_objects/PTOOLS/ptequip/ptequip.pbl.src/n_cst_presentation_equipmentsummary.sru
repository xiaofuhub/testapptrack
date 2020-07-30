$PBExportHeader$n_cst_presentation_equipmentsummary.sru
forward
global type n_cst_presentation_equipmentsummary from n_cst_presentation
end type
end forward

global type n_cst_presentation_equipmentsummary from n_cst_presentation
end type

type variables
//Note : This setting was added late, so not all the objects
//reference it.  For those that do, they can use it to adjust
//column settings based on whether the display will be 
//editable.  For example, they can use it to decide
//whether to apply ddlb settings to a code table column, 
//or just leave the column as an edit style.

//Also note : I would have preferred to put this directly on
//n_cst_presentation, but I was having the usual problems
//with it needing a regen, and I didn't want to chance it.
//The property could go on the ancestor at some safer point.
//So, I'm going to make it a public property and set it directly 
//for now.  Ultimately, it should be protected with gets and 
//sets.

Public Boolean	ib_Editable = FALSE
end variables

forward prototypes
public function integer of_setpresentation (powerobject apo_target, string as_objectname)
protected function integer of_getvaluelist (string as_columnname, ref string as_valuelist)
end prototypes

public function integer of_setpresentation (powerobject apo_target, string as_objectname);String	lsa_Settings[], &
			ls_ValueList, &
			ls_Work
Integer	li_Count, &
			li_Index, &
			li_Return

n_cst_AnyArraySrv	lnv_AnyArray

li_Return = 1
as_ObjectName = Lower ( as_ObjectName )


CHOOSE CASE as_ObjectName



	CASE  "intermodalequipment_type"
		IF This.of_GetValueList ( as_ObjectName, ls_ValueList ) = 1 THEN
			lsa_Settings = { "Edit.CodeTable = Yes", ls_ValueList, "ddlb.UseAsBorder = No", "ddlb.VScrollBar = Yes" }
		ELSE
			li_Return = -1
		END IF	
//*** EQUIPMENT  SUMMARY***
	CASE "equipment_type" , "intermodalequipment_type"

		IF This.of_GetValueList ( as_ObjectName, ls_ValueList ) = 1 THEN
			IF ib_Editable = TRUE THEN
				lsa_Settings = { "Edit.CodeTable = Yes", ls_ValueList, "ddlb.UseAsBorder = No", "ddlb.ShowList = No", "ddlb.VScrollBar = Yes", "ddlb.Sorted = Yes" }
			ELSE
				lsa_Settings = { "Edit.CodeTable = Yes", ls_ValueList}
			END IF
		ELSE
			li_Return = -1
		END IF
		
	CASE "equipment_status" 
		IF This.of_GetValueList ( as_ObjectName, ls_ValueList ) = 1 THEN
			IF ib_Editable = TRUE THEN
				lsa_Settings = { "Edit.CodeTable = Yes", ls_ValueList, "ddlb.UseAsBorder = No", "ddlb.ShowList = No", "ddlb.VScrollBar = Yes", "ddlb.Sorted = Yes" }
			ELSE
				lsa_Settings = { "Edit.CodeTable = Yes", ls_ValueList}
			END IF
		ELSE
			li_Return = -1
		END IF
		
	CASE "currentevent_fkshipment"
			lsa_Settings = { "Format = '0000'"}
		
	CASE "equipment_length"

	CASE "equipment_width"

	CASE "currentevent_type"
		IF This.of_GetValueList ( as_ObjectName, ls_ValueList ) = 1 THEN
			lsa_Settings = { "Edit.CodeTable = Yes", ls_ValueList }
		ELSE
			li_Return = -1
		END IF		


	CASE "currentevent_timearrived", "currentevent_timedeparted", "currentevent_appointmenttime", &
		"equipmentlease_originationtime", "equipmentlease_terminationtime", "shipment_cutofftime", &
		"shipment_arrivaltime", " shipment_lastfreetime" 

		lsa_Settings = { "Format = 'hh:mm'" }


	CASE "currentevent_timezone" , "originationevent_timezone" , "terminationevent_timezone"
		IF This.of_GetValueList ( as_ObjectName, ls_ValueList ) = 1 THEN
			lsa_Settings = { "Edit.CodeTable = Yes", ls_ValueList }
		ELSE
			li_Return = -1
		END IF		

	CASE "equipmentlease_freetimeexpiration"
		ls_work = "color = '16777215~tif ( equipmentlease_charges > 0 , " + String( RGB ( 255 , 255 , 255 )  ) + " , " + string ( RGB ( 0,0,0) ) + " ) '"
	    lsa_Settings =  { ls_Work }
	 	ls_Work = "Format = 'mm/dd/yy  hh:mm'"
		lsa_Settings [ upperbound (lsa_settings) + 1 ] = ls_Work
		
		int li_Flex
		int li_DayNum
		li_dayNum = DayNumber ( Today () )
		Choose Case li_DayNum
			Case 6
				li_Flex = 4
			Case 7 
				li_Flex = 3
			Case Else
				li_Flex = 2
		END Choose
		ls_Work = "Background.color = '16777215~tif ( equipmentlease_charges > 0 , " + String ( RGB ( 255 , 0 ,0) ) + "  , IF ( DaysAfter ( Today ( ) , equipmentlease_freetimeexpiration ) < " +  string ( li_Flex )  + " , " + String (RGB ( 255 , 255 , 0 ) ) + " , " + string (RGB ( 255 , 255 , 255 ) ) + " ) )'"
		lsa_Settings [ upperbound (lsa_settings) + 1 ] = ls_Work


	CASE "equipmentlease_charges"
		
	    lsa_Settings = { "Format = '[Currency]' ", "color = '16777215~tIF ( equipmentlease_charges > 0 , " + String ( RGB ( 255 , 255 , 255 ) ) + " , 16777215 )'",  & 
						  "background.color = '16777217~tIF ( equipmentlease_charges > 0 , " + String ( RGB ( 255 ,0 , 0 ) ) + " , 16777215 ) ' "}
				




//	CASE "equipmentlease_freetimeexpiration"
//		ls_work = "BackGround.Color = '16777215~tCase ( DaysAfter (   Today ( ) ,  equipmentlease_freetimeexpiration )"+&
//				" WHEN  1  THEN " + string ( RGB ( 255, 255, 0 ) ) + " WHEN  0  THEN " + string ( RGB ( 255, 255, 0 ) ) + " WHEN  IS < 0 THEN " + string (  RGB ( 255, 0 ,0 ) ) +" ELSE " + string( RGB ( 255, 255, 255 ) ) + " )'"
//	    lsa_Settings =  { ls_Work }
//
//		ls_work = "color = '16777215~tCase ( DaysAfter ( Today( ) ,  equipmentlease_freetimeexpiration )" +&
//				  " WHEN  1  THEN " + string ( RGB ( 0, 0, 0 ) ) + " WHEN IS < 0 THEN " + string ( RGB ( 255, 255 ,255) ) + " ELSE " + string ( RGB ( 0, 0, 0  ) ) + ")'"
//
//	    lsa_Settings [ upperbound (lsa_settings) + 1 ] = ls_Work
//

END CHOOSE

IF li_Return = 1 THEN

	li_Count = UpperBound ( lsa_Settings )
	
	FOR li_Index = 1 TO li_Count
	
		apo_Target.Dynamic Modify ( as_ObjectName + "." + lsa_Settings [ li_Index ] )
	
	NEXT

END IF

RETURN li_return



end function

protected function integer of_getvaluelist (string as_columnname, ref string as_valuelist);Integer	li_Return
String	ls_ValueList
n_cst_Events	lnv_Events

li_Return = 1
as_ValueList = ""

CHOOSE CASE as_ColumnName

CASE "intermodalequipment_type"
		ls_ValueList = "TRLR~tV/FLBD~tF/REFR~tR/TANK~tK/RBOX~tB/CHAS~tH/CNTN~tC/" 
		
CASE "equipment_type", "trip_equipmenttype", "bt_eq_type"
		ls_ValueList = "----~tZ/TRAC~tT/STRT~tS/VAN~tN/TRLR~tV"+&
				"/FLBD~tF/REFR~tR/TANK~tK/RBOX~tB/CHAS~tH/CNTN~tC/" 

CASE "currentevent_type" ,  "originationevent_type", "terminationevent_type"
		ls_ValueList = lnv_Events.of_GetTypeCodeTable ( )

CASE "currentevent_timezone", "originationevent_timezone" , "terminationevent_timezone"
		ls_ValueList = n_cst_Constants.cs_TimeZoneCodeTable
CASE "equipment_status"
	ls_ValueList = "ACTIVE~tK/DEACTIVATED~tD/"

CASE ELSE
	li_Return = 0 
END CHOOSE

IF li_Return = 1 THEN
	as_ValueList = "Values = '" + ls_ValueList + "'"
END IF


RETURN li_Return
end function

on n_cst_presentation_equipmentsummary.create
TriggerEvent( this, "constructor" )
end on

on n_cst_presentation_equipmentsummary.destroy
TriggerEvent( this, "destructor" )
end on

