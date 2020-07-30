$PBExportHeader$n_cst_modlogreport.sru
$PBExportComments$[n_base] Ancestor of all Document objects
forward
global type n_cst_modlogreport from n_base
end type
end forward

global type n_cst_modlogreport from n_base
end type
global n_cst_modlogreport n_cst_modlogreport

forward prototypes
public subroutine of_parsemodlog (string as_parse, ref string as_date, ref string as_status, ref string as_user)
public subroutine of_createmodlogreport (date ad_start, date ad_end, ref string as_filename)
public function boolean of_isstatusvalid (string as_status)
end prototypes

public subroutine of_parsemodlog (string as_parse, ref string as_date, ref string as_status, ref string as_user);long	ll_pos, &
		ll_start
		

//date
ll_Pos = pos(as_parse, '~t', 1 )
if ll_pos > 0 then
	as_date = left(as_parse, ll_Pos - 1 )
end if

//time
ll_start = ll_Pos + 1
ll_Pos = pos(as_parse, '~t', ll_start )
 // not getting value
ll_start = ll_Pos + 1

//status
ll_Pos = pos(as_parse, '~t', ll_start )
if ll_Pos > 0 then
	as_status = mid(as_parse, ll_start, ll_pos - ll_start )
end if
if as_status = 'AUTHORIZED' THEN
	ll_start = ll_Pos + 1
else
	ll_start = ll_Pos + 2
end if

//user

if ll_Pos > 0 then
	as_user = mid(as_parse, ll_start, len(as_parse) - ( ll_start - 1 ) )
end if

end subroutine

public subroutine of_createmodlogreport (date ad_start, date ad_end, ref string as_filename);/////////////////////////////////////////////////////////
//
// Function	: of_CreateModlogReport
//
// Arguments 	:  
//				ad_start
//				ad_end
//				as_filename
//
// Returns 	none
//
// Description  : select all rows from the disp_ship table and count 
//						the status in the modlog column for CREATED, ROUTED, 
//						AUTHORIZED and AUDITED for each user within the date 
//						range from the arguments
//
// Author	: Norm LeBlanc
// Created on 	: 10/09/2003
// Modified by 	: Add Author here	TimeStamp
//				
/////////////////////////////////////////////////////////

string	ls_modlog,&
			ls_parse, &
			ls_status, &
			ls_user, &
			ls_date,&
			ls_path, &
			ls_filename = 'shipcnt.psr',&
			ls_reportfile
			
long		ll_pos, &
			ll_parsepos, &
			ll_ParseStart, &
			ll_count, &
			ll_rowcount, &
			ll_found, &
			ll_start=1

integer	li_sqlcode

n_ds		lds_ModlogReport

lds_ModlogReport = Create n_ds
lds_ModlogReport.SettransObject(SQLCA)
lds_ModlogReport.DataObject = 'd_modlogreport'

ls_path = gnv_app.of_GetApplicationFolder()
//creating on the local drive
ls_reportfile = "c:\" + ls_filename
//ls_reportfile = ls_path + ls_filename

lds_ModlogReport.object.t_startdate.text = string(ad_start,'mm/dd/yy')
lds_ModlogReport.object.t_enddate.text = string(ad_end,'mm/dd/yy')

 DECLARE modlog_cursor CURSOR FOR  
  SELECT "disp_ship"."ds_mod_log"  
    FROM "disp_ship" ;

  OPEN modlog_cursor;

do while li_sqlcode = 0
	
	FETCH modlog_cursor INTO :ls_modlog;
	
	li_sqlcode = sqlca.sqlcode
	
	if li_sqlcode = 0 then
		
		ll_start = 1
		ll_pos = 1
	
		if isnull(ls_modlog) then
			ll_pos = 0
		end if
		
		do until ll_pos = 0
			
			ls_date = ''
			ls_status = ''
			ls_user = ''
			
			ll_pos = pos(ls_modlog,'~r~n', ll_start)
			
			if ll_pos > 0 then
				
				ls_parse = mid(ls_modlog, ll_start, ll_pos - ll_start )
				this.of_ParseModlog(ls_parse, ls_date, ls_status, ls_user)		
				if this.of_IsStatusValid(ls_status) then
					if date(ls_date) >= ad_start and date(ls_date) <= ad_end then
						//write
						ll_rowcount = lds_ModlogReport.rowcount()
						if ll_rowcount > 0 then
							ll_found =  lds_ModlogReport.find("userid = '" + ls_user + "'", 1, ll_rowcount)
						end if
						
						if ll_found > 0 then
							//modify
						else
							ll_found = lds_Modlogreport.insertrow(0)
							lds_ModlogReport.object.userid[ll_found] = ls_user
						end if
						
						if ll_found > 0 then
							choose case ls_status
								case 'CREATED'
									ll_count = lds_ModlogReport.object.created[ll_found]
									if isnull(ll_count) then
										ll_count = 0
									end if
									lds_ModlogReport.object.created[ll_found] = ll_count + 1
									
								case 'ROUTED'
									ll_count = lds_ModlogReport.object.routed[ll_found]
									if isnull(ll_count) then
										ll_count = 0
									end if
									lds_ModlogReport.object.routed[ll_found] = ll_count + 1
									
								case 'AUTHORIZED'
									ll_count = lds_ModlogReport.object.authorized[ll_found]
									if isnull(ll_count) then
										ll_count = 0
									end if
									lds_ModlogReport.object.authorized[ll_found] = ll_count + 1
									
								case 'AUDITED'
									ll_count = lds_ModlogReport.object.audited[ll_found]
									if isnull(ll_count) then
										ll_count = 0
									end if
									lds_ModlogReport.object.audited[ll_found] = ll_count + 1			
								
							end choose
						end if
					end if					
				end if
					
			end if
			
			ll_start = ll_pos + 2
			
		loop
		
	end if
	
loop

 CLOSE modlog_cursor;

lds_ModlogReport.SaveAs (ls_reportfile , PSReport!, TRUE )

as_filename = ls_reportfile

destroy lds_ModlogReport


end subroutine

public function boolean of_isstatusvalid (string as_status);boolean	lb_valid

choose case as_status
	case 'CREATED', 'ROUTED', 'AUTHORIZED', 'AUDITED'
		lb_valid = true
	case else
		lb_valid = false
end choose

return lb_valid
end function

on n_cst_modlogreport.create
call super::create
end on

on n_cst_modlogreport.destroy
call super::destroy
end on

