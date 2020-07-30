$PBExportHeader$n_cst_dwsrv_restrict.sru
forward
global type n_cst_dwsrv_restrict from n_cst_dwsrv
end type
end forward

shared variables

end variables

global type n_cst_dwsrv_restrict from n_cst_dwsrv
event ue_restrict ( n_cst_restrictioncriteria anv_data,  u_dw_quickmatch adw_quickmatch )
event ue_clearrestriction ( string as_dwtype )
end type
global n_cst_dwsrv_restrict n_cst_dwsrv_restrict

type variables
n_cst_restrictionCriteria 	inv_restrictionData
constant Int	ci_OutOfMode = 1
constant Int	ci_intoMode = 0
constant string	cs_CHECKROWSTAG = "CHECKROWS"		//this is the tag that should
																	//be inserted into a column 
																	//of a grouped datawindow if 
																	//you want it to look through all
																	//the rows in the group rather than
																	//checking the computes. Computes will
																	//not be checked if it finds this tag in a column.
																	
constant string	cs_KEEPGROUPTAG = "KEEPGROUP"		//this tag is used for shipements views right now.
																	//In shipments views it should be put in the
																	//1st column of the dataobject tag.  It is used
																	//to signify that if a grouped shipment finds one row
																	//within a group that passes validation, then the whole
																	//group should be changed. IF the tag isn't there, then
																	//it will filter out the rows that do not pass in the group
																	//and keep the rows that do pass.  (it only makes sense to
																	//have this if your checking all rows and the dataobject 
																	//is grouped)
n_cst_routing		inv_routing

boolean	ib_pcmilerconnected
boolean	ib_oldpcmilerversion
boolean	ib_pcmilerstreets

u_dw_quickMatch	idw_qm

String	isa_computedObjects[]
end variables

forward prototypes
public function boolean of_isdeliverytype (string as_type)
public function boolean of_loadsfromcache ()
public function boolean of_loadsfromdb ()
public function integer of_pcmconnect ()
public function integer of_setquickmatch (u_dw_quickmatch adw_quickmatch)
public function boolean of_checkcriteria (integer ai_mode, long al_index, n_cst_restrictioncriteria anv_data, boolean ab_checkcomputes, ref boolean ab_checkallrows)
public function boolean of_checkcriteria (integer ai_mode, long al_index, n_cst_restrictioncriteria anv_data, boolean ab_checkcomputes)
public function integer of_getrequestoridcolumn ()
end prototypes

event ue_restrict(n_cst_restrictioncriteria anv_data, u_dw_quickMatch adw_quickmatch);//meant to be extended by ancestors
end event

event ue_clearrestriction(string as_dwtype);//implemented at lower levels
end event

public function boolean of_isdeliverytype (string as_type);//returns true if the sent in item is a delivery type event
IF as_type = "" THEN		//REVISE!!
	RETURN true
ELSE 
	RETURN FALSE
END IF
end function

public function boolean of_loadsfromcache ();String	ls_select


//find out if the dataobject has a select statement or not
ls_select = idw_requestor.describe("datawindow.table.select")

IF ls_select = "?" OR ls_select = "!" THEN
	
	ls_select = ""
END IF

//-----
// if the length lof ls_select is greater than 0 then we know its a retrieval.
// If the number of args is 0 then we do nothing, linkage should take care of it, or
// the dataobject will have a button to manually prompt for args.

IF len( ls_select ) > 0 AND not isNULL( idw_requestor.inv_base ) AND isValid( idw_requestor.inv_base ) THEN
	
	RETURN False
	
ELSE														//refresh from cache
	
	RETURN true
END IF
end function

public function boolean of_loadsfromdb ();String	ls_select
String	lsa_argnames[]
String	lsa_argDataTypes[]

//find out if the dataobject has a select statement or not
ls_select = idw_requestor.describe("datawindow.table.select")

IF ls_select = "?" OR ls_select = "!" THEN
	
	ls_select = ""
END IF

//-----
// if the length lof ls_select is greater than 0 then we know its a retrieval.
// If the number of args is 0 then we do nothing, linkage should take care of it, or
// the dataobject will have a button to manually prompt for args.

IF len( ls_select ) > 0 AND not isNULL( idw_requestor.inv_base ) AND isValid( idw_requestor.inv_base ) THEN
	idw_requestor.inv_base.of_dwarguments( lsa_argNames, lsa_argDataTypes )
	
	IF upperBound( lsa_argNames ) < 1 THEN			//normal retrieve
		
		RETURN TRUE		
	ELSE								
		RETURN FALSE
		//linkage or manual prompte for args
	END IF
	
ELSE														//refresh from cache
	RETURN FALSE
END IF
end function

public function integer of_pcmconnect ();Integer	li_Return
n_cst_trip	lnv_trip
n_cst_licensemanager	lnv_licensemanager

lnv_trip = Create n_cst_trip


IF pcms_inst AND (lnv_LicenseManager.of_usepcmilerstreets() OR &
			lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.ci_Module_PCMiler )) THEN
	IF lnv_trip.of_connect(inv_routing) THEN
		IF inv_routing.of_isvalid() THEN
			ib_pcmilerconnected = True
			IF inv_routing.of_isoldpcmilerversion() THEN
				ib_oldpcmilerversion = True
			END IF
			IF inv_routing.of_isstreets() THEN
				ib_pcmilerstreets = True
			END IF
		ELSE
			ib_pcmilerconnected = False
			li_Return = -1
		END IF
	ELSE
		ib_pcmilerconnected = False
		li_Return = -1
	END IF
END IF

Return li_Return
end function

public function integer of_setquickmatch (u_dw_quickmatch adw_quickmatch);IF isValid( adw_quickMatch ) THEN
	idw_qm = adw_quickMatch
	return 1
END IF
Return -1
end function

public function boolean of_checkcriteria (integer ai_mode, long al_index, n_cst_restrictioncriteria anv_data, boolean ab_checkcomputes, ref boolean ab_checkallrows);// meant to be implemented at ancestor level
return False
end function

public function boolean of_checkcriteria (integer ai_mode, long al_index, n_cst_restrictioncriteria anv_data, boolean ab_checkcomputes);boolean	lb_dummy
return this.of_checkcriteria( ai_mode, al_index, anv_data, ab_checkComputes,lb_dummy/*ref boolean ab_checkallrows */)
end function

public function integer of_getrequestoridcolumn ();//DEK 6-18-07, for shipments, drivers sql, and equipment this is true.  For Drivers it is 2 if it is from cache.
//DEK 6-18-07
INt	li_return = 1
u_dw_tcard ldw_Tcard
IF isValid( idw_requestor ) THEN
	IF POS(idw_requestor.classname(), "u_dw_tcard") > 0 THEN
		ldw_tcard = idw_requestor
		li_return = ldw_Tcard.of_getIdColumn()
	END IF
END IF

RETURN li_Return
end function

on n_cst_dwsrv_restrict.create
call super::create
end on

on n_cst_dwsrv_restrict.destroy
call super::destroy
end on

event constructor;call super::constructor;This.of_pcmConnect()
end event

