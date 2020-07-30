$PBExportHeader$n_cst_pcmilerconversions.sru
forward
global type n_cst_pcmilerconversions from n_base
end type
end forward

global type n_cst_pcmilerconversions from n_base
end type
global n_cst_pcmilerconversions n_cst_pcmilerconversions

forward prototypes
public function string of_getversion (n_cst_routing anv_routing)
public subroutine of_convertpq (n_cst_routing anv_routing)
public function integer of_convertcanadiancodes ()
end prototypes

public function string of_getversion (n_cst_routing anv_routing);string	ls_version

if anv_routing.of_isvalid() then
	ls_version = anv_routing.of_about("ProductVersion")
end if

return ls_Version
end function

public subroutine of_convertpq (n_cst_routing anv_routing);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_ConvertPQ
//	Access		:public
//
//	Arguments	:none
//
//	Return		:integer 
//						1 - success
//					  -1 - failure
//						
//	Description	:Canadian province of Quebec changed abbreviation from 'PQ' to 'QC'.
//					For PCMiler v. prior to 16 s/b 'PQ'. Version 16 and later s/b 'QC'.
//
//
// Written by	:Norm LeBlanc
// 		Date	:11/01/04
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////
//

SetPointer(HourGlass!)

string	ls_string

boolean	lb_convert

//check system setting to see if it has already been done
n_cst_setting_PQConversionDone	lnv_PQConversionDone
lnv_PQConversionDone = create n_cst_setting_PQConversionDone

IF lnv_PQConversionDone.of_Getvalue( ) = lnv_PQConversionDone.cs_Yes THEN
	// not needed
	
else
	
	SetPointer(HourGlass!)

	//check the PCMiler version to see if we need to convert
	if anv_routing.of_isvalid() then

		choose case this.of_GetVersion(anv_routing)
			case "11.0", "12.0", "2000.0", "14.0", "15.0"
				//don't convert
				lb_convert = FALSE
				
			case else//"16.0", "17.0", "18.0" etc..
				//convert
				lb_Convert = TRUE
				
		end choose

	end if
	
	//convert 
	IF lb_Convert then
		
		if this.of_convertcanadiancodes( ) = 1 then
			
			//set system setting
			SELECT ss_string
			 INTO :ls_string  
			 FROM system_settings
			WHERE ss_id = 191  ;
	
			ls_String = 'YES!'
			
			CHOOSE CASE SQLCA.SQLCODE
				CASE 0
					UPDATE "system_settings" SET "ss_string" = :ls_String WHERE "ss_id" = 191;
							
					CHOOSE CASE SQLCA.SQLCODE
						CASE 0,100
							Commit;
						CASE ELSE
							Rollback;
					END CHOOSE

				CASE 100
					  INSERT INTO "system_settings"  
								( "ss_id",   
								  "ss_uid",   
								  "ss_long",   
								  "ss_char",   
								  "ss_string",   
								  "ss_date",   
								  "ss_dec" )  
					  VALUES ( 191,   
								  0,   
								  null,   
								  null,   
								  :ls_string,   
								  null,   
								  null )  ;
					
					CHOOSE CASE SQLCA.SQLCODE
						CASE 0,100
							Commit;
						CASE ELSE
							Rollback;
					END CHOOSE
											
				CASE ELSE
					Rollback;
			END CHOOSE
			
		
		else
		
			RollBack;
		
		end if	
	end if
	
end if

destroy lnv_PQConversionDone


end subroutine

public function integer of_convertcanadiancodes ();integer	li_return = 1

long		ll_row, &
			ll_rowcount, &
			ll_pos
			
string	ls_locator, &
			ls_state

n_ds		lds_Canadian
		
lds_Canadian = create n_ds
lds_Canadian.dataobject = 'd_canadiancompanies'
lds_Canadian.SetTransObject(SQLCA)
ll_rowcount = lds_Canadian.retrieve( )

for ll_Row = 1 to ll_RowCount
	
	ls_state = lds_Canadian.object.co_State[ll_Row]
	
	choose case ls_state
			
		case 'PQ'
			
			lds_Canadian.object.co_State[ll_Row] = 'QC'
		
			ls_Locator = lds_Canadian.object.co_PCM[ll_Row]
			ll_pos = pos(upper(ls_Locator),'PQ',1)
			ls_locator = replace(ls_locator,ll_pos,2,'QC')
			lds_Canadian.object.co_PCM[ll_Row] = ls_Locator
			
		case 'NF'

			lds_Canadian.object.co_State[ll_Row] = 'NL'
		
			ls_Locator = lds_Canadian.object.co_PCM[ll_Row]
			ll_pos = pos(upper(ls_Locator),'NF',1)
			ls_locator = replace(ls_locator,ll_pos,2,'NL')
			lds_Canadian.object.co_PCM[ll_Row] = ls_Locator
			
		case 'YK'
			
			lds_Canadian.object.co_State[ll_Row] = 'YT'
		
			ls_Locator = lds_Canadian.object.co_PCM[ll_Row]
			ll_pos = pos(upper(ls_Locator),'YK',1)
			ls_locator = replace(ls_locator,ll_pos,2,'YT')
			lds_Canadian.object.co_PCM[ll_Row] = ls_Locator

	end choose

next

if ll_rowcount > 0 then
	
	if lds_Canadian.update() = 1 then
		
		li_return = 1
		
	else
		
		li_return = 0
				
	end if

	//commit happens in calling function
	
else
	
	li_return = 0
	
end if
			
return li_return
end function

on n_cst_pcmilerconversions.create
call super::create
end on

on n_cst_pcmilerconversions.destroy
call super::destroy
end on

