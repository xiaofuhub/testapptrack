$PBExportHeader$n_cst_licensemanager.sru
forward
global type n_cst_licensemanager from nonvisualobject
end type
end forward

shared variables
//begin comment by appeon 20070727
//Boolean		sb_Ready
//DataStore	sds_Cache
//String		ssa_DefinedModules[]
//Integer		si_DefinedModuleCount
//Boolean		sb_PCMilerStreets
//integer		si_pcmilerserverid
//begin comment by appeon 20070727

end variables

global type n_cst_licensemanager from nonvisualobject autoinstantiate
event type integer ue_convert ( integer ai_version )
event ue_post_26 ( )
event ue_post_27 ( )
event ue_post_29 ( )
event ue_post_30 ( )
event ue_post_40 ( )
event ue_post_39 ( )
event ue_post_56 ( )
event ue_post_59 ( )
event ue_post_62 ( )
event ue_post_70 ( )
event ue_post_75 ( )
event ue_post_72 ( )
event ue_post_85 ( )
event ue_post_86 ( )
event ue_post_91 ( )
event ue_post_95 ( )
event ue_post_105 ( )
event ue_post_107 ( )
event ue_post_110 ( )
event ue_post_112 ( )
event ue_post_rt_113 ( )
event ue_post_113 ( )
event ue_post_rt_115 ( )
event ue_post_116 ( )
event ue_post_117 ( )
event ue_post_rt_117 ( )
event ue_post_119 ( )
event ue_post_rt_121 ( )
event ue_post_121 ( )
end type

type prototypes

end prototypes

type variables
boolean ib_upgrade_done = FALSE
end variables

forward prototypes
public function date of_getlicensestart ()
public function date of_getlicenseexpiration ()
public function boolean of_getlicensed (string as_module)
public function boolean of_ready ()
private function integer of_setlicensed (string as_module)
public function integer of_initialize ()
private function boolean of_ready (boolean ab_initialize)
public function boolean of_approveconnection ()
public function long of_getdbversion ()
public function long of_getlicensedusers ()
public function integer of_getcurrentusers ()
private function boolean of_validateexpiration ()
public function string of_getlicensedcompany ()
public function integer of_initialize (boolean ab_forcerefresh)
public function string of_getexpirationnotice ()
private function integer of_getdaysremaining ()
public function boolean of_getlicenseexpired ()
private function boolean of_checkrequired ()
public function integer of_setlicensestart (date ad_licensestart)
private function long of_find (string as_setting, boolean ab_insert)
public function integer of_setlicenseexpiration (date ad_licenseexpiration)
public function integer of_setlicensedcompany (string as_licensedcompany)
public function integer of_setlicensedusers (long al_licensedusers)
public function integer of_setdbversion (long al_dbversion)
public function string of_generaterequestcode ()
public function integer of_processregistrationkey (string as_requestcode, string as_registrationkey)
public function integer of_setbasetimezone (integer ai_basetimezone)
public function integer of_getbasetimezone ()
public function integer of_update ()
private function integer of_dbinit ()
public function integer of_getmoduledisplaylist (ref string asa_displaylist[])
public function integer of_getmoduledisplaycount ()
public function boolean of_getlicensed (integer ai_module)
private function string of_convert (integer ai_module)
public subroutine of_displaymodulenotice (string as_messageheader)
public function string of_getdisplayname (readonly string as_module)
public subroutine of_apply_sqlscript (string as_filename)
public subroutine of_apply_sqlstring (string as_sqlstring)
public function integer of_deletemodulelocks ()
public function integer of_getmodulelock (string as_modulename, string as_messagetype)
public function boolean of_hasmodulelock (string as_modulename)
public function boolean of_validatemodulelicenses ()
public function boolean of_hascommunicationslicense ()
public function boolean of_hasmobilecommunicationslicense ()
public function boolean of_hasedi214license ()
public function integer of_setpcmilerstreets ()
public function boolean of_usepcmilerstreets ()
public function boolean of_haspcmilerlicense ()
public subroutine of_setpcmilerserverid (integer ai_serverid)
public function integer of_getpcmilerserverid ()
public function boolean of_hasautoratinglicensed ()
public function boolean of_hasrouteoptimizer ()
public function boolean of_hasedi204license ()
public function boolean of_hasnotificationlicense ()
public function boolean of_hasedi322license ()
public function long of_getspecialops ()
private function integer of_purge ()
public function boolean of_hasedi210license ()
public function boolean of_hasanyedilicense ()
public function integer of_setspecialops (long al_currentspecialops)
public function boolean of_hasequipmentpostinglicense ()
public function boolean of_hasnextellicense ()
public function integer of_displayconversionmessage (ref string as_path)
public function integer of_backupdatabase (string as_path)
public function boolean of_hasdocumentttansfer ()
public function integer of_emailversionchange ()
public function string of_getappversion ()
public function integer of_setappversion (string as_version)
private function integer of_flagupdateinprogress ()
private function integer of_getlicensedusersfromdb ()
private function integer of_flagupdatedone ()
private function boolean of_isupdateinprogress ()
public function integer of_autoactivaterailtrace (boolean ab_enable)
public function boolean of_israiltracesetup ()
public function string of_getdbbackuplocation ()
public function boolean of_asa9db ()
private function integer of_activaterailtraceinbound ()
private function integer of_deactivaterailtraceinbound ()
public function boolean of_israiltraceactiveinbound ()
public function integer of_activaterailtrace ()
public function integer of_deactivaterailtrace ()
public function boolean of_israiltraceactiveoutbound ()
public function string of_getrailtraceversion ()
public function boolean of_compatiblerailtrace (string as_expectedversion, string as_currentversion)
public function integer of_upgraderailtraceinterface ()
public function integer of_upgraderailtraceinterface (boolean ab_backupdatabase)
public function integer of_getlocalconnectioncount ()
public function integer of_addoperation ()
end prototypes

event ue_convert;// Open message window
string 	ls_sqlexpr, &
			ls_version
long 		ll_rowcount, &
			ll_index
integer 	li_Return

li_Return = 1
ls_version = string(ai_version)

Open ( w_Upgrade )

IF IsValid ( w_Upgrade ) THEN
	w_Upgrade.Title = "Upgrading to version " + ls_version
	w_Upgrade.st_message.Text = "To Version " + ls_version + "... Wait."
	w_Upgrade.SetPosition( TopMost! )
	w_Upgrade.Visible = TRUE
END IF

n_ds lds_data
lds_data = Create n_ds
lds_data.DataObject = "d_sqlstore"

lds_data.SetFilter( "ver='" + ls_version + "'" )
lds_data.Filter( )
lds_data.SetSort( "num A" )
lds_data.Sort( )

ll_rowcount = lds_data.RowCount( )

for ll_index = 1 to ll_rowcount
	ls_sqlexpr = lds_data.GetItemString( ll_index, "expr" )
//	MessageBox( lds_data.GetItemString( ll_index, "ver" ) + "->" + lds_data.GetItemString( ll_index, "num" ), ls_sqlexpr )
	if not IsNull( ls_sqlexpr ) and Len( ls_sqlexpr ) > 0 then
		w_Upgrade.st_message.Text = "Processing Step " + string(ll_index) + " of " + String ( ll_rowcount ) + "..."
		// Execute it!
		execute immediate :ls_sqlexpr using sqlca;
		if sqlca.sqlcode <> 0 then
			MessageBox( "Error", sqlca.sqlerrtext + "~n~nPlease contact Profit Tools technical support.", Exclamation! )
			li_return = -1
			Exit
		end if
	end if
next

IF li_Return = 1 THEN

	COMMIT ;

	IF SQLCA.SqlCode = 0 THEN
		//OK
	ELSE
		ROLLBACK ;
		li_Return = -1
	END IF

ELSE
	ROLLBACK ;

END IF

Destroy lds_data

IF IsValid ( w_Upgrade ) THEN
	Close ( w_Upgrade )
END IF

return li_Return

end event

event ue_post_26;//Special post-convert processing for V26.
//Due to addition of salesrep field to shipment summary cache dataobject in 3.0.15,
//we need to delete the existing shipsum.psr 

n_cst_ShipmentManager	lnv_ShipmentManager
String	ls_CacheFile

CHOOSE CASE lnv_ShipmentManager.of_GetShipmentCacheFile ( ls_CacheFile )

CASE 1
	FileDelete ( ls_CacheFile )
	//Note : Even if this fails, it's not a fatal error.  The user may need to delete the
	//file manually.  So, I'm not checking the return code.

CASE 0
	//No cache file specified -- nothing to delete.

CASE -1
	//Failed to get cache file name.  Not a fatal error, though -- allow processing to proceed.

END CHOOSE
end event

event ue_post_27;//Special post-convert processing for V27.
//Due to addition of custom fields to shipment summary cache dataobject in 3.0.16,
//we need to delete the existing shipsum.psr 

n_cst_ShipmentManager	lnv_ShipmentManager
String	ls_CacheFile

CHOOSE CASE lnv_ShipmentManager.of_GetShipmentCacheFile ( ls_CacheFile )

CASE 1
	FileDelete ( ls_CacheFile )
	//Note : Even if this fails, it's not a fatal error.  The user may need to delete the
	//file manually.  So, I'm not checking the return code.

CASE 0
	//No cache file specified -- nothing to delete.

CASE -1
	//Failed to get cache file name.  Not a fatal error, though -- allow processing to proceed.

END CHOOSE
end event

event ue_post_29;DataStore	lds_Work

Long			ll_Min, &
				ll_Max, &
				ll_DBMax, &
				ll_ActEq, &
				ll_Id, &
				ll_Row, &
				ll_RowCount, &
				ll_Null

Integer		li_Index, &
				li_SqlCode

Decimal		lc_ActEq_Seq

String		ls_SelectBase, &
				ls_Where, &
				ls_EventType, &
				ls_MultiList, &
				ls_NewMultiList, &
				ls_ContainerIds, &
				ls_Null

DWObject		ldwo_EventType, &
				ldwo_Trailer1, &
				ldwo_Trailer1_Seq, &
				ldwo_Trailer2, &
				ldwo_Trailer2_Seq, &
				ldwo_Trailer3, &
				ldwo_Trailer3_Seq, &
				ldwo_Container1, &
				ldwo_Container1_Seq, &
				ldwo_Container2, &
				ldwo_Container2_Seq, &
				ldwo_Container3, &
				ldwo_Container3_Seq, &
				ldwo_Container4, &
				ldwo_Container4_Seq, &
				ldwo_ActEq, &
				ldwo_ActEq_Seq, &
				ldwo_ActPos, &
				ldwo_MultiList


SetNull ( ls_Null )
SetNull ( ll_Null )

Constant Integer	li_Increment = 5000  //The id range increment per cycle.
//(Note that the number retrieved per cycle will normally be less than this.)

Integer		li_Return = 1  //Flag only.  There is no actual return.


IF li_Return = 1 THEN

	Open ( w_Upgrade )

	IF IsValid ( w_Upgrade ) THEN
		w_Upgrade.Title = "Upgrading to version 29"
		w_Upgrade.st_message.Text = "Converting..."
		w_Upgrade.SetPosition ( TopMost! )
		w_Upgrade.Visible = TRUE
	END IF

END IF


IF li_Return = 1 THEN

	SELECT Max ( de_id ) INTO :ll_DBMax FROM disp_events ;

	li_SqlCode = SQLCA.SqlCode
	COMMIT ;

	CHOOSE CASE li_SqlCode

	CASE 0

		//Note : An empty table will give SQLCode 0 and ll_DBMax = Null

	CASE ELSE

		li_Return = -1

	END CHOOSE

END IF


IF li_Return = 1 THEN

	lds_Work = CREATE DataStore
	lds_Work.DataObject = "d_EventConversion"
	lds_Work.SetTransObject ( SQLCA )

	ls_SelectBase = lds_Work.Object.DataWindow.Table.Select

	ldwo_EventType = lds_Work.Object.de_Event_Type
	ldwo_Trailer1 = lds_Work.Object.de_Trailer1
	ldwo_Trailer1_Seq = lds_Work.Object.de_Trailer1_Seq
	ldwo_Trailer2 = lds_Work.Object.de_Trailer2
	ldwo_Trailer2_Seq = lds_Work.Object.de_Trailer2_Seq
	ldwo_Trailer3 = lds_Work.Object.de_Trailer3
	ldwo_Trailer3_Seq = lds_Work.Object.de_Trailer3_Seq
	ldwo_Container1 = lds_Work.Object.de_Container1
	ldwo_Container1_Seq = lds_Work.Object.de_Container1_Seq
	ldwo_Container2 = lds_Work.Object.de_Container2
	ldwo_Container2_Seq = lds_Work.Object.de_Container2_Seq
	ldwo_Container3 = lds_Work.Object.de_Container3
	ldwo_Container3_Seq = lds_Work.Object.de_Container3_Seq
	ldwo_Container4 = lds_Work.Object.de_Container4
	ldwo_Container4_Seq = lds_Work.Object.de_Container4_Seq
	ldwo_ActEq = lds_Work.Object.de_ActEq
	ldwo_ActEq_Seq = lds_Work.Object.de_ActEq_Seq
	ldwo_ActPos = lds_Work.Object.de_ActPos
	ldwo_MultiList = lds_Work.Object.de_Multi_List


	ll_Min = 0

	DO WHILE ll_Min <= ll_DBMax  //If ll_Max was null above, not iterations will execute.

		ll_Max = ll_Min + ( li_Increment - 1 )

		IF IsValid ( w_Upgrade ) THEN
			w_Upgrade.st_message.Text = "Converting " + String ( ll_Min ) + " to " +&
				String ( ll_Max ) + " of " + String ( ll_DBMax )
		END IF


		ls_Where = " WHERE de_Event_Type IN ( 'H', 'R', 'M', 'N' ) AND "+&
			"de_Id BETWEEN " + String ( ll_Min ) + " AND " + String ( ll_Max )

		lds_Work.Object.DataWindow.Table.Select = ls_SelectBase + ls_Where

		ll_RowCount = lds_Work.Retrieve ( )

		CHOOSE CASE ll_RowCount

		CASE IS >= 0
			//OK

		CASE ELSE
			li_Return = -1
			EXIT

		END CHOOSE

		FOR ll_Row = 1 TO ll_RowCount

			ls_EventType = ldwo_EventType.Primary [ ll_Row ]
			ls_MultiList = ldwo_MultiList.Primary [ ll_Row ]
			ll_ActEq = ldwo_ActEq.Primary [ ll_Row ]
			lc_ActEq_Seq = ldwo_ActEq_Seq.Primary [ ll_Row ]

			SetNull ( ls_NewMultiList )


			CHOOSE CASE ls_EventType

			CASE "M", "N"  //Mount, dismount

				IF IsNull ( ll_ActEq ) OR lc_ActEq_Seq = 0 THEN

					//Seq = 0 would happen for an unrouted mount/dismount in a shipment.

					//Allow ActEq and ActEq_Seq, and actpos to be cleared.
					//Allow MultiList to be set to null.

				ELSE

					//Try to fit the container into the regular container assignments.
	
					IF IsNull ( ldwo_Container1.Primary [ ll_Row ] ) THEN
						ldwo_Container1.Primary [ ll_Row ] = ll_ActEq
						ldwo_Container1_Seq.Primary [ ll_Row ] = lc_ActEq_Seq
					ELSEIF IsNull ( ldwo_Container2.Primary [ ll_Row ] ) THEN
						ldwo_Container2.Primary [ ll_Row ] = ll_ActEq
						ldwo_Container2_Seq.Primary [ ll_Row ] = lc_ActEq_Seq
					ELSEIF IsNull ( ldwo_Container3.Primary [ ll_Row ] ) THEN
						ldwo_Container3.Primary [ ll_Row ] = ll_ActEq
						ldwo_Container3_Seq.Primary [ ll_Row ] = lc_ActEq_Seq
					ELSEIF IsNull ( ldwo_Container4.Primary [ ll_Row ] ) THEN
						ldwo_Container4.Primary [ ll_Row ] = ll_ActEq
						ldwo_Container4_Seq.Primary [ ll_Row ] = lc_ActEq_Seq
					ELSE
						//Shouldn't happen.  Let it go??
					END IF

					ls_NewMultiList = "C=" + String ( ll_ActEq )

				END IF


			CASE "H", "R"  //Hook, Drop


				IF IsNull ( ll_ActEq ) OR lc_ActEq_Seq = 0 THEN

					//Seq = 0 would happen for an unrouted hook/drop in a shipment.

					//If the container seqs are zero (they should be), clear the ids (if any).

					IF ldwo_Container1_Seq.Primary [ ll_Row ] = 0 THEN
						ldwo_Container1.Primary [ ll_Row ] = ll_Null
					END IF

					IF ldwo_Container2_Seq.Primary [ ll_Row ] = 0 THEN
						ldwo_Container2.Primary [ ll_Row ] = ll_Null
					END IF

					IF ldwo_Container3_Seq.Primary [ ll_Row ] = 0 THEN
						ldwo_Container3.Primary [ ll_Row ] = ll_Null
					END IF

					IF ldwo_Container4_Seq.Primary [ ll_Row ] = 0 THEN
						ldwo_Container4.Primary [ ll_Row ] = ll_Null
					END IF

					//Allow ActEq and ActEq_Seq, and actpos to be cleared.
					//Allow multilist to be set to null.

				ELSE

					ls_NewMultiList = "T=" + String ( ll_ActEq )
					ls_ContainerIds = ""


					IF Len ( ls_MultiList ) = 8 AND Match ( ls_MultiList, "^[0-5]+$" ) THEN
		
						//We have a valid multilist.
						//There may be premounted containers at the ActEq position.  Identify them, if any.

						FOR li_Index = 7 TO 8

							SetNull ( ll_Id )
	
							CHOOSE CASE Integer ( Mid ( ls_MultiList, li_Index, 1 ) )
	
							CASE 1
								ll_Id = ldwo_Container1.Primary [ ll_Row ]
	
							CASE 2
								ll_Id = ldwo_Container2.Primary [ ll_Row ]
	
							CASE 3
								ll_Id = ldwo_Container3.Primary [ ll_Row ]
	
							CASE 4
								ll_Id = ldwo_Container4.Primary [ ll_Row ]
	
							END CHOOSE
	
							IF NOT IsNull ( ll_Id ) THEN

								IF Len ( ls_ContainerIds ) > 0 THEN
									ls_ContainerIds += ","
								END IF

								ls_ContainerIds += String ( ll_Id )

							END IF

						NEXT

					END IF

					IF Len ( ls_ContainerIds ) > 0 THEN
						ls_NewMultiList += ";" + "C=" + ls_ContainerIds
					END IF


					//Try to fit the TrailerChassis into the regular trailer assignments.
	
					IF IsNull ( ldwo_Trailer1.Primary [ ll_Row ] ) THEN
						ldwo_Trailer1.Primary [ ll_Row ] = ll_ActEq
						ldwo_Trailer1_Seq.Primary [ ll_Row ] = lc_ActEq_Seq
					ELSEIF IsNull ( ldwo_Trailer2.Primary [ ll_Row ] ) THEN
						ldwo_Trailer2.Primary [ ll_Row ] = ll_ActEq
						ldwo_Trailer2_Seq.Primary [ ll_Row ] = lc_ActEq_Seq
					ELSEIF IsNull ( ldwo_Trailer3.Primary [ ll_Row ] ) THEN
						ldwo_Trailer3.Primary [ ll_Row ] = ll_ActEq
						ldwo_Trailer3_Seq.Primary [ ll_Row ] = lc_ActEq_Seq
					ELSE
						//Shouldn't happen.  Let it go??
					END IF

				END IF

			END CHOOSE

			ldwo_ActEq.Primary [ ll_Row ] = ll_Null
			ldwo_ActEq_Seq.Primary [ ll_Row ] = 0
			ldwo_ActPos.Primary [ ll_Row ] = 0
			ldwo_MultiList.Primary [ ll_Row ] = ls_NewMultiList

		NEXT


		//Now, try to update the datastore.

		IF lds_Work.Update ( ) = 1 THEN
			COMMIT ;

			IF SQLCA.SqlCode = 0 THEN
				//OK
			ELSE
				ROLLBACK ;
				li_Return = -1
				EXIT
			END IF

		ELSE
			ROLLBACK ;
			li_Return = -1
			EXIT
		END IF

		ll_Min += li_Increment
		lds_Work.Reset ( )

	LOOP

END IF


IF li_Return = -1 THEN

	ib_Upgrade_Done = FALSE

END IF


DESTROY ldwo_EventType
DESTROY ldwo_Trailer1
DESTROY ldwo_Trailer1_Seq
DESTROY ldwo_Trailer2
DESTROY ldwo_Trailer2_Seq
DESTROY ldwo_Trailer3
DESTROY ldwo_Trailer3_Seq
DESTROY ldwo_Container1
DESTROY ldwo_Container1_Seq
DESTROY ldwo_Container2
DESTROY ldwo_Container2_Seq
DESTROY ldwo_Container3
DESTROY ldwo_Container3_Seq
DESTROY ldwo_Container4
DESTROY ldwo_Container4_Seq
DESTROY ldwo_ActEq
DESTROY ldwo_ActEq_Seq
DESTROY ldwo_ActPos
DESTROY ldwo_MultiList
DESTROY lds_Work

IF IsValid ( w_Upgrade ) THEN
	Close ( w_Upgrade )
END IF
end event

event ue_post_30;//Special post-convert processing for V30.
//Due to addition of custom fields to shipment summary cache dataobject in 3.5.b1,
//we need to delete the existing shipsum.psr 

n_cst_ShipmentManager	lnv_ShipmentManager
String	ls_CacheFile

CHOOSE CASE lnv_ShipmentManager.of_GetShipmentCacheFile ( ls_CacheFile )

CASE 1
	FileDelete ( ls_CacheFile )
	//Note : Even if this fails, it's not a fatal error.  The user may need to delete the
	//file manually.  So, I'm not checking the return code.

CASE 0
	//No cache file specified -- nothing to delete.

CASE -1
	//Failed to get cache file name.  Not a fatal error, though -- allow processing to proceed.

END CHOOSE
end event

event ue_post_40;long	lla_shiptypeid[], &	
		ll_ndx, &
		ll_count, &
		ll_row, &
		ll_freightid, &
		ll_accessorialid
		
integer	li_SqlCode

string	ls_amounttype, &
			ls_SalesAccount, &
			ls_AccessorialSalesAccount, &
			ls_ReceivablesAccount
	
n_ds	lds_accountmap
n_cst_shiptype lnv_shiptype
n_cst_ship_type lnv_cst_ship_type

CONSTANT Boolean cb_Commit	= TRUE	

Integer		li_Return = 1  //Flag only.  There is no actual return.

IF li_Return = 1 THEN

	Open ( w_Upgrade )

	IF IsValid ( w_Upgrade ) THEN
		w_Upgrade.Title = "Upgrading to version 40"
		w_Upgrade.st_message.Text = "Converting..."
		w_Upgrade.SetPosition ( TopMost! )
		w_Upgrade.Visible = TRUE
	END IF

END IF


lds_accountmap = create n_ds
lds_accountmap.dataobject = "d_acctmap"
lds_accountmap.settransobject(sqlca)

IF gnv_App.of_GetNextId ( "n_cst_beo_amounttype", ll_freightid, cb_Commit ) = 1 THEN
	
	//create freight amount type
	ls_amounttype = "FREIGHT"
	  INSERT INTO "amounttype"  
				( "id",   
				  "name",   
				  "category",   
				  "typicalamount",   
				  "taxabledefault",   
				  "tag" )  
	  VALUES ( :ll_freightid,   
				  :ls_amounttype,   
				  3,   
				  0,   
				  0,   
				  NULL )  ;
			
end if

IF gnv_App.of_GetNextId ( "n_cst_beo_amounttype", ll_accessorialid, cb_Commit ) = 1 THEN
	
	//create accessorial amount type
	ls_amounttype = "ACCESSORIAL"
	  INSERT INTO "amounttype"  
				( "id",   
				  "name",   
				  "category",   
				  "typicalamount",   
				  "taxabledefault",   
				  "tag" )  
	  VALUES ( :ll_accessorialid,   
				  :ls_amounttype,   
				  3,   
				  0,   
				  0,   
				  NULL )  ;
				  
end if

//get the list of all shipment type ids 
ll_count = lnv_cst_ship_type.of_gettypelist('ALL', FALSE, lla_shiptypeid)

for ll_ndx = 1 to ll_count

	if isvalid(lnv_shiptype) then
		destroy lnv_shiptype
	end if

	if not lnv_cst_ship_type.of_get_object(lla_shiptypeid[ll_ndx], lnv_shiptype) = 1 then
		continue
	end if
	
	//Get the sales and receivables account values from the shipment type
	ls_ReceivablesAccount = lnv_shiptype.ids_data.object.st_accounting_ar[1]
	ls_SalesAccount = lnv_shiptype.ids_data.object.st_accounting_sales[1]
	ls_AccessorialSalesAccount = lnv_shiptype.ids_data.object.st_accounting_accessorialsales[1]
	
	//insert freight
	ll_row = lds_accountmap.insertrow(0)
	lds_accountmap.object.accountmap_amounttypeid[ll_row]=ll_freightid
	lds_accountmap.object.accountmap_division[ll_row]=lla_shiptypeid[ll_ndx]
	lds_accountmap.object.accountmap_araccount[ll_row]=ls_ReceivablesAccount
	lds_accountmap.object.accountmap_salesaccount[ll_row]=ls_SalesAccount

	//insert accessorial
	ll_row = lds_accountmap.insertrow(0)
	lds_accountmap.object.accountmap_amounttypeid[ll_row]=ll_accessorialid
	lds_accountmap.object.accountmap_division[ll_row]=lla_shiptypeid[ll_ndx]
	lds_accountmap.object.accountmap_araccount[ll_row]=ls_ReceivablesAccount
	if len(trim(ls_AccessorialSalesAccount)) > 0 then
		lds_accountmap.object.accountmap_salesaccount[ll_row]=ls_AccessorialSalesAccount
	else
		lds_accountmap.object.accountmap_salesaccount[ll_row]=ls_SalesAccount
	end if
	
next

if lds_accountmap.update() = 1 then
	commit;
else
	rollback;
	li_return = -1
end if

if li_return = 1 then
//set default system settings
  INSERT INTO "system_settings"  
         ( "ss_id",   
           "ss_uid",   
           "ss_long",   
           "ss_char",   
           "ss_string",   
           "ss_date",   
           "ss_dec" )  
  VALUES ( 98,   
           0,   
           :ll_freightid,   
           null,   
           null,   
           null,   
           null )  ;

  INSERT INTO "system_settings"  
         ( "ss_id",   
           "ss_uid",   
           "ss_long",   
           "ss_char",   
           "ss_string",   
           "ss_date",   
           "ss_dec" )  
  VALUES ( 99,   
           0,   
           :ll_accessorialid,   
           null,   
           null,   
           null,   
           null )  ;

	li_SqlCode = SQLCA.SqlCode
	COMMIT ;

	CHOOSE CASE li_SqlCode

	CASE 0

	CASE ELSE

		li_Return = -1

	END CHOOSE

end if

if li_return = 1 then
  UPDATE "disp_items"  
     SET "amounttype" = :ll_freightid  
   WHERE ( "disp_items"."di_item_type" = 'L' ) AND  
         ( "disp_items"."amounttype" is null )   ;

  UPDATE "disp_items"  
     SET "amounttype" = :ll_accessorialid  
   WHERE ( "disp_items"."di_item_type" = 'A' ) AND  
         ( "disp_items"."amounttype" is null )   ;

	li_SqlCode = SQLCA.SqlCode
	COMMIT ;

	CHOOSE CASE li_SqlCode

	CASE 0	

	CASE ELSE

		li_Return = -1

	END CHOOSE
end if

IF li_Return = -1 THEN

	ib_Upgrade_Done = FALSE

END IF

if isvalid(lds_accountmap) then
	destroy lds_accountmap
end if

IF IsValid ( w_Upgrade ) THEN
	Close ( w_Upgrade )
END IF
end event

event ue_post_39;//Special post-convert processing for V39.
//Due to changes in shipment summary column names in 3.5.03,
//we need to delete the existing shipsum.psr 

n_cst_ShipmentManager	lnv_ShipmentManager
String	ls_CacheFile

CHOOSE CASE lnv_ShipmentManager.of_GetShipmentCacheFile ( ls_CacheFile )

CASE 1
	FileDelete ( ls_CacheFile )
	//Note : Even if this fails, it's not a fatal error.  The user may need to delete the
	//file manually.  So, I'm not checking the return code.

CASE 0
	//No cache file specified -- nothing to delete.

CASE -1
	//Failed to get cache file name.  Not a fatal error, though -- allow processing to proceed.

END CHOOSE
end event

event ue_post_56;long	ll_rowcount
integer	li_sqlcode

datastore	lds_notificationstatus

CONSTANT Boolean cb_Commit	= TRUE	

Integer		li_Return = 1  //Flag only.  There is no actual return.

lds_notificationstatus = create datastore
lds_notificationstatus.dataobject = "d_notificationstatus"
lds_notificationstatus.SetTransObject(SQLCA)
ll_rowcount = lds_notificationstatus.Retrieve()

IF li_Return = 1 THEN

	Open ( w_Upgrade )

	IF IsValid ( w_Upgrade ) THEN
		w_Upgrade.Title = "Upgrading to version 56"
		w_Upgrade.st_message.Text = "Converting..."
		w_Upgrade.SetPosition ( TopMost! )
		w_Upgrade.Visible = TRUE
	END IF

END IF

if ll_rowcount > 0 then
	INSERT INTO "nextids" ( "classid", "nextid" )  
	select 16, Max(id) + 1 from "notificationstatus";
else
	INSERT INTO "nextids" ( "classid", "nextid" )  
   VALUES ( 16, 1 )  ;
end if

li_SqlCode = SQLCA.SqlCode
COMMIT ;

CHOOSE CASE li_SqlCode

CASE 0

CASE ELSE

	li_Return = -1

END CHOOSE

IF li_Return = -1 THEN

	ib_Upgrade_Done = FALSE

END IF

destroy lds_notificationstatus

IF IsValid ( w_Upgrade ) THEN
	Close ( w_Upgrade )
END IF
end event

event ue_post_59;//loop through all oe and set leaseftx on the oe
Long			ll_ShipmentCount
Long			ll_ShipIndex
Long			ll_EqCount
Long			ll_EqIndex
Long			lla_ShipIDs[]
Long			ll_ShipID
DateTime 	ldt_FTX
Date			ld_FTx
Time			lt_Ftx
Int			li_SetRtn



DataStore						lds_Shipments
n_cst_AnyArraySrv 			lnv_Array
n_cst_beo_Equipment2			lnva_Equipment[]
n_cst_beo_EquipmentLease2	lnv_Lease
n_cst_bso_Dispatch			lnv_Disp

lnv_Disp = CREATE n_cst_bso_Dispatch
lds_Shipments = Create DataStore

lds_Shipments.DataObject = "d_shipswithoe" 
lds_Shipments.SetTransObject ( SQLCA )

Open ( w_Upgrade )

IF IsValid ( w_Upgrade ) THEN
	w_Upgrade.Title = "Upgrading to version 59"
	w_Upgrade.st_message.Text = "Converting..."
	w_Upgrade.SetPosition ( TopMost! )
	w_Upgrade.Visible = TRUE
END IF

lds_Shipments.Retrieve ( )

ll_ShipmentCount = lds_Shipments.RowCount ( )

FOR ll_ShipIndex = 1 TO ll_ShipmentCount
	w_Upgrade.st_message.Text = "Converting " + String ( ll_ShipIndex ) + " of " + String ( ll_ShipmentCount )
	
	ll_ShipID = lds_Shipments.object.disp_ship_ds_id [ ll_shipIndex ]
	ll_EqCount = lnv_Disp.of_getequipmentforshipment ( ll_ShipID , lnva_Equipment )
	
	
	
	FOR ll_EqIndex = 1 TO ll_EqCount
		lnva_Equipment[ll_EqIndex].of_GetEquipmentLease ( lnv_Lease ) 
		
		IF isValid ( lnv_Lease ) THEN
			
			ldt_FTX =	lnv_Lease.of_getfreetimeexpiration ( )
			IF Not IsNull ( ldt_FTX )THEN
				ld_Ftx = Date ( DateTime ( ldt_FTX ) )
				lt_Ftx = Time ( ldt_FTX )
				lnv_Lease.of_SetAllowFilterSet ( TRUE )
				li_SetRtn = lnv_Lease.of_setfreetimeexpirationDate ( ld_Ftx)
			 	li_SetRtn = lnv_Lease.of_setfreetimeexpirationTime ( lt_Ftx )
			END IF
		END IF
		DESTROY ( lnv_Lease )		
	NEXT
	
	lnv_Array.of_Destroy ( lnva_Equipment ) 	
	
	GarbageCollect ( )
	
NEXT

li_SetRtn = lnv_Disp.Event pt_Save ( ) 

DESTROY ( lnv_Disp )
DESTROY ( lds_Shipments )

if li_setrtn = 1 then
	long	ll_id
	
	 DECLARE emp_cursor CURSOR FOR  
	  SELECT "employees"."em_id"  
	    FROM "employees"  
	   WHERE "employees"."em_class" = 1005   ;
	
	 	open emp_cursor;
		 
	do 
		
		fetch emp_cursor into :ll_id;
		
		  INSERT INTO "system_settings"  
			( "ss_id",   
			  "ss_uid",   
			  "ss_long",   
			  "ss_char",   
			  "ss_string",   
			  "ss_date",   
			  "ss_dec" )  
			 VALUES ( 39001,   
				  :ll_id,   
				  1,   
				  null,   
				  null,   
				  null,   
				  null )  ;
				  
		
	loop while sqlca.sqlcode = 0

	commit;
	
	close emp_cursor; 
	
else
	ib_Upgrade_Done = false
end if

IF IsValid ( w_Upgrade ) THEN
	Close ( w_Upgrade )
END IF

end event

event ue_post_62;long	ll_current


ll_current = of_GetDBVersion ( )

if ll_current < 55 then

	Open ( w_Upgrade )

	IF IsValid ( w_Upgrade ) THEN
		w_Upgrade.Title = "Upgrading to version 62"
		w_Upgrade.st_message.Text = "Converting..."
		w_Upgrade.SetPosition ( TopMost! )
		w_Upgrade.Visible = TRUE
	END IF

	  UPDATE "amounttemplate"  
        SET "type" = 6  
  	   WHERE "type" = 4 and "amounttemplate"."aggregatecalc" = 0   ;


	IF SQLCA.SqlCode = 0 THEN
		commit;
	ELSE
		ROLLBACK ;
		ib_Upgrade_Done = false
	end if

	IF IsValid ( w_Upgrade ) THEN
		Close ( w_Upgrade )
	END IF

end if
end event

event ue_post_70();/* This event is coded to cater to the new system settings in the new version of PT 3.8
Here the Pools & yards property in system settings (ss_id = 85) was string (companies.co_code_name) delimited by 
a comma. In the new system settings this comma delited string values for pools & yards property was replaced by
number string (companies.co_id) delimited by comma.
Hence the below code is coded to take care of customers who still may have string values in ss_id = 85 
in system settings table. The below code will replace the string value with a numeric string of co_ids. 

Returns 1 = Success, -1 = Failure
*/

Int li_Ctr
Int li_Return = 1
Long ll_UpperBound
Long ll_coid
String lsa_RowValues[]
String ls_OldValue
String ls_Value
String ls_code
String ls_NewValue

n_cst_setting_PoolsYards lnv_PoolsYards
lnv_PoolsYards = CREATE n_cst_setting_PoolsYards

ls_OldValue = lnv_PoolsYards.of_GetValue()

n_cst_String lnv_String
lnv_String.of_Parsetoarray(ls_OldValue,',',lsa_RowValues)

ll_UpperBound =  UpperBound(lsa_RowValues)
IF ll_UpperBound  > 0 THEN
	FOR li_Ctr = 1 to ll_UpperBound
		ls_Value  = lsa_RowValues[li_Ctr]
		SetNull(ll_coid)
		SELECT co_id into :ll_coid from companies
		where 	co_code_name = :ls_Value
		and co_status = 'K'	;
		
		CHOOSE CASE SQLCA.SQLCODE
			CASE 0,100		
				Commit;
			CASE ELSE
				li_Return = -1
				Rollback;
		END CHOOSE
		
		IF IsNull(ll_coid)  THEN
			Continue;
		END IF
		ls_NewValue = ls_NewValue + String (ll_coid) + ','
	NEXT
	ls_NewValue = Left(ls_NewValue, (Len(ls_NewValue) - 1))
	
	UPDATE system_settings
	set ss_string = :ls_NewValue
	where ss_id = 85;
	CHOOSE CASE SQLCA.SQLCODE
		CASE 0,100		
			Commit;
		CASE ELSE
			li_Return = -1
			Rollback;
	END CHOOSE
END IF

DESTROY(lnv_PoolsYards)

IF li_Return = -1 THEN
	ib_upgrade_done = FALSE
END IF
end event

event ue_post_75(); // 0		 		1				   2		   3			4				5				6			7				8					9				  10				11			12					13				14				15				16				17				18			 19				20					21				22          23             24          25            26          27            28           29			    30          31			 32				33
// [NONE]", "SHIPPER'S #", "REF #", "P.O. #", "PRO #", "AIRBILL #", "ORDER #", "S.O. #", "WORK ORDER #", "RELEASE #", "CONTROL #", "SLIP #", "TICKET #", "CARRIER #", "TRIP #", "MASTER BL #", "AUTH. #", "ENTRY #", "BOOKING #", "RECEIPT #", "CONTAINER #", "SEAL #", "FWDR REF #", "TRAILER #", "PICKUP #", "MANIFEST #", "RAILBOX #", "CUSTOMER #" , "CHASSIS #" , "LOAD #" , "PRENOTE #", "CUSTOMS #" , "I.T. #" , "CLAIM #"}

Long ll_TotRows

String ls_RefName0
String ls_RefName1
String ls_RefName2
String ls_RefName3
String ls_RefName4
String ls_RefName5
String ls_RefName6
String ls_RefName7
String ls_RefName8
String ls_RefName9
String ls_RefName10
String ls_RefName11
String ls_RefName12
String ls_RefName13
String ls_RefName14
String ls_RefName15
String ls_RefName16
String ls_RefName17
String ls_RefName18
String ls_RefName19
String ls_RefName20
String ls_RefName21
String ls_RefName22
String ls_RefName23
String ls_RefName24
String ls_RefName25
String ls_RefName26
String ls_RefName27
String ls_RefName28
String ls_RefName29
String ls_RefName30
String ls_RefName31
String ls_RefName32
String ls_RefName33

ls_RefName0 	= "[NONE]"
ls_RefName1 	= "SHIPPER'S #"
ls_RefName2 	= "REF #"
ls_RefName3 	= "P.O. #"
ls_RefName4 	= "PRO #"
ls_RefName5 	= "AIRBILL #"
ls_RefName6 	= "ORDER #"
ls_RefName7		= "S.O. #"
ls_RefName8 	= "WORK ORDER #"
ls_RefName9 	= "RELEASE #"
ls_RefName10 	= "CONTROL #"
ls_RefName11 	= "SLIP #"
ls_RefName12 	= "TICKET #"
ls_RefName13 	= "CARRIER #"
ls_RefName14 	= "TRIP #"
ls_RefName15 	= "MASTER BL #"
ls_RefName16 	= "AUTH. #"
ls_RefName17 	= "ENTRY #"
ls_RefName18 	= "BOOKING #"
ls_RefName19 	= "RECEIPT #"
ls_RefName20 	= "CONTAINER #"
ls_RefName21 	= "SEAL #"
ls_RefName22 	= "FWDR REF #"
ls_RefName23 	= "TRAILER #"
ls_RefName24 	= "PICKUP #"
ls_RefName25 	= "MANIFEST #"
ls_RefName26 	= "RAILBOX #"
ls_RefName27 	= "CUSTOMER #"
ls_RefName28 	= "CHASSIS #"
ls_RefName29 	= "LOAD #"
ls_RefName30 	= "PRENOTE #"
ls_RefName31 	= "CUSTOMS #"
ls_RefName32 	= "I.T. #"
ls_RefName33 	= "CLAIM #"

Integer		li_Return = 1  //Flag only.  There is no actual return.


IF li_Return = 1 THEN

	Open ( w_Upgrade )

	IF IsValid ( w_Upgrade ) THEN
		w_Upgrade.Title = "Upgrading to version 75"
		w_Upgrade.st_message.Text = "Converting..."
		w_Upgrade.SetPosition ( TopMost! )
		w_Upgrade.Visible = TRUE
	END IF

END IF


IF li_Return = 1 THEN

	INSERT INTO "REFERENCELIST" ("REFERENCEID","REFERENCENAME","REFERENCECATEGORY","SYSTEMDEFINED") VALUES (0,  :ls_RefName0,	'REFERENCETYPE', 'Y');
	INSERT INTO "REFERENCELIST" ("REFERENCEID","REFERENCENAME","REFERENCECATEGORY","SYSTEMDEFINED") VALUES (1,  :ls_RefName1,	'REFERENCETYPE', 'Y');
	INSERT INTO "REFERENCELIST" ("REFERENCEID","REFERENCENAME","REFERENCECATEGORY","SYSTEMDEFINED") VALUES (2,  :ls_RefName2, 	'REFERENCETYPE', 'Y');
	INSERT INTO "REFERENCELIST" ("REFERENCEID","REFERENCENAME","REFERENCECATEGORY","SYSTEMDEFINED") VALUES (3,  :ls_RefName3, 	'REFERENCETYPE', 'Y');
	INSERT INTO "REFERENCELIST" ("REFERENCEID","REFERENCENAME","REFERENCECATEGORY","SYSTEMDEFINED") VALUES (4,  :ls_RefName4,	'REFERENCETYPE', 'Y');
	INSERT INTO "REFERENCELIST" ("REFERENCEID","REFERENCENAME","REFERENCECATEGORY","SYSTEMDEFINED") VALUES (5,  :ls_RefName5,	'REFERENCETYPE', 'Y');
	INSERT INTO "REFERENCELIST" ("REFERENCEID","REFERENCENAME","REFERENCECATEGORY","SYSTEMDEFINED") VALUES (6,  :ls_RefName6, 	'REFERENCETYPE', 'Y');
	INSERT INTO "REFERENCELIST" ("REFERENCEID","REFERENCENAME","REFERENCECATEGORY","SYSTEMDEFINED") VALUES (7,  :ls_RefName7, 	'REFERENCETYPE', 'Y');
	INSERT INTO "REFERENCELIST" ("REFERENCEID","REFERENCENAME","REFERENCECATEGORY","SYSTEMDEFINED") VALUES (8,  :ls_RefName8,  'REFERENCETYPE', 'Y');
	INSERT INTO "REFERENCELIST" ("REFERENCEID","REFERENCENAME","REFERENCECATEGORY","SYSTEMDEFINED") VALUES (9,  :ls_RefName9, 	'REFERENCETYPE', 'Y');
	INSERT INTO "REFERENCELIST" ("REFERENCEID","REFERENCENAME","REFERENCECATEGORY","SYSTEMDEFINED") VALUES (10, :ls_RefName10, 'REFERENCETYPE', 'Y');
	INSERT INTO "REFERENCELIST" ("REFERENCEID","REFERENCENAME","REFERENCECATEGORY","SYSTEMDEFINED") VALUES (11, :ls_RefName11,	'REFERENCETYPE', 'Y');
	INSERT INTO "REFERENCELIST" ("REFERENCEID","REFERENCENAME","REFERENCECATEGORY","SYSTEMDEFINED") VALUES (12, :ls_RefName12, 'REFERENCETYPE', 'Y');
	INSERT INTO "REFERENCELIST" ("REFERENCEID","REFERENCENAME","REFERENCECATEGORY","SYSTEMDEFINED") VALUES (13, :ls_RefName13, 'REFERENCETYPE', 'Y');
	INSERT INTO "REFERENCELIST" ("REFERENCEID","REFERENCENAME","REFERENCECATEGORY","SYSTEMDEFINED") VALUES (14, :ls_RefName14, 'REFERENCETYPE', 'Y');
	INSERT INTO "REFERENCELIST" ("REFERENCEID","REFERENCENAME","REFERENCECATEGORY","SYSTEMDEFINED") VALUES (15, :ls_RefName15, 'REFERENCETYPE', 'Y');
	INSERT INTO "REFERENCELIST" ("REFERENCEID","REFERENCENAME","REFERENCECATEGORY","SYSTEMDEFINED") VALUES (16, :ls_RefName16,	'REFERENCETYPE', 'Y');
	INSERT INTO "REFERENCELIST" ("REFERENCEID","REFERENCENAME","REFERENCECATEGORY","SYSTEMDEFINED") VALUES (17, :ls_RefName17, 'REFERENCETYPE', 'Y');
	INSERT INTO "REFERENCELIST" ("REFERENCEID","REFERENCENAME","REFERENCECATEGORY","SYSTEMDEFINED") VALUES (18, :ls_RefName18, 'REFERENCETYPE', 'Y');
	INSERT INTO "REFERENCELIST" ("REFERENCEID","REFERENCENAME","REFERENCECATEGORY","SYSTEMDEFINED") VALUES (19, :ls_RefName19, 'REFERENCETYPE', 'Y');
	INSERT INTO "REFERENCELIST" ("REFERENCEID","REFERENCENAME","REFERENCECATEGORY","SYSTEMDEFINED") VALUES (20, :ls_RefName20, 'REFERENCETYPE', 'Y');
	INSERT INTO "REFERENCELIST" ("REFERENCEID","REFERENCENAME","REFERENCECATEGORY","SYSTEMDEFINED") VALUES (21, :ls_RefName21, 'REFERENCETYPE', 'Y');
	INSERT INTO "REFERENCELIST" ("REFERENCEID","REFERENCENAME","REFERENCECATEGORY","SYSTEMDEFINED") VALUES (22, :ls_RefName22, 'REFERENCETYPE', 'Y');
	INSERT INTO "REFERENCELIST" ("REFERENCEID","REFERENCENAME","REFERENCECATEGORY","SYSTEMDEFINED") VALUES (23, :ls_RefName23, 'REFERENCETYPE', 'Y');
	INSERT INTO "REFERENCELIST" ("REFERENCEID","REFERENCENAME","REFERENCECATEGORY","SYSTEMDEFINED") VALUES (24, :ls_RefName24, 'REFERENCETYPE', 'Y');
	INSERT INTO "REFERENCELIST" ("REFERENCEID","REFERENCENAME","REFERENCECATEGORY","SYSTEMDEFINED") VALUES (25, :ls_RefName25, 'REFERENCETYPE', 'Y');
	INSERT INTO "REFERENCELIST" ("REFERENCEID","REFERENCENAME","REFERENCECATEGORY","SYSTEMDEFINED") VALUES (26, :ls_RefName26, 'REFERENCETYPE', 'Y');
	INSERT INTO "REFERENCELIST" ("REFERENCEID","REFERENCENAME","REFERENCECATEGORY","SYSTEMDEFINED") VALUES (27, :ls_RefName27, 'REFERENCETYPE', 'Y');
	INSERT INTO "REFERENCELIST" ("REFERENCEID","REFERENCENAME","REFERENCECATEGORY","SYSTEMDEFINED") VALUES (28, :ls_RefName28, 'REFERENCETYPE', 'Y');
	INSERT INTO "REFERENCELIST" ("REFERENCEID","REFERENCENAME","REFERENCECATEGORY","SYSTEMDEFINED") VALUES (29, :ls_RefName29, 'REFERENCETYPE', 'Y');
	INSERT INTO "REFERENCELIST" ("REFERENCEID","REFERENCENAME","REFERENCECATEGORY","SYSTEMDEFINED") VALUES (30, :ls_RefName30, 'REFERENCETYPE', 'Y');
	INSERT INTO "REFERENCELIST" ("REFERENCEID","REFERENCENAME","REFERENCECATEGORY","SYSTEMDEFINED") VALUES (31, :ls_RefName31,	'REFERENCETYPE', 'Y');
	INSERT INTO "REFERENCELIST" ("REFERENCEID","REFERENCENAME","REFERENCECATEGORY","SYSTEMDEFINED") VALUES (32, :ls_RefName32,	'REFERENCETYPE', 'Y');
	INSERT INTO "REFERENCELIST" ("REFERENCEID","REFERENCENAME","REFERENCECATEGORY","SYSTEMDEFINED") VALUES (33, :ls_RefName33, 'REFERENCETYPE', 'Y');
	
	SELECT Count(*) INTO :ll_TotRows FROM REFERENCELIST;
	IF ll_TotRows = 34 THEN
		COMMIT;
	ELSE
		li_Return = -1 
		ROLLBACK;
	END IF

END IF

IF li_Return = -1 THEN

	ib_Upgrade_Done = FALSE

END IF

IF IsValid ( w_Upgrade ) THEN
	Close ( w_Upgrade )
END IF

end event

event ue_post_72();Int li_RtnVal = 1
String ls_Value


Open ( w_Upgrade )

IF IsValid ( w_Upgrade ) THEN
	w_Upgrade.Title = "Upgrading to version 72"
	w_Upgrade.st_message.Text = "Converting..."
	w_Upgrade.SetPosition ( TopMost! )
	w_Upgrade.Visible = TRUE
END IF


//Due to change for billto name in populateextendeddata
//we need to delete the existing shipsum.psr 
n_cst_ShipmentManager	lnv_ShipmentManager
String	ls_CacheFile

CHOOSE CASE lnv_ShipmentManager.of_GetShipmentCacheFile ( ls_CacheFile )

CASE 1
	FileDelete ( ls_CacheFile )
	//Note : Even if this fails, it's not a fatal error.  The user may need to delete the
	//file manually.  So, I'm not checking the return code.

CASE 0
	//No cache file specified -- nothing to delete.

CASE -1
	//Failed to get cache file name.  Not a fatal error, though -- allow processing to proceed.

END CHOOSE

SELECT ss_string INTO  :ls_Value FROM system_settings WHERE ss_id = 138;
CHOOSE CASE SQLCA.SQLCODE
	CASE 0,100		
		Commit;
	CASE ELSE
		li_RtnVal = -1
		Rollback;
END CHOOSE

CHOOSE CASE ls_Value
	CASE 'RELINK!'
		UPDATE system_settings SET ss_string = 'YES!' WHERE ss_id = 138;
		CHOOSE CASE SQLCA.SQLCODE
			CASE 0,100
				Commit;
			CASE ELSE
				li_RtnVal = -1
				Rollback;
		END CHOOSE
	CASE 'RELOAD!' 
		UPDATE system_settings SET ss_string = 'NO!' WHERE ss_id = 138;
		CHOOSE CASE SQLCA.SQLCODE
			CASE 0,100
				Commit;
			CASE ELSE
				li_RtnVal = -1
				Rollback;
		END CHOOSE
END CHOOSE		

IF IsValid ( w_Upgrade ) THEN
	Close ( w_Upgrade )
END IF

IF li_RtnVal = -1 THEN
	ib_upgrade_done = FALSE
END IF
end event

event ue_post_85();long	lla_shiptypeid[], &	
		ll_ndx, &
		ll_count, &
		ll_termcnt, &
		ll_shipId, &
		ll_foundrow, &
		ll_shipindex, &
		ll_ShipmentCount, &
		ll_CurrentShipCount, &
		ll_Shiptype
		
Long	ll_MaxID		

string	ls_terms, &
			lsa_terms[], &
			ls_setting
			
integer	li_SqlCode

n_ds				lds_Shipments, &
					lds_Currentshipments
					
n_cst_shiptype lnv_shiptype
n_cst_ship_type lnv_cst_ship_type

CONSTANT Boolean cb_Commit	= TRUE	

Integer		li_Return = 1  //Flag only.  There is no actual return.

IF li_Return = 1 THEN

	Open ( w_Upgrade )

	IF IsValid ( w_Upgrade ) THEN
		w_Upgrade.Title = "Upgrading to version 85"
		w_Upgrade.st_message.Text = "Converting..."
		w_Upgrade.SetPosition ( TopMost! )
		w_Upgrade.Visible = TRUE
	END IF

END IF

//get the list of all shipment type ids 
ll_count = lnv_cst_ship_type.of_gettypelist('ALL', FALSE, lla_shiptypeid)

for ll_ndx = 1 to ll_count

	if isvalid(lnv_shiptype) then
		destroy lnv_shiptype
	end if

	if not lnv_cst_ship_type.of_get_object(lla_shiptypeid[ll_ndx], lnv_shiptype) = 1 then
		continue
	end if
	
	//Get the terms and add to array
	ls_terms = lnv_shiptype.ids_data.object.st_terms[1]
	
	if len(trim(ls_terms)) > 0 then
		ll_termcnt ++
		lsa_terms[ll_termcnt] = ls_terms
	end if
	
next

if li_return = 1 then

	if ll_termcnt > 0 then 
		
		n_cst_anyarraysrv			lnv_Arraysrv
		n_cst_String lnv_String

		//remove dupes
		lnv_Arraysrv.of_GetShrinked ( lsa_terms, FALSE /*Shrink Nulls */, true /*Shrink dupes */)

		lnv_String.of_ArraytoString(lsa_terms,',',ls_setting)
		
	end if
	
end if
	
if li_return = 1 then
	//set system setting
  INSERT INTO "system_settings"  
         ( "ss_id",   
           "ss_uid",   
           "ss_long",   
           "ss_char",   
           "ss_string",   
           "ss_date",   
           "ss_dec" )  
  VALUES ( 178,   
           0,   
           null,   
           null,   
           :ls_setting,   
           null,   
           null )  ;

	li_SqlCode = SQLCA.SqlCode
	COMMIT ;

	CHOOSE CASE li_SqlCode

	CASE 0

	CASE ELSE

		li_Return = -1

	END CHOOSE

end if

if li_return = 1 then
	
	//update paymentterms column on active shipments
	//modify where clause
	
	lds_CurrentShipments = create n_ds
	lds_CurrentShipments.dataobject = "d_current_shipment_ids"
	lds_CurrentShipments.settransobject(sqlca)
	lds_CurrentShipments.setsort("cs_id A")
	ll_CurrentShipCount = lds_CurrentShipments.retrieve()
	
	lds_Shipments = Create n_ds
	lds_Shipments.DataObject = "d_shiparterms" 
	lds_Shipments.SetTransObject ( SQLCA )
	ll_ShipmentCount = lds_Shipments.Retrieve ( )

	FOR ll_ShipIndex = 1 TO ll_CurrentShipCount
		
		ll_shipId = lds_CurrentShipments.object.cs_id[ll_Shipindex]
		
		ll_foundrow = lds_Shipments.find('ds_id = ' + string(ll_shipid), 1, ll_ShipmentCount)
		
		if ll_foundrow > 0 then
			
			ll_Shiptype = lds_Shipments.object.ds_ship_type [ ll_foundrow ]
		
			if ll_Shiptype = 0 or isnull(ll_shiptype) then
				continue
			end if
			
			if isvalid(lnv_shiptype) then
				destroy lnv_shiptype
			end if
			
			if not lnv_cst_ship_type.of_get_object(ll_Shiptype, lnv_shiptype) = 1 then
				continue
			end if
	
			ls_terms = lnv_shiptype.ids_data.object.st_terms[1]
			
			if len(trim(ls_terms)) > 0 then
				lds_Shipments.object.paymentterms [ ll_foundrow ] = ls_terms
			end if
		
		end if
	
	NEXT
	
	IF lds_Shipments.Update ( ) = 1 THEN
		COMMIT ;

		IF SQLCA.SqlCode = 0 THEN
			//OK
		ELSE
			ROLLBACK ;
			li_Return = -1
		END IF

	ELSE
		ROLLBACK ;
		li_Return = -1
	END IF

	destroy lds_shipments
	
end if

//done with shiptype
if isvalid(lnv_shiptype) then
	destroy lnv_shiptype
end if

if li_Return = 1 then
	//set initial value for reverse search on settlements
	
	n_cst_setting_reverseorides				lnv_ReverseSetting
	n_cst_setting_reverseoridesSettlements	lnv_SettlementsSetting
	
	lnv_ReverseSetting = create n_cst_setting_reverseorides
	lnv_SettlementsSetting = create n_cst_setting_reverseoridesSettlements
	
	IF lnv_ReverseSetting.of_Getvalue( ) = lnv_ReverseSetting.cs_Yes THEN
		ls_Setting = lnv_ReverseSetting.cs_Yes
	ELSE
		ls_Setting = lnv_ReverseSetting.cs_No
	END IF
	
	lnv_SettlementsSetting.of_Savevalue(ls_Setting)
	lnv_SettlementsSetting.of_SaveSetting()
	
	
	destroy lnv_ReverseSetting
	destroy lnv_SettlementsSetting

	
end if

IF li_Return = -1 THEN

	ib_Upgrade_Done = FALSE

END IF

IF IsValid ( w_Upgrade ) THEN
	Close ( w_Upgrade )
END IF

end event

event ue_post_86();long		ll_MaxId

CONSTANT Boolean cb_Commit	= TRUE	

Integer		li_Return = 1  //Flag only.  There is no actual return.

IF li_Return = 1 THEN

	Open ( w_Upgrade )

	IF IsValid ( w_Upgrade ) THEN
		w_Upgrade.Title = "Upgrading to version 86"
		w_Upgrade.st_message.Text = "Converting..."
		w_Upgrade.SetPosition ( TopMost! )
		w_Upgrade.Visible = TRUE
	END IF

END IF


IF li_Return = 1 THEN
	
	// events
	select max ( de_id ) into :ll_MaxID from disp_events;
	IF sqlca.sqlcode = 0 THEN
		IF isNull ( ll_MaxID ) THEN
			ll_MaxID = 0
		END IF
		ll_MaxID ++
		insert into nextids
		values ( 21 , :ll_MaxID );
		IF sqlca.sqlcode = 0 THEN
			COMMIT;
		ELSE
			ROLLBACK;
			li_Return = -1
		END IF
	ELSE
		RollBack;
	END IF
	
	// items
	select max ( di_item_id ) into :ll_MaxID from disp_items;
	IF sqlca.sqlcode = 0 THEN
		IF isNull ( ll_MaxID ) THEN
			ll_MaxID = 0
		END IF
		ll_MaxID ++
		insert into nextids
		values ( 22 , :ll_MaxID );
		IF sqlca.sqlcode = 0 THEN
			COMMIT;
		ELSE
			ROLLBACK;
			li_Return = -1
		END IF
	ELSE
		RollBack;
	END IF

	// shipment
	select max ( ds_id ) into :ll_MaxID from disp_Ship;
	IF sqlca.sqlcode = 0 THEN
		IF isNull ( ll_MaxID ) THEN
			ll_MaxID = 0
		END IF
		ll_MaxID ++
		insert into nextids
		values ( 23 , :ll_MaxID );
		IF sqlca.sqlcode = 0 THEN
			COMMIT;
		ELSE
			ROLLBACK;
			li_Return = -1
		END IF
	ELSE
		RollBack;
	END IF
	
END IF

IF li_Return = -1 THEN

	ib_Upgrade_Done = FALSE

END IF

IF IsValid ( w_Upgrade ) THEN
	Close ( w_Upgrade )
END IF




end event

event ue_post_91();long		ll_MaxId

CONSTANT Boolean cb_Commit	= TRUE	

Integer		li_Return = 1  //Flag only.  There is no actual return.

IF li_Return = 1 THEN

	Open ( w_Upgrade )

	IF IsValid ( w_Upgrade ) THEN
		w_Upgrade.Title = "Upgrading to version 91"
		w_Upgrade.st_message.Text = "Converting..."
		w_Upgrade.SetPosition ( TopMost! )
		w_Upgrade.Visible = TRUE
	END IF

END IF

IF li_Return = 1 THEN
	Long		ll_Count
	Long 		i 
	String	ls_Pending
	String	ls_Spent
	
	DataStore lds_204Companies
	lds_204Companies = CREATE datastore 
	lds_204Companies.DataObject = "d_204companies"
	lds_204Companies.SetTransObject (SQLCA ) 
	
	n_cst_setting_pathto204importfolder	lnv_Pending
	lnv_Pending = CREATE n_cst_setting_pathto204importfolder
	
	n_cst_setting_pathto204processedfolder lnv_Spent
	lnv_Spent = CREATE n_cst_setting_pathto204processedfolder
	
	ls_Spent = lnv_Spent.of_Getvalue( )
	ls_Pending = lnv_Pending.of_getvalue( )
	
	ll_Count = lds_204Companies.Retrieve( )
	IF ll_Count > 0 THEN
		FOR i = 1 TO ll_Count
			lds_204Companies.object.edi204profile_processedfiles[i] = ls_Spent
			lds_204Companies.object.edi204profile_pendingfiles[i] = ls_Pending
		NEXT
		
		IF lds_204Companies.Update() <> 1 THEN
			li_Return = -1
		END IF
	END IF
	
	DESTROY ( lnv_Spent )
	DESTROY ( lnv_Pending )
	DESTROY ( lds_204Companies )
	
END IF

	
IF li_Return = -1 THEN

	ib_Upgrade_Done = FALSE

END IF

IF IsValid ( w_Upgrade ) THEN
	Close ( w_Upgrade )
END IF




end event

event ue_post_95();long		ll_MaxId

CONSTANT Boolean cb_Commit	= TRUE	

Integer		li_Return = 1  //Flag only.  There is no actual return.

IF li_Return = 1 THEN

	Open ( w_Upgrade )

	IF IsValid ( w_Upgrade ) THEN
		w_Upgrade.Title = "Upgrading to version 95"
		w_Upgrade.st_message.Text = "Converting..."
		w_Upgrade.SetPosition ( TopMost! )
		w_Upgrade.Visible = TRUE
	END IF

END IF


IF li_Return = 1 THEN
	UPDATE equipmentleasetype set dayofinterchangecounts = 0;
	IF SQLCA.Sqlcode = 0 THEN
		COMMIT;
	ELSE
		ROLLBACK;
		li_Return = -1
	END IF
	
END IF

IF li_Return = -1 THEN

	ib_Upgrade_Done = FALSE

END IF

IF IsValid ( w_Upgrade ) THEN
	Close ( w_Upgrade )
END IF




end event

event ue_post_105();long		ll_MaxId

CONSTANT Boolean cb_Commit	= TRUE	

Integer		li_Return = 1  //Flag only.  There is no actual return.

IF li_Return = 1 THEN

	Open ( w_Upgrade )

	IF IsValid ( w_Upgrade ) THEN
		w_Upgrade.Title = "Upgrading to version 105"
		w_Upgrade.st_message.Text = "Converting..."
		w_Upgrade.SetPosition ( TopMost! )
		w_Upgrade.Visible = TRUE
	END IF

END IF


IF li_Return = 1 THEN
	
	INSERT INTO DynamicObject
	(Name, ClassName, Type, Description)
	VALUES
	('DataWindow Template', 'u_dw','datawindow','Generic DataWindow'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('DataWindow Template','dataobject','d_generic'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('DataWindow Template','width','1000'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('DataWindow Template','height','500'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('DataWindow Template','titleBar','true'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('DataWindow Template','title','Generic DataWindow'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('DataWindow Template','controlmenu','false'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	
	INSERT INTO DynamicObject
	(Name, ClassName, Type, Description)
	VALUES
	('Window Template', 'w_master','window','Generic Window'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('Window Template','titleBar','true'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('Window Template','title','Generic Window'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('Window Template','backcolor','12632256'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('Window Template','title','Window Template'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('Window Template','controlmenu','true'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('Window Template','width','4000'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('Window Template','height','2000'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('Window Template','border','true'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('Window Template','resizeable','true'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	
	
	
	INSERT INTO DynamicObject
	(Name, ClassName, Type, Description)
	VALUES
	('Shipment Template', 'u_dw_tcard_shipments','datawindow','Generic Shipment T-card'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('Shipment Template','dataobject','d_generic'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('Shipment Template','width','1000'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('Shipment Template','height','500'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('Shipment Template','titleBar','true'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('Shipment Template','title','Generic Shipment T-card'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('Shipment Template','controlmenu','false'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	
	
	
	INSERT INTO DynamicObject
	(Name, ClassName, Type, Description)
	VALUES
	('Driver Template', 'u_dw_tcard_drivers','datawindow','Generic Driver T-card'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('Driver Template','dataobject','d_generic'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('Driver Template','width','1000'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('Driver Template','height','500'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('Driver Template','titleBar','true'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('Driver Template','title','Generic Driver T-card'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('Driver Template','controlmenu','false'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	
	
	
	INSERT INTO DynamicObject
	(Name, ClassName, Type, Description)
	VALUES
	('Equipment Template', 'u_dw_tcard_equipment','datawindow','Generic Equipment T-card'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('Equipment Template','dataobject','d_generic'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('Equipment Template','width','1000'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('Equipment Template','height','500'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('Equipment Template','titleBar','true'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('Equipment Template','title','Generic Equipment T-card'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('Equipment Template','controlmenu','false'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	
	
	
	INSERT INTO DynamicObject
	(Name, ClassName, Type, Description)
	VALUES
	('Admin Tool', 'u_dw_admintool','datawindow','Tool used for admin toggle'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('Admin Tool','titlebar','true'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	
	
	
	INSERT INTO DynamicObject
	(Name, ClassName, Type, Description)
	VALUES
	('Quick Match Tool', 'u_dw_quickmatch','datawindow','Tool used for radius restriction'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('Quick Match Tool','title','QuickMatch'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('Quick Match Tool','resizable','true'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('Quick Match Tool','dataobject','d_quickmatch_display'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('Quick Match Tool','titleBar','true'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('Quick Match Tool','dragscroll','false'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('Quick Match Tool','width','658'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('Quick Match Tool','border','true'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('Quick Match Tool','borderstyle','stylelowered'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('Quick Match Tool','prefilter',''  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('Quick Match Tool','controlmenu','true'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('Quick Match Tool','height','720'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	
	
	
	INSERT INTO DynamicObject
	(Name, ClassName, Type, Description)
	VALUES
	('Tab Template', 'u_tab','tab','Generic Tab'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('Tab Template','height','112'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('Tab Template','boldselected','true'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('Tab Template','position','tabsontop'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('Tab Template','tabbackcolor','12632256'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('Tab Template','width','1010'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('Tab Template','multiline','false'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('Tab Template','backcolor','12632256'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	INSERT INTO DynamicProperty
	(ObjectName,PropertyLabel, PropertyValue)
	VALUES
	('Tab Template','tabtextcolor','0'  );
	IF SQLCA.Sqlcode = 0 THEN
		//Commit;
	ELSE
		//RollBack;
		li_Return = -1
	END IF
	
	
	insert into AppUser ( appuser.id, appuser.ref) select em_id, em_ref from employees where em_class <> 1001 and em_ref is not null;

	
END IF

IF li_Return = -1 THEN
	RollBack;
	ib_Upgrade_Done = FALSE
ELSE
	Commit;
END IF

IF IsValid ( w_Upgrade ) THEN
	Close ( w_Upgrade )
END IF







end event

event ue_post_107();long		ll_MaxId

CONSTANT Boolean cb_Commit	= TRUE	

Integer		li_Return = 1  //Flag only.  There is no actual return.

IF li_Return = 1 THEN

	Open ( w_Upgrade )

	IF IsValid ( w_Upgrade ) THEN
		w_Upgrade.Title = "Upgrading to version 107"
		w_Upgrade.st_message.Text = "Converting..."
		w_Upgrade.SetPosition ( TopMost! )
		w_Upgrade.Visible = TRUE
	END IF

END IF


IF li_Return = 1 THEN
	Int		i
	String	lsa_Fun[] = {"ModifyShipment", "AlterItinerary" ,  "EditEventTimes" , "ConfirmEvents" , "UnconfirmEvents" , "Scan Image", "Delete Image" , "Modify Image"    , "Modify Rate Table"}
	String	lsa_mod[] = { "Dispatch" ,      "Dispatch",          "Dispatch",       "Dispatch",          "Dispatch"  ,     "Imaging",    "Imaging" ,  		"Imaging"  ,           "AutoRating"      }
	long		lla_Role [] = { 1003 ,            1003 ,                1003 ,            1003 ,              1003 ,				1003 ,         1003, 				1003 ,   	      	 1005        }		
	String	lsa_Type[] = { "D" ,               "D" ,                 "D" ,             "D",                "D" ,             "D",          "D" ,   			 "D" ,                 "N"        }
	

	String	ls_Fun
	Long	ll_Role
	String	ls_Mod
	String	ls_Type
	
	FOR i = 1 TO 9
		
		ls_Fun = lsa_Fun[i]
		ls_Mod = lsa_mod[i]
		ll_Role = lla_Role[i]
		ls_Type = lsa_Type[i]
		
		  INSERT INTO "privmodulefunction"  
         ( "modfnid",   
           "module",   
           "function",   
           "role",   
	        "type" )  
  			VALUES ( :i ,   
           :ls_Mod,   
           :ls_Fun,   
           :ll_Role,   
           :ls_Type )  ;

		IF SQLCA.Sqlcode <> 0 THEN
			li_Return = -1
		END IF
	NEXT

	
END IF




IF li_Return = -1 THEN
	RollBack;
	ib_Upgrade_Done = FALSE
ELSE
	Commit;
END IF

IF IsValid ( w_Upgrade ) THEN
	Close ( w_Upgrade )
END IF







end event

event ue_post_110();Long	ll_NextID
Int	li_Return = 1

n_Cst_numerical	lnv_numerical
select max(eq_id) into :ll_NextID from equipment ;
if sqlca.sqlcode <> 0 then 
	rollback	;
ELSE
	if lnv_Numerical.of_IsNullOrNotPos(ll_NextID) then 
		ll_NextID = 10000000
	END IF
END IF  

ll_NextID ++

INSERT INTO "nextids"  
		( "classid",   
		  "nextid" )  
VALUES ( 28,   
		  :ll_nextid )  ;
			  
IF sqlca.sqlcode <> 0 then 
	rollback	;
	li_Return = -1
ELSE
	Commit;
END IF


IF li_Return = -1 THEN

	ib_Upgrade_Done = FALSE

END IF

end event

event ue_post_112();long		ll_MaxId
n_Cst_privileges	lnv_Privs
CONSTANT Boolean cb_Commit	= TRUE	

Integer		li_Return = 1  //Flag only.  There is no actual return.

IF li_Return = 1 THEN

	Open ( w_Upgrade )

	IF IsValid ( w_Upgrade ) THEN
		w_Upgrade.Title = "Upgrading to version 112"
		w_Upgrade.st_message.Text = "Converting..."
		w_Upgrade.SetPosition ( TopMost! )
		w_Upgrade.Visible = TRUE
	END IF

END IF
IF li_Return = 1 THEN
	
	Int	li_NextID
	SELECT Max ("privmodulefunction"."modfnid" )
    INTO :li_NextID  
    FROM "privmodulefunction"  ;
	 
	IF sqlca.sqlcode <> 0 THEN
		li_Return = -1
	
	END IF
	
END IF
	
	

IF li_Return = 1 THEN

	Int		i
	String	lsa_Fun[] = {appeon_constant.cs_ModifyEmployee , appeon_constant.cs_ModifyDriverLog ,  appeon_constant.cs_ModifyGlobalPayable , appeon_constant.cs_ModifyEmployeePayable , appeon_constant.cs_BillShipment , appeon_constant.cs_SettleDrivers , appeon_constant.cs_ViewLogReports }
	String	lsa_mod[] = {  "Employees" , 	 										 "Logs",                 				    "Settlements",                           "Settlements",            					            "Billing" ,                "Settlements" ,                              	"Logs"} 
	long		lla_Role [] = {  1004 ,           									 1004 ,                 					     1005 ,                                   1004 ,              	      			            1004 ,                    1004  ,											 lnv_Privs.ci_Class_Lookup	 }		
	String	lsa_Type[] = {    "D" ,           								 	 "D" ,                   					    	 "N" ,                                   "D",                          			          	 "D" ,                     "D",															"D" }
	
	Int		li_End
	String	ls_Fun
	String	ls_Mod
	String	ls_Type
	Long		ll_Role
	
	  
	li_End = UpperBound ( lsa_Fun )
	
	FOR i = 1 TO li_End
		
		li_NextID ++
		ls_Fun = lsa_Fun[i]
		ls_Mod = lsa_mod[i]
		ll_Role = lla_Role[i]
		ls_Type = lsa_Type[i]
		
		  INSERT INTO "privmodulefunction"  
         ( "modfnid",   
           "module",   
           "function",   
           "role",   
	        "type" )  
  			VALUES ( :li_NextID ,   
           :ls_Mod,   
           :ls_Fun,   
           :ll_Role,   
           :ls_Type )  ;

		IF SQLCA.Sqlcode <> 0 THEN
			li_Return = -1
		END IF
	NEXT
	
END IF


IF li_Return = -1 THEN
	RollBack;
	ib_Upgrade_Done = FALSE
ELSE
	Commit;
END IF

IF IsValid ( w_Upgrade ) THEN
	Close ( w_Upgrade )
END IF
end event

event ue_post_rt_113();Integer		li_Return = 1  //Flag only.  There is no actual return.
Constant Boolean lb_BackupDB = FALSE //No database backup

IF li_Return = 1 THEN
	
	IF This.of_UpgradeRailTraceInterface(lb_BackupDb) = -1 THEN
		li_Return = -1
	END IF

	
END IF

IF li_Return = -1 THEN
	ib_Upgrade_Done = FALSE
END IF


end event

event ue_post_113();long		ll_MaxId

CONSTANT Boolean cb_Commit	= TRUE	

Integer		li_Return = 1  //Flag only.  There is no actual return.

IF li_Return = 1 THEN

	Open ( w_Upgrade )

	IF IsValid ( w_Upgrade ) THEN
		w_Upgrade.Title = "Upgrading to version 113"
		w_Upgrade.st_message.Text = "Converting..."
		w_Upgrade.SetPosition ( TopMost! )
		w_Upgrade.Visible = TRUE
	END IF

END IF


IF li_Return = 1 THEN
	
	  UPDATE "edi_transportsettings"  
     SET "passive_transfer" = 0  ;
 
	
	IF SQLCA.Sqlcode = 0 THEN
		COMMIT;
	ELSE
		ROLLBACK;
		li_Return = -1
	END IF
	
END IF

IF li_Return = -1 THEN

	ib_Upgrade_Done = FALSE

END IF

IF IsValid ( w_Upgrade ) THEN
	Close ( w_Upgrade )
END IF

end event

event ue_post_rt_115;Integer		li_Return = 1  //Flag only.  There is no actual return.
Constant Boolean lb_BackupDB = FALSE //No database backup

IF li_Return = 1 THEN
	
	IF This.of_UpgradeRailTraceInterface(lb_BackupDb) = -1 THEN
		li_Return = -1
	END IF

	
END IF

IF li_Return = -1 THEN
	ib_Upgrade_Done = FALSE
END IF
end event

event ue_post_116();long		ll_MaxId
n_Cst_privileges	lnv_Privs
CONSTANT Boolean cb_Commit	= TRUE	

Integer		li_Return = 1  //Flag only.  There is no actual return.

IF li_Return = 1 THEN

	Open ( w_Upgrade )

	IF IsValid ( w_Upgrade ) THEN
		w_Upgrade.Title = "Upgrading to version 116"
		w_Upgrade.st_message.Text = "Converting..."
		w_Upgrade.SetPosition ( TopMost! )
		w_Upgrade.Visible = TRUE
	END IF

END IF
IF li_Return = 1 THEN
	
	Int	li_NextID
	SELECT Max ("privmodulefunction"."modfnid" )
    INTO :li_NextID  
    FROM "privmodulefunction"  ;
	 
	IF sqlca.sqlcode <> 0 THEN
		li_Return = -1
	
	END IF
	
END IF
	
	

IF li_Return = 1 THEN

	Int		i
	String	lsa_Fun[] = {appeon_constant.cs_viewcharges , appeon_constant.cs_viewbilling }
	String	lsa_mod[] = {  "Dispatch" , 	 										 "Billing"} 
	long		lla_Role [] = {  1002 ,           									 1002	}		
	String	lsa_Type[] = {    "N" ,           								 	 "N"  }
	
	Int		li_End
	String	ls_Fun
	String	ls_Mod
	String	ls_Type
	Long		ll_Role
	
	  
	li_End = UpperBound ( lsa_Fun )
	
	FOR i = 1 TO li_End
		
		li_NextID ++
		ls_Fun = lsa_Fun[i]
		ls_Mod = lsa_mod[i]
		ll_Role = lla_Role[i]
		ls_Type = lsa_Type[i]
		
		  INSERT INTO "privmodulefunction"  
         ( "modfnid",   
           "module",   
           "function",   
           "role",   
	        "type" )  
  			VALUES ( :li_NextID ,   
           :ls_Mod,   
           :ls_Fun,   
           :ll_Role,   
           :ls_Type )  ;

		IF SQLCA.Sqlcode <> 0 THEN
			li_Return = -1
		END IF
	NEXT
	
END IF


IF li_Return = -1 THEN
	RollBack;
	ib_Upgrade_Done = FALSE
ELSE
	Commit;
END IF

IF IsValid ( w_Upgrade ) THEN
	Close ( w_Upgrade )
END IF
end event

event ue_post_117();long		ll_MaxId
String	ls_Sql
n_Cst_privileges	lnv_Privs
CONSTANT Boolean cb_Commit	= TRUE	

Integer		li_Return = 1  //Flag only.  There is no actual return.

IF li_Return = 1 THEN

	Open ( w_Upgrade )

	IF IsValid ( w_Upgrade ) THEN
		w_Upgrade.Title = "Upgrading to version 117"
		w_Upgrade.st_message.Text = "Converting..."
		w_Upgrade.SetPosition ( TopMost! )
		w_Upgrade.Visible = TRUE
	END IF

END IF

IF li_Return = 1 THEN
	
	Int	li_NextID
	SELECT Max ("privmodulefunction"."modfnid" )
    INTO :li_NextID  
    FROM "privmodulefunction"  ;
	 
	IF sqlca.sqlcode <> 0 THEN
		li_Return = -1
	END IF
	
END IF
	
IF li_Return = 1 THEN

	Int		i
	String	lsa_Fun[] = {appeon_constant.cs_ViewEmployee,	 appeon_constant.cs_ModifyBilledShip, appeon_constant.cs_ModifyBilledShipRates  }
	String	lsa_mod[] = {  "Employees",									"Dispatch",										"Dispatch" } 
	long		lla_Role [] = {  appeon_constant.cl_Lookup,			1006,													1006}		//the last two are higher then PTADMIN
	String	lsa_Type[] = {    "D",											 "D",													"D"}
	
	Int		li_End
	String	ls_Fun
	String	ls_Mod
	String	ls_Type
	Long		ll_Role
	
	  
	li_End = UpperBound ( lsa_Fun )
	
	FOR i = 1 TO li_End
		
		li_NextID ++
		ls_Fun = lsa_Fun[i]
		ls_Mod = lsa_mod[i]
		ll_Role = lla_Role[i]
		ls_Type = lsa_Type[i]
		
		  INSERT INTO "privmodulefunction"  
         ( "modfnid",   
           "module",   
           "function",   
           "role",   
	        "type" )  
  			VALUES ( :li_NextID ,   
           :ls_Mod,   
           :ls_Fun,   
           :ll_Role,   
           :ls_Type )  ;

		IF SQLCA.Sqlcode <> 0 THEN
			li_Return = -1
		END IF
	NEXT
	
END IF

//Remove openshipmentdelete trigger for TT interface
IF li_Return = 1 THEN
	ls_sql = "IF EXISTS (SELECT 1 FROM systriggers WHERE trigname = 'openshipmentsdelete') THEN "
	ls_sql += "DROP trigger openshipmentsdelete; " + &
				"END IF"			 
	Execute Immediate :ls_Sql;
	IF SQLCA.Sqlcode <> 0 THEN
		li_Return = -1
	END IF
END IF


IF li_Return = -1 THEN
	RollBack;
	ib_Upgrade_Done = FALSE
ELSE
	Commit;
END IF

IF IsValid ( w_Upgrade ) THEN
	Close ( w_Upgrade )
END IF
end event

event ue_post_rt_117();Integer		li_Return = 1  //Flag only.  There is no actual return.
Constant Boolean lb_BackupDB = FALSE //No database backup

IF li_Return = 1 THEN
	
	IF This.of_UpgradeRailTraceInterface(lb_BackupDb) = -1 THEN
		li_Return = -1
	END IF

	
END IF

IF li_Return = -1 THEN
	ib_Upgrade_Done = FALSE
END IF
end event

event ue_post_119();long		ll_MaxId
String	ls_Sql
n_Cst_privileges	lnv_Privs
String	ls_errMsg
CONSTANT Boolean cb_Commit	= TRUE	

Integer		li_Return = 1  //Flag only.  There is no actual return.

IF li_Return = 1 THEN

	Open ( w_Upgrade )

	IF IsValid ( w_Upgrade ) THEN
		w_Upgrade.Title = "Upgrading to version 119"
		w_Upgrade.st_message.Text = "Converting..."
		w_Upgrade.SetPosition ( TopMost! )
		w_Upgrade.Visible = TRUE
	END IF

END IF


IF li_Return = 1 THEN
	ls_sql = "IF NOT EXISTS (SELECT 1 FROM sys.sysindex WHERE index_name = 'ndx_ReloadShipment') THEN "	
	ls_sql += "CREATE INDEX ndx_ReloadShipment ON outside_equip ( reloadshipment ) ~n" + &
				 "END IF"			 
	Execute Immediate :ls_Sql USING SQLCA;
	
	IF SQLCA.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not create equipment reload index."
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	ls_sql = "IF NOT EXISTS (SELECT 1 FROM sys.sysindex WHERE index_name = 'ndx_eqstatus') THEN "	
	ls_sql += "CREATE INDEX ndx_eqstatus ON equipment ( eq_status ) ~n" + &
				 "END IF"			 
	Execute Immediate :ls_Sql USING SQLCA;
	
	IF SQLCA.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not create equipment reload index."
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	
	ls_sql = "update equipment set eq_cur_event = null where eq_cur_event not in (select de_id from disp_events)"	
	Execute Immediate :ls_Sql USING SQLCA;
	
	IF SQLCA.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not update equipment table to set missing events to null."
		li_Return = -1
	END IF
END IF


IF li_Return = 1 THEN
	
	ls_sql = "IF NOT EXISTS (SELECT 1 FROM sys.sysforeignkey WHERE role = 'fk_disp_events_Equipment') THEN "	
	ls_sql += "ALTER TABLE equipment ADD FOREIGN KEY fk_disp_events_Equipment ( eq_cur_event ) REFERENCES disp_events ( de_id ) ON UPDATE CASCADE ON DELETE SET NULL ~n" + &	
				 "END IF"			 
	Execute Immediate :ls_Sql USING SQLCA;
	
	IF SQLCA.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not create equipment/event FK."
		li_Return = -1
	END IF
END IF



IF li_Return = -1 THEN
	RollBack;
	ib_Upgrade_Done = FALSE
ELSE
	Commit;
END IF

IF IsValid ( w_Upgrade ) THEN
	Close ( w_Upgrade )
END IF

end event

event ue_post_rt_121;Integer		li_Return = 1  //Flag only.  There is no actual return.
Constant Boolean lb_BackupDB = FALSE //No database backup

IF li_Return = 1 THEN
	
	IF This.of_UpgradeRailTraceInterface(lb_BackupDb) = -1 THEN
		li_Return = -1
	END IF

	
END IF

IF li_Return = -1 THEN
	ib_Upgrade_Done = FALSE
END IF
end event

event ue_post_121();long		ll_MaxId
String	ls_Sql
n_Cst_privileges	lnv_Privs
String	ls_errMsg
CONSTANT Boolean cb_Commit	= TRUE	

Integer		li_Return = 1  //Flag only.  There is no actual return.

IF li_Return = 1 THEN

	Open ( w_Upgrade )

	IF IsValid ( w_Upgrade ) THEN
		w_Upgrade.Title = "Upgrading to version 121"
		w_Upgrade.st_message.Text = "Converting..."
		w_Upgrade.SetPosition ( TopMost! )
		w_Upgrade.Visible = TRUE
	END IF

END IF


IF li_Return = 1 THEN
	Delete from eventtasks where eventtaskname = 'SYNCROMET';
END IF



IF li_Return = -1 THEN
	RollBack;
	ib_Upgrade_Done = FALSE
ELSE
	Commit;
END IF

IF IsValid ( w_Upgrade ) THEN
	Close ( w_Upgrade )
END IF

end event

public function date of_getlicensestart ();Long	ll_FoundRow
Date	ld_LicenseStart

ll_FoundRow = of_Find ( "LicenseStart", FALSE )

IF ll_FoundRow > 0 THEN
	ld_LicenseStart = sds_Cache.Object.ss_date [ ll_FoundRow ]
ELSE
	SetNull ( ld_LicenseStart )
END IF

RETURN ld_LicenseStart
end function

public function date of_getlicenseexpiration ();Long	ll_FoundRow
Date	ld_LicenseExpiration

ll_FoundRow = of_Find ( "LicenseExpiration", FALSE )

IF ll_FoundRow > 0 THEN
	ld_LicenseExpiration = sds_Cache.Object.ss_date [ ll_FoundRow ]
ELSE
	SetNull ( ld_LicenseExpiration )
END IF

RETURN ld_LicenseExpiration
end function

public function boolean of_getlicensed (string as_module);//Returns TRUE if the module is licensed, FALSE if the module is not licensed, or the
//license could not be determined.

String	ls_ModuleList, &
			lsa_ModuleList[]
Long		ll_InstallType, &
			ll_RowCount, &
			ll_FoundRow
Integer	li_Ndx, &
			li_Count
n_cst_String	lnv_String


//Validate cache

IF IsValid ( sds_Cache ) THEN
	ll_RowCount = sds_Cache.RowCount ( )
END IF

CHOOSE CASE ll_RowCount
CASE IS > 0
	//Proceed
CASE ELSE
	RETURN FALSE
END CHOOSE


//Try to retrieve the module list

ll_FoundRow = sds_Cache.Find ( "ss_id = 7", 1, ll_RowCount )

CHOOSE CASE ll_FoundRow
CASE IS > 0

	//A module list was found.  Parse it.

	ls_ModuleList = sds_Cache.Object.ss_string [ ll_Foundrow ]
	lnv_String.of_ParseToArray ( ls_ModuleList, ";", lsa_ModuleList )

CASE 0
	//No module list was found.  Try to retrieve the (legacy) install type.

	//This provides legacy support for some early installations that were
	//done before modularization.  These sites had a "9" in this field to
	//indicate "all modules", or a "1" to indicate log checker only.  The
	//"all" setting is translated to the modules they are used to having.
	//It does not include modules released after that.

	ll_FoundRow = sds_Cache.Find ( "ss_id = 6", 1, ll_RowCount )

	CHOOSE CASE ll_FoundRow
	CASE IS > 0

		ll_InstallType = sds_Cache.Object.ss_long [ ll_FoundRow ]

		CHOOSE CASE ll_InstallType
		CASE 9

			lsa_ModuleList = { &
				n_cst_Constants.cs_Module_ContactManager, &
				n_cst_Constants.cs_Module_OrderEntry, &
				n_cst_Constants.cs_Module_Billing, &
				n_cst_Constants.cs_Module_Brokerage, &
				n_cst_Constants.cs_Module_Dispatch, &
				n_cst_Constants.cs_Module_LogAudit, &
				n_cst_Constants.cs_Module_PCMiler }

		CASE 1
			lsa_ModuleList = { n_cst_Constants.cs_Module_LogAudit }

		CASE ELSE
			RETURN FALSE
		END CHOOSE

	CASE ELSE
		RETURN FALSE
	END CHOOSE

CASE ELSE
	RETURN FALSE
END CHOOSE


//The code below should be converted to f_array_find, or equivalent

li_Count = UpperBound ( lsa_ModuleList )
as_Module = Upper ( as_Module )

FOR li_Ndx = 1 TO li_Count
	IF as_Module = Upper ( lsa_ModuleList [ li_Ndx ] ) THEN
		RETURN TRUE
	END IF
NEXT

RETURN FALSE
end function

public function boolean of_ready ();RETURN of_Ready ( FALSE )
end function

private function integer of_setlicensed (string as_module);String	lsa_ValidModules[], &
			lsa_ModuleList[], &
			ls_ModuleList
String	ls_Null
Integer	li_Ndx, &
			li_Count, &
			li_Return
Long		ll_FoundRow

n_cst_String		lnv_String
n_cst_anyarraysrv lnv_Array

li_Return = 1

SetNull ( ls_Null )

lsa_ValidModules = ssa_DefinedModules
li_Count = si_DefinedModuleCount

CHOOSE CASE Upper ( as_Module )

CASE Upper ( "All" )  //This one may not be used anywhere?

	FOR li_Ndx = 1 TO li_Count
		of_SetLicensed ( lsa_ValidModules [ li_Ndx ] )
	NEXT

CASE Upper ( "None" )

	ll_FoundRow = of_Find ( "LicensedModules", TRUE /*InsertIfNotPresent*/ )

	IF ll_FoundRow > 0 THEN

		ls_ModuleList = ""
		sds_Cache.Object.ss_string [ ll_Foundrow ] = ls_ModuleList
		sb_Ready = FALSE

	ELSE
		li_Return = -1

	END IF

CASE ELSE

	li_Return = -1

	FOR li_Ndx = 1 TO li_Count
		IF lsa_ValidModules [ li_Ndx ] = as_Module THEN
			li_Return = 1
			EXIT
		END IF
	NEXT

	IF li_Return = 1 THEN

		li_Return = -1
		ll_FoundRow = of_Find ( "LicensedModules", TRUE )

		IF ll_FoundRow > 0 THEN

			ls_ModuleList = sds_Cache.Object.ss_string [ ll_Foundrow ]
			lnv_String.of_ParseToArray ( ls_ModuleList, ";", lsa_ModuleList )
			
			IF of_GetLicensed ( as_Module ) = FALSE THEN
				lsa_ModuleList [ UpperBound ( lsa_ModuleList ) + 1 ] = as_Module

				IF lnv_String.of_ArrayToString ( lsa_ModuleList, ";", ls_ModuleList ) = 1 THEN

					sds_Cache.Object.ss_string [ ll_FoundRow ] = ls_ModuleList
					sb_Ready = FALSE
					li_Return = 1

				END IF
				
			ELSE  // it is licensed so remove it
				
				li_count = UpperBound ( lsa_ModuleList )
				FOR li_Ndx = 1 TO li_Count
					IF lsa_ModuleList[ li_Ndx ] = as_module THEN
						lsa_ModuleList[ li_Ndx ] = ls_Null
					END IF						
				NEXT
				
				lnv_Array.of_getshrinked ( lsa_ModuleList, TRUE , TRUE )
				IF lnv_String.of_ArrayToString ( lsa_ModuleList, ";", ls_ModuleList ) = 1 THEN

					sds_Cache.Object.ss_string [ ll_FoundRow ] = ls_ModuleList
					sb_Ready = FALSE
					li_Return = 1	
				END IF
													
			END IF
		END IF

	END IF

END CHOOSE

RETURN li_Return
end function

public function integer of_initialize ();//Returns : 1 = Success, 0 = License Not Configured, -1 = Error, Could not retrieve

String	ls_Select
Long		ll_RowCount, &
			ll_FoundRow
Integer	li_Return
n_cst_Dws		lnv_Dws


//Fail, unless set otherwise

li_Return = -1


//Check whether initialization has already been performed

IF of_Ready ( ) THEN
	//Already Initialized
	li_Return = 1
	GOTO Cleanup
END IF


//Set empty values

//These two should end up elsewhere, so I've left them as globals for now.
pcms_inst = FALSE
pcmm_inst = FALSE


IF NOT IsValid ( sds_Cache ) THEN

	ls_Select = "SELECT ss_id, ss_long, ss_string, ss_date FROM system_settings "+&
		"WHERE ss_id < 20"

	sds_Cache = lnv_Dws.of_CreateDataStore ( ls_Select )

	IF NOT IsValid ( sds_Cache ) THEN
		GOTO Cleanup
	END IF

	IF NOT sds_Cache.Modify ( &
		"DataWindow.Table.UpdateTable = 'system_settings' " +&
		"DataWindow.Table.UpdateWhere = 2 " +&
		"ss_id.Key = Yes " +&
		"ss_id.Update = Yes " +&
		"ss_long.Update = Yes " +&
		"ss_string.Update = Yes " +&
		"ss_date.Update = Yes " ) = "" THEN

		GOTO Cleanup

	END IF

END IF

ll_RowCount = sds_Cache.Retrieve ( )

CHOOSE CASE ll_RowCount

CASE IS > 0

	COMMIT ;


	//Check that all required values are present

	IF of_CheckRequired ( ) = FALSE THEN
		GOTO Cleanup
	END IF


	//Determine pcms_inst (this setting should end up elsewhere)

	ll_FoundRow = sds_Cache.Find ( "ss_id = 10", 1, ll_RowCount )

	IF ll_FoundRow > 0 THEN
		IF sds_Cache.Object.ss_long [ ll_FoundRow ] = 1 THEN
			pcms_inst = TRUE
		ELSE
			pcms_inst = FALSE
		END IF
	ELSE
		//Assume false if value not present.
		pcms_inst = FALSE
	END IF


	//Determine pcmm_inst (this setting should end up elsewhere)

	ll_FoundRow = sds_Cache.Find ( "ss_id = 11", 1, ll_RowCount )

	IF ll_FoundRow > 0 THEN
		IF sds_Cache.Object.ss_long [ ll_FoundRow ] = 1 THEN
			pcmm_inst = TRUE
		ELSE
			pcmm_inst = FALSE
		END IF
	ELSE
		//Assume false if value not present.
		pcmm_inst = FALSE
	END IF

	//determine if PC*Miler-Streets is the routing package
	//system setting 86
	this.of_setpcmilerstreets()
	
	sb_Ready = TRUE
	li_Return = 1

CASE 0
	COMMIT ;
	li_Return = 0
	GOTO Cleanup
CASE ELSE
	ROLLBACK ;
	GOTO Cleanup
END CHOOSE


CleanUp:

IF li_Return = -1 THEN
	DESTROY sds_Cache
END IF

RETURN li_Return
end function

private function boolean of_ready (boolean ab_initialize);IF sb_Ready = FALSE AND &
	ab_Initialize = TRUE THEN
		of_Initialize ( )
END IF

RETURN sb_Ready
end function

public function boolean of_approveconnection ();String	ls_Message, &
			ls_MessageHeader, &
			ls_BackupPath
Integer	li_CurrentUsers
Int		li_LicUsers

Boolean	lb_DontConvert
Boolean	lb_RailTraceActive

ls_MessageHeader = "Program Registration"

CHOOSE CASE of_Initialize ( )

CASE 1
	
// ches 1999-10-25 DBModify feature //////////////////////////////// begin changes ////////////////
	long ll_expected, ll_current
	ll_expected = gnv_App.of_GetDBExpected ( )
	ll_current = of_GetDBVersion ( )

	IF ll_expected = ll_current THEN
		//Versions match.  Proceed.
	ELSE
		// If database upgrade is possible in automatic mode - prompt it!

		//Should check here if conversion from ll_Current to ll_Expected is possible --
		//since this will remain fixed until we delete ue_xxx, I think it's ok to hardwire it.
		IF ll_Current >= 10 THEN 
			//Conversion from current version is supported -- proceed.

			if this.of_DisplayConversionMessage( ls_backupPath ) = 1 then
				
				IF of_IsUpdateInProgress() THEN
					ls_Message = "Profit Tools is currently being upgraded.~r~n"+&
					"Please try to login again later."
					GOTO Reject
				END IF
				
				lb_RailTraceActive =  of_IsRailTraceActiveInbound() 
			
				IF lb_RailTraceActive THEN
					This.of_DeactivateRailTrace()
				END IF

				IF lb_RailTraceActive AND of_Asa9db() THEN
					
					//Enable the db event that activates rail trace on db startup
					//incase the upgrade fails and the backup db is restored
					This.of_AutoActivateRailTrace(TRUE)	
					
				END IF
				
				if len(ls_backupPath) > 0 then
					//Perform an automatic update of the database for ASA 9
					if this.of_BackupDatabase( ls_backupPath ) = -1 then
						//abandon conversion
						lb_DontConvert = TRUE
					end if
				end if
								
				int li_index

				IF lb_DontConvert then
					ib_Upgrade_Done = FALSE
				else
					
					IF of_IsUpdateInProgress() THEN
						ls_Message = "Profit Tools is currently being upgraded.~r~n"+&
						"Please try to login again later."
						GOTO Reject
					END IF
					
					IF This.of_FlagUpdateInProgress() = 1 THEN
					
						for li_index = ll_Current + 1 to ll_expected
		
							//Perform pre-conversion processing.
		
							ib_Upgrade_Done = TRUE
		
							this.TriggerEvent( "ue_pre_" + string(li_index) )  //Added pre option 3.0.15
		
							IF ib_Upgrade_Done = FALSE THEN
								EXIT
							END IF
		
		
							//Perform primary conversion processing.
		
							IF this.Event ue_Convert( li_index ) = 1 THEN
								//OK
							ELSE
								ib_Upgrade_Done = FALSE
								EXIT
							END IF
		
							//Perform post-conversion processing.
		
							ib_Upgrade_Done = TRUE
		
							this.TriggerEvent( "ue_post_" + string(li_index) )  //Added post option 3.0.15
		
							IF ib_Upgrade_Done = FALSE THEN
								EXIT
							END IF
							
		
							UPDATE system_settings
							SET ss_long = :li_Index 
							WHERE ss_id = 0; 
						
							if sqlca.sqlcode <> 0 then
								MessageBox( "Error", sqlca.sqlerrtext + "~n~nPlease contact Profit Tools technical support.", Exclamation! )
								ROLLBACK ;
								ib_Upgrade_Done = FALSE
								EXIT
							ELSE
								commit;
							END IF
		
						next
						
						//preform any new rt upgrades for the new version - 10/16/06
						This.TriggerEvent( "ue_post_rt_" + String(ll_expected) )
		
						
					ELSE
						ls_Message = "Your database must be updated before you can run this version "+&
										"of the program. The exclusive lock could not be applied to the DB."
						Goto Reject
					END IF
				end if
			end if

			if ib_upgrade_done then
				
				MessageBox ( "Profit Tools Version Upgrade", "Database upgrade completed successfully.  "+&
					"Enjoy your new version of Profit Tools!" )
				
				//If the rail trace was active before the upgrade....
				IF lb_RailTraceActive THEN
					
					//Disable auto activate of rail trace on db startup
					IF of_Asa9Db() THEN
						This.of_AutoActivateRailTrace(FALSE)	
					END IF
					
						
					//Update rail trace info
					SQLCA.of_RailTraceUpdate()
					
					//Reactivate RailTrace interface
					This.of_ActivateRailTrace()
						
					
				END IF
				
				//Remove lock flag
				IF This.of_FlagUpdateDone() <> 1 THEN
						
					ls_Message = "ERROR: Your database must be updated before you can run this version "+&
					"of the program. The exclusive lock could not be removed from the DB. "
					Goto Reject
						
				END IF
				
			ELSE
				
				//Attempt to remove lock flag
				This.of_FlagUpdateDone()
				
				ls_Message = "Your database must be updated before you can run this version "+&
				"of the program."
				goto Reject
		   END IF

		ELSE

			ls_Message = "Your database must be updated before you can run this version "+&
			"of the program, but these changes cannot be made automatically.  Please contact "+&
			"Profit Tools technical support."
			goto Reject
		end if
// ches 1999-10-25 DBModify feature //////////////////////////////// end changes //////////////////
	END IF
	
	//MFS 12/5/06 of_GetCurrentUsers ( ) replaced with of_GetLocalConnectionCount
	//so that we do not count the remote connections
	li_CurrentUsers = of_GetLocalConnectionCount()

	IF li_CurrentUsers > of_GetLicensedUsers ( ) OR IsNull ( li_CurrentUsers ) THEN
		ls_Message = "All licensed connections are already in use.  Another user~n"+&
			"must exit the system before you will be permitted to log on."
		GOTO Reject
	END IF

	IF of_ValidateExpiration ( ) = FALSE THEN
		ls_Message = ""
		GOTO Reject
	END IF
	
	//force a refresh of the cache
	this.of_initialize(true)
	
	//The user can choose to proceed even if module licenses aren't valid, but they're warned
	//that application functionality will be restricted.
	This.of_ValidateModuleLicenses ( )

//  this chunk was moved below
//	long ll_nextspecialops, ll_setting
//	
//	ll_nextspecialops = gnv_App.of_GetNextSpecialOPs ( )
//	ll_setting = of_GetSpecialOps ( )
//
//	IF ll_nextspecialops = ll_setting THEN
//		// Proceed.
//		
//	ELSE
//		n_cst_bso_SpecialOps_Manager	lnv_SpecialOpsManager
//		
//		lnv_SpecialOpsManager = create n_cst_bso_SpecialOps_Manager
//		
//		if lnv_SpecialOpsManager.of_initiate(ll_setting, ll_nextspecialops) = 1 then
//			UPDATE system_settings
//			SET ss_long = :ll_nextspecialops
//			WHERE ss_id = 14; 
//			commit;
//			destroy lnv_SpecialOpsManager
//		ELSE
//			destroy lnv_SpecialOpsManager
//			ls_Message = "The conversion routine must be successfully completed before running this version of the program.~n~nProgram will close."
//			MessageBox ( ls_MessageHeader, ls_Message, Exclamation! )
//			RETURN FALSE      ///////// MID CODE RETURN HERE. RATHER THAN CODE A 'GOTO'
//		end if	
//		
//	END IF

CASE 0

	//License settings have not been initialized.  Open the initialization dialog.

	Open ( w_reg_init )

	//If control returns here, initialization has been performed successfully.  Proceed.

CASE ELSE //-1
	ls_Message = "Could not verify registration information."
	GOTO Reject
END CHOOSE

// this chunk was moved for 3.9
long ll_nextspecialops, ll_setting

ll_nextspecialops = gnv_App.of_GetNextSpecialOPs ( )
ll_setting = of_GetSpecialOps ( )

IF ll_nextspecialops = ll_setting THEN
	// Proceed.
	
ELSE
	n_cst_bso_SpecialOps_Manager	lnv_SpecialOpsManager
	
	lnv_SpecialOpsManager = create n_cst_bso_SpecialOps_Manager
	
	if lnv_SpecialOpsManager.of_initiate(ll_setting, ll_nextspecialops) = 1 then
		UPDATE system_settings
		SET ss_long = :ll_nextspecialops
		WHERE ss_id = 14; 
		commit;
		destroy lnv_SpecialOpsManager
	ELSE
		destroy lnv_SpecialOpsManager
		ls_Message = "The conversion routine must be successfully completed before running this version of the program.~n~nProgram will close."
		MessageBox ( ls_MessageHeader, ls_Message, Exclamation! )
		RETURN FALSE      ///////// MID CODE RETURN HERE. RATHER THAN CODE A 'GOTO'
	end if	
	
END IF

// end of Chunk
of_EmailVersionChange()

RETURN TRUE


Reject:
IF Len ( ls_Message ) > 0 THEN
	ls_Message += "~n~nProgram will close."
	MessageBox ( ls_MessageHeader, ls_Message, Exclamation! )
END IF

//Halt Close

RETURN FALSE
end function

public function long of_getdbversion ();Long	ll_FoundRow, ll_DBVersion
ll_FoundRow = of_Find ( "DBVersion", FALSE )
IF ll_FoundRow > 0 THEN
	ll_DBVersion = sds_Cache.Object.ss_long [ ll_FoundRow ]
ELSE
	SetNull ( ll_DBVersion )
END IF

// ches 1999-10-25 DBModify feature ////////////////////////////////
if not IsNull(ll_DBVersion) and ll_DBVersion = 10 then
	// Need to determine current version more carefully
	declare test_cursor dynamic cursor FOR sqlsa;
	prepare sqlsa from "select count(NextId) from NextIds";
	open dynamic test_cursor;
	if sqlca.sqlcode = 0 then
		ll_DBVersion = 11
		close test_cursor;
	end if
end if
// ches 1999-10-25 DBModify feature ////////////////////////////////

RETURN ll_DBVersion
end function

public function long of_getlicensedusers ();Long	ll_FoundRow, &
		ll_LicensedUsers

ll_FoundRow = of_Find ( "LicensedUsers", FALSE )

IF ll_FoundRow > 0 THEN
	ll_LicensedUsers = sds_Cache.Object.ss_long [ ll_FoundRow ]
ELSE
	SetNull ( ll_LicensedUsers )
END IF

RETURN ll_LicensedUsers
end function

public function integer of_getcurrentusers ();Integer	li_CurrentUsers

SELECT Convert ( SmallInt, DB_Property ( 'ConnCount' ) ) INTO :li_CurrentUsers FROM Dummy ;

//"dummy" is recognized by SQL.  Using it here gives a SQLCode of 0, while substituting
//a real table name gives -1.

IF SQLCA.SqlCode <> 0 THEN
	ROLLBACK ;
	SetNull ( li_CurrentUsers )
ELSE
	COMMIT ;
END IF

RETURN li_CurrentUsers
end function

private function boolean of_validateexpiration ();Integer	li_DaysRemaining
String	ls_Message, &
			ls_MessageHeader = "Program Registration"
Boolean	lb_ScheduledTask

IF isValid ( gnv_app ) THEN
	lb_ScheduledTask = gnv_app.of_runningscheduledtask( )
END IF

IF NOT of_Ready ( ) THEN
	RETURN FALSE
END IF

li_DaysRemaining = of_GetDaysRemaining ( )


IF li_DaysRemaining < 8 THEN

	ls_Message = of_GetExpirationNotice ( )

	IF li_DaysRemaining < 0 THEN

		ls_Message += "You must contact Profit Tools for a registration renewal code "+&
			"in order to continue using the program.~n~nDo you want to perform the "+&
			"registration renewal procedure now?"

		IF MessageBox ( ls_MessageHeader, ls_Message, Question!, YesNo!, 1 ) = 2 THEN

			RETURN FALSE

		ELSE

			Open ( w_reg_adjust )//comment by liulihua

			//See if the user actually extended their license while in the window, 
			//and notify and return accordingly.
			
			li_DaysRemaining = This.of_GetDaysRemaining ( )
			//li_DaysRemaining = 100 //add by liulihua
			IF li_DaysRemaining >= 0 THEN
				RETURN TRUE
			ELSE
				MessageBox ( ls_MessageHeader, "You must perform the registration procedure "+&
					"before using Profit Tools.  Program will close." )
				RETURN FALSE
			END IF

		END IF

	ELSE
		IF NOT lb_ScheduledTask THEN  // don't pop the warning if we are running a scheduled task.
			ls_Message += "~n~nPlease contact Profit Tools for a registration renewal code."
	
			IF li_DaysRemaining < 2 THEN
				MessageBox ( ls_MessageHeader, ls_Message, Exclamation! )
			ELSE
				MessageBox ( ls_MessageHeader, ls_Message )
			END IF
		END IF

	END IF

END IF

RETURN TRUE
end function

public function string of_getlicensedcompany ();Long		ll_FoundRow
String	ls_LicensedCompany

ll_FoundRow = of_Find ( "LicensedCompany", FALSE )

IF ll_FoundRow > 0 THEN
	ls_LicensedCompany = sds_Cache.Object.ss_string [ ll_FoundRow ]
ELSE
	SetNull ( ls_LicensedCompany )
END IF

RETURN ls_LicensedCompany
end function

public function integer of_initialize (boolean ab_forcerefresh);IF ab_ForceRefresh THEN
	sb_Ready = FALSE
END IF

RETURN of_Initialize ( )
end function

public function string of_getexpirationnotice ();Date		ld_LicenseExpiration
Integer	li_DaysRemaining
String	ls_Notice

IF of_Ready ( ) THEN

	ld_LicenseExpiration = of_GetLicenseExpiration ( )
	li_DaysRemaining = of_GetDaysRemaining ( )

	ls_Notice = "Your current program registration expire"

	IF li_DaysRemaining < 0 THEN
		ls_Notice += "d "
	ELSE
		ls_Notice += "s "
	END IF

	IF li_DaysRemaining = 0 THEN
		ls_Notice += "today.  "
	ELSE
		ls_Notice += "on " + String ( ld_LicenseExpiration, "dddd, mmmm d" ) + ".  "
//		ls_Notice += "on " + String ( ld_LicenseExpiration, "m/d/yy (Dddd)" ) + ".  "
	END IF

ELSE
	SetNull ( ls_Notice )
END IF

RETURN ls_Notice
end function

private function integer of_getdaysremaining ();Integer	li_DaysRemaining
Date		ld_LicenseExpiration

IF of_Ready ( ) THEN
	ld_LicenseExpiration = of_GetLicenseExpiration ( )
	li_DaysRemaining = DaysAfter ( Today ( ), ld_LicenseExpiration )
ELSE
	SetNull ( li_DaysRemaining )
END IF

RETURN li_DaysRemaining
end function

public function boolean of_getlicenseexpired ();Boolean	lb_LicenseExpired

IF of_GetDaysRemaining ( ) >= 0 THEN
	lb_LicenseExpired = FALSE
ELSE
	lb_LicenseExpired = TRUE
END IF

RETURN lb_LicenseExpired
end function

private function boolean of_checkrequired ();//Check for DBVersion
IF IsNull ( of_GetDBVersion ( ) ) THEN
	GOTO Failure
END IF

//Check for LicensedUsers
IF IsNull ( of_GetLicensedUsers ( ) ) THEN
	GOTO Failure
END IF

//Check for LicenseStart
IF IsNull ( of_GetLicenseStart ( ) ) THEN
	GOTO Failure
END IF

//Check for LicenseExpiration
IF IsNull ( of_GetLicenseExpiration ( ) ) THEN
	GOTO Failure
END IF

//Check for LicensedCompany
IF IsNull ( of_GetLicensedCompany ( ) ) THEN
	GOTO Failure
END IF

//Check for BaseTimeZone
IF IsNull ( of_GetBaseTimeZone ( ) ) THEN
	GOTO Failure
END IF

RETURN TRUE

Failure:
RETURN FALSE
end function

public function integer of_setlicensestart (date ad_licensestart);//This will attempt to set a value on the cache.  If the row is not already on the 
//cache, the call to of_Find with InsertIfNotPresent = TRUE will insert a row with
//the correct id.  If the set succeeds, sb_Ready will be set to false, indicating
//that updates have been made to the cache but not yet saved to the db.

Long	ll_FoundRow
Integer	li_Return

ll_FoundRow = of_Find ( "LicenseStart", TRUE /*InsertIfNotPresent*/ )

IF ll_FoundRow > 0 THEN
	sds_Cache.Object.ss_date [ ll_FoundRow ] = ad_LicenseStart
	sb_Ready = FALSE
	li_Return = 1
ELSE
	li_Return = -1
END IF

RETURN li_Return
end function

private function long of_find (string as_setting, boolean ab_insert);//Returns : Row if setting is found (or added), 0 if setting is not found (and not added),
//	and -1 if and Error occurs (including an invalid setting request)

Long	ll_FoundRow
Integer	li_Id
String	ls_Find

CHOOSE CASE Upper ( as_Setting )

CASE Upper ( "DBVersion" )
	li_Id = 0

CASE Upper ( "LicenseStart" )
	li_Id = 3

CASE Upper ( "LicenseExpiration" )
	li_Id = 4

CASE Upper ( "LicensedUsers" )
	li_Id = 5

CASE Upper ( "LicensedCompany" )
	li_Id = 1

CASE Upper ( "BaseTimeZone" )
	li_Id = 2

CASE Upper ( "LicensedModules" )
	li_Id = 7

CASE Upper ( "SpecialOps" )
	li_id = 14
	
CASE Upper ( "AppVersion" )
	li_id = 15
	
CASE ELSE
	RETURN -1

END CHOOSE

ls_Find = "ss_id = " + String ( li_Id )

IF IsValid ( sds_Cache ) THEN

	ll_FoundRow = sds_Cache.Find ( ls_Find, 1, sds_Cache.RowCount ( ) )

	IF ll_FoundRow = 0 AND ab_Insert THEN

		ll_FoundRow = sds_Cache.InsertRow ( 0 )

		IF ll_FoundRow > 0 THEN

			sds_Cache.Object.ss_id [ ll_FoundRow ] = li_Id

		END IF

	END IF

END IF

n_cst_numerical lnv_numerical
IF lnv_numerical.of_IsNullOrNeg ( ll_FoundRow ) THEN
	ll_FoundRow = -1
END IF

RETURN ll_FoundRow
end function

public function integer of_setlicenseexpiration (date ad_licenseexpiration);//This will attempt to set a value on the cache.  If the row is not already on the 
//cache, the call to of_Find with InsertIfNotPresent = TRUE will insert a row with
//the correct id.  If the set succeeds, sb_Ready will be set to false, indicating
//that updates have been made to the cache but not yet saved to the db.

Long	ll_FoundRow
Integer	li_Return

ll_FoundRow = of_Find ( "LicenseExpiration", TRUE /*InsertIfNotPresent*/ )

IF ll_FoundRow > 0 THEN
	sds_Cache.Object.ss_date [ ll_FoundRow ] = ad_LicenseExpiration
	sb_Ready = FALSE
	li_Return = 1
ELSE
	li_Return = -1
END IF

RETURN li_Return
end function

public function integer of_setlicensedcompany (string as_licensedcompany);//This will attempt to set a value on the cache.  If the row is not already on the 
//cache, the call to of_Find with InsertIfNotPresent = TRUE will insert a row with
//the correct id.  If the set succeeds, sb_Ready will be set to false, indicating
//that updates have been made to the cache but not yet saved to the db.

Long	ll_FoundRow
Integer	li_Return

IF Len ( Trim ( as_LicensedCompany ) ) > 0 THEN

	ll_FoundRow = of_Find ( "LicensedCompany", TRUE /*InsertIfNotPresent*/ )

END IF

IF ll_FoundRow > 0 THEN
	sds_Cache.Object.ss_string [ ll_FoundRow ] = as_LicensedCompany
	sb_Ready = FALSE
	li_Return = 1
ELSE
	li_Return = -1
END IF

RETURN li_Return
end function

public function integer of_setlicensedusers (long al_licensedusers);//This will attempt to set a value on the cache.  If the row is not already on the 
//cache, the call to of_Find with InsertIfNotPresent = TRUE will insert a row with
//the correct id.  If the set succeeds, sb_Ready will be set to false, indicating
//that updates have been made to the cache but not yet saved to the db.

Long	ll_FoundRow
Integer	li_Return

ll_FoundRow = of_Find ( "LicensedUsers", TRUE /*InsertIfNotPresent*/ )

IF ll_FoundRow > 0 THEN
	sds_Cache.Object.ss_long [ ll_FoundRow ] = al_LicensedUsers
	sb_Ready = FALSE
	li_Return = 1
ELSE
	li_Return = -1
END IF


RETURN li_Return
end function

public function integer of_setdbversion (long al_dbversion);//This will attempt to set a value on the cache.  If the row is not already on the 
//cache, the call to of_Find with InsertIfNotPresent = TRUE will insert a row with
//the correct id.  If the set succeeds, sb_Ready will be set to false, indicating
//that updates have been made to the cache but not yet saved to the db.

Long	ll_FoundRow
Integer	li_Return

ll_FoundRow = of_Find ( "DBVersion", TRUE /*InsertIfNotPresent*/ )

IF ll_FoundRow > 0 THEN
	sds_Cache.Object.ss_long [ ll_FoundRow ] = al_DBVersion
	sb_Ready = FALSE
	li_Return = 1
ELSE
	li_Return = -1
END IF

RETURN li_Return
end function

public function string of_generaterequestcode ();string base_str, rstr1, rstr2, workstr
Date	ld_LicenseExpiration, base_date
Long	ll_LicensedUsers
u_Code_Proc	lnv_Codes

ld_LicenseExpiration = of_GetLicenseExpiration ( )
IF IsNull ( ld_LicenseExpiration ) THEN
	ld_LicenseExpiration = Date ( DateTime ( Today ( ) ) )
END IF

ll_LicensedUsers = of_GetLicensedUsers ( )
IF IsNull ( ll_LicensedUsers ) THEN
	ll_LicensedUsers = 0
END IF

base_date = ld_LicenseExpiration
base_str = string(base_date, "mmddyy") + string(ll_LicensedUsers, "00")

rstr1 = left(string(rand(999), "000"), 1) + mid(string(rand(999), "000"), 2, 1) +&
	right(string(rand(999), "000"), 1)
rstr2 = left(string(rand(999), "000"), 1) + mid(string(rand(999), "000"), 2, 1) +&
	right(string(rand(999), "000"), 1)

workstr = right(string(lnv_Codes.process_c(base_str, 6) + lnv_Codes.process_c(rstr1 + rstr2, 1)), 1) +&
	rstr1 + right(string(lnv_Codes.process_c(base_str, 1) + integer(mid(rstr1, 1, 1))), 1) +&
	rstr2 + right(string(lnv_Codes.process_c(base_str, 2) + integer(mid(rstr2, 3, 1))), 1)

workstr = lnv_Codes.process_d(lnv_Codes.process_a(workstr, 6), 4)

RETURN workstr

/*   //////////

string rstr
rstr = rstr1 + rstr2
integer actval = 14

workstr = ""

workstr += right(string(integer(right(string(lnv_Codes.process_c(rstr, 1)), 1)) +&
	integer(mid(lnv_Codes.process_a(rstr2 + rstr1, integer(mid(rstr2, 2, 1))), 3, 3))), 1)

workstr += right(string(lnv_Codes.process_g(rstr, 5) + integer(rstr2) * day(base_date)), 1)

workstr += right(string(lnv_Codes.process_f(string(base_date, "yyddmm") + rstr1 +&
	string(ll_LicensedUsers, "00"), 3)), 1)

workstr += string(mod(actval + integer(mid(rstr, 3, 3)), 1000), "000")
//workstr += string(mod(actval + 100, 1000), "000")
//workstr += right(string(actval + 200, "000"), 3)

workstr += left(string(long(rstr) + abs(lnv_Codes.process_g(string(year(base_date) * actval), actval) +&
	lnv_Codes.process_f(string(lnv_Codes.process_c(string(actval + day(base_date)), 1) * integer(rstr1) * &
	month(relativedate(base_date, fact(integer(mid(rstr2, 2, 1)))))), 2)), "000"), 3)

workstr = lnv_Codes.process_d(lnv_Codes.process_a(lnv_Codes.process_a(workstr, 5), 3), 4)

sle_rk_entry.text = workstr
//st_cn_disp.text = rstr1 + " " + rstr2

//messagebox("Your Reg Key Is...", workstr)

*/   ///////////
end function

public function integer of_processregistrationkey (string as_requestcode, string as_registrationkey);//RETURN -1 //comment by liulihua
RETURN 1 //add by liulihua
end function

public function integer of_setbasetimezone (integer ai_basetimezone);//This will attempt to set a value on the cache.  If the row is not already on the 
//cache, the call to of_Find with InsertIfNotPresent = TRUE will insert a row with
//the correct id.  If the set succeeds, sb_Ready will be set to false, indicating
//that updates have been made to the cache but not yet saved to the db.

Long	ll_FoundRow
Integer	li_Return

IF ai_BaseTimeZone >= 0 THEN

	ll_FoundRow = of_Find ( "BaseTimeZone", TRUE /*InsertIfNotPresent*/ )

END IF

IF ll_FoundRow > 0 THEN
	sds_Cache.Object.ss_long [ ll_FoundRow ] = ai_BaseTimeZone
	sb_Ready = FALSE
	li_Return = 1
ELSE
	li_Return = -1
END IF

RETURN li_Return
end function

public function integer of_getbasetimezone ();Long		ll_FoundRow
Integer	li_BaseTimeZone

ll_FoundRow = of_Find ( "BaseTimeZone", FALSE )

IF ll_FoundRow > 0 THEN
	li_BaseTimeZone = sds_Cache.Object.ss_long [ ll_FoundRow ]
ELSE
	SetNull ( li_BaseTimeZone )
END IF

RETURN li_BaseTimeZone
end function

public function integer of_update ();//Returns : 1 = Success, 0 = No attempt made ( required values missing), -1 = Error

Long	ll_FoundRow

//Verify that all required values have been supplied

IF of_CheckRequired ( ) = FALSE THEN
	RETURN 0
END IF


//Determine whether this is an initial update, and if so, call the initialization script

ll_FoundRow = of_Find ( "DBVersion", FALSE )

IF ll_FoundRow > 0 THEN

	CHOOSE CASE sds_Cache.GetItemStatus ( ll_FoundRow, 0, Primary! )

	CASE New!, NewModified!
		
		//Need to initialize the database
			
		IF of_DBInit ( ) = -1 THEN
			GOTO RollItBack
		END IF
				
	END CHOOSE

ELSE
	GOTO RollItBack
END IF

//Attempt to update the cache
//Note:  This used to PRECEDE the call to dbinit, above, but the order was reversed
//in 3.9.00 to handle the need to set a value for SpecialOps on the cache in dbinit, in addition
//to making SQL inserts
IF sds_Cache.Update ( FALSE, FALSE ) = -1 THEN
	GOTO RollItBack
END IF


COMMIT ;

IF SQLCA.SqlCode <> 0 THEN
	GOTO RollItBack
END IF

sds_Cache.ResetUpdate ( )
sb_Ready = TRUE

RETURN 1

RollItBack:
ROLLBACK ;
RETURN -1
end function

private function integer of_dbinit ();//Returns : 1 if it succeeds, -1 if it doesn't

//NOTE!!!! : This function does not perform a commit or rollback - it expects the
//  calling script ( of_Update ) to do that.

//Note : DBVersion for a newly initialized db is currently being set in cb_Next
//in w_reg_init, along with LicensedCompany, BaseTimeZone, and LicenseStart.
//It is set to whatever the value for DBExpected is  (assumes the clean target db
//has the structure the app version expects as DBExpected)


//Is PC*Miler Server Installed (0 = No; 1 = Yes)
insert into system_settings (ss_id, ss_long) values (10, 0) ;
if sqlca.sqlcode <> 0 then goto rollitback

//Is PC*Miler Mapping Installed (0 = No; 1 = Yes)
insert into system_settings (ss_id, ss_long) values (11, 0) ;
if sqlca.sqlcode <> 0 then goto rollitback

//Settings added in version 3.9.00 for DBInit to DBVersion 77 
// this covers the changes needed for specialops 1

// add the required amount types

INSERT INTO amounttype ( id, name, Category, TypicalAmount, TaxableDefault, Tag, ItemType, Surcharge, sendnotification ) &
VALUES ( 1 , 'FREIGHT' , 3 , 1, 0 , NULL, 'L', 'T', 'F' );
if sqlca.sqlcode <> 0 then goto rollitback

INSERT INTO amounttype ( id, name, Category, TypicalAmount, TaxableDefault, Tag, ItemType, Surcharge, sendnotification ) &
VALUES ( 2 , 'ACCESSORIAL' , 3 , 1, 0 , NULL, 'A', 'N', 'F' );
if sqlca.sqlcode <> 0 then goto rollitback

INSERT INTO amounttype ( id, name, Category, TypicalAmount, TaxableDefault, Tag, ItemType, Surcharge, sendnotification ) &
VALUES ( 3 , 'FUEL SURCHARGE' , 3 , 1, 0 , NULL, 'A', 'N', 'F' );
if sqlca.sqlcode <> 0 then goto rollitback

// add the fsc entry into the ratetable
INSERT INTO ratetable  ( codename, name, defaultdescription, breakunit, amounttype ) &  
VALUES ( 'FSC', 'Fuel Surcharge',  null, null, 3 )  ;
if sqlca.sqlcode <> 0 then goto rollitback

// update the next id for the amount type changes made above
INSERT INTO nextids ( classid, nextid )  VALUES ( 3, 4 )  ;
if sqlca.sqlcode <> 0 then goto rollitback

// update the next id for the Rate Code Name
INSERT INTO nextids ( classid, nextid )  VALUES ( 14, 3 )  ;
if sqlca.sqlcode <> 0 then goto rollitback

// Default accessorial amount type
// 1 is the amountTypeid in the amountType table.
insert into system_settings (ss_id, ss_long) values (98, 1) ;
if sqlca.sqlcode <> 0 then goto rollitback

// Default Freight amount type
// 2 is the amountTypeid in the amountType table.
insert into system_settings (ss_id, ss_long) values (99, 2) ;
if sqlca.sqlcode <> 0 then goto rollitback

// sets the specialops value to reflect the changes made above.
IF THIS.of_SetSpecialops( 1 ) <> 1 THEN
	goto rollitback			
END IF
//END of the Settings added in version 3.9.00 for DBInit to DBVersion 75


//Log Checker: Is lockdate feature on or off (0 = No; 1 = Yes)
insert into system_settings (ss_id, ss_long) values (10002, 0) ;
if sqlca.sqlcode <> 0 then goto rollitback

//Log Checker: Lockdate number of days
insert into system_settings (ss_id, ss_long) values (10003, 14) ;
if sqlca.sqlcode <> 0 then goto rollitback

//Log Checker: Minimum MPH Constant
insert into system_settings (ss_id, ss_long) values (10010, 20) ;
if sqlca.sqlcode <> 0 then goto rollitback

//Log Checker: Maximum MPH Constant
insert into system_settings (ss_id, ss_long) values (10011, 55) ;
if sqlca.sqlcode <> 0 then goto rollitback

//User Class Setup
insert into system_settings (ss_id, ss_string) values (1001, 'NON-USER') ;
if sqlca.sqlcode <> 0 then goto rollitback

//User Class Setup
insert into system_settings (ss_id, ss_string) values (1002, 'LOOKUP') ;
if sqlca.sqlcode <> 0 then goto rollitback

//User Class Setup
insert into system_settings (ss_id, ss_string) values (1003, 'ENTRY') ;
if sqlca.sqlcode <> 0 then goto rollitback

//User Class Setup
insert into system_settings (ss_id, ss_string) values (1004, 'AUDIT') ;
if sqlca.sqlcode <> 0 then goto rollitback

//User Class Setup
insert into system_settings (ss_id, ss_string) values (1005, 'ADMINISTRATIVE') ;
if sqlca.sqlcode <> 0 then goto rollitback

//User Class Privileges Setup

long set_9[7], set_19[8], set_29[9], set_id, set_uid, setloop

for set_uid = -1001 to -1005 step -1
	choose case set_uid
	case -1001
		set_9 =  {0, 0, 0, 0, 0, 0, 0}
		set_19 = {0, 0, 0, 0, 0, 0, 0, 0}
		set_29 = {0, 0, 0, 0, 0, 0, 0, 0, 0}
	case -1002
		set_9 =  {1, 0, 0, 0, 0, 0, 0}
		set_19 = {1, 1, 0, 0, 0, 0, 0, 0}
		set_29 = {0, 0, 0, 0, 0, 0, 0, 0, 0}
	case -1003
		set_9 =  {1, 0, 0, 0, 0, 0, 0}
		set_19 = {1, 1, 1, 0, 0, 0, 0, 0}
		set_29 = {0, 0, 0, 0, 0, 0, 1, 1, 0}
	case -1004
		set_9 =  {1, 1, 0, 0, 0, 0, 0}
		set_19 = {1, 1, 1, 1, 0, 0, 0, 1}
		set_29 = {1, 1, 1, 1, 0, 0, 1, 1, 1}
	case -1005
		set_9 =  {1, 1, 1, 1, 1, 1, 1}
		set_19 = {1, 1, 1, 1, 1, 1, 1, 1}
		set_29 = {1, 1, 1, 1, 1, 1, 1, 1, 1}
	end choose
	for setloop = 1 to 7
		set_id = 9000 + setloop
		insert into system_settings (ss_id, ss_uid, ss_long)
			values (:set_id, :set_uid, :set_9[setloop]) ;
		if sqlca.sqlcode <> 0 then goto rollitback
	next
	for setloop = 1 to 8
		set_id = 19000 + setloop
		insert into system_settings (ss_id, ss_uid, ss_long)
			values (:set_id, :set_uid, :set_19[setloop]) ;
		if sqlca.sqlcode <> 0 then goto rollitback
	next
	for setloop = 1 to 9
		set_id = 29000 + setloop
		insert into system_settings (ss_id, ss_uid, ss_long)
			values (:set_id, :set_uid, :set_29[setloop]) ;
		if sqlca.sqlcode <> 0 then goto rollitback
	next
next

//Add PTADMIN user
insert into employees (em_id, em_ref, em_password, em_status, em_type, em_class)
	values (10000, 'PTADMIN', 'TRUCKS', 'K', 0, 1005) ;
if sqlca.sqlcode <> 0 then goto rollitback


RETURN 1

RollItBack:
RETURN -1
end function

public function integer of_getmoduledisplaylist (ref string asa_displaylist[]);//Returns :  Display Module Count (>=0), or -1 for error

String	lsa_DisplayList[]
Integer	li_DisplayCount, &
			li_Check

FOR li_Check = 1 TO si_DefinedModuleCount

	IF of_GetLicensed ( ssa_DefinedModules [ li_Check ] ) THEN

		li_DisplayCount ++
		lsa_DisplayList [ li_DisplayCount ] = of_GetDisplayName ( ssa_DefinedModules [ li_Check ] )

	END IF

NEXT

asa_DisplayList = lsa_DisplayList

RETURN li_DisplayCount
end function

public function integer of_getmoduledisplaycount ();//A wrapper function for when the user only wants the count, and not the list.

String	lsa_ModuleDisplayList[]

RETURN of_GetModuleDisplayList ( lsa_ModuleDisplayList )
end function

public function boolean of_getlicensed (integer ai_module);RETURN of_GetLicensed ( of_Convert ( ai_Module ) )
end function

private function string of_convert (integer ai_module);CHOOSE CASE ai_Module

CASE n_cst_Constants.ci_Module_ContactManager
	RETURN n_cst_Constants.cs_Module_ContactManager

CASE n_cst_Constants.ci_Module_OrderEntry
	RETURN n_cst_Constants.cs_Module_OrderEntry

CASE n_cst_Constants.ci_Module_Billing
	RETURN n_cst_Constants.cs_Module_Billing

CASE n_cst_Constants.ci_Module_Brokerage
	RETURN n_cst_Constants.cs_Module_Brokerage

CASE n_cst_Constants.ci_Module_Dispatch
	RETURN n_cst_Constants.cs_Module_Dispatch

CASE n_cst_Constants.ci_Module_LogAudit
	RETURN n_cst_Constants.cs_Module_LogAudit

CASE n_cst_Constants.ci_Module_PCMiler
	RETURN n_cst_Constants.cs_Module_PCMiler

END CHOOSE
end function

public subroutine of_displaymodulenotice (string as_messageheader);MessageBox ( as_MessageHeader, "Your current license does not include the "+&
	"modules required to perform this function.~n~nRequest cancelled." )
end subroutine

public function string of_getdisplayname (readonly string as_module);//This method allows us to specify a display name for each module that is different
//from the internal name used to record it in the database.  This override is optional.
//If no override is provided, the db name will be used as the display name.

String	ls_DisplayName

CHOOSE CASE as_Module

CASE n_cst_Constants.cs_Module_ContactManager
	ls_DisplayName = "Contact Manager"

CASE n_cst_Constants.cs_Module_OrderEntry
	ls_DisplayName = "Order Entry"

CASE n_cst_Constants.cs_Module_Billing
	ls_DisplayName = "Billing"

CASE n_cst_Constants.cs_Module_Brokerage
	ls_DisplayName = "Broker / Forwarder"

CASE n_cst_Constants.cs_Module_Dispatch
	ls_DisplayName = "Dispatcher"

CASE n_cst_Constants.cs_Module_LogAudit
	ls_DisplayName = "Log Auditor"

CASE n_cst_Constants.cs_Module_PCMiler
	ls_DisplayName = "PC*Miler Interface"

CASE n_cst_Constants.cs_Module_FuelCard
	ls_DisplayName = "Fuel Card Interfaces"

CASE n_cst_Constants.cs_Module_Imaging
	ls_DisplayName = "Document Imaging"

CASE n_cst_Constants.cs_Module_RailTrace
	ls_DisplayName = "Rail Trace"

CASE ELSE
	ls_DisplayName = as_Module

END CHOOSE

RETURN ls_DisplayName
end function

public subroutine of_apply_sqlscript (string as_filename);// Make some preparation
n_cst_filesrv lnv_filesrv
lnv_filesrv = Create n_cst_filesrvwin32
blob lblb_data
long ll_size
// Open and read script file
ll_size = lnv_filesrv.of_FileRead( as_filename, lblb_data )
if ll_size < 1 then
	MessageBox( "Error", "Cannot open file '" + as_filename + "'!", StopSign! )
	goto cleanup
end if
this.of_Apply_SQLString( string( lblb_data ) )

cleanup:
	Destroy lnv_filesrv

end subroutine

public subroutine of_apply_sqlstring (string as_sqlstring);// Make some preparation
n_cst_string lnv_string
long ll_size, ll_index
string lsa_expressions[]

ib_upgrade_done = FALSE

ll_Size = lnv_string.of_ParseToExpressions( as_sqlstring, "/", "'", lsa_expressions )

if ll_size < 1 then
	MessageBox( "Error", "SQL File doesn't contain commands!", Exclamation! )
	return
end if

for ll_index = 1 to ll_size

	lnv_string.of_GlobalReplace( lsa_expressions[ll_index], "~n", " " )
	lnv_string.of_GlobalReplace( lsa_expressions[ll_index], "~r", " " )
	lsa_expressions[ll_index] = RightTrim(LeftTrim( lsa_expressions[ll_index] ))

	// If sql expression is possible valid
	if not IsNull(lsa_expressions[ll_index]) and Len(lsa_expressions[ll_index]) > 1 then

		if IsValid( w_upgrade ) then
			w_upgrade.st_message.Text = "Processing Step " + string(ll_index) + " of " + String ( ll_Size ) + "..."
		end if

		// Execute it!

		execute immediate :lsa_expressions[ll_index] using sqlca;
		if sqlca.sqlcode <> 0 then
			MessageBox( "Error", sqlca.sqlerrtext + "~n~nPlease contact Profit Tools technical support.", Exclamation! )
			return
		end if

	end if
next

commit;
ib_upgrade_done = TRUE

end subroutine

public function integer of_deletemodulelocks ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_DeleteModuleLocks
//
//	Access:  public
//
//	Arguments:  None
//
//	Returns:  Integer
//					0 no action
//					1 success			
//				  -1 failure
//
//	Description:	Delete all rows from the ModuleLock table for the 
//						machine that is running the application.
//
// Written by: Norm LeBlanc
// 		Date: 8/23/00
//		Version: 3.0
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////
integer	li_Return
string 	ls_ComputerName

n_cst_platformwin32 lnv_platform

lnv_platform = create n_cst_platformwin32
ls_ComputerName = lnv_platform.of_getcomputername()

IF Len ( ls_ComputerName ) > 0 THEN

	DELETE FROM "modulelocks"  
	   WHERE "modulelocks"."machinename" = :ls_ComputerName   ;
	
	CHOOSE CASE SQLCA.SqlCode
	
	CASE 0
		COMMIT ;
		li_Return = 1
	
	CASE 100
		COMMIT ;
		li_Return = 0
	
	CASE ELSE
		ROLLBACK ;
		li_Return = -1
	
	END CHOOSE
	
ELSE
	li_Return = 0
	
END IF

destroy lnv_platform

Return li_Return


end function

public function integer of_getmodulelock (string as_modulename, string as_messagetype);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetModuleLock
//
//	Access:  public
//
//	Arguments:  as_ModuleName
//
//	Returns:  Integer
//					0 no action already locked
//					1 success			
//				  -1 failure
//
//	Description: First make sure that the user doesn't already have a lock
//					for the requested module on the current machine. If there
//					isn't a lock attempt	to insert a row into the ModuleLock table.
//					Test for a successful insert ( there may not be any available).
//
// Written by: Norm LeBlanc
// 		Date: 8/23/00
//		Version: 3.0
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////

integer	li_Return
string 	ls_ComputerName, &
			ls_Module, &
			ls_UserId, &
			ls_MessageTitle
boolean	lb_HasLock			
Long		lla_sourceIds[]

n_cst_platformwin32 lnv_platform

//added by dan 7-26-06
n_cst_errorlog		lnv_error
n_cst_errorlog_manager	lnv_errorlogmanager
lnv_errorlogmanager = create n_cst_errorlog_manager
//-----------------------


lnv_platform = create n_cst_platformwin32
ls_ComputerName = lnv_platform.of_getcomputername()
ls_UserId = gnv_app.of_GetUserID ( )
ls_MessageTitle = as_modulename + " module"


choose case as_ModuleName

	case n_cst_constants.cs_Module_Brokerage, n_cst_constants.cs_Module_Dispatch

		IF this.Of_HasModuleLock ( n_cst_constants.cs_Module_Billing ) THEN
			
			li_Return = 0
			lb_HasLock = TRUE
			
		ELSEIF this.Of_HasModuleLock ( n_cst_constants.cs_Module_Settlements ) THEN
			
			li_Return = 0
			lb_HasLock = TRUE
			
		END IF 

end choose

IF lb_HasLock = FALSE THEN
	IF Len ( ls_ComputerName ) > 0 THEN
	
		choose case SQLCA.of_GetModuleLock ( ls_ComputerName, as_ModuleName, ls_UserId )

			case 0	//user already has a lock for the requested module
				li_Return = 0

			case 1	//successful lock for the requested module
				li_Return = 1

			case else 
				choose case as_MessageType
					case "E"	//enter into module
						//added by Dan 7-26-06  to stop messagebox from popping up if scheduled task is running
						//this function is called by appeon_constant.of_hasautorate()
						IF gnv_App.of_Runningscheduledtask( ) THEN
							lnv_error = CREATE n_cst_errorlog	
							lnv_error.of_setlogdata( "Get Module Lock", "Scheduled Task Module Lock",  String(Today(), "m/d/yy hh:mm")+"All licenses for the " + as_modulename + &
																		" module are currently in use by users.~r~n " + &
																		"A user must release their lock before scheduled tasks can enter this module.~r~nIt is likely a shipment wasn't autorated." , 1, lla_sourceIds[], "n_cst_errorremedy")
							lnv_errorLogManager.of_logerror( lnv_error )
							Destroy lnv_error
						ELSE
							MessageBox ( ls_MessageTitle, "All licenses for the " + as_modulename + &
							" module are currently in use by other users. " + &
							" Another user must release their lock before you can enter this module." )
						END IF
					case "S"	//save in module
						//----------------------added by Dan 7-26-06
						IF gnv_App.of_Runningscheduledtask( ) THEN
							lnv_error = CREATE n_cst_errorlog	
							lnv_error.of_setlogdata( "Get Module Lock", "Scheduled Task Module Lock",  String(Today(), "m/d/yy hh:mm")+"All licenses for the " + as_modulename + &
																			" module are currently in use by users.~r~n" + &
																			"A user must release their lock before scheduled tasks can enter this module.~r~nIt is likely a shipment wasn't autorated." , 1, lla_sourceIds[], "n_cst_errorremedy")
							lnv_errorLogManager.of_logerror( lnv_error )
							Destroy lnv_error
						ELSE
							MessageBox ( ls_MessageTitle, "All licenses for the " + as_modulename + &
							" module are currently in use by other users. You will not be able to save" + &
							" your changes until another user has released their lock on this module." )
						
						END IF
				end choose
				
				li_Return = -1

		end choose
		
	ELSE
		li_Return = -1
		
	END IF

END IF


destroy lnv_platform
destroy lnv_errorlogmanager

Return li_Return

end function

public function boolean of_hasmodulelock (string as_modulename);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_HasModuleLock
//
//	Access:  public
//
//	Arguments:  as_ModuleName
//
//	Returns:  Boolean
//
//	Description: 
//
//
// Written by: Norm LeBlanc
// 		Date: 8/23/00
//		Version: 3.0
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////
integer	li_Return, &
			li_RetVal
string 	ls_ComputerName, &
			ls_Module, &
			ls_UserId, &
			ls_ModuleName
Boolean	lb_Return = FALSE

n_cst_platformwin32 lnv_platform

lnv_platform = create n_cst_platformwin32
ls_ComputerName = lnv_platform.of_getcomputername()
ls_UserId = gnv_app.of_GetUserID ( )

  select modulelocks.module into :ls_ModuleName
    from modulelocks
    where(modulelocks.machinename=:ls_ComputerName)
    and(modulelocks.module=:as_modulename)
    and(modulelocks.userid=:ls_UserId);
	
If sqlca.sqlcode = 0 THEN
	lb_Return = TRUE
END IF

COMMIT ;

DESTROY lnv_Platform

RETURN lb_Return
end function

public function boolean of_validatemodulelicenses ();Long		ll_TotalLicensed
Integer	li_SerialReturn
Boolean	lb_Valid = FALSE
String	ls_MessageHeader

ls_MessageHeader = "Version " + gnv_App.of_GetVersion ( ) + " CD Key"

IF NOT lb_Valid THEN

	SELECT Sum ( Licensed ) INTO :ll_TotalLicensed FROM ModuleLicenses ;
	COMMIT ;
	
	//This assumes that if nothing's licensed, no key's been entered.  This holds at present, 
	//but if we had a situation where someone could use only non-user-count restricted modules,
	//this would not hold.

	IF ll_TotalLicensed > 0 THEN
		lb_Valid = TRUE
	END IF

END IF


IF NOT lb_Valid THEN

	DO

		Open ( w_SerialNumber )
		li_SerialReturn = Message.DoubleParm
		
		IF li_SerialReturn = 1 THEN
			lb_Valid = TRUE
		ELSE
			CHOOSE CASE MessageBox ( ls_MessageHeader, "You will not be able to use some parts of the application "+&
				"until a valid CD Key has been entered.", Exclamation!, RetryCancel!, 1 )

			CASE 1  //Retry
				//Proceed to next attempt.

			CASE ELSE  //Cancel, or Unexpected Value
				EXIT

			END CHOOSE
		END IF

	LOOP UNTIL lb_Valid = TRUE

END IF

RETURN lb_Valid
end function

public function boolean of_hascommunicationslicense ();//Indicates whether any of the available communications packages have been licensed.
//This can be used for things like setting up menus, etc.

Boolean	lb_Result

IF This.of_HasMobileCommunicationsLicense ( ) THEN
	lb_Result = TRUE
ELSEIF This.of_GetLicensed ( n_cst_Constants.cs_Module_ClipBoard )  THEN
	lb_Result = TRUE
ELSEIF This.of_GetLicensed ( n_cst_Constants.cs_Module_Nextel )  THEN
	lb_Result = TRUE		//NEXTEL currently does NOT set of_HasMobileCommunicationsLicense to TRUE
//ELSEIF ....  THEN
//	lb_Result = TRUE

END IF

RETURN lb_Result

end function

public function boolean of_hasmobilecommunicationslicense ();//Indicates whether any of the available communications packages have been licensed.
//This can be used for things like setting up menus, etc. This is separate from
// of_HasCommuicationsLicense in that things like Clipboard Should NOT be in here.
// this will control whether menu options like process inbound should be visible. 

//NEXTEL currently does NOT set of_HasMobileCommunicationsLicense to TRUE.
//However, it does set of_HasCommunicationsLicense to TRUE.
//This distinction is made because Nextel does not need menu items like Import Messages, etc.

Boolean	lb_Result

IF This.of_GetLicensed ( n_cst_Constants.cs_Module_Qualcomm ) THEN
	lb_Result = TRUE
ELSEIF This.of_GetLicensed ( n_cst_Constants.cs_Module_InTouch ) THEN
	lb_Result = TRUE
ELSEIF This.of_GetLicensed ( n_cst_Constants.cs_Module_AtRoad )  THEN
	lb_Result = TRUE
ELSEIF This.of_GetLicensed ( n_cst_Constants.cs_Module_Cadec )  THEN
	lb_Result = TRUE
//ELSEIF ....  THEN
//	lb_Result = TRUE

END IF

RETURN lb_Result

end function

public function boolean of_hasedi214license ();
Boolean	lb_Result

IF This.of_GetLicensed ( n_cst_Constants.cs_Module_EDI214 ) THEN
	lb_Result = TRUE
END IF

RETURN lb_Result

end function

public function integer of_setpcmilerstreets ();integer	li_return

IF This.of_GetLicensed ( n_cst_Constants.cs_Module_PCMilerStreets  ) THEN
	sb_PCMilerStreets = true
	li_return = 1
else
	sb_PCMilerStreets = false
	li_return = 0
END IF

RETURN li_return


end function

public function boolean of_usepcmilerstreets ();return sb_PCMilerStreets
end function

public function boolean of_haspcmilerlicense ();Boolean	lb_Result

IF This.of_GetLicensed ( n_cst_Constants.cs_Module_PCMiler  ) THEN
	lb_Result = TRUE
END IF

RETURN lb_Result

end function

public subroutine of_setpcmilerserverid (integer ai_serverid);si_pcmilerserverid = ai_serverid
end subroutine

public function integer of_getpcmilerserverid ();return si_pcmilerserverid
end function

public function boolean of_hasautoratinglicensed ();

Boolean	lb_Result

IF This.of_GetLicensed ( n_cst_Constants.cs_Module_AutoRating) THEN
	lb_Result = TRUE
END IF

RETURN lb_Result

end function

public function boolean of_hasrouteoptimizer ();

Boolean	lb_Result

IF This.of_GetLicensed ( n_cst_Constants.cs_Module_RouteOptimizer ) THEN
	lb_Result = TRUE
END IF

RETURN lb_Result

end function

public function boolean of_hasedi204license ();Boolean	lb_Result

IF This.of_GetLicensed ( n_cst_Constants.cs_Module_EDI204 ) THEN
	lb_Result = TRUE
END IF

RETURN lb_Result

end function

public function boolean of_hasnotificationlicense ();Boolean	lb_Result

IF This.of_GetLicensed ( n_cst_Constants.cs_Module_notification ) THEN
	lb_Result = TRUE
END IF

RETURN lb_Result

end function

public function boolean of_hasedi322license ();
Boolean	lb_Result

IF This.of_GetLicensed ( n_cst_Constants.cs_Module_EDI322 ) THEN
	lb_Result = TRUE
END IF

RETURN lb_Result

end function

public function long of_getspecialops ();Long	ll_FoundRow, ll_SpecialOps
ll_FoundRow = of_Find ( "SpecialOps", FALSE )
IF ll_FoundRow > 0 THEN
	ll_SpecialOps = sds_Cache.Object.ss_long [ ll_FoundRow ]
ELSE
	SetNull ( ll_SpecialOps )
END IF

RETURN ll_SpecialOps
end function

private function integer of_purge ();integer	li_return=1, &
			li_sqlcode
			
String	ls_TemplateStatus

ls_TemplateStatus = gc_Dispatch.cs_ShipmentStatus_Template 

string	ls_MessageTitle = 'Purge Training/Practice Data'

Choose case Messagebox(ls_MessageTitle, &
		'Purge all practice data from your database. Are you sure you want to proceed ?',Question!,okcancel!)
	case 2
		//cancel will return 1, same as successful purge. Doing this because calling script needs 1 or -1
		li_return = 1
		
	case else
		setpointer(Hourglass!)
		
		IF li_return = 1 THEN
			
			//this will cascade to disp_events and disp_items
			
			DELETE FROM "disp_ship" Where ds_Status <> :ls_TemplateStatus ;
			
			IF SQLCA.SqlCode = 0 THEN
				//OK
			ELSE
				
				messagebox(ls_MessageTitle, 'Problem deleting rows in disp_ship. SqlCode - ' + &
							string(SQLCA.SqlDBCode) + ' Errtxt - ' + SQLCA.SqlErrText)
				li_Return = -1
				ROLLBACK ;
			END IF
		
		END IF
		
		IF li_return = 1 THEN
			
			//disp_events without ship ids
			
			DELETE FROM "disp_events" where de_shipment_id is null ;
			
			IF SQLCA.SqlCode = 0 THEN
				//OK
			ELSE
				
				messagebox(ls_MessageTitle, 'Problem deleting rows in disp_events. SqlCode - ' + &
							string(SQLCA.SqlDBCode) + ' Errtxt - ' + SQLCA.SqlErrText)
				li_Return = -1
				ROLLBACK ;
			END IF
		
		END IF
		
		IF li_return = 1 THEN
		
			DELETE FROM "brok_trips"  ;
			
			IF SQLCA.SqlCode = 0 THEN
				//OK
			ELSE
				
				messagebox(ls_MessageTitle, 'Problem deleting rows in brok_trips. SqlCode - ' + &
							string(SQLCA.SqlDBCode) + ' Errtxt - ' + SQLCA.SqlErrText)
				li_Return = -1
				ROLLBACK ;
			END IF
		
		END IF
		
			
		IF li_return = 1 THEN
		
			DELETE FROM "amountowed"  ;
			
			IF SQLCA.SqlCode = 0 THEN
				//OK
			ELSE
				
				messagebox(ls_MessageTitle, 'Problem deleting rows in amountowed. SqlCode - ' + &
							string(SQLCA.SqlDBCode) + ' Errtxt - ' + SQLCA.SqlErrText)
				li_Return = -1
				ROLLBACK ;
			END IF
		
		END IF
		
		IF li_return = 1 THEN
		
			DELETE "transaction" ;
			
			IF SQLCA.SqlCode = 0 THEN
				//OK
			ELSE
				
				messagebox(ls_MessageTitle, 'Problem deleting rows in transaction. SqlCode - ' + &
							string(SQLCA.SqlDBCode) + ' Errtxt - ' + SQLCA.SqlErrText)
				li_Return = -1
				ROLLBACK ;
			END IF
		
		END IF
		
	
		
		IF li_return = 1 THEN
			
		  //	Initialize periodic amount templates
		  UPDATE "amounttemplate"  
			  SET "runningtotal" = null,   
					"runningcount" = null,   
					"lastamount" = null,   
					"lastdate" = null,   
					"firstdate" = null  
			WHERE "amounttemplate"."type" = 7   ;
		
			Choose case SQLCA.SqlCode
				case 0, 100
					//OK
				case else
					
					messagebox(ls_MessageTitle, 'Problem initializing periodic amount templates. SqlCode - ' + &
								string(SQLCA.SqlDBCode) + ' Errtxt - ' + SQLCA.SqlErrText)
					li_Return = -1
					ROLLBACK ;
			end choose
			
		END IF
		
		IF li_return = 1 THEN
		
			DELETE FROM "equipment"  
			WHERE "equipment"."eq_id" in (  SELECT "outside_equip"."oe_id"  
													 FROM "outside_equip" )  ;
			
			IF SQLCA.SqlCode = 0 THEN
				//OK
			ELSE
				
				messagebox(ls_MessageTitle, 'Problem deleting rows in equipment. SqlCode - ' + &
							string(SQLCA.SqlDBCode) + ' Errtxt - ' + SQLCA.SqlErrText)
				li_Return = -1
				ROLLBACK ;
			END IF
		
		END IF
		
		IF li_return = 1 THEN
		
			UPDATE "equipment"  
			SET "eq_cur_event" = NULL ;
			
			IF SQLCA.SqlCode = 0 THEN
				//OK
			ELSE
				
				messagebox(ls_MessageTitle, 'Problem setting current event to null in the equipment table. SqlCode - ' + &
							string(SQLCA.SqlDBCode) + ' Errtxt - ' + SQLCA.SqlErrText)
				li_Return = -1
				ROLLBACK ;
			END IF
		
		END IF
		
		IF li_return = 1 THEN
		
			UPDATE "billing_sequences"  
			  SET "bs_next" = 1  ;
			
			Choose case SQLCA.SqlCode
				case 0, 100
					//OK
				case else
					
					messagebox(ls_MessageTitle, 'Problem setting bs_next to 1 in billing_sequences. SqlCode - ' + &
								string(SQLCA.SqlDBCode) + ' Errtxt - ' + SQLCA.SqlErrText)
					li_Return = -1
					ROLLBACK ;
			end choose
		
		END IF
		
		IF li_Return = 1 THEN
			commit;	
		END IF	
		
end choose

return li_return
end function

public function boolean of_hasedi210license ();Boolean	lb_Result

IF This.of_GetLicensed ( n_cst_Constants.cs_Module_EDI210 ) THEN
	lb_Result = TRUE
END IF

RETURN lb_Result

end function

public function boolean of_hasanyedilicense ();Boolean	lb_Result

IF This.of_GetLicensed ( n_cst_Constants.cs_Module_EDI204 ) or &
	This.of_GetLicensed ( n_cst_Constants.cs_Module_EDI210 ) or &
	This.of_GetLicensed ( n_cst_Constants.cs_Module_EDI214 ) or &
	This.of_GetLicensed ( n_cst_Constants.cs_Module_EDI322 ) THEN
	lb_Result = TRUE
END IF

RETURN lb_Result

end function

public function integer of_setspecialops (long al_currentspecialops);//This will attempt to set a value on the cache.  If the row is not already on the 
//cache, the call to of_Find with InsertIfNotPresent = TRUE will insert a row with
//the correct id.  If the set succeeds, sb_Ready will be set to false, indicating
//that updates have been made to the cache but not yet saved to the db.

Long	ll_FoundRow
Integer	li_Return

ll_FoundRow = of_Find ( "SpecialOps", TRUE /*InsertIfNotPresent*/ )

IF ll_FoundRow > 0 THEN
	sds_Cache.Object.ss_long [ ll_FoundRow ] = al_currentspecialops
	sb_Ready = FALSE
	li_Return = 1
ELSE
	li_Return = -1
END IF


RETURN li_Return


end function

public function boolean of_hasequipmentpostinglicense ();Boolean	lb_Result

IF This.of_GetLicensed ( n_cst_Constants.cs_Module_EquipmentPosting) THEN
	lb_Result = TRUE
END IF

RETURN lb_Result

end function

public function boolean of_hasnextellicense ();Boolean	lb_Result

IF This.of_GetLicensed ( n_cst_Constants.cs_Module_Nextel ) THEN
	lb_Result = TRUE
END IF

RETURN lb_Result

end function

public function integer of_displayconversionmessage (ref string as_path);integer	li_Return

string	ls_version, &
			ls_msg, &
			ls_MachineName

boolean	lb_asa9
Boolean	lb_UseAppPath
n_cst_filesrvwin32	lnv_FileSrv
lnv_FileSrv = CREATE n_Cst_filesrvwin32

n_cst_PlatformWin32 	 lnv_Platform

lnv_Platform = Create n_cst_PlatformWin32
	
//check for ASA version
//check moved to fn 7/12/06
lb_asa9 = This.of_Asa9Db()

IF lb_asa9 AND keyDown ( KEYSHIFT! ) THEN
	IF MEssagebox ( "DB Backup" , "Are you sure you want to skip the DB backup?" , QUESTION!, YESNO! , 1 ) = 1 THEN
		lb_Asa9 = FALSE
	END IF
END IF
	


if lb_asa9 then
	
	//get the backup file
	n_cst_setting_dbBackupLocation	lnv_dbBackupLocation
	
	lnv_dbBackupLocation = CREATE n_cst_setting_dbBackupLocation
	
	as_path =  lnv_dbBackupLocation.of_Getvalue( ) 
	
	destroy lnv_dbBackupLocation
	
	ls_MachineName = lnv_Platform.of_GetComputerName()
	
	IF len(Trim ( as_path ) ) > 0 THEN
		
		IF Right (as_path,1)  <> '\' THEN
			as_Path += '\'
		END IF
		
		IF NOT lnv_FileSrv.of_directoryExists ( as_Path ) THEN
			IF lnv_FileSrv.of_CreateFolder( as_path ) <> 1 THEN
				
				IF MessageBox ( "DB Backup Location" , "There was a problem attempting to access/create the Backup location specified in the system settings. (" + as_path + &
				   + ") ~r~n Do you want to use the application path instead?" , Question! , YESNO! , 1 ) = 1 THEN

					lb_UseAppPath = TRUE
				ELSE
					
					li_Return = -1
				END IF		
			END IF
		END IF
		
		IF li_Return <> -1 THEN
			//use it	
			as_path = as_path + string(today(),"yymmdd") + string(now(), "hhmm") + "-" + ls_MachineName			
		END IF
		
	ELSE
		lb_UseAppPath = TRUE		
	END IF
		
	IF lb_UseAppPath THEN
		as_Path = gnv_app.of_GetApplicationfolder( )
		if len(as_path) > 0 then
			IF Right ( as_path, 1 ) <> '\' THEN
				as_path += '\'
			END IF
			as_path = as_path  + string(today(),"yymmdd") + string(now(), "hhmm") + "-" + ls_MachineName
		else
			as_path = 'c:\' + string(today(),"yymmdd") + string(now(), "hhmm") + "-" + ls_MachineName
		end if
		
	END IF	
		
	ls_msg = "Welcome to " + gnv_App.of_GetAppVersionName ( ) + ".~n~n" + &
		"Your database must be upgraded before you can use this version of the application.~n~n" + &
		"WARNING:  THIS PROCEDURE IS NOT REVERSIBLE, AND ANY ERRORS COULD SERIOUSLY DAMAGE YOUR DATABASE.~n~n" + &
		"Profit Tools will automatically backup your database to " + as_path + " before the conversion.~n~n" + &
		"OK to proceed with version update?"
	
else
	
	ls_msg = "Welcome to " + gnv_App.of_GetAppVersionName ( ) + ".~n~n" + &
		"Your database must be upgraded before you can use this version of the application. " + &
		"Would you like to perform the update procedure now?~n~n" + &
		"WARNING:  DO NOT PERFORM THIS PROCEDURE WITHOUT MAKING A BACKUP OF YOUR DATABASE FIRST. " + &
		"THIS PROCEDURE IS NOT REVERSIBLE, AND ANY ERRORS COULD SERIOUSLY DAMAGE YOUR DATABASE.~n~n" + &
		"OK to proceed with version update?"
	
end if

IF li_Return <> -1 THEN
	li_Return  = MessageBox( "Profit Tools Version Upgrade", ls_msg, Question!, OkCancel!, 1 )
END IF

DESTROY ( lnv_FileSrv )
Destroy ( lnv_Platform )

return li_Return

end function

public function integer of_backupdatabase (string as_path);integer	li_return
string	ls_sql

setpointer(hourglass!)
W_PleaseWait	lw_PW
Open (lw_PW)
// I use the Upper command to prevent the path from having any escape chars in it.
ls_sql = "BACKUP DATABASE DIRECTORY '" + Upper ( as_Path ) + "'"
Execute Immediate :ls_Sql;


if sqlca.sqlcode <> 0 then
	MessageBox( "Error", sqlca.sqlerrtext + "~n~nThe database was not successfully backed up.", Exclamation! )
	ROLLBACK ;
	li_Return = -1
ELSE
	li_Return = 1
	commit;
END IF


Close ( lw_PW )

return li_return
end function

public function boolean of_hasdocumentttansfer ();Boolean	lb_Result

IF This.of_GetLicensed ( n_cst_Constants.cs_Module_DocumentTransfer ) THEN
	lb_Result = TRUE
END IF

RETURN lb_Result

end function

public function integer of_emailversionchange ();Integer	li_Return

String		ls_ExpectedVersion
String 		ls_CurrentVersion
String		ls_Company
String		ls_Notify 
String		ls_inifile


n_cst_bso_email_manager_ptserver lnv_EmailManager
n_cst_emailmessage	lnv_EmailMsg

ls_ExpectedVersion = gnv_App.of_GetVersion ( )
ls_CurrentVersion =  This.of_GetAppVersion( )
ls_Company = This.of_GetLicensedcompany( )
IF isNull ( ls_CurrentVersion ) THEN
	ls_CurrentVersion = "0"
END IF

IF ls_CurrentVersion = ls_ExpectedVersion THEN
	//Versions match.  Proceed.
ELSE
	ls_IniFile = gnv_App.of_GetAppIniFile ( )
	ls_Notify = ProfileString(ls_IniFile, "Version Notify","Notify", "YES")
	IF  ls_Notify <> "no" THEN
		
		lnv_EmailManager = CREATE n_cst_bso_email_manager_ptserver
		
		lnv_EmailMsg.of_SetAuthor("updatenotification@profittools.net")
		lnv_EmailMsg.of_Addtargetaddress("updatenotification@profittools.net")
		
		lnv_EmailMsg.of_Setsubject(ls_Company + " App Update")
		lnv_EmailMsg.of_Setbody( ls_Company + " has upgraded from version " + ls_CurrentVersion + " to " + ls_ExpectedVersion )	
		
		IF lnv_EmailManager.of_SendMail( lnv_EmailMsg ) <> 1 THEN
			li_Return = -1
		ELSE
			li_Return = 1
		END IF
	END IF
	
	This.of_SetAppVersion(ls_ExpectedVersion)
	
	Destroy ( lnv_EmailManager )
	
END IF

Return li_Return
end function

public function string of_getappversion ();String	ls_Version
Long	ll_FoundRow

ll_FoundRow = of_Find ( "AppVersion", FALSE )
IF ll_FoundRow > 0 THEN
	ls_Version = sds_Cache.Object.ss_string [ ll_FoundRow ]
ELSE
	SetNull ( ls_Version )
END IF

Return ls_Version
end function

public function integer of_setappversion (string as_version);Long		ll_FoundRow
Integer	li_Return
n_cst_Settings   lnv_settings

lnv_Settings.of_Setsetting(15, as_version, lnv_Settings.cs_datatype_string)
lnv_Settings.of_savesetting( )

Return li_Return
end function

private function integer of_flagupdateinprogress ();Integer	li_Return = -1

n_cst_Setting_DbUpdateInProgress	 lnv_DbLocked

lnv_DbLocked = Create n_cst_Setting_DbUpdateInProgress

IF lnv_DbLocked.of_SaveValue(1) = 1 THEN
	lnv_DbLocked.of_SaveSetting( )
	li_Return = 1
END IF

Destroy (lnv_DbLocked)

RETURN li_Return

end function

private function integer of_getlicensedusersfromdb ();Int	li_Return = -1
Int	li_Count

  SELECT "system_settings"."ss_long"  
    INTO :li_Count  
    FROM "system_settings"  
   WHERE "system_settings"."ss_id" = 5   ;

IF SQLCA.Sqlcode = 0 THEN
	Commit;
	li_Return = li_Count
ELSE
	Rollback;
END IF

RETURN li_Return
end function

private function integer of_flagupdatedone ();Integer	li_Return

n_cst_Setting_DbUpdateInProgress	 lnv_DbLocked

lnv_DbLocked = Create n_cst_Setting_DbUpdateInProgress

IF lnv_DbLocked.of_SaveValue(0) = 1 THEN
	lnv_DbLocked.of_SaveSetting()
	li_Return = 1
END IF

Destroy (lnv_DbLocked)

Return li_Return
end function

private function boolean of_isupdateinprogress ();Integer	li_Return
String	ls_Locked
Boolean  lb_InProgress

n_cst_Setting_DbUpdateInProgress	 lnv_DbLocked

lnv_DbLocked = Create n_cst_Setting_DbUpdateInProgress

ls_Locked = lnv_DbLocked.of_GetValue() 
	
Destroy (lnv_DbLocked)

IF ls_Locked = appeon_constant.cs_Locked THEN
	lb_InProgress = TRUE
ELSE
	lb_InProgress = FALSE
END IF

RETURN lb_InProgress
end function

public function integer of_autoactivaterailtrace (boolean ab_enable);// enables/disables the ptev_ActivateRailTrace
// backup databases are saved with this event on so that rail trace will be activated
// in a recovery situation.
// MFS 7/13/06

Integer	li_Return
String	ls_Sql
String 	ls_Mode

IF ab_Enable THEN
	ls_Mode = "ENABLE"
ELSE
	ls_Mode = "DISABLE"
END IF

ls_Sql = "ALTER EVENT ptev_ActivateRailTrace " + ls_Mode
Execute Immediate :ls_Sql;

IF sqlca.sqlcode = 0 THEN
	Commit;
	li_Return = 1
ELSE
	RollBack;
	li_Return = -1
END IF


Return li_Return
end function

public function boolean of_israiltracesetup ();String	ls_Setting
Boolean  lb_SetUp
Long		ll_ServerId

//If RT remote server is set we assume everything is set up
SELECT "srvid" 
INTO :ll_ServerId
FROM "sys"."sysservers" 
WHERE "srvname" = 'local_rtdb';

IF ll_ServerId > 0 THEN
	lb_Setup = TRUE
END IF

IF SQLCA.SqlCode = 0 THEN
	COMMIT ;
ELSE
	ROLLBACK ;
END IF

RETURN lb_SetUp
end function

public function string of_getdbbackuplocation ();String	ls_Path, &
			ls_MachineName, &
			ls_FileName
Boolean	lb_UseAppPath

n_cst_filesrvwin32	lnv_FileSrv
lnv_FileSrv = Create n_Cst_filesrvwin32

n_cst_PlatformWin32 	 lnv_Platform
lnv_Platform = Create n_cst_PlatformWin32
	
//get the backup file
n_cst_setting_dbBackupLocation	lnv_dbBackupLocation
lnv_dbBackupLocation = Create n_cst_setting_dbBackupLocation
ls_path =  lnv_dbBackupLocation.of_Getvalue( ) 
Destroy lnv_dbBackupLocation

ls_MachineName = lnv_Platform.of_GetComputerName()
ls_FileName = string(today(),"yymmdd") + string(now(), "hhmm") + "-" + ls_MachineName

IF Len(Trim ( ls_path ) ) > 0 THEN
	
	IF Right (ls_path,1)  <> '\' THEN
		ls_path += '\'
	END IF
	
	IF NOT lnv_FileSrv.of_DirectoryExists ( ls_path ) THEN
		IF lnv_FileSrv.of_CreateFolder( ls_path ) <> 1 THEN
			lb_UseAppPath = TRUE		
		END IF
	END IF
	
	IF NOT lb_UseAppPath THEN
		ls_path = ls_path + ls_FileName
	END IF

ELSE
	lb_UseAppPath = TRUE		
END IF
	
IF lb_UseAppPath THEN
	
	ls_path = gnv_app.of_GetApplicationfolder( )
	IF Len(ls_path) > 0 THEN
		IF Right ( ls_path, 1 ) <> '\' THEN
			ls_path += '\'
		END IF
		ls_path = ls_path  + ls_FileName
	ELSE
		ls_path = 'c:\' + ls_FileName
	END IF
	
END IF	
	
Destroy ( lnv_FileSrv )
Destroy ( lnv_Platform )

Return ls_Path

end function

public function boolean of_asa9db ();//Created MFS 7/12/06

String	ls_Option = 'ProductVersion'
String	ls_Version
Boolean	lb_asa9

DECLARE version_proc CURSOR FOR  
SELECT xp_msver(:ls_Option)  ;

OPEN version_proc;

//xp_msver doesn't exist in older versions
//if the cursor can't be opened then not asa9 
IF sqlca.sqlcode <> 0 THEN
	//not asa 9
	lb_asa9 = false
END IF

FETCH version_proc Into :ls_version;

CLOSE version_proc;

commit;

IF left(ls_version,1) = '9' THEN
	lb_asa9 = true
ELSE
	lb_asa9 = false
END IF

Return lb_asa9
end function

private function integer of_activaterailtraceinbound ();//Turn on RailTrace updates to Profit Tools
Integer	li_Return

Update "rt_system_settings"  
  Set "rt_system_settings"."ss_string" = 'YES!'
Where "rt_system_settings"."ss_id" = 1   
           ;
IF SQLCA.Sqlcode = 0 THEN
	Commit;
	li_Return = 1
ELSE
	RollBack;
	li_Return = -1
END IF

Return li_Return
end function

private function integer of_deactivaterailtraceinbound ();//Turn off RailTrace updates to Profit Tools
Integer	li_Return

Update "rt_system_settings"  
Set "rt_system_settings"."ss_string" = 'NO!'
Where "rt_system_settings"."ss_id" = 1   
           ;
IF SQLCA.Sqlcode = 0 THEN
	Commit;
	li_Return = 1
ELSE
	RollBack;
	li_Return = -1
END IF

Return li_Return
end function

public function boolean of_israiltraceactiveinbound ();String	ls_Setting
Boolean  lb_Active
Long		ll_TableId

//Check if proxy table is set up
SELECT "systable"."table_id" 
INTO :ll_TableId
FROM "systable"
WHERE "table_name" = 'rt_system_settings';

//IF RT is set up, check if RT is currently interacting with PT.
IF ll_TableId > 0 THEN
	
	SELECT "rt_system_settings"."ss_string" 
	INTO :ls_Setting 
	FROM "rt_system_settings"
	WHERE "rt_system_settings"."ss_id" = 1;
	
END IF

IF SQLCA.SqlCode = 0 THEN
	COMMIT ;
ELSE
	ROLLBACK ;
END IF

IF ls_Setting = "YES!" THEN
	lb_Active = TRUE
ELSE
	lb_Active = FALSE
END IF

RETURN lb_Active
end function

public function integer of_activaterailtrace ();//Activate Profit Tools interaction to RailTrace (outbound)
//Activate RailTrace interaction to Profit Tools (inbound)

Integer	li_Return = 1

Update "system_settings"  
  Set "system_settings"."ss_string" = 'YES!'
Where "system_settings"."ss_id" = 220;

IF SQLCA.Sqlcode <> 0 THEN
	li_Return = -1
END IF

IF li_Return = 1 THEN
	
	Update "rt_system_settings"  
	Set "rt_system_settings"."ss_string" = 'YES!'
	Where "rt_system_settings"."ss_id" = 1;
	
	IF SQLCA.Sqlcode <> 0 THEN
		li_Return = -1
	END IF

END IF

IF li_Return = 1 THEN
	Commit;
ELSE
	Rollback;
END IF

Return li_Return
end function

public function integer of_deactivaterailtrace ();//De-Activate Profit Tools interaction to RailTrace (outbound)
//De-Activate RailTrace interaction to Profit Tools (inbound)

Integer	li_Return = 1


Update "system_settings"  
  Set "system_settings"."ss_string" = 'NO!'
Where "system_settings"."ss_id" = 220;

IF SQLCA.Sqlcode <> 0 THEN
	li_Return = -1
END IF

IF li_Return = 1 THEN
	
	Update "rt_system_settings"  
	Set "rt_system_settings"."ss_string" = 'NO!'
	Where "rt_system_settings"."ss_id" = 1;
	
	IF SQLCA.Sqlcode <> 0 THEN
		li_Return = -1
	END IF

END IF

IF li_Return = 1 THEN
	Commit;
ELSE
	Rollback;
END IF

Return li_Return
end function

public function boolean of_israiltraceactiveoutbound ();String	ls_Setting
Boolean  lb_Active

SELECT "system_settings"."ss_string" 
INTO :ls_Setting 
FROM "system_settings"
WHERE "system_settings"."ss_id" = 220;

IF SQLCA.SqlCode = 0 THEN
	COMMIT ;
ELSE
	ROLLBACK ;
END IF

IF ls_Setting = "YES!" THEN
	lb_Active = TRUE
ELSE
	lb_Active = FALSE
END IF

RETURN lb_Active
end function

public function string of_getrailtraceversion ();String	ls_Version

SELECT "rt_system_settings"."ss_string" 
INTO :ls_Version
FROM "rt_system_settings"
WHERE "rt_system_settings"."ss_id" = 16;
	
	
IF SQLCA.SqlCode = 0 THEN
	COMMIT ;
ELSE
	ROLLBACK ;
END IF

IF isNull(ls_Version) OR Len(ls_Version) < 1 THEN
	ls_Version = "0.0.0"
END IF


Return ls_Version
end function

public function boolean of_compatiblerailtrace (string as_expectedversion, string as_currentversion);//checks if version passed in is compatible with this version of PT railtrace.
Boolean 	lb_Return = TRUE
Long		i
Long		lla_Expected[]
Long		lla_Current[]
Long		ll_ExpectedLen
Long		ll_CurrentLen

n_cst_string	lnv_String

ll_ExpectedLen = lnv_String.of_Parsetoarray( as_ExpectedVersion,".", lla_Expected)

ll_CurrentLen = lnv_String.of_Parsetoarray( as_CurrentVersion,".", lla_Current)

IF ll_ExpectedLen = ll_CurrentLen THEN
	
	FOR i = 1 TO ll_ExpectedLen
		
		IF lla_Current[i] < lla_Expected[i] THEN
			lb_Return = FALSE
			EXIT
		ELSEIF lla_Current[i] > lla_Expected[i] THEN
			EXIT //greater versions should be compatible
		ELSE
			//they are equal so check next position
		END IF
		
	NEXT
	
ELSE
	//array sizes do not match, we assume versions are not compatible
	lb_Return = FALSE
END IF


Return lb_Return
end function

public function integer of_upgraderailtraceinterface ();Constant Boolean lb_BackupDatabase = TRUE

Return This.of_UpgradeRailTraceInterface(lb_BackupDatabase)
end function

public function integer of_upgraderailtraceinterface (boolean ab_backupdatabase);//Return 0 : upgrade is not necessary, not compatible, no clients were connected
//Return 1 : upgrade successful
//Return -1: upgrade failed

Integer		li_Return = 1 

String		ls_ExpectedRTVersion
String		ls_CurrentRtVersion
String		ls_SetupError
String		ls_BackupLocation
String		ls_RailTraceAppName

Boolean		lb_RailTraceActive
Boolean		lb_SkipDBbackup

n_cst_PTRailTraceManager	lnv_RailTraceManager

lnv_RailTraceManager = Create n_cst_PTRailTraceManager

ls_RailTraceAppName = gnv_App.of_GetRailTraceAppName()

//Check if setup is necessary
IF NOT of_IsRailTraceSetup() THEN	
	li_Return = 0 //not necessary
END IF

//Check if they have a compatible version of RailTrace
IF li_Return = 1 THEN
	ls_CurrentRTVersion = of_GetRailTraceVersion()
	ls_ExpectedRTVersion = lnv_RailTraceManager.of_GetRTVersionExpected( )
	
	IF NOT of_CompatibleRailTrace(ls_ExpectedRtVersion, ls_CurrentRtVersion) THEN
		li_Return = 0
		MessageBox("Interface Upgrade", "We recommend that you upgrade the PT interface to " + ls_RailTraceAppName + "~r~n" + &
					  "To do this you must first upgrade " + ls_RailTraceAppName + " to version " + String(ls_ExpectedRTVersion) + " or higher.~r~n" + &
					  "Once you have upgraded " + ls_RailTraceAppName + ", go to System Settings --> Equipment Tab, and click on 'Upgrade Interface.")
	END IF
END IF

//Make sure no other clients are running
IF li_Return = 1 THEN
	IF This.of_GetLocalConnectionCount() > 1 THEN
		MessageBox("Interface Upgrade", "We recommend that you upgrade the Profit Tools/" + ls_RailTraceAppName + " Interface.~r~n" + &
						  "Profit Tools has detected other clients connected to the database.~r~n" + &
						  "Make sure that all clients are disconneced from Profit Tools and try again.~r~n~r~n" + &
						  "To upgrade the interface, go to System Settings --> Equipment Tab, and click on 'Upgrade Interface.")
		li_Return = 0
	END IF
END IF

//Backup database
IF li_Return = 1 THEN
	
	IF ab_BackupDatabase THEN
		
		IF This.of_Asa9Db() THEN
			IF keyDown ( KEYSHIFT! ) THEN
				IF Messagebox ( "DB Backup" , "Are you sure you want to skip the DB backup?" , QUESTION!, YESNO! , 1 ) = 1 THEN
					lb_SkipDBbackup = TRUE
				END IF
			END IF
			
			IF NOT lb_SkipDBbackup THEN
				ls_BackUpLocation = This.of_GetDbBackUpLocation()
				IF This.of_Backupdatabase(ls_BackUpLocation) <> 1 THEN
					MessageBox("Interface Upgrade.", "Error occured while trying to backup database to " + ls_BackupLocation + ".")
					li_Return = -1
				END IF
			END IF
		ELSE
			IF MessageBox("Interface Upgrade", "WARNING:  DO NOT PERFORM THIS SETUP WITHOUT MAKING A BACKUP OF YOUR DATABASE FIRST. " + &
				"THIS SETUP IS NOT REVERSIBLE, AND ANY ERRORS COULD SERIOUSLY DAMAGE YOUR DATABASE.~n~n" + &
				"OK to proceed with " + ls_RailTraceAppName + " Setup?", Exclamation!, YesNo!, 2) = 2 THEN
				li_Return = -1
			END IF
		END IF

	END IF
		
END IF

//Upgrade Interface
IF li_Return = 1 THEN
		
	//Find out if RT is Active, if so we need to disable and re-activate
	lb_RailTraceActive = of_IsRailTraceActiveOutbound( )
	
	//Deactivate RT (inbound and outbound)
	IF li_Return = 1 THEN
		IF lb_RailTraceActive THEN
			IF of_DeactivateRailTrace() <> 1 THEN
				li_Return = -1 
			END IF
		END IF
	END IF
	
	//Set up Rail Trace
	IF li_Return = 1 THEN
		IF lnv_RailTraceManager.of_SetUpRailtrace() <> 1 THEN
			li_Return = -1
			ls_SetupError = lnv_RailTraceManager.of_GetErrorMsg()
			MessageBox("Interface Upgrade Error", "Error occured while upgrading " + ls_RailTraceAppName + " interface. Your " + ls_RailTraceAppName + " interface has been disabled.~r~n" + &
						  "Please contact Profit Tools for technical support.~r~n~r~n" + ls_SetupError)
		END IF
	END IF
	
	//Re-Activate RT (inbound and outbound)
	IF li_Return = 1 THEN
		IF lb_RailTraceActive THEN
			IF of_ActivateRailTrace() <> 1 THEN
				li_Return = -1
			END IF
		END IF
	END IF
	
END IF

Destroy(lnv_RailTraceManager)

Return li_Return
end function

public function integer of_getlocalconnectioncount ();//returns number of connections to the database (NOT including remote connections)
Integer		li_Count
Integer		i
Long			ll_ConnId
String		ls_ConnName
Constant String cs_RemoteConnection = "ASACIS_"

n_ds	lds_Operations

lds_Operations = Create n_ds

lds_Operations.DataObject = "d_operations"
lds_Operations.SetTransObject(SQLCA)
lds_Operations.Retrieve()

li_Count = lds_operations.RowCount()

//Do not count remote connections
FOR i = li_Count TO 1 STEP - 1
	ll_ConnId = lds_operations.GetItemNumber(i, "conn_id")
	SELECT connection_property ('Name', :ll_ConnId) INTO :ls_ConnName FROM Dummy;
	Commit;
	IF Pos(ls_ConnName, cs_RemoteConnection) > 0 THEN
		lds_operations.RowsDiscard(i,i,Primary!)
	END IF
NEXT

li_Count = lds_operations.RowCount()


/* This was the old method before the operations table
	SELECT NEXT_CONNECTION ( NULL ) INTO :ll_connid FROM Dummy;
	
	DO UNTIL isNull(ll_connid)
	 
		SELECT connection_property('name', :ll_connid) INTO :ls_connname FROM Dummy;
		
		//Do not count remote connections
		IF POS(ls_connname, cs_RemoteConnection) = 0 THEN
			li_Count ++
		END IF
	
		SELECT NEXT_CONNECTION (:ll_connid) INTO :ll_connid FROM Dummy;
		
		IF SQLCA.SqlCode <> 0 THEN //should not happen
			EXIT
		END IF
	
	 LOOP
	 
	IF SQLCA.SqlCode <> 0 THEN
		ROLLBACK ;
		SetNull ( li_Count )
	ELSE
		COMMIT ;
	END IF
*/

Destroy(lds_Operations)

Return li_Count
end function

public function integer of_addoperation ();Integer	li_Return = 1
Long		ll_EmId
Long		ll_ConnId
Long		ll_Row
String	ls_FindString
String	ls_AppInfo

n_ds		lds_Operations

lds_Operations = Create n_ds

ll_EmId = gnv_App.of_GetNumericUserId()

IF ll_EmId = 0 THEN
	SetNull(ll_EmId)
END IF

//Get the current connection properties
SELECT connection_property ('Number') INTO :ll_ConnId FROM Dummy;
SELECT connection_property ('AppInfo') INTO :ls_AppInfo FROM Dummy;

lds_Operations.DataObject = "d_operations"
lds_Operations.SetTransObject(SQLCA)
lds_Operations.Retrieve()

ls_FindString = "conn_id =" + String(ll_ConnId)
ll_Row = lds_Operations.Find(ls_FindString, 1, lds_Operations.RowCount())

IF ll_Row > 0 THEN //Update existing connection with em_id
	lds_Operations.SetItem(ll_Row, "em_id", ll_EmId)
ELSE //Add New connection - This should be taken care of by connect event (db side)
	ll_Row = lds_Operations.InsertRow(0)
	IF ll_Row > 0 THEN
		lds_Operations.SetItem(ll_Row, "conn_id", ll_ConnId)
		lds_Operations.SetItem(ll_Row, "conn_appinfo", ls_AppInfo)
		lds_Operations.SetItem(ll_Row, "em_id", ll_EmId)
	ELSE
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	IF lds_Operations.Update() = 1 THEN
		Commit;
	ELSE
		Rollback;
		li_Return = -1
	END IF
END IF

Destroy(lds_Operations)

Return li_Return
end function

on n_cst_licensemanager.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_licensemanager.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//In order to add a module, you must do the following:
//Add a cs_Module_xxx entry to n_cst_Constants.  The value is the module code you want in the DB.
//Add the module to the DefinedModule array initiation below.
//Add a registration key entry for that module in of_ProcessRegistrationKey
//Add a display name for the module to of_GetDisplayName (Optional)
//If the module is a communications package, add it to the list in of_HasCommunicationsLicense.
//Make any changes to the RegKey application.


//If this is the first time the object has been instantiated,
//load the DefinedModule array.

IF si_DefinedModuleCount = 0 THEN

	si_DefinedModuleCount ++
	ssa_DefinedModules [ si_DefinedModuleCount ] = n_cst_Constants.cs_Module_ContactManager

	si_DefinedModuleCount ++
	ssa_DefinedModules [ si_DefinedModuleCount ] = n_cst_Constants.cs_Module_OrderEntry

	si_DefinedModuleCount ++
	ssa_DefinedModules [ si_DefinedModuleCount ] = n_cst_Constants.cs_Module_Billing

	si_DefinedModuleCount ++
	ssa_DefinedModules [ si_DefinedModuleCount ] = n_cst_Constants.cs_Module_Brokerage

	si_DefinedModuleCount ++
	ssa_DefinedModules [ si_DefinedModuleCount ] = n_cst_Constants.cs_Module_Dispatch

	si_DefinedModuleCount ++
	ssa_DefinedModules [ si_DefinedModuleCount ] = n_cst_Constants.cs_Module_LogAudit

	si_DefinedModuleCount ++
	ssa_DefinedModules [ si_DefinedModuleCount ] = n_cst_Constants.cs_Module_PCMiler

	si_DefinedModuleCount ++
	ssa_DefinedModules [ si_DefinedModuleCount ] = n_cst_Constants.cs_Module_Settlements

	si_DefinedModuleCount ++
	ssa_DefinedModules [ si_DefinedModuleCount ] = n_cst_Constants.cs_Module_FuelCard

	si_DefinedModuleCount ++
	ssa_DefinedModules [ si_DefinedModuleCount ] = n_cst_Constants.cs_Module_FuelTax

	si_DefinedModuleCount ++
	ssa_DefinedModules [ si_DefinedModuleCount ] = n_cst_Constants.cs_Module_Imaging

	si_DefinedModuleCount ++
	ssa_DefinedModules [ si_DefinedModuleCount ] = n_cst_Constants.cs_Module_EDI210

	si_DefinedModuleCount ++
	ssa_DefinedModules [ si_DefinedModuleCount ] = n_cst_Constants.cs_Module_RouteManager

	si_DefinedModuleCount ++
	ssa_DefinedModules [ si_DefinedModuleCount ] = n_cst_Constants.cs_Module_Qualcomm

	si_DefinedModuleCount ++
	ssa_DefinedModules [ si_DefinedModuleCount ] = n_cst_Constants.cs_Module_InTouch
	
	si_DefinedModuleCount ++
	ssa_DefinedModules [ si_DefinedModuleCount ] = n_cst_Constants.cs_Module_AtRoad

	si_DefinedModuleCount ++
	ssa_DefinedModules [ si_DefinedModuleCount ] = n_cst_Constants.cs_Module_ClipBoard
	
	si_DefinedModuleCount ++
	ssa_DefinedModules [ si_DefinedModuleCount ] = n_cst_Constants.cs_Module_DataManager
	
	si_DefinedModuleCount ++
	ssa_DefinedModules [ si_DefinedModuleCount ] = n_cst_Constants.cs_Module_EDI214
	
	si_DefinedModuleCount ++
	ssa_DefinedModules [ si_DefinedModuleCount ] = n_cst_Constants.cs_Module_PCMilerStreets
	
	si_DefinedModuleCount ++
	ssa_DefinedModules [ si_DefinedModuleCount ] = n_cst_Constants.cs_Module_AutoRating
	
	si_DefinedModuleCount ++
	ssa_DefinedModules [ si_DefinedModuleCount ] = n_cst_Constants.cs_Module_RouteOptimizer
	
	si_DefinedModuleCount ++

	ssa_DefinedModules [ si_DefinedModuleCount ] = n_cst_Constants.cs_Module_EDI204
	
	si_DefinedModuleCount ++
	ssa_DefinedModules [ si_DefinedModuleCount ] = n_cst_Constants.cs_Module_Notification
	
	si_DefinedModuleCount ++
	ssa_DefinedModules [ si_DefinedModuleCount ] = n_cst_Constants.cs_Module_EDI322
	
	si_DefinedModuleCount ++
	ssa_DefinedModules [ si_DefinedModuleCount ] = n_cst_Constants.cs_Module_EquipmentPosting
	
	si_DefinedModuleCount ++
	ssa_DefinedModules [ si_DefinedModuleCount ] = n_cst_Constants.cs_Module_Nextel

	si_DefinedModuleCount ++
	ssa_DefinedModules [ si_DefinedModuleCount ] = n_cst_Constants.cs_Module_Cadec
	
	si_DefinedModuleCount ++
	ssa_DefinedModules [ si_DefinedModuleCount ] = n_cst_Constants.cs_Module_DocumentTransfer
	
	si_DefinedModuleCount ++
	ssa_DefinedModules [ si_DefinedModuleCount ] = n_cst_Constants.cs_Module_RailTrace

END IF
end event

