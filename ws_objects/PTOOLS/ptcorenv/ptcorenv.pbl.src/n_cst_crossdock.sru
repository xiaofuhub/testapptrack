$PBExportHeader$n_cst_crossdock.sru
forward
global type n_cst_crossdock from nonvisualobject
end type
end forward

global type n_cst_crossdock from nonvisualobject
end type
global n_cst_crossdock n_cst_crossdock

type variables
Private:
Boolean	ib_Ready
Long	ila_Ids[]
String	is_EventsOnInvoice = "SHOW!", &
	is_EventsOnDelrec = "SHOW!"
end variables

forward prototypes
public function boolean of_ready ()
private function integer of_retrieve ()
public function integer of_getdockids (ref long ala_ids[])
public function integer of_getdockcount ()
public function integer of_getdockrows (datastore ads_source, ref long ala_crossdockrows[])
private function integer of_setdockids (long ala_ids[])
private function integer of_seteventsoninvoice (string as_value)
private function integer of_seteventsondelrec (string as_value)
public function string of_geteventsoninvoice ()
public function string of_geteventsondelrec ()
public function boolean of_getfilteroninvoice ()
public function boolean of_getfilterondelrec ()
public function integer of_getdockdescription (long al_id, ref string as_description)
public function integer of_getdockdescriptions (ref long ala_ids[], ref string asa_descriptions[])
public function long of_getselecteddock ()
end prototypes

public function boolean of_ready ();IF NOT ib_Ready THEN
	IF of_Retrieve ( ) > 0 THEN
		ib_Ready = TRUE
	END IF
END IF

RETURN ib_Ready
end function

private function integer of_retrieve ();String	ls_DockList, &
			ls_EventsOnInvoice, &
			ls_EventsOnDelrec
Long		lla_DockIds[]
n_cst_String	lnv_String

SELECT ss_string INTO :ls_Docklist FROM system_settings WHERE ss_id = 40 ;

CHOOSE CASE SQLCA.SqlCode
CASE 0
	COMMIT ;
CASE 100
	COMMIT ;
CASE -1
	ROLLBACK ;
	GOTO Failure
END CHOOSE


SELECT ss_string INTO :ls_EventsOnInvoice FROM system_settings WHERE ss_id = 41 ;

CHOOSE CASE SQLCA.SqlCode
CASE 0
	COMMIT ;
CASE 100
	COMMIT ;
CASE -1
	ROLLBACK ;
	GOTO Failure
END CHOOSE


SELECT ss_string INTO :ls_EventsOnDelrec FROM system_settings WHERE ss_id = 42 ;

CHOOSE CASE SQLCA.SqlCode
CASE 0
	COMMIT ;
CASE 100
	COMMIT ;
CASE -1
	ROLLBACK ;
	GOTO Failure
END CHOOSE


lnv_String.of_ParseToArray ( ls_DockList, ";", lla_DockIds )

IF of_SetDockIds ( lla_DockIds ) = -1 THEN
	GOTO Failure
END IF

IF of_SetEventsOnInvoice ( ls_EventsOnInvoice ) = -1 THEN
	GOTO Failure
END IF

IF of_SetEventsOnDelrec ( ls_EventsOnDelrec ) = -1 THEN
	GOTO Failure
END IF

RETURN 1

Failure:
RETURN -1
end function

public function integer of_getdockids (ref long ala_ids[]);IF of_Ready ( ) THEN
	ala_Ids = ila_Ids
	RETURN UpperBound ( ala_Ids )
ELSE
	RETURN -1
END IF
end function

public function integer of_getdockcount ();IF of_Ready ( ) THEN
	RETURN UpperBound ( ila_Ids )
ELSE
	RETURN -1
END IF
end function

public function integer of_getdockrows (datastore ads_source, ref long ala_crossdockrows[]);//Note : The result array will be in sequence.

Long	lla_CrossDockRows[], ll_StartSite, ll_CheckSite, lla_DockIds[], ll_SkipSite
Integer	li_RowCount, li_CheckStart, li_CheckEnd, li_ConfirmedEnd, li_DockCount, li_Ndx
n_cst_anyarraysrv lnv_anyarray

ala_CrossDockRows = lla_CrossDockRows[]

IF NOT IsValid ( ads_Source ) THEN
	RETURN -1
END IF

li_DockCount = of_GetDockIds ( lla_DockIds )

CHOOSE CASE li_DockCount
CASE 0
	RETURN 0
CASE -1
	RETURN -1
END CHOOSE

li_RowCount = ads_Source.RowCount ( )

IF li_RowCount >= 4 THEN
	//There must be at least 4 events for a cross dock to have happened.
	//We are looking for a sequence of [DRN] ... [PHM], all at the same site, not including
	//the first or last event in the datastore.

	ll_SkipSite = ads_Source.Object.de_site [ 1 ]

	FOR li_CheckStart = 2 TO li_RowCount - 2

		ll_StartSite = ads_Source.Object.de_site [ li_CheckStart ]

		IF ll_StartSite = ll_SkipSite THEN
			CONTINUE
		ELSE
			SetNull ( ll_SkipSite )
		END IF

		IF lnv_anyarray.of_FindLong ( lla_DockIds, ll_StartSite, 1, li_DockCount ) > 0 THEN

			CHOOSE CASE ads_Source.Object.de_event_type [ li_CheckStart ]
			CASE "D", "R", "N"
				//A candidate.  Proceed.
			CASE ELSE
				ll_SkipSite = ll_StartSite
				CONTINUE
			END CHOOSE

		ELSE
			CONTINUE
		END IF

		li_ConfirmedEnd = li_CheckStart

		FOR li_CheckEnd = li_CheckStart + 1 TO li_RowCount

			ll_CheckSite = ads_Source.Object.de_site [ li_CheckEnd ]

			IF ll_CheckSite = ll_StartSite THEN
				li_ConfirmedEnd = li_CheckEnd
			ELSE
				EXIT
			END IF

		NEXT

		IF li_ConfirmedEnd > li_CheckStart THEN

			IF li_ConfirmedEnd = li_RowCount THEN
				EXIT
			END IF

			CHOOSE CASE ads_Source.Object.de_event_type [ li_ConfirmedEnd ]
			CASE "P", "H", "M"

				//The range specified is a valid cross-dock sequence.  Add the rows to the
				//result set.

				FOR li_Ndx = li_CheckStart TO li_ConfirmedEnd
					lla_CrossDockRows [ UpperBound ( lla_CrossDockRows ) + 1 ] = li_Ndx
				NEXT

			END CHOOSE

			//Whether the sequence was valid or not, don't let the loop 
			//re-examine a portion of it.
			li_CheckStart = li_ConfirmedEnd

		ELSE
			CONTINUE
		END IF

	NEXT

END IF

ala_CrossDockRows = lla_CrossDockRows[]

RETURN UpperBound ( ala_CrossDockRows )
end function

private function integer of_setdockids (long ala_ids[]);Integer	li_Ndx, li_Count
n_cst_numerical lnv_numerical

li_Count = UpperBound ( ala_Ids )

FOR li_Ndx = 1 TO li_Count
	IF lnv_numerical.of_IsNullOrNotPos ( ala_Ids [ li_Ndx ] ) THEN
		RETURN -1
	END IF
NEXT

ila_Ids = ala_Ids

RETURN 1
end function

private function integer of_seteventsoninvoice (string as_value);Integer	li_Return

IF IsNull ( as_Value ) THEN
	as_Value = ""
END IF

CHOOSE CASE as_Value
CASE "HIDE!", "SHOW!", "ASK!"
	is_EventsOnInvoice = as_Value
	li_Return = 1
CASE ""
	li_Return = 0
CASE ELSE
	li_Return = -1
END CHOOSE

RETURN li_Return
end function

private function integer of_seteventsondelrec (string as_value);Integer	li_Return

IF IsNull ( as_Value ) THEN
	as_Value = ""
END IF

CHOOSE CASE as_Value
CASE "HIDE!", "SHOW!", "ASK!"
	is_EventsOnDelrec = as_Value
	li_Return = 1
CASE ""
	li_Return = 0
CASE ELSE
	li_Return = -1
END CHOOSE

RETURN li_Return
end function

public function string of_geteventsoninvoice ();RETURN is_EventsOnInvoice
end function

public function string of_geteventsondelrec ();RETURN is_EventsOnDelrec
end function

public function boolean of_getfilteroninvoice ();Boolean	lb_Filter

CHOOSE CASE of_GetEventsOnInvoice ( )
CASE "HIDE!"
	lb_Filter = TRUE
CASE "SHOW!"
	lb_Filter = FALSE
CASE "ASK!"
	CHOOSE CASE MessageBox ( "Generate Invoice", "Do you want to hide crossdock events?", &
		Question!, YesNo!, 1 )
	CASE 1
		lb_Filter = TRUE
	CASE 2
		lb_Filter = FALSE
	END CHOOSE
END CHOOSE

IF lb_Filter THEN
	IF of_GetDockCount ( ) < 1 THEN
		//There are no docks defined, so there will be nothing to filter
		lb_Filter = FALSE
	END IF
END IF

RETURN lb_Filter
end function

public function boolean of_getfilterondelrec ();Boolean	lb_Filter

CHOOSE CASE of_GetEventsOnDelrec ( )
CASE "HIDE!"
	lb_Filter = TRUE
CASE "SHOW!"
	lb_Filter = FALSE
CASE "ASK!"
	CHOOSE CASE MessageBox ( "Generate Delivery Receipt", "Do you want to hide crossdock events?", &
		Question!, YesNo!, 1 )
	CASE 1
		lb_Filter = TRUE
	CASE 2
		lb_Filter = FALSE
	END CHOOSE
END CHOOSE

IF lb_Filter THEN
	IF of_GetDockCount ( ) < 1 THEN
		//There are no docks defined, so there will be nothing to filter
		lb_Filter = FALSE
	END IF
END IF

RETURN lb_Filter
end function

public function integer of_getdockdescription (long al_id, ref string as_description);Integer	li_Return
String	ls_Description, &
			ls_AddressOptions, &
			ls_Address, &
			ls_CodeName
n_cst_String	lnv_String

li_Return = 1
SetNull ( ls_Description )

ls_AddressOptions = "PHYSICAL!~tNO_NAME!~tNO_STREETS!~tNO_ZIP!"

CHOOSE CASE gnv_cst_Companies.of_GetCodeName ( al_Id, ls_CodeName )
CASE 1
	ls_Description = Substitute ( ls_CodeName, null_str, "" )
CASE ELSE  //0, -1
	li_Return = -1
	GOTO CleanUp
END CHOOSE

CHOOSE CASE gnv_cst_Companies.of_Get_Address ( al_Id, ls_AddressOptions, ls_Address )
CASE 1
	ls_Address = lnv_String.of_Trim ( ls_Address, TRUE, TRUE )
		//Need to trim the trailing LF + CR that Get_Address tacks on
	ls_Description += "  (" + ls_Address + ")"
	ls_Description = Trim ( ls_Description )
	as_Description = ls_Description
CASE ELSE  //0, -1
	li_Return = -1
	GOTO CleanUp
END CHOOSE

CleanUp:

RETURN li_Return
end function

public function integer of_getdockdescriptions (ref long ala_ids[], ref string asa_descriptions[]);Long		lla_DockIds[]
Integer	li_DockCount, &
			li_Ndx, &
			li_Return
String	lsa_Descriptions[]

ala_Ids = lla_DockIds
asa_Descriptions = lsa_Descriptions

li_DockCount = of_GetDockIds ( lla_DockIds )

CHOOSE CASE li_DockCount
CASE IS >= 0

	FOR li_Ndx = 1 TO li_DockCount
		CHOOSE CASE of_GetDockDescription ( lla_DockIds [ li_Ndx ], lsa_Descriptions [ li_Ndx ] )
		CASE 1
			//Success
		CASE ELSE
			li_Return = -1
			GOTO CleanUp
		END CHOOSE
	NEXT

	ala_Ids = lla_DockIds
	asa_Descriptions = lsa_Descriptions
	li_Return = li_DockCount

CASE ELSE
	li_Return = -1

END CHOOSE

CleanUp:

RETURN li_Return
end function

public function long of_getselecteddock ();// I know that this nvo should not be opening selection windows, but the x-dock window is a pain to use
// and I would have had to replecate mulitple lines of code every time I wanted the user to be able
// to pick a dock location.

Long		ll_DockId, &
			lla_DockIds[], &
			ll_Return, &
			lla_SelectedIndexes[]
String	ls_MessageHeader, &
			lsa_DockDescriptions[], &
			ls_Result
Integer	li_DockCount, &
			li_Ndx

s_Strings	lstr_Strings
n_cst_String	lnv_String

ls_MessageHeader = "New Cross-Dock Shipment"


li_DockCount = THIS.of_GetDockDescriptions ( lla_DockIds, lsa_DockDescriptions )

CHOOSE CASE li_DockCount

CASE IS > 1

	lstr_Strings.Strar [ 1 ] = ls_MessageHeader
	lstr_Strings.Strar [ 2 ] = "Please select a dock location."

	FOR li_Ndx = 1 TO li_DockCount
		lstr_Strings.Strar [ 4 + li_Ndx ] = lsa_DockDescriptions [ li_Ndx ]
	NEXT

	OpenWithParm ( w_List_Sel, lstr_Strings )
	ls_Result = Message.StringParm

	lnv_String.of_ParseToArray ( ls_Result, "q", lla_SelectedIndexes )

	IF UpperBound ( lla_SelectedIndexes ) > 0 THEN

		ll_Return = lla_DockIds[lla_SelectedIndexes [ 1 ] ]
	ELSE

		ll_Return = 0

	END IF

CASE 1
	ll_Return =  lla_DockIds [ 1 ] 

CASE 0
	
	ll_Return = 0

CASE ELSE
	
	ll_Return = -1

END CHOOSE


RETURN ll_Return
end function

on n_cst_crossdock.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_crossdock.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

