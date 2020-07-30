$PBExportHeader$n_cst_presentation_state.sru
$PBExportComments$PresentationService (Non-persistent Class from PBL map PTApp) //@(*)[46244804|433]
forward
global type n_cst_presentation_state from n_cst_presentation
end type
end forward

global type n_cst_presentation_state from n_cst_presentation
end type

type variables
private:

Constant String	cs_State_ValueList = "choose a state~t /" +&
													"Alabama~tAL/" +&
													"Alaska~tAK/" +&
													"Arizona~tAZ/" +&
													"Arkansas~tAR/" +&
													"California~tCA/" +&
													"Colorado~tCO/" +&
													"Connecticut~tCT/" +&
													"Delaware~tDE/" +&
													"District of Columbia~tDC/" +&
													"Florida~tFL/" +&
													"Georgia~tGA/" +&
													"Hawaii~tHI/" +&
													"Idaho~tID/" +&
													"Illinois~tIL/" +&
													"Indiana~tIN/" +&
													"Iowa~tIA/" +&
													"Kansas~tKS/" +&
													"Kentucky~tKY/" +&
													"Louisiana~tLA/" +&
													"Maine~tME/" +&
													"Maryland~tMD/" +&
													"Massachusetts~tMA/" +&
													"Michigan~tMI/" +&
													"Minnesota~tMN/" +&
													"Mississippi~tMS/" +&
													"Missouri~tMO/" +&
													"Montana~tMT/" +&
													"Nebraska~tNE/" +&
													"Nevada~tNV/" +&
													"New Hampshire~tNH/" +&
													"New Jersey~tNJ/" +&
													"New Mexico~tNM/" +&
													"New York~tNY/" +&
													"North Carolina~tNC/" +&
													"North Dakota~tND/" +&
													"Ohio~tOH/" +&
													"Oklahoma~tOK/" +&
													"Oregon~tOR/" +&
													"Pennsylvania~tPA/" +&
													"Rhode Island~tRI/" +&
													"South Carolina~tSC/" +&
													"South Dakota~tSD/" +&
													"Tennessee~tTN/" +&
													"Texas~tTX/" +&
													"Utah~tUT/" +&
													"Vermont~tVT/" +&
													"Virginia~tVA/" +&
													"Washington~tWA/" +&
													"West Virginia~tWV/" +&
													"Wisconsin~tWI/" +&
													"Wyoming~tWY/" 
													
													
Constant String	cs_State_PRE16 =		"Alberta~tAB/" +&
													"British Columbia~tBC/" +&
													"Manitoba~tMB/" +&
													"New Brunswick~tNB/" +&
													"Newfoundland~tNF/" +&
													"Northwest Territories~tNT/" +&
													"Nova Scotia~tNS/" +&
													"Ontario~tON/" +&
													"Prince Edward Island~tPE/" +&
													"Quebec~tPQ/" +&
													"Saskatchewan~tSK/" +&
													"Yukon~tYK/" +&
													"Mexico~tMX/"
													
Constant String	cs_State_POST15 =		"Alberta~tAB/" +&
													"British Columbia~tBC/" +&
													"Manitoba~tMB/" +&
													"New Brunswick~tNB/" +&
													"Newfoundland and Labrador~tNL/" +&
													"Northwest Territories~tNT/" +&
													"Nova Scotia~tNS/" +&
													"Nunavut~tNU/" +&
													"Ontario~tON/" +&
													"Prince Edward Island~tPE/" +&
													"Quebec~tQC/" +&
													"Saskatchewan~tSK/" +&
													"Yukon~tYT/" +&
													"Mexico~tMX/"
													
Constant String	cs_State_AbrevList = "AL~tAL/" +&
													"AK~tAK/" +&
													"AZ~tAZ/" +&
													"AR~tAR/" +&
													"CA~tCA/" +&
													"CO~tCO/" +&
													"CT~tCT/" +&
													"DE~tDE/" +&
													"DC~tDC/" +&
													"FL~tFL/" +&
													"GA~tGA/" +&
													"HI~tHI/" +&
													"ID~tID/" +&
													"IL~tIL/" +&
													"IN~tIN/" +&
													"IA~tIA/" +&
													"KS~tKS/" +&
													"KY~tKY/" +&
													"LA~tLA/" +&
													"ME~tME/" +&
													"MD~tMD/" +&
													"MA~tMA/" +&
													"MI~tMI/" +&
													"MN~tMN/" +&
													"MS~tMS/" +&
													"MO~tMO/" +&
													"MT~tMT/" +&
													"NE~tNE/" +&
													"NV~tNV/" +&
													"NH~tNH/" +&
													"NJ~tNJ/" +&
													"NM~tNM/" +&
													"NY~tNY/" +&
													"NC~tNC/" +&
													"ND~tND/" +&
													"OH~tOH/" +&
													"OK~tOK/" +&
													"OR~tOR/" +&
													"PA~tPA/" +&
													"RI~tRI/" +&
													"SC~tSC/" +&
													"SD~tSD/" +&
													"TN~tTN/" +&
													"TX~tTX/" +&
													"UT~tUT/" +&
													"VT~tVT/" +&
													"VA~tVA/" +&
													"WA~tWA/" +&
													"WV~tWV/" +&
													"WI~tWI/" +&
													"WY~tWY/"
													
Constant String	cs_State_Abrev_PRE16 =	 &
													"AB~tAB/" +&
													"BC~tBC/" +&
													"MB~tMB/" +&
													"NB~tNB/" +&
													"NF~tNF/" +&
													"NT~tNT/" +&
													"NS~tNS/" +&
													"ON~tON/" +&
													"PE~tPE/" +&
													"PQ~tPQ/" +&
													"SK~tSK/" +&
													"YK~tYK/" +&
													"MX~tMX/"
													
Constant String	cs_State_Abrev_POST15 =	&
													"AB~tAB/" +&
													"BC~tBC/" +&
													"MB~tMB/" +&
													"NB~tNB/" +&
													"NL~tNL/" +&
													"NT~tNT/" +&
													"NS~tNS/" +&
													"NU~tNU/" +&
													"ON~tON/" +&
													"PE~tPE/" +&
													"QC~tQC/" +&
													"SK~tSK/" +&
													"YT~tYT/" +&
													"MX~tMX/"
													
													
end variables

forward prototypes
protected function integer of_getvaluelist (string as_columnname, ref string as_valuelist)
public function integer of_setpresentation (powerobject apo_target, string as_objectname)
end prototypes

protected function integer of_getvaluelist (string as_columnname, ref string as_valuelist);Integer	li_Return
String	ls_ValueList

li_Return = 1
as_ValueList = ""

string	ls_ProductVersion
n_cst_trip	lnv_trip
n_cst_routing	lnv_routing

//need PCMiler version
lnv_trip = create n_cst_trip

if lnv_trip.of_isconnected() then
	if lnv_trip.of_connect(lnv_routing) then
		if lnv_routing.of_isvalid() then
			ls_productversion=lnv_routing.of_about("ProductVersion")
		end if	
	end if
end if

destroy lnv_trip
//

CHOOSE CASE as_ColumnName

CASE "state" 
	ls_ValueList = THIS.cs_state_ValueList

	//depending on PCMiler version
	choose case ls_productversion
		case "11.0", "12.0", "2000.0", "14.0", "15.0"
			ls_ValueList = ls_ValueList + THIS.cs_State_PRE16
			
		case else//"16.0", "17.0", "18.0" etc..
			ls_ValueList = ls_ValueList + THIS.cs_State_Post15
			
	end choose
	
CASE "di_lic_state", "em_state", "co_state", "co_bill_state", "lr_state"
	ls_ValueList = THIS.cs_State_AbrevList
	
	//depending on PCMiler version
	choose case ls_productversion
		case "11.0", "12.0", "2000.0", "14.0", "15.0"
			ls_ValueList = ls_ValueList + THIS.cs_State_Abrev_PRE16			
		
		case else//"16.0", "17.0", "18.0" etc..
			ls_ValueList = ls_ValueList + THIS.cs_State_Abrev_Post15
			
	end choose

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


li_Return = 1

as_ObjectName = Lower ( as_ObjectName )

CHOOSE CASE as_ObjectName

CASE "state"
	IF This.of_GetValueList ( as_ObjectName, ls_ValueList ) = 1 THEN
		lsa_Settings = { "Edit.CodeTable = Yes", ls_ValueList, "ddlb.UseAsBorder = No", "ddlb.Sorted = Yes", "ddlb.VScrollBar = Yes" }
	ELSE
		li_Return = -1
	END IF
	
CASE "di_lic_state", "em_state", "co_state", "co_bill_state", "lr_state"
	IF This.of_GetValueList ( as_ObjectName, ls_ValueList ) = 1 THEN
		lsa_Settings = { "Edit.CodeTable = Yes", ls_ValueList}
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

on n_cst_presentation_state.create
call super::create
end on

on n_cst_presentation_state.destroy
call super::destroy
end on

