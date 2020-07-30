$PBExportHeader$n_cst_presentation.sru
$PBExportComments$PresentationService (Non-persistent Class from PBL map PTApp) //@(*)[46244804|433]
forward
global type n_cst_presentation from nonvisualobject
end type
end forward

shared variables
////@(text)(recreate=opt)<Synchronized Shared Variables>
////The following variables will be synchronized with HOW.
////You may edit these variables, add new variables or delete variables.
////Please add one variable declaration per line.
//
////begin modification Shared Variables by appeon  20070730
//n_cst_presentation sn_n_cst_presentation_a[] //@(*)[46244804|433:n]<nosync>
//Integer sn_n_cst_presentation_c //@(*)[46244804|433:c]<nosync>
////@(text)--
//
////Add your implementation-only shared variables after this line.
////These variables will NOT be synchronized with HOW.
//
//DataStore	sds_CustomCache
////end modification Shared Variables by appeon  20070730
end variables

global type n_cst_presentation from nonvisualobject autoinstantiate
event type integer ue_getcustomlabel ( string as_custom,  ref string as_label )
event type string ue_getcustomsectionheader ( )
end type

type variables
//@(text)(recreate=opt)<Synchronized Shared Variables>
//The following variables will be synchronized with HOW.
//You may edit these variables, add new variables or delete variables.
//Please add one variable declaration per line.

//begin modification Shared Variables by appeon  20070730
n_cst_presentation sn_n_cst_presentation_a[] //@(*)[46244804|433:n]<nosync>
Integer sn_n_cst_presentation_c //@(*)[46244804|433:c]<nosync>
//@(text)--

//Add your implementation-only shared variables after this line.
//These variables will NOT be synchronized with HOW.

//DataStore	sds_CustomCache
//end modification Shared Variables by appeon  20070730

Protected Boolean	ib_Report


end variables

forward prototypes
public function integer of_getcodetable (string as_class, ref string as_codetable)
public function integer of_setpresentation (powerobject apo_target)
public function integer of_setpresentation (powerobject apo_target, string as_objectname)
protected function integer of_getvaluelist (string as_columnname, ref string as_valuelist)
public function integer of_setenablement (datawindow adw_dw, boolean ab_enable)
public function integer of_setenablement (datawindow adw_dw, boolean ab_enable, string asa_excludecols[], boolean ab_greyout, long al_greyoutcolor)
public function integer of_setenablement (datawindow adw_dw, boolean ab_enable, string asa_excludecols[], boolean ab_greyout)
public function integer of_setenablement (datawindow adw_dw, boolean ab_enable, string asa_excludecols[])
end prototypes

event ue_getcustomlabel;//Returns : 1 = Custom field defined, label passed out in as_Label
//0 = Custom Field recognized, but not defined
//-1 = Error : unable to intialize, or custom field requested not recognized.

Long		ll_CacheRow
String	ls_Label, &
			ls_SectionHeader, &
			ls_IniFile

Integer	li_Return = 0


as_Custom = Lower ( as_Custom )
as_Label = ""

ls_SectionHeader = This.Event ue_GetCustomSectionHeader ( )


IF Len ( ls_SectionHeader ) > 0 THEN

	IF NOT IsValid ( sds_CustomCache ) THEN

		sds_CustomCache = CREATE DataStore
		sds_CustomCache.DataObject = "d_IniValues"

	END IF


	ll_CacheRow = sds_CustomCache.Find ( "Lower ( Section ) = '" + Lower ( ls_SectionHeader ) +& 
		"' AND Lower ( Key ) = '" + Lower ( as_Custom ) + "'", 1, sds_CustomCache.RowCount ( ) )

	IF ll_CacheRow > 0 THEN

		ls_Label = sds_CustomCache.Object.StringValue [ ll_CacheRow ]

		IF Len ( ls_Label ) > 0 THEN
			as_Label = ls_Label
			li_Return = 1
		END IF

	ELSE

		ls_IniFile = gnv_App.of_GetAppIniFile ( )
		ls_Label = ProfileString ( ls_IniFile, ls_SectionHeader, as_Custom, "" )

		IF Len ( ls_Label ) > 0 THEN

			as_Label = ls_Label
			li_Return = 1

		ELSE
			ls_Label = ""

		END IF

		ll_CacheRow = sds_CustomCache.InsertRow ( 0 )

		IF ll_CacheRow > 0 THEN
			sds_CustomCache.Object.Section [ ll_CacheRow ] = ls_SectionHeader
			sds_CustomCache.Object.Key [ ll_CacheRow ] = as_Custom
			sds_CustomCache.Object.StringValue [ ll_CacheRow ] = ls_Label
		END IF

	END IF

ELSE

	li_Return = -1

END IF


RETURN li_Return
end event

event ue_getcustomsectionheader;//Placeholder for descendants that support custom fields.
//For those descendants, this code should be overridden to return the section header
//name in the ini file ("CompanyCustom", for example.)

RETURN ""
end event

public function integer of_getcodetable (string as_class, ref string as_codetable);//as_Class should be in the form n_cst_dlkc_xxx

//Return : 1, -1

n_cst_bcm	lnv_Cache
Integer		li_Return
Constant Boolean	lb_CreateNew = TRUE
Constant Boolean	lb_RetrieveNew = TRUE

li_Return = -1

IF gnv_App.inv_CacheManager.of_GetCache ( as_Class, lnv_Cache, lb_CreateNew, lb_RetrieveNew ) = 1 THEN
	IF lnv_Cache.GetCodeTable ( as_CodeTable ) = 1 THEN
		li_Return = 1
	END IF
END IF

RETURN li_Return
end function

public function integer of_setpresentation (powerobject apo_target);//@(*)[46417896|434]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>
//@(text)--


//Integer	li_ColumnCount, &
//			li_Column
//String	ls_ColumnName
//
//li_ColumnCount = Integer ( adw_Target.Describe ( "DataWindow.Column.Count" ) )
//
//FOR li_Column = 1 TO li_ColumnCount
//
//	ls_ColumnName = adw_Target.Describe ( "#" + String ( li_Column ) + ".Name" )
//	of_SetPresentation ( adw_Target, ls_ColumnName )
//
//NEXT

Integer	li_ObjectCount, &
			li_Object
String	ls_ObjectList, &
			ls_Objects[], &
			ls_ReadOnly
n_cst_String	lnv_String


//Determine if we are working on a report.  If so, flag it, so subsequent calls can
//take that into account.

ls_ReadOnly = apo_Target.Dynamic Describe ( "DataWindow.ReadOnly" )

IF Lower ( ls_ReadOnly ) = "yes" THEN
	ib_Report = TRUE
END IF


ls_ObjectList = apo_Target.Dynamic Describe ( "DataWindow.Objects" )

li_ObjectCount = lnv_String.of_ParseToArray ( ls_ObjectList, "~t", ls_Objects )

FOR li_Object = 1 TO li_ObjectCount

	This.of_SetPresentation ( apo_Target, ls_Objects [ li_Object ] )

NEXT

RETURN 1
end function

public function integer of_setpresentation (powerobject apo_target, string as_objectname);//@(*)[47193615|436]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>
//@(text)--


String	lsa_Settings[], &
		ls_ValueList, &
		ls_Work
Integer	li_Count, &
		li_Index, &
		li_Return

li_Return = 1
as_ObjectName = Lower ( as_ObjectName )


//CHOOSE CASE as_ObjectName
//
////Currently, no values are defined here.
//
//END CHOOSE


IF li_Return = 1 THEN

	li_Count = UpperBound ( lsa_Settings )
	
	FOR li_Index = 1 TO li_Count
	
		apo_Target.Dynamic Modify ( as_ObjectName + "." + lsa_Settings [ li_Index ] )
	
	NEXT

END IF

RETURN li_Return
end function

protected function integer of_getvaluelist (string as_columnname, ref string as_valuelist);//@(*)[330911798|442]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

//Returns: 1 = Success, 0 = Column not found, -1 = Error

Integer	li_Return
String	ls_ValueList

li_Return = 1
as_ValueList = ""

//CHOOSE CASE as_ColumnName
//
////Currently, no values are defined here.
//
//CASE ELSE
	li_Return = 0

//END CHOOSE

IF li_Return = 1 THEN
	as_ValueList = "Values = '" + ls_ValueList + "'"
END IF

RETURN li_Return
end function

public function integer of_setenablement (datawindow adw_dw, boolean ab_enable);String	lsa_ExcludeCols[]

Return This.of_SetEnablement(adw_dw, ab_Enable, lsa_ExcludeCols)
end function

public function integer of_setenablement (datawindow adw_dw, boolean ab_enable, string asa_excludecols[], boolean ab_greyout, long al_greyoutcolor);Integer	li_Return = 1
Integer	li_Protect
Long		ll_BackColor
Long		ll_ColCount
Long		ll_ExcludeCount
Long		i
Long		j
String	ls_ColName
String	ls_Type
String	ls_CheckBox3d
Boolean	lb_Skip

adw_Dw.SetRedraw(False)

IF NOT isValid(adw_dw.Object) THEN
	li_Return = -1
END IF

IF li_Return = 1 THEN
	
	IF ab_Enable THEN
		li_Protect = 0
		ll_BackColor = RGB(255,255,255) //White
		ls_CheckBox3d = "Yes"
	ELSE
		li_Protect = 1
		ll_BackColor = al_GreyOutColor
		ls_CheckBox3d = "No"
	END IF

	ll_ColCount = Long ( adw_dw.Object.DataWindow.Column.Count )
	ll_ExcludeCount = UpperBound(asa_ExcludeCols)
	
	FOR i = 1 TO ll_ColCount

		ls_ColName = adw_dw.Describe( "#" + String (i) +".Name" )
		IF ls_ColName = "di_dutystatusdatetime" THEN
			ls_Colname = ls_Colname
		END IF
		//Skip exlcuded columns
		lb_Skip = FALSE
		FOR j = 1 TO ll_ExcludeCount
			IF ls_ColName = asa_ExcludeCols[j] THEN
				lb_Skip = TRUE
				EXIT
			END IF
		NEXT
		
		IF lb_Skip THEN
			CONTINUE
		END IF
		
		//Modify Columns
		ls_Type = adw_dw.Describe( "#" + String(i) + ".Edit.Style")
		adw_dw.Modify( ls_ColName +".Protect=" + String ( li_Protect ) )
		
		IF ab_GreyOut THEN
			
			CHOOSE CASE ls_Type
				CASE "checkbox"
					adw_dw.Modify(ls_ColName + ".CheckBox.3D=" + ls_CheckBox3d) 
				CASE ELSE
					adw_dw.Modify( ls_ColName + ".Background.Color = " + String(ll_BackColor) )
			END CHOOSE

		END IF
		
	NEXT
	
END IF

adw_Dw.SetRedraw(True)

Return li_Return
end function

public function integer of_setenablement (datawindow adw_dw, boolean ab_enable, string asa_excludecols[], boolean ab_greyout);Constant Long	ll_Silver = RGB(192,192,192)
Return This.of_SetEnablement( adw_dw, ab_enable, asa_excludecols, ab_Greyout, ll_Silver )
end function

public function integer of_setenablement (datawindow adw_dw, boolean ab_enable, string asa_excludecols[]);Constant Boolean	lb_GREYOUT = True

Return This.of_SetEnablement(adw_dw, ab_Enable, asa_ExcludeCols, lb_GREYOUT)
end function

on n_cst_presentation.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_presentation.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//@(text)(recreate=yes)<init>

//@(text)--


end event

