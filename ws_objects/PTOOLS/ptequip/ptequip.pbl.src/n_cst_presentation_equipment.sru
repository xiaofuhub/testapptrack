$PBExportHeader$n_cst_presentation_equipment.sru
$PBExportComments$PresentationService (Non-persistent Class from PBL map PTApp) //@(*)[46244804|433]
forward
global type n_cst_presentation_equipment from n_cst_presentation
end type
end forward

global type n_cst_presentation_equipment from n_cst_presentation
end type

type variables
private:

Constant String	cs_TANK_Type_Hazardous = 'HAZARDOUS'
Constant String	cs_TANK_Type_GeneralChemical = 'GENERAL CHEMICAL'
Constant String	cs_TANK_Type_FoodGrade = 'FOOD GRADE'
Constant String	cs_TANK_Type_Lined = 'LINED'
Constant String	cs_TANK_Type_DryBulk = 'DRY BULK'
Constant String	cs_TANK_Type_Insulated = 'INSULATED'
Constant String	cs_TANK_Type_Pressurized = 'PRESSURIZED'
													
Constant String	cs_FLAT_Type_StraightFrame = 'STRAIGHT FRAME'
Constant String	cs_FLAT_Type_StraightFrameSpreadAxle = 'STRAIGHT FRAME SPREAD AXLE'
Constant String	cs_FLAT_Type_StraightFrameExtendable = 'STRAIGHT FRAME EXTENDABLE'
Constant String	cs_FLAT_Type_SingleDrop = 'SINGLE DROP'
Constant String	cs_FLAT_Type_SingleDropExtendable = 'SINGLE DROP EXTENDABLE'
Constant String	cs_FLAT_Type_DoubleDrop = 'DOUBLE DROP'
Constant String	cs_FLAT_Type_DoubleDropExtendable = 'DOUBLE DROP EXTENDABLE'
Constant String	cs_FLAT_Type_LowBoy = 'LOWBOY'
Constant String	cs_FLAT_Type_LandAll = 'LANDALL'

Constant String	cs_STRT_Type_Dry = 'DRY'
Constant String	cs_STRT_Type_Reefer = 'REEFER'

Constant String	cs_TRLR_Type_Van = 'VAN'
Constant String	cs_TRLR_Type_AutoDrop = 'AUTO DROP'
Constant String	cs_TRLR_Type_ElectronicsDrop = 'ELECTRONICS DROP'
Constant String	cs_TRLR_Type_CurtainSide = 'CURTAIN SIDE'
Constant String	cs_TRLR_Type_RollerBed = 'ROLLER BED'

Constant String	cs_CHAS_Type_Slider = 'SLIDER'
Constant String	cs_CHAS_Type_HeavyHauler = 'HEAVY HAULER'
Constant String	cs_CHAS_Type_SuperChassis = 'SUPERCHASSIS'
Constant String	cs_CHAS_Type_Extendable = 'EXTENDABLE'
Constant String	cs_CHAS_Type_8Pin = '8 PIN'

Constant String	cs_CNTN_Type_ReeferStandard = 'REEFER-STANDARD'
Constant String	cs_CNTN_Type_ReeferHighCube = 'REEFER-HIGH CUBE'
Constant String	cs_CNTN_Type_DryStandard = 'DRY-STANDARD'
Constant String	cs_CNTN_Type_DryHighCube = 'DRY-HIGH CUBE'
Constant String	cs_CNTN_Type_FlatRack = 'FLAT RACK'
Constant String	cs_CNTN_Type_OpenTop = 'OPEN TOP'
Constant String	cs_CNTN_Type_OpenSide = 'OPEN SIDE'
Constant String	cs_CNTN_Type_Vented = 'VENTED'
Constant String	cs_CNTN_Type_Tank = 'TANK'
Constant String	cs_CNTN_Type_Bulk = 'BULK'
Constant String	cs_CNTN_Type_AutoRack = 'AUTO RACK'

Constant String	cs_REFR_Type_SingleTemp = 'SINGLE TEMP'
Constant String	cs_REFR_Type_MultiTemp = 'MULTI TEMP'

Constant String	cs_DoorType_Swing = 'SWING'
Constant String	cs_DoorType_Roll = 'ROLL'

Constant String	cs_FloorType_Wood = 'WOOD'
Constant String	cs_FloorType_Aluminum = 'ALUMINUM'

Constant String	cs_Construction_Steel = 'STEEL'
Constant String	cs_Construction_Aluminum = 'ALUMINUM'
Constant String	cs_Construction_FRP = 'FRP'

Constant String	cs_Discharge_Powered = 'POWERED'
Constant String	cs_Discharge_GravityFeed = 'GRAVITY FEED'

Constant String	cs_AuxiliaryDevice_PrePass = 'PrePass#'
Constant String	cs_AuxiliaryDevice_FastTrack = 'Fast Track'
Constant String	cs_AuxiliaryDevice_IMEI = 'IMEI#'

Constant String	cs_Tarp_Full = 'FULL'
Constant String	cs_Tarp_Half = 'HALF'
Constant String	cs_Tarp_Skin = 'SKIN'

Constant String	cs_PowerSource_Mechanical = 'MECHANICAL'
Constant String	cs_PowerSource_Electric = 'ELECTRIC'


Constant String	cs_Tank_Type_ValueList = cs_TANK_Type_Hazardous + "~t" + cs_TANK_Type_Hazardous+ "/" +&
													cs_TANK_Type_GeneralChemical + "~t" + cs_TANK_Type_GeneralChemical+ "/" +&
													cs_TANK_Type_FoodGrade + "~t" + cs_TANK_Type_FoodGrade+ "/" +&
													cs_TANK_Type_Lined + "~t" + cs_TANK_Type_Lined+ "/" +&
													cs_TANK_Type_DryBulk + "~t" + cs_TANK_Type_DryBulk+ "/" +&
													cs_TANK_Type_Insulated + "~t" + cs_TANK_Type_Insulated+ "/" +&
													cs_TANK_Type_Pressurized + "~t" + cs_TANK_Type_Pressurized+ "/" 
													
Constant String	cs_FLAT_Type_ValueList = cs_FLAT_Type_StraightFrame + "~t" + cs_FLAT_Type_StraightFrame+ "/" +&
													cs_FLAT_Type_StraightFrameSpreadAxle + "~t" + cs_FLAT_Type_StraightFrameSpreadAxle+ "/" +&
													cs_FLAT_Type_StraightFrameExtendable + "~t" + cs_FLAT_Type_StraightFrameExtendable+ "/" +&
													cs_FLAT_Type_SingleDrop + "~t" + cs_FLAT_Type_SingleDrop+ "/" +&
													cs_FLAT_Type_SingleDropExtendable + "~t" + cs_FLAT_Type_SingleDropExtendable+ "/" +&
													cs_FLAT_Type_DoubleDrop + "~t" + cs_FLAT_Type_DoubleDrop+ "/" +&
													cs_FLAT_Type_DoubleDropExtendable + "~t" + cs_FLAT_Type_DoubleDropExtendable+ "/" +&
													cs_FLAT_Type_LowBoy + "~t" + cs_FLAT_Type_LowBoy+ "/" +&
													cs_FLAT_Type_LandAll + "~t" + cs_FLAT_Type_LandAll+ "/" 						

Constant String	cs_STRT_Type_ValueList = cs_STRT_Type_Dry + "~t" + cs_STRT_Type_Dry+ "/" +&
													cs_STRT_Type_Reefer + "~t" + cs_STRT_Type_Reefer+ "/" 

Constant String	cs_TRLR_Type_ValueList = cs_TRLR_Type_Van + "~t" + cs_TRLR_Type_Van+ "/" +&
													cs_TRLR_Type_AutoDrop + "~t" + cs_TRLR_Type_AutoDrop+ "/" +&
													cs_TRLR_Type_ElectronicsDrop + "~t" + cs_TRLR_Type_ElectronicsDrop+ "/" +&
													cs_TRLR_Type_CurtainSide + "~t" + cs_TRLR_Type_CurtainSide+ "/" +&
													cs_TRLR_Type_RollerBed + "~t" + cs_TRLR_Type_RollerBed+ "/"
													
Constant String	cs_CHAS_Type_ValueList = cs_CHAS_Type_Slider + "~t" + cs_CHAS_Type_Slider+ "/" +&
													cs_CHAS_Type_HeavyHauler + "~t" + cs_CHAS_Type_HeavyHauler+ "/" +&
													cs_CHAS_Type_SuperChassis + "~t" + cs_CHAS_Type_SuperChassis+ "/" +&
													cs_CHAS_Type_Extendable + "~t" + cs_CHAS_Type_Extendable+ "/" +&
													cs_CHAS_Type_8Pin + "~t" + cs_CHAS_Type_8Pin+ "/"

Constant String	cs_CNTN_Type_ValueList = cs_CNTN_Type_ReeferStandard + "~t" + cs_CNTN_Type_ReeferStandard+ "/" +&
													cs_CNTN_Type_ReeferHighCube + "~t" + cs_CNTN_Type_ReeferHighCube+ "/" +&
													cs_CNTN_Type_DryStandard + "~t" + cs_CNTN_Type_DryStandard+ "/" +&
													cs_CNTN_Type_DryHighCube + "~t" + cs_CNTN_Type_DryHighCube+ "/" +&
													cs_CNTN_Type_FlatRack + "~t" + cs_CNTN_Type_FlatRack+ "/" +&
													cs_CNTN_Type_OpenTop + "~t" + cs_CNTN_Type_OpenTop+ "/" +&
													cs_CNTN_Type_OpenSide + "~t" + cs_CNTN_Type_OpenSide+ "/" +&
													cs_CNTN_Type_Vented + "~t" + cs_CNTN_Type_Vented+ "/" +&
													cs_CNTN_Type_Tank + "~t" + cs_CNTN_Type_Tank+ "/" +&
													cs_CNTN_Type_Bulk + "~t" + cs_CNTN_Type_Bulk+ "/" +&
													cs_CNTN_Type_AutoRack + "~t" + cs_CNTN_Type_AutoRack+ "/"

Constant String	cs_REFR_Type_ValueList = cs_REFR_Type_SingleTemp + "~t" + cs_REFR_Type_SingleTemp+ "/" +&
													cs_REFR_Type_MultiTemp + "~t" + cs_REFR_Type_MultiTemp+ "/"

Constant String	cs_DoorType_ValueList = cs_DoorType_Swing + "~t" + cs_DoorType_Swing+ "/" +&
													cs_DoorType_Roll + "~t" + cs_DoorType_Roll+ "/"

Constant String	cs_FloorType_ValueList = cs_FloorType_Wood + "~t" + cs_FloorType_Wood+ "/" +&
													cs_FloorType_Aluminum + "~t" + cs_FloorType_Aluminum+ "/"

Constant String	cs_Construction_ValueList = cs_Construction_Steel + "~t" + cs_Construction_Steel+ "/" +&
													cs_Construction_Aluminum + "~t" + cs_Construction_Aluminum+ "/" +&
													cs_Construction_FRP + "~t" + cs_Construction_FRP+ "/"
													
Constant String	cs_Discharge_ValueList = cs_Discharge_Powered + "~t" + cs_Discharge_Powered+ "/" +&
													cs_Discharge_GravityFeed + "~t" + cs_Discharge_GravityFeed+ "/"

Constant String	cs_AuxiliaryDevice_ValueList = cs_AuxiliaryDevice_PrePass + "~t" + cs_AuxiliaryDevice_PrePass+ "/" +&
													cs_AuxiliaryDevice_FastTrack + "~t" + cs_AuxiliaryDevice_FastTrack+ "/" +&
													cs_AuxiliaryDevice_IMEI + "~t" + cs_AuxiliaryDevice_IMEI+ "/"

Constant String	cs_Tarp_ValueList = cs_Tarp_Full + "~t" + cs_Tarp_Full+ "/" +&
													cs_Tarp_Half + "~t" + cs_Tarp_Half+ "/" +&
													cs_Tarp_Skin + "~t" + cs_Tarp_Skin+ "/"

Constant String	cs_PowerSource_ValueList = cs_PowerSource_Mechanical + "~t" + cs_PowerSource_Mechanical+ "/" +&
													cs_PowerSource_Electric + "~t" + cs_PowerSource_Electric+ "/"

end variables

forward prototypes
protected function integer of_getvaluelist (string as_columnname, ref string as_valuelist)
public function integer of_setpresentation (powerobject apo_target, string as_objectname)
end prototypes

protected function integer of_getvaluelist (string as_columnname, ref string as_valuelist);Integer	li_Return
String	ls_ValueList

n_cst_equipmentmanager	lnv_EquipmentManager
li_Return = 1
as_ValueList = ""

CHOOSE CASE as_ColumnName
		
CASE lnv_EquipmentManager.cs_TRAC, lnv_EquipmentManager.cs_VAN, lnv_EquipmentManager.cs_RBOX
	//NO LIST
	
CASE lnv_EquipmentManager.cs_STRT
	ls_ValueList = cs_STRT_Type_ValueList
	
CASE lnv_EquipmentManager.cs_TRLR 
	ls_ValueList = cs_TRLR_Type_ValueList
	
CASE lnv_EquipmentManager.cs_FLBD
	ls_ValueList = cs_FLAT_Type_ValueList
	
CASE lnv_EquipmentManager.cs_REFR
	ls_ValueList = cs_REFR_Type_ValueList
	
CASE lnv_EquipmentManager.cs_TANK
	ls_ValueList = cs_Tank_Type_ValueList
	
CASE lnv_EquipmentManager.cs_CHAS
	ls_ValueList = cs_CHAS_Type_ValueList
	
CASE lnv_EquipmentManager.cs_CNTN
	ls_ValueList = cs_CNTN_Type_ValueList

CASE "doortype"
	ls_ValueList = cs_DoorType_ValueList
	
CASE "floortype"
	ls_ValueList = cs_FloorType_ValueList
	
CASE "construction"
	ls_ValueList = cs_Construction_ValueList
	
CASE "dischargetype"
	ls_ValueList = cs_Discharge_ValueList
	
CASE "device"
	ls_ValueList = cs_AuxiliaryDevice_ValueList

CASE "tarp"
	ls_ValueList = cs_Tarp_ValueList
	
CASE "powersource"
	ls_ValueList = cs_PowerSource_ValueList
	
CASE ELSE						
	li_Return = 0

END CHOOSE

IF li_Return = 1 THEN
	as_ValueList = "Values = '" + ls_ValueList + "'"
END IF


RETURN li_Return

end function

public function integer of_setpresentation (powerobject apo_target, string as_objectname);
String	ls_ValueList, &
			lsa_settings[]
			
Integer	li_Count, &
			li_Index, &
			li_Return

n_cst_EquipmentManager	lnv_EquipmentManager
li_Return = 1

CHOOSE CASE as_ObjectName
		
CASE	lnv_EquipmentManager.cs_TRAC, lnv_EquipmentManager.cs_VAN, lnv_EquipmentManager.cs_RBOX, &
		lnv_EquipmentManager.cs_STRT, lnv_EquipmentManager.cs_TRLR, lnv_EquipmentManager.cs_FLBD, &
		lnv_EquipmentManager.cs_REFR, lnv_EquipmentManager.cs_TANK, lnv_EquipmentManager.cs_CHAS, &
		lnv_EquipmentManager.cs_CNTN
		
		//don't make lower case
		
CASE ELSE
	
		as_ObjectName = Lower ( as_ObjectName )
		
END CHOOSE

CHOOSE CASE as_ObjectName
		
CASE	lnv_EquipmentManager.cs_TRAC, lnv_EquipmentManager.cs_VAN, lnv_EquipmentManager.cs_RBOX, &
		lnv_EquipmentManager.cs_STRT, lnv_EquipmentManager.cs_TRLR, lnv_EquipmentManager.cs_FLBD, &
		lnv_EquipmentManager.cs_REFR, lnv_EquipmentManager.cs_TANK, lnv_EquipmentManager.cs_CHAS, &
		lnv_EquipmentManager.cs_CNTN
		
	IF This.of_GetValueList ( as_ObjectName, ls_ValueList ) = 1 THEN
		lsa_Settings = { "Edit.CodeTable = Yes", ls_ValueList, "ddlb.UseAsBorder = No", "ddlb.Sorted = No", "ddlb.VScrollBar = Yes" }

	ELSE
		li_Return = -1
	END IF
	
		as_ObjectName = 'description'
		
		
CASE "doortype", "floortype", "construction", "dischargetype", "device", "tarp", "powersource"
		
	IF This.of_GetValueList ( as_ObjectName, ls_ValueList ) = 1 THEN
		lsa_Settings = { "Edit.CodeTable = Yes", ls_ValueList, "ddlb.UseAsBorder = No", "ddlb.Sorted = No", "ddlb.VScrollBar = Yes" }
	ELSE
		li_Return = -1
	END IF
	
END CHOOSE

IF li_Return = 1 THEN

	li_Count = UpperBound ( lsa_Settings )
	
	FOR li_Index = 1 TO li_Count
	
		apo_Target.Dynamic Modify ( as_ObjectName + "." + lsa_Settings [ li_Index ] )
	
	NEXT

END IF

RETURN li_Return

end function

on n_cst_presentation_equipment.create
call super::create
end on

on n_cst_presentation_equipment.destroy
call super::destroy
end on

