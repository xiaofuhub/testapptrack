$PBExportHeader$n_cst_specialops.sru
forward
global type n_cst_specialops from n_base
end type
end forward

global type n_cst_specialops from n_base
event ue_1 ( )
end type
global n_cst_specialops n_cst_specialops

type variables
boolean	ib_ConversionDone 
end variables

forward prototypes
public function boolean of_conversiondone ()
end prototypes

event ue_1();Any		la_SettingResult
long		ll_count
Long		ll_AmountType
Long		ll_FscList
Long		ll_Find
Int		li_AdminRtn
String	ls_FSCNone
String	ls_FscBoth
String	ls_ItemTypeFreight
String	ls_ItemTypeAcc
String	ls_ItemTypeNone
String	lsa_RateList[]
String	ls_FSCRateTableCodeName
Boolean	lb_HaveFSCList
Boolean	lb_SetAmountType

DataStore					lds_RateTables
n_cst_Msg					lnv_Msg
s_Parm						lstr_Parm
n_cst_bso_Rating			lnv_Rating
n_cst_RateData				lnv_RateData
n_cst_Settings	lnv_Settings

ll_FSCList = appeon_constant.cl_fuelsurcharge_list
//begin modification by apeon 20070727
//ll_FSCList = appeon_constant.cl_fuelsurcharge_list
lnv_Rating = CREATE n_cst_bso_Rating
ll_FSCList = lnv_Rating.cl_fuelsurcharge_list
//end modification by appeon 20070727
ls_ItemTypeNone = n_cst_constants.cs_itemtype_none
ls_ItemTypeAcc = n_cst_constants.cs_itemtype_accessorial
ls_ItemTypeFreight = n_cst_constants.cs_itemtype_freight
ls_FSCNone = n_Cst_Constants.cs_FuelSurcharge_None
ls_FSCBoth = n_Cst_Constants.cs_FuelSurcharge_Both
ls_FSCRateTableCodeName = 'FSC'


Open ( w_PTAdminLogon ) 
li_AdminRtn = Message.doubleParm
IF li_AdminRtn <> 1 THEN
	THIS.ib_conversiondone = FALSE
	RETURN 						///// EARLY RETURN HERE 	
END IF

select count(id) into :ll_count from amounttype where itemtype is null;
commit;

UPDATE "amounttype"  
  SET "surcharge" = null ;	  
Commit ;

w_pop_progress lw_Pop
Open(lw_Pop)
lw_Pop.wf_settext ( "Please wait while Profit Tools retrieves the information necessary to initialize the configuration routine.")
lw_Pop.wf_showbar ( False)
						
SetPointer ( HOURGLASS! ) 
//comment by appeon 20070727
//lnv_Rating = CREATE n_cst_bso_Rating
lnv_RateData = CREATE n_cst_RateData

IF lnv_Rating.of_GetCodeDefaultList ( 0 , appeon_constant.cl_FuelSurcharge_list , lsa_RateList ) > 0 THEN	
	lb_HaveFscList = TRUE
	ls_FSCRateTableCodeName = lsa_RateList[1]
	lnv_RateData.of_SetCodeName ( ls_FSCRateTableCodeName )
	ll_AmountType = lnv_Rating.of_GetAmountType ( lnv_RateData )
END IF
 
CLOSE ( lw_Pop )

if ll_count > 0 then
								 		
	lstr_Parm.is_label = "INSTRUCTIONS"
	lstr_Parm.ia_Value = "Amount types will now be filtered by Freight and Accessorial type in the order entry window. " + &
								"You will need to select a Type for each one in order to determine in which list it will be " + &
								"seen.  The Category column will determine whether it will be available in settlements " + &
								"(payables templates), shipment or both.  The new fuel surcharge column will determine if the " + &
								"amount type contributes to the fuel surcharge. "
	lnv_Msg.of_Add_Parm ( lstr_Parm ) 
	
	lstr_Parm.is_label = "FORCESAVE"
	lstr_Parm.ia_Value = TRUE
	lnv_Msg.of_Add_Parm ( lstr_Parm ) 
	
	OpenWithParm ( w_AmountTypes , lnv_Msg )
		
END IF

UPDATE "amounttype"  
  SET "surcharge" = :ls_FSCNone 
 WHERE  "surcharge" is null AND 
	("itemtype" = :ls_ItemTypeAcc OR  "itemtype" = :ls_ItemTypeNone OR  "id" = :ll_AmountType );
 Commit ;
	
UPDATE "amounttype"  
  SET "surcharge" = :ls_FSCBoth
 WHERE  "surcharge" is Null AND 
	("itemtype" = :ls_ItemTypeFreight AND "id" <> :ll_AmountType );
 Commit ;



// get the rate table or create it if it DNE
lds_RateTables = lnv_Rating.of_GetRateTableNameCache ( )
IF isValid ( lds_RateTables ) THEN

	ll_Find = lds_RateTables.find ( "ratetable_codename = '" + ls_FSCRateTableCodeName + "'"  , 1 , lds_RateTables.RowCount ( ) )
	
	IF ll_Find > 0 THEN // they have a rate table defined. so check the amount type
		IF IsNull ( lds_RateTables.GetItemNumber ( ll_Find , "ratetable_amounttype" ) )THEN
			lb_SetAmountType = TRUE
		END IF
	ELSE  // we did not find a rate table with a code name of FSC so create it
		lb_SetAmountType = TRUE
		INSERT INTO "ratetable"  
			( "codename",   
			  "name",   
			  "defaultdescription",   
			  "breakunit",   
			  "amounttype" )  
		VALUES ( :ls_FSCRateTableCodeName,   
					'FUEL SURCHARGE',   
					null,   
					null,   
					null );
		Commit ;
				
		
	END IF
	
END IF


// Set the amount type on the rate table
IF lb_SetAmountType THEN
	Open ( w_AmountTypeSelection )
	ll_AmountType = Message.DoubleParm	
		
	IF ll_AmountType > 0 THEN
		UPDATE "ratetable"  
		  SET "amounttype" = :ll_AmountType
		 WHERE  "codename"  = :ls_FSCRateTableCodeName;
		 Commit ;
	END IF
END IF

//Set the rate table as the code default
IF lnv_Settings.of_Setcodedefaultsetting ( 0, appeon_constant.cl_fuelsurcharge_list, ls_FSCRateTableCodeName ) = 1 THEN
	lnv_Settings.of_SaveSetting ( )
END IF

// reset the cache so the changes we made will be seen	
lnv_Rating.of_ResetCache ( )

			
DESTROY ( lnv_Rating )
DESTROY ( lnv_RateData )

String	ls_Message

ls_Message = "Please be sure to check the following setup as items may have been changed during the conversion." 
ls_Message += "~r~n* Amount Type Setup"
ls_Message += "~r~n* Rate Table for Fuel Surcharge"


MessageBox ( "Profit Tools Conversion" , ls_Message )









end event

public function boolean of_conversiondone ();RETURN ib_conversiondone
end function

on n_cst_specialops.create
call super::create
end on

on n_cst_specialops.destroy
call super::destroy
end on

event constructor;ib_conversiondone = TRUE
end event

