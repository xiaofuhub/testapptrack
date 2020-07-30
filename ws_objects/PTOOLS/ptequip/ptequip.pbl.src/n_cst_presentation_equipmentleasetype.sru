$PBExportHeader$n_cst_presentation_equipmentleasetype.sru
forward
global type n_cst_presentation_equipmentleasetype from n_cst_presentation
end type
end forward

global type n_cst_presentation_equipmentleasetype from n_cst_presentation
end type

forward prototypes
public function integer of_setpresentation (powerobject apo_target, string as_objectname)
protected function integer of_getvaluelist (string as_columnname, ref string as_valuelist)
end prototypes

public function integer of_setpresentation (powerobject apo_target, string as_objectname);/* rdt 08-05-02 added code for following columns:
equipmentleasetype_freetimestart, equipmentleasetype_freetimeweekend
equipmentleasetype_perdiemholiday, equipmentleasetype_perdiemweekend
equipmentleasetype_leasestatus 
*/		
String	lsa_Settings[], &
		ls_ValueList, &
		ls_Work
Integer	li_Count, &
		li_Index, &
		li_Return

li_Return = 1
as_ObjectName = Lower ( as_ObjectName )


CHOOSE CASE as_ObjectName

//***EquipmentLeaseType Table***

CASE "equipmentleasetype_freetimeunits", "equipmentleasetype_firstchargedunits", &
	"equipmentleasetype_secondchargedunits", "equipmentleasetype_thirdchargedunits", &
	"equipmentleasetype_fourthchargedunits" , "equipmentleasetype_chargedperiods", &
	"equipmentleasetype_firstchargedperiod", "equipmentleasetype_firstchargedrate", &
	"equipmentleasetype_secondchargedperiod", "equipmentleasetype_secondchargedrate", &
	"equipmentleasetype_thirdchargedperiod", "equipmentleasetype_thirdchargedrate", &
	"equipmentleasetype_fourthchargedperiod", "equipmentleasetype_fourthchargedrate", &
	"equipmentleasetype_freetimeunits", "equipmentleasetype_freetimeperiod" , &
	"equipmentleasetype_id", "equipmentleasetype_freetimestart", &
	"equipmentleasetype_freetimefriday", "equipmentleasetype_freetimeholiday" , &
	"equipmentleasetype_freetimeweekend" ,	"equipmentleasetype_perdiemholiday", &
	"equipmentleasetype_leasestatus" , "equipmentleasetype_dayofinterchangecounts"
													

	CHOOSE CASE as_ObjectName

		CASE "equipmentleasetype_id"
				
				lsa_Settings = { "Protect = 1","Background.Color = 12648447" }
	
		CASE "equipmentleasetype_freetimeunits", "equipmentleasetype_firstchargedunits", &
			"equipmentleasetype_secondchargedunits", "equipmentleasetype_thirdchargedunits", &
			"equipmentleasetype_fourthchargedunits" , "equipmentleasetype_chargedperiods", &
			"equipmentleasetype_freetimestart", "equipmentleasetype_freetimeweekend",& 
		   "equipmentleasetype_perdiemholiday", "equipmentleasetype_leasestatus",&
			"equipmentleasetype_dayofinterchangecounts"
			IF This.of_GetValueList ( as_ObjectName, ls_ValueList ) = 1 THEN
				lsa_Settings = { "Edit.CodeTable = Yes", ls_ValueList, "ddlb.UseAsBorder = No" }
			ELSE
				li_Return = -1
			END IF
			
	END CHOOSE


	CHOOSE CASE as_ObjectName

	CASE "equipmentleasetype_freetimeunits", "equipmentleasetype_freetimeperiod",&
			"equipmentleasetype_freetimestart"
			
			lsa_Settings [ UpperBound ( lsa_Settings ) + 1 ] = &
			"BackGround.Color = " + String ( Rgb ( 128, 255, 128 ) )

	CASE "equipmentleasetype_firstchargedunits", "equipmentleasetype_firstchargedperiod", &
		"equipmentleasetype_firstchargedrate"
	
		lsa_Settings [ UpperBound ( lsa_Settings ) + 1 ] = &
			"BackGround.Color = 12639424"

		IF as_objectName = "equipmentleasetype_firstchargedrate" THEN
			lsa_Settings [ UpperBound ( lsa_Settings ) + 1 ] = &
				"Format = '[currency]'"
		END IF

		IF as_ObjectName = "equipmentleasetype_firstchargedperiod" THEN
			lsa_Settings [ UpperBound ( lsa_Settings ) + 1 ] = &
				"Format = '[general]~tIF ( equipmentleasetype_chargedperiods = 1,~~'[general];[general];[general];UNTIL RTN~~', ~~'[general]~~')'"
			lsa_Settings [UpperBound (lsa_Settings ) + 1] = &
				"Protect = '0~tIF ( equipmentleasetype_chargedperiods = 1, 1, 0 )'"
		END IF

	CASE "equipmentleasetype_secondchargedunits", "equipmentleasetype_secondchargedperiod", &
		"equipmentleasetype_secondchargedrate"
	
		lsa_Settings [ UpperBound ( lsa_Settings ) + 1] = &
			"BackGround.Color = '16777215~tIF ( equipmentleasetype_chargedperiods > 1, 15780518, 12632256 )'"
		lsa_Settings [ UpperBound ( lsa_Settings ) + 1 ] = &
			"Protect = '0~tIF ( equipmentleasetype_chargedperiods > 1, 0, 1 )'"

		IF as_objectName = "equipmentleasetype_secondchargedrate" THEN
			lsa_Settings [ UpperBound ( lsa_Settings ) + 1 ] = &
				"Format = '[currency]'"
		END IF
		
		IF as_ObjectName = "equipmentleasetype_secondchargedperiod" THEN
			lsa_Settings [ UpperBound ( lsa_Settings ) + 1 ] = &
				"Format = '[general]~tIF ( equipmentleasetype_chargedperiods = 2,~~'[general];[general];[general];UNTIL RTN~~', ~~'[general]~~')'"
			lsa_Settings [UpperBound (lsa_Settings ) + 1] = &
				"Protect = '0~tIF ( equipmentleasetype_chargedperiods = 2, 1, 0 )'"
		END IF
	

	CASE "equipmentleasetype_thirdchargedunits", "equipmentleasetype_thirdchargedperiod", &
		"equipmentleasetype_thirdchargedrate"
	
		lsa_Settings [ UpperBound ( lsa_Settings ) + 1 ] = &
			"BackGround.Color = '16777215~tIF ( equipmentleasetype_chargedperiods > 2, 12639424, 12632256 )'"
		lsa_Settings [ UpperBound ( lsa_Settings ) + 1 ] = &
			"Protect = '0~tIF ( equipmentleasetype_chargedperiods > 2, 0, 1 )'"

		IF as_objectName = "equipmentleasetype_thirdchargedrate" THEN
			lsa_Settings [ UpperBound ( lsa_Settings ) + 1 ] = &
				"Format = '[currency]'"
		END IF

		IF as_objectName = "equipmentleasetype_thirdchargedperiod" THEN
			lsa_Settings [ UpperBound ( lsa_Settings ) + 1 ] = &
				"Format = '[general]~tIF ( equipmentleasetype_chargedperiods = 3,~~'[general];[general];[general];UNTIL RTN~~', ~~'[general]~~')'"
			lsa_Settings [UpperBound (lsa_Settings ) + 1] = &
				"Protect = '0~tIF ( equipmentleasetype_chargedperiods <= 3 , 1, 0 )'"
		END IF

	
	CASE "equipmentleasetype_fourthchargedunits", "equipmentleasetype_fourthchargedperiod", &
		"equipmentleasetype_fourthchargedrate"
	
		lsa_Settings [ UpperBound ( lsa_Settings ) + 1 ] = &
			"BackGround.Color = '16777215~tIF ( equipmentleasetype_chargedperiods > 3, 15780518, 12632256 )'"
		lsa_Settings [ UpperBound ( lsa_Settings ) + 1 ] = &
			"Protect = '0~tIF ( equipmentleasetype_chargedperiods > 3, 0, 1 )'"
	
		IF as_objectName = "equipmentleasetype_fourthchargedrate" THEN
			lsa_Settings [ UpperBound ( lsa_Settings ) + 1 ] = &
				"Format = '[currency]'"
		END IF

		IF as_objectName = "equipmentleasetype_fourthchargedperiod" THEN
			lsa_Settings [ UpperBound ( lsa_Settings ) + 1 ] = &
				"Format = '[general]~tIF ( equipmentleasetype_chargedperiods = 4,~~'[general];[general];[general];UNTIL RTN~~', ~~'[general]~~')'"
			lsa_Settings [UpperBound (lsa_Settings ) + 1] = &
				"Protect = '0~tIF ( equipmentleasetype_chargedperiods = 4 , 1, 1 )'"
		END IF


	CASE "equipmentleasetype_freetimefriday"
			lsa_Settings [ UpperBound ( lsa_Settings ) + 1 ] = "Format = 'h:mm AM/PM'"
			lsa_Settings [ UpperBound ( lsa_Settings ) + 1 ] = "Edit.Format = 'h:mm AM/PM'"	
			lsa_Settings [ UpperBound ( lsa_Settings ) + 1 ] = &
			"BackGround.Color = " + String ( Rgb ( 128, 255, 128 ) )


	CASE "equipmentleasetype_freetimeholiday"
			lsa_Settings [ UpperBound ( lsa_Settings ) + 1 ] = "Format = 'h:mm AM/PM'" 
			lsa_Settings [ UpperBound ( lsa_Settings ) + 1 ] = "Edit.Format = 'h:mm AM/PM'" 
			lsa_Settings [ UpperBound ( lsa_Settings ) + 1 ] = &
			"BackGround.Color = " + String ( Rgb ( 128, 255, 128 ) )

// rdt 08/23/02 changed to upper case only
	CASE "equipmentleasetype_line", "equipmentleasetype_type", "equipmentleasetype_equipmentlength", &
			"equipmentleasetype_lineprefix"
			lsa_Settings [ UpperBound ( lsa_Settings ) + 1 ] = "Edit.Case = 'upper'" 
	
	
	
	CASE  "equipmentleasetype_dayofinterchangecounts"
		
		
		lsa_Settings [ UpperBound ( lsa_Settings ) + 1] = &
			"BackGround.Color = '12632256~tIF ( equipmentleasetype_freetimeperiod > 0, RGB( 128, 255, 128 ), 12632256 )'"
		
		lsa_Settings [ UpperBound ( lsa_Settings ) + 1] = &
			"Color = '0~tIF ( equipmentleasetype_freetimeperiod > 0, 0,12632256)'"
		
		
		lsa_Settings [ UpperBound ( lsa_Settings ) + 1 ] = &
			"Protect = '0~tIF ( equipmentleasetype_freetimeperiod > 0, 0, 1 )'"
		
		
		
	CASE  "equipmentleasetype_freetimeweekend"
		
		
		lsa_Settings [ UpperBound ( lsa_Settings ) + 1] = &
			"BackGround.Color = '12632256~tIF ( equipmentleasetype_freetimeperiod > 0, RGB( 128, 255, 128 ), 12632256 )'"
		
		lsa_Settings [ UpperBound ( lsa_Settings ) + 1] = &
			"Color = '0~tIF ( equipmentleasetype_freetimeperiod > 0, 0,12632256)'"
		
		
		lsa_Settings [ UpperBound ( lsa_Settings ) + 1 ] = &
			"Protect = '0~tIF ( equipmentleasetype_freetimeperiod > 0, 0, 1 )'"
		
			
		
	END CHOOSE
END CHOOSE

IF li_Return = 1 THEN

	li_Count = UpperBound ( lsa_Settings )
	
	FOR li_Index = 1 TO li_Count
	
		apo_Target.Dynamic Modify ( as_ObjectName + "." + lsa_Settings [ li_Index ] )
	
	NEXT

END IF

RETURN li_Return

end function

protected function integer of_getvaluelist (string as_columnname, ref string as_valuelist);/* rdt 08-05-02 added code for following columns:
equipmentleasetype_freetimestart, equipmentleasetype_freetimeweekend
equipmentleasetype_perdiemholiday, equipmentleasetype_perdiemweekend
equipmentleasetype_leasestatus, cf_fridayflag, cf_holidayflag
*/		

//Returns: 1 = Success, 0 = Column not found, -1 = Error

Integer	li_Return
String	ls_ValueList

li_Return = 1
as_ValueList = ""

CHOOSE CASE as_ColumnName


CASE "equipmentleasetype_freetimeunits", "equipmentleasetype_firstchargedunits", &
	"equipmentleasetype_secondchargedunits", "equipmentleasetype_thirdchargedunits", &
	"equipmentleasetype_fourthchargedunits"

	ls_ValueList = "CALENDAR DAY~t" + String ( appeon_constant.ci_CalendarDays ) +&
						"/WORKING DAY~t" + String ( appeon_constant.ci_WorkingDays ) +&
						"/HOUR~t" + String ( appeon_constant.ci_Hours ) + "/"
	
CASE "equipmentleasetype_chargedperiods"
	
	ls_ValueList = 	"1~t1/" + &
					"2~t2/" + &
					"3~t3/" + &
					"4~t4/" 
CASE "equipmentleasetype_freetimestart" 
		ls_ValueList = "NOTIFY~t" + String(appeon_constant.ci_Notify) + &
		               "/OUTGATE~t" + String(appeon_constant.ci_OutGate) + "/"

CASE "equipmentleasetype_freetimeweekend", "equipmentleasetype_perdiemholiday" ,&
		"equipmentleasetype_dayofinterchangecounts"
		ls_ValueList = "YES~t" + String(appeon_constant.ci_Yes) + &
		               "/NO~t" + String(appeon_constant.ci_No) + "/"

CASE "equipmentleasetype_leasestatus"
		ls_ValueList = "ACTIVE~t" + String(appeon_constant.ci_Active) + &
		               "/DEACTIVATED~t" + String(appeon_constant.ci_DeActive) + "/"
		
CASE ELSE
	li_Return = 0

END CHOOSE

IF li_Return = 1 THEN
	as_ValueList = "Values = '" + ls_ValueList + "'"
END IF

RETURN li_Return
end function

on n_cst_presentation_equipmentleasetype.create
call super::create
end on

on n_cst_presentation_equipmentleasetype.destroy
call super::destroy
end on

