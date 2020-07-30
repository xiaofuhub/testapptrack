$PBExportHeader$n_cst_acctlink_dynamics.sru
forward
global type n_cst_acctlink_dynamics from n_cst_acctlink
end type
type os_stats_dynamics from structure within n_cst_acctlink_dynamics
end type
end forward

type os_stats_dynamics from structure
	string		set
	string		dic
	string		uid
	string		pwd
	string		company
	string		sales_accounts[]
	long		sales_account_indexes[]
	string		recv_accounts[]
	long		recv_account_indexes[]
	integer		currency_index
	string		currency
	string		post_date_from
	boolean		connected
	boolean		logged_in
	boolean		batch_headers_open
	boolean		rm_keys_mstr_open
	boolean		rm_sales_work_open
	boolean		rm_distribution_work_open
	boolean		sy_batch_activity_mstr_open
	boolean		gl_account_mstr_open
	boolean		mc_setp_open
	boolean		sy_posting_journal_settings_open
end type

global type n_cst_acctlink_dynamics from n_cst_acctlink
end type
global n_cst_acctlink_dynamics n_cst_acctlink_dynamics

type variables
Private:
n_cst_dde inv_cst_dde
os_stats_dynamics istr_stats
string is_date_format = "m/d/yy"
Integer	ii_DiagnosticsFile = -1
Boolean	ib_SixPlus //***Determine via system setting in constructor***
Boolean	ib_SevenPlus //***Determine via system setting in constructor***
Boolean	ib_NoCellUpdates //***Determine via system setting in constructor***
end variables

forward prototypes
public function integer of_link_open (ref string as_posting_company)
public function integer of_logon (string as_posting_company, string as_uid, string as_pwd)
public function integer of_validate_accounts (n_cst_msg anv_cst_msg, ref string as_notice)
public function integer of_validate_customers (datastore ads_list)
public function integer of_batch_create (n_cst_msg anv_cst_msg)
protected function boolean of_batch_clearflags (ref boolean ab_sy_batch_activity_mstr_flagged, ref boolean ab_batch_headers_flagged)
protected function integer of_make_command (string as_table, s_anys astr_parms, ref string as_command)
protected function integer of_batch_list (ref string asa_list[])
public function boolean of_link_close ()
protected function boolean of_command_eval (string as_target)
protected function string of_command_sub (string as_target)
end prototypes

public function integer of_link_open (ref string as_posting_company);boolean lb_first_attempt, lb_success, lb_approval
string ls_work, ls_reject, lsa_parsed[], ls_response, ls_trailing_period
integer li_selection
s_parm lstr_parm
n_cst_msg lnv_cst_msg
os_stats_dynamics lstr_blank_stats
n_cst_string lnv_string

if istr_stats.connected = true then return 1
istr_stats = lstr_blank_stats

ls_reject = "Could not process request."

//The following is used in constructing the instructions sentences.  It is used to
//avoid a double period.
if right(as_posting_company, 1) = "." then ls_trailing_period = "" &
	else ls_trailing_period = "."

lb_first_attempt = true
lb_approval = false

do

	if istr_stats.connected = false then
		istr_stats.connected = inv_cst_dde.of_OpenChannel("DYNAMICS", "DBMS")
	end if

	if istr_stats.connected then
		
		if inv_cst_dde.of_GetRemote("DBMS.GetInfo()", ls_response) then
			if lnv_string.of_ParseToArray(ls_response, "~t", lsa_parsed) = 4 then
				if upper(as_posting_company) = upper(lsa_parsed[3]) or &
					lsa_parsed[3] = "The World Online, Inc." then
						istr_stats.set = lsa_parsed[1]
						istr_stats.dic = lsa_parsed[2]
						istr_stats.company = lsa_parsed[3]
						istr_stats.uid = lsa_parsed[4]
						lb_approval = true
				end if
			end if
		end if

		if not lb_approval then
			ls_work = "Please switch to Dynamics now and log in to " + as_posting_company +&
				ls_trailing_period + "  Once you have done so, switch back to this screen "+&
				"and press OK to continue."
			if not lb_first_attempt then &
				ls_work = "You must log in to Dynamics in order to create an AR batch.  " + ls_work
		end if

	else

		ls_work = "Please start Dynamics now and log in to " + as_posting_company +&
			ls_trailing_period + "  Once you have done so, switch back to this screen "+&
			"and press OK to continue."
		if not lb_first_attempt then &
			ls_work = "Dynamics must be running in order to create an AR batch.  " + ls_work

	end if

	if not lb_approval then

		lnv_cst_msg.of_reset()

		lstr_parm.is_label = "REQUEST"
		lstr_parm.ia_value = "MESSAGE!"
		lnv_cst_msg.of_add_parm(lstr_parm)

		lstr_parm.is_label = "MESSAGE"
		lstr_parm.ia_value = ls_work
		lnv_cst_msg.of_add_parm(lstr_parm)

		openwithparm(w_acct_logon, lnv_cst_msg)
		li_selection = message.doubleparm

		choose case li_selection
		case 1 //User pressed OK
			lb_first_attempt = false
			//Continue loop (try to connect again)
		case -2, -3 //-2 = User chose No AR Batch, -3 = User chose Cancel Billing
			return li_selection
		case else //-1 = Error, or Unexpected return value
			goto failure
		end choose

	end if

loop while lb_approval = false



lnv_cst_msg.of_reset()

lstr_parm.is_label = "REQUEST"
lstr_parm.ia_value = "LOGON!"
lnv_cst_msg.of_add_parm(lstr_parm)

lstr_parm.is_label = "ACCTLINK"
lstr_parm.ia_value = this
lnv_cst_msg.of_add_parm(lstr_parm)

lstr_parm.is_label = "COMPANY"
lstr_parm.ia_value = istr_stats.company
lnv_cst_msg.of_add_parm(lstr_parm)

lstr_parm.is_label = "UID"
lstr_parm.ia_value = istr_stats.uid
lnv_cst_msg.of_add_parm(lstr_parm)

lstr_parm.is_label = "INSTRUCT"
lstr_parm.ia_value = "Please enter the password used to connect to Dynamics."
lnv_cst_msg.of_add_parm(lstr_parm)

openwithparm(w_acct_logon, lnv_cst_msg)
li_selection = message.doubleparm

choose case li_selection
case 1 //User logged on successfully
	//No processing needed (the response window will already have called functions 
	//	in this object making it aware of the PWD and setting the logged_in flag, etc.)
case -2, -3 //-2 = User chose No AR Batch, -3 = User chose Cancel Billing
	return li_selection
case else //-1 = Error, or Unexpected return value
	goto failure
end choose



//Open assorted tables

ls_reject = "Could not access one or more Dynamics data tables needed to perform this "+&
	"procedure.  Please verify your access privileges."


lb_success = inv_cst_dde.of_GetRemote("Table.Open(Batch_Headers)", ls_response)
if lb_success and ls_response = "0" then istr_stats.Batch_Headers_OPEN = true else goto failure

lb_success = inv_cst_dde.of_GetRemote("Table.Open(RM_Keys_MSTR)", ls_response)
if lb_success and ls_response = "0" then istr_stats.RM_Keys_MSTR_OPEN = true else goto failure

lb_success = inv_cst_dde.of_GetRemote("Table.Open(RM_Sales_WORK)", ls_response)
if lb_success and ls_response = "0" then istr_stats.RM_Sales_WORK_OPEN = true else goto failure

lb_success = inv_cst_dde.of_GetRemote("Table.Open(RM_Distribution_WORK)", ls_response)
if lb_success and ls_response = "0" then istr_stats.RM_Distribution_WORK_OPEN = true else goto failure

lb_success = inv_cst_dde.of_GetRemote("Table.Open(SY_Batch_Activity_MSTR)", ls_response)
if lb_success and ls_response = "0" then istr_stats.SY_Batch_Activity_MSTR_OPEN = true else goto failure

lb_success = inv_cst_dde.of_GetRemote("Table.Open(GL_Account_MSTR)", ls_response)
if lb_success and ls_response = "0" then istr_stats.GL_Account_MSTR_OPEN = true else goto failure


//Get functional currency id and index value

lb_success = inv_cst_dde.of_GetRemote("Table.Open(MC_SETP)", ls_response)
if lb_success and ls_response = "0" then istr_stats.MC_SETP_OPEN = true else goto failure

ls_reject = "Could not verify Dynamics Multicurrency Setup information."

lb_success = inv_cst_dde.of_GetRemote("Row.SetSelection('Functional Currency', 'Functional Currency Index')", &
	ls_response)
if lb_success and ls_response = "0" then lb_success = lb_success else goto failure

lb_success = inv_cst_dde.of_GetRemote("Row.GetFirst()", ls_response)

if lb_success and lnv_string.of_ParseToArray(ls_response, "~t", lsa_parsed) = 2 then
	istr_stats.currency = lsa_parsed[1]
	istr_stats.currency_index = integer(lsa_parsed[2])
else
	goto failure
end if

lb_success = inv_cst_dde.of_GetRemote("Table.Close()", ls_response)
if lb_success and ls_response = "0" then istr_stats.MC_SETP_OPEN = false


//Get Post Date From value (Batch vs. Document)

ls_reject = "Could not access one or more Dynamics data tables needed to perform this "+&
	"procedure.  Please verify your access privileges."

lb_success = inv_cst_dde.of_GetRemote("Table.Open(SY_Posting_Journal_Settings)", ls_response)
if lb_success and ls_response = "0" then istr_stats.SY_Posting_Journal_Settings_OPEN = true else goto failure

ls_reject = "Could not verify Dynamics Posting Setup information."

lb_success = inv_cst_dde.of_GetRemote("Key.Set(Journal_Settings_Key_1)", ls_response)
if lb_success and ls_response = "0" then lb_success = lb_success else goto failure

lb_success = inv_cst_dde.of_SetRemote("Key.SetData()", "3, 'Receivables Sales Entry', "+&
	"3, 'Receivables Sales Entry'")
if not lb_success then goto failure

lb_success = inv_cst_dde.of_GetRemote("Row.SetSelection('Use Posting Date From')", ls_response)
if lb_success and ls_response = "0" then lb_success = lb_success else goto failure

lb_success = inv_cst_dde.of_GetRemote("Row.GetFirst()", ls_response)
if lb_success and (ls_response = "0" or ls_response = "1") then
	if ls_response = "1" then istr_stats.post_date_from = "DOCUMENT" else istr_stats.post_date_from = "BATCH"
else
	goto failure
end if

lb_success = inv_cst_dde.of_GetRemote("Table.Close()", ls_response)
if lb_success and ls_response = "0" then istr_stats.SY_Posting_Journal_Settings_OPEN = false

ii_DiagnosticsFile = FileOpen ( "c:\ptdiag.txt", LineMode!, Write!, LockReadWrite!, Append! )

IF ii_DiagnosticsFile >= 0 THEN
	FileWrite ( ii_DiagnosticsFile, "***Begin Session***" )
END IF

return 1

failure:
messagebox("Connect to Dynamics", ls_reject + "~n~nRequest cancelled.", exclamation!)
return -1



////////////////////////


//		if upperbound(istr_expected_companies.strar) > 1 then &
//			ls_work += "one of the following companies: "
//		for li_ndx = 1 to upperbound(istr_expected_companies.strar)
//			if li_ndx > 1 then ls_work += ", "
//			ls_work += istr_expected_companies.strar[li_ndx]
//		next
end function

public function integer of_logon (string as_posting_company, string as_uid, string as_pwd);boolean lb_success
string ls_response

if len(trim(as_pwd)) > 0 then
	//No processing needed.
else
	messagebox("Dynamics Login", "You must enter a password in order to connect.")
	return -1
end if

if not (of_command_eval(istr_stats.set) and of_command_eval(istr_stats.dic) and &
	of_command_eval(istr_stats.company) and of_command_eval(istr_stats.uid) and &
	of_command_eval(as_pwd)) then
		messagebox("Dynamics Login", "Could not log in to Dynamics due to a character "+&
			"substitution conflict.  Please contact Profit Tools technical support for "+&
			"assistance.", exclamation!)
		return -1
end if

lb_success = inv_cst_dde.of_GetRemote("DBMS.Login('" + of_command_sub(istr_stats.set) + "', '" +&
	of_command_sub(istr_stats.dic) + "', '" + of_command_sub(istr_stats.company) + "', '" +&
	of_command_sub(istr_stats.uid) + "', '" + of_command_sub(as_pwd) + "')", ls_response)

if lb_success and ls_response = "0" then
	istr_stats.pwd = as_pwd
	istr_stats.logged_in = true
	return 1
else
	messagebox("Dynamics Login", "Could not log in to Dynamics.  Please type your "+&
		"password again and retry.", exclamation!)
	return -1
end if
end function

public function integer of_validate_accounts (n_cst_msg anv_cst_msg, ref string as_notice);string ls_response, ls_account_type, ls_category_description, ls_account_number
string lsa_validation_list[], lsa_valid_accounts[], lsa_parsed[]
long ll_account_category, ll_account_index, lla_valid_indexes[]
integer li_checkloop, li_ndx
boolean lb_success
s_parm lstr_parm
n_cst_anyarraysrv lnv_anyarray
n_cst_string lnv_string

as_notice = ""

lb_success = inv_cst_dde.of_GetRemote("Table.Set(GL_Account_MSTR)", ls_response)
if lb_success and ls_response = "0" then lb_success = lb_success else goto failure

lb_success = inv_cst_dde.of_GetRemote("Key.Set(GL_Account_MSTR_Key6)", ls_response)
if lb_success and ls_response = "0" then lb_success = lb_success else goto failure

lb_success = inv_cst_dde.of_GetRemote("Row.SetSelection('Account Index', 'Account Number', "+&
	"'Account Category Number', 'Active')", ls_response)
if lb_success and ls_response = "0" then lb_success = lb_success else goto failure


for li_checkloop = 1 to anv_cst_msg.of_get_count()

	anv_cst_msg.of_get_parm(li_checkloop, lstr_parm)

	choose case lstr_parm.is_label
	case "SALES", "RECV"
		ls_account_type = lstr_parm.is_label
		lsa_validation_list = lstr_parm.ia_value
	case else
		continue
	end choose

	choose case ls_account_type
	case "SALES"
		ll_account_category = 31  //31 = Sales
		ls_category_description = "Sales Account"
		lsa_valid_accounts = istr_stats.sales_accounts
		lla_valid_indexes = istr_stats.sales_account_indexes
	case "RECV"
		ll_account_category = 3  //3 = Accounts Receivable
		ls_category_description = "Receivables Account"
		lsa_valid_accounts = istr_stats.recv_accounts
		lla_valid_indexes = istr_stats.recv_account_indexes
	end choose

	//Note:  Account Category values are not the same as Distribution Type values.

	for li_ndx = 1 to upperbound(lsa_validation_list)
		ls_account_number = lsa_validation_list[li_ndx]

		if lnv_anyarray.of_Find( lsa_valid_accounts, ls_account_number, null_long, null_long) > 0 &
			then continue

		if not inv_cst_dde.of_SetRemote("Key.SetData()", "'" + ls_account_number + "', '"+&
			ls_account_number + "'") then goto failure
	
		lb_success = inv_cst_dde.of_GetRemote("Row.GetFirst()", ls_response)
	
		if lb_success and lnv_string.of_ParseToArray(ls_response, "~t", lsa_parsed) = 4 then

			if lsa_parsed[2] = ls_account_number then
				lb_success = lb_success
			else
				//This CAN happen.  One example:  If the account 000-1200-00 exists, and
				//you're looking for 000-1200-000 (extra trailing 0), 000-1200-00 will
				//be found and processing will come here.  I don't think we need to execute
				//a loop here, though, because only one of the two formats should be right, 
				//and if there is a "true" match, it should be the first row returned.
				as_notice += "~nThe account " + ls_account_number + " does not exist."
				continue
			end if

			if long(lsa_parsed[3]) = ll_account_category then
				//Account is the correct category
			else
				as_notice += "~nThe account " + ls_account_number + " is not a " +&
					ls_category_description + "."
				continue
			end if

			if long(lsa_parsed[4]) = 1 then
				//Account is active
			else
				as_notice += "~nThe account " + ls_account_number + " is not active."
				continue
			end if

			ll_account_index = long(lsa_parsed[1])
			if ll_account_index > 0 then
				lsa_valid_accounts[upperbound(lsa_valid_accounts) + 1] = ls_account_number
				lla_valid_indexes[upperbound(lla_valid_indexes) + 1] = ll_account_index
			else
				as_notice += "~nCould not determine Index for the account " + ls_account_number + "."
				continue
			end if

		else
			as_notice += "~nThe account " + ls_account_number + " does not exist."
		end if
	next

	choose case ls_account_type
	case "SALES"
		istr_stats.sales_accounts = lsa_valid_accounts
		istr_stats.sales_account_indexes = lla_valid_indexes
	case "RECV"
		istr_stats.recv_accounts = lsa_valid_accounts
		istr_stats.recv_account_indexes = lla_valid_indexes
	end choose

next

if len(as_notice) > 0 then goto failure

lb_success = inv_cst_dde.of_GetRemote("Table.Close()", ls_response)
if lb_success and ls_response = "0" then istr_stats.GL_Account_MSTR_OPEN = false

//Script that set account index values into dw_bills used to be here

return 1

failure:
if len(as_notice) = 0 then as_notice = "Could not verify Dynamics posting account information."
return -1
end function

public function integer of_validate_customers (datastore ads_list);//Returns the number of entries in the primary buffer that do not pass validation 
//(0 = All OK.)  Returns -1 if an error occurs.

boolean lb_RM_Customer_MSTR_OPEN
string ls_acctcode, ls_acctsub, ls_acctname
long ll_row, ll_valid_count, ll_invalid_count

boolean lb_success
string ls_response

setpointer(hourglass!)

lb_success = inv_cst_dde.of_GetRemote("Table.Open(RM_Customer_MSTR)", ls_response)
if lb_success and ls_response = "0" then lb_success = lb_success else goto failure
lb_RM_Customer_MSTR_OPEN = true

lb_success = inv_cst_dde.of_GetRemote("Key.Set(RM_Customer_MSTR_Key1)", ls_response)
if lb_success and ls_response = "0" then lb_success = lb_success else goto failure

lb_success = inv_cst_dde.of_GetRemote("Row.SetSelection('Customer Name')", ls_response)
if lb_success and ls_response = "0" then lb_success = lb_success else goto failure

for ll_row = 1 to ads_list.rowcount()

	ls_acctcode = ads_list.object.co_bill_acctcode[ll_row]

	if len(trim(ls_acctcode)) > 0 then

		if of_command_eval(ls_acctcode) then
			ls_acctsub = of_command_sub(ls_acctcode)
		else
			continue
			//This will appear to the user as an invalid id, which is sufficient for now.
			//The real explanation is that there is a character substitution problem.
		end if

		if inv_cst_dde.of_SetRemote("Key.SetData()", "'" + ls_acctsub + "', '" + ls_acctsub + "'") then
			ls_acctname = ""
			if inv_cst_dde.of_GetRemote("Row.GetFirst()", ls_acctname) then
				if len(ls_acctname) > 0 then
					ll_valid_count ++
					ads_list.object.xx_acct_name[ll_row] = ls_acctname
					ads_list.object.approved[ll_row] = "T"
				else
					goto failure
				end if
			//else
				//Originally, we made a distinction between -2 and the other failure values.
				//Now, we're simply assuming the failure to be a -2.
			end if
		else
			goto failure
		end if
	end if
next

inv_cst_dde.of_GetRemote("Table.Close()", ls_response)

ll_invalid_count = ads_list.rowcount() - ll_valid_count

return ll_invalid_count

failure:
if lb_RM_Customer_MSTR_OPEN then inv_cst_dde.of_GetRemote("Table.Close()", ls_response)
return -1
end function

public function integer of_batch_create (n_cst_msg anv_cst_msg);//Return Values : 1 = Success, -1 = Failure, -2 = User Chose No AR Batch

//This function is responsible for its own error notifications and explanations.


n_cst_anyarraysrv lnv_anyarray
string ls_noco_skiplist, ls_dup_skiplist, ls_err_skiplist, ls_work1, ls_work2, ls_work3, &
	ls_message, ls_temp, ls_command, lsa_batch_list[]
decimal {2} lc_temp
long ll_trns, ll_dist, ll_noco_skipcount, ll_dup_skipcount, &
	ll_err_skipcount, ll_temp, ll_account_index
s_anys lstr_command_parms, lstr_empty_parms

integer li_ndx
s_parm lstr_parm
n_cst_msg lnv_Msg
boolean lb_success
string ls_batch_type, ls_batch_number, ls_response
date ld_batch_date
s_accounting_transaction lstra_trns[]
s_accounting_distribution lstr_dist

boolean lb_batch_started, lb_Batch_Headers_FLAGGED, lb_SY_Batch_Activity_MSTR_FLAGGED, &
	lb_batch_completed, lb_Append
Long	ll_BatchCount
Decimal {2}	lc_BatchTotal

//Extract parameters from message object that was passed in.

for li_ndx = 1 to anv_cst_msg.of_get_count()
	if anv_cst_msg.of_get_parm(li_ndx, lstr_parm) > 0 then
		choose case lstr_parm.is_label
		case "BATCH_TYPE"
			ls_batch_type = lstr_parm.ia_value
		case "TRANSACTION"
			lstra_trns[upperbound(lstra_trns) + 1] = lstr_parm.ia_value
		end choose
	end if
next

//Validate requested batch type

choose case ls_batch_type
case "SALES!"
	//Batch type is OK
case else
	goto failure
end choose


//Verify that the ib_SixPlus value has been determined correctly.

IF IsNull ( ib_SixPlus ) THEN

	//Give a preliminary heads-up message.
	MessageBox ( "Create AR Batch", "Error evaluating Dynamics Version number." )

	//Now, give the normal failure message, too.
	GOTO Failure

END IF


//Get Batch Number and Batch Date

if not this.of_batch_list(lsa_batch_list) = 1 then goto failure
//You could consider proceeding even if this fails, or putting this in an attempt loop.


do
	lb_success = false

	lnv_Msg.of_reset()
	
	lstr_parm.is_label = "BATCH_LIST"
	lstr_parm.ia_value = lsa_batch_list
	lnv_Msg.of_add_parm(lstr_parm)
	
	openwithparm(w_acct_batchnum, lnv_Msg)
	lnv_Msg = message.powerobjectparm
	
	if not lnv_Msg.of_get_parm("SELECTION", lstr_parm) > 0 then goto failure
	
	choose case lstr_parm.ia_value
	case "CREATE_BATCH!"
		if not lnv_Msg.of_get_parm("BATCH_NUMBER", lstr_parm) > 0 then goto failure
		ls_batch_number = lstr_parm.ia_value
	
		if lnv_Msg.of_get_parm("BATCH_DATE", lstr_parm) > 0 then
			ld_batch_date = lstr_parm.ia_value
		else
			ld_batch_date = today()
		end if

		IF lnv_Msg.of_Get_Parm ( "APPEND", lstr_Parm ) > 0 THEN
			lb_Append = TRUE
		END IF


		//If we can't do cell updates, we can't append, because we won't be able to update
		//the batch totals (dollars and count.)  So, throw an error if both conditions are true.

		IF lb_Append = TRUE AND ib_NoCellUpdates = TRUE THEN

			MessageBox ( "Append to AR Batch", "Append is not supported when MS SQL Server is "+&
				"being used as the database for Dynamics, because batch totals cannot be updated.  "+&
				"You will need to specify a different batch number." )

			CONTINUE

		END IF


		if of_command_eval(ls_batch_number) = false then
			messagebox("Create AR Batch", "The batch number you have specified is not "+&
				"acceptable due to a character substitution conflict.  You will need to "+&
				"specify a different batch number.  If you need further explanation, please "+&
				"contact Profit Tools technical support.")
			continue
		end if

		lb_success = true

	case "NO_BATCH!"
		return -2
	case else //Unexpected value
		goto failure
	end choose

loop until lb_success = true


setpointer(hourglass!)

////////////////////////////
//This section added to determine batch count and total ahead of time, to deal w. SQL Server
//Note that this option does not apply to append, which will fail under SQL Server

IF ib_NoCellUpdates = TRUE THEN

	for ll_trns = 1 to upperbound(lstra_trns)
	
		ll_BatchCount ++
		lc_BatchTotal += lstra_trns[ll_trns].ic_document_amount
	
	next

END IF

///////////////


//Create Batch Header

lb_success = inv_cst_dde.of_GetRemote("Table.Set(Batch_Headers)", ls_response)

//Yields were originally added during development of the version 6 interface as an 
//attempt to counteract some problems.  They were still in when we solved the problem, 
//which was a column name issue, so I believe the yields are not necessary.  So, I'm
//commenting them out, but leaving the comments there for now in case it turns out 
//they WERE necessary.  If this build runs fine, we can remove them.  Please note that
//there are some yields that were in before -- these are not commented or conditional, 
//and should be left alone.
//
//IF ib_SixPlus THEN
//	yield()
//END IF

if lb_success and ls_response = "0" then lb_success = lb_success else goto failure


IF lb_Append = TRUE THEN

	lb_success = inv_cst_dde.of_GetRemote("Key.Set(Batch_Header_Key7)", ls_response)
	if lb_success and ls_response = "0" then lb_success = lb_success else goto failure

//	IF ib_SixPlus THEN
//		yield()
//	END IF
	
	ls_Command = "3, RM_Sales, 'BATCH', 3, RM_Sales, 'BATCH'"
	ls_Command = Substitute ( ls_Command, "BATCH", of_Command_Sub ( ls_Batch_Number ) )
	if not inv_cst_dde.of_SetRemote( "Key.SetData()", ls_Command ) then goto failure

//	IF ib_SixPlus THEN
//		yield()
//	END IF


	lb_success = inv_cst_dde.of_GetRemote("Row.SetSelection('Number Of TRX')", ls_response)
	if lb_success and ls_response = "0" then lb_success = lb_success else goto failure

//	IF ib_SixPlus THEN
//		yield()
//	END IF

	lb_success = inv_cst_dde.of_GetRemote("Row.GetFirst()", ls_response)
	if lb_success and IsNumber( ls_Response ) then &
		ll_BatchCount = Long ( ls_Response ) else goto failure

//	IF ib_SixPlus THEN
//		yield()
//	END IF

	lb_success = inv_cst_dde.of_GetRemote("Row.SetSelection('Batch Total')", ls_response)
	if lb_success and ls_response = "0" then lb_success = lb_success else goto failure

//	IF ib_SixPlus THEN
//		yield()
//	END IF
	
	lb_success = inv_cst_dde.of_GetRemote("Row.GetFirst()", ls_response)
	if lb_success and IsNumber( ls_Response ) then &
		lc_BatchTotal = Dec ( ls_Response ) else goto failure

//	IF ib_SixPlus THEN
//		yield()
//	END IF

	//Should possibly set User ID and Modified Date

	lb_success = inv_cst_dde.of_SetRemote("Cell.SetData('Batch Status')", "3")
	if lb_success then lb_success = lb_success else goto failure

//	IF ib_SixPlus THEN
//		yield()
//	END IF

ELSE

	lstr_command_parms = lstr_empty_parms
	
	//[1] = GL Posting Date (Date)
	lstr_command_parms.anys[1] = ld_batch_date
	
	//[2] = Batch Number (String)
	lstr_command_parms.anys[2] = ls_batch_number
	
	//[3] = Number Of TRX (Long)

	IF ib_NoCellUpdates = TRUE THEN
		ll_temp = ll_BatchCount
	ELSE
		ll_temp = 0
	END IF

	lstr_command_parms.anys[3] = ll_temp
	
	//[4] = Batch Comment (String)
	ls_temp = "Created by Profit Tools"
	lstr_command_parms.anys[4] = ls_temp
	
	//[5] = Batch Total (Currency)
	IF ib_NoCellUpdates = TRUE THEN
		lc_temp = lc_BatchTotal
	ELSE
		lc_temp = 0.00
	END IF
	lstr_command_parms.anys[5] = lc_temp
	
	//[6] = Batch Status (Integer)
	IF ib_NoCellUpdates = TRUE THEN
		ll_temp = 0
	ELSE
		ll_temp = 3
	END IF
	lstr_command_parms.anys[6] = ll_temp
	
	choose case this.of_make_command("Batch_Headers", lstr_command_parms, ls_command)
	case 1
		//No processing needed
	case else
		goto failure
	end choose

	IF ii_DiagnosticsFile >= 0 THEN
		FileWrite ( ii_DiagnosticsFile, "Row.Create() :: " + ls_Command )
	END IF
	
	if not inv_cst_dde.of_SetRemote("Row.Create()", ls_command) then goto failure

//	IF ib_SixPlus THEN
//		yield()
//	END IF

	IF ib_NoCellUpdates = TRUE THEN
		ll_BatchCount = 0
		lc_BatchTotal = 0
	END IF

END IF

lb_batch_started = true
lb_Batch_Headers_FLAGGED = true

//For some unknown reason, the GL Posting Date provided in the row create string above
//doesn't take; you end up with 0/0/00 in the column.  It does take when you set it this way.
//This same problem occurs with the Document Date in RM_Sales_WORK (below).

//This seems to have been fixed in Dynamics in 6.0, so I'm going to make the attempt conditional
//on us being running against a pre-6.0 version.  (And, because of this issue we don't support 
//MS SQL Server in pre-6.0, so ib_NoCellUpdates should not be TRUE.)

IF ib_SixPlus = FALSE THEN

	IF ii_DiagnosticsFile >= 0 THEN
		FileWrite ( ii_DiagnosticsFile, "Cell.SetData('GL Posting Date') :: " + string(ld_batch_date, &
		is_date_format) )
	END IF
	
	if not inv_cst_dde.of_SetRemote("Cell.SetData('GL Posting Date')", string(ld_batch_date, &
		is_date_format)) then goto failure

END IF

//Create Batch Activity entry

IF ii_DiagnosticsFile >= 0 THEN
	FileWrite ( ii_DiagnosticsFile, "Table.Set(SY_Batch_Activity_MSTR)" )
END IF

lb_success = inv_cst_dde.of_GetRemote("Table.Set(SY_Batch_Activity_MSTR)", ls_response)
if lb_success and ls_response = "0" then lb_success = lb_success else goto failure
lb_SY_Batch_Activity_MSTR_FLAGGED = true

//IF ib_SixPlus THEN
//	yield()
//END IF

lstr_command_parms = lstr_empty_parms

//[1] = Batch Number (String)
lstr_command_parms.anys[1] = ls_batch_number

//[2] = Posting (Boolean) -- as long
ll_temp = 1
lstr_command_parms.anys[2] = ll_temp

choose case this.of_make_command("SY_Batch_Activity_MSTR", lstr_command_parms, ls_command)
case 1
	//No processing needed
case else
	goto failure
end choose

IF ii_DiagnosticsFile >= 0 THEN
	FileWrite ( ii_DiagnosticsFile, "Row.Create() :: " + ls_command )
END IF

if not inv_cst_dde.of_SetRemote("Row.Create()", ls_command) then goto failure

//IF ib_SixPlus THEN
//	yield()
//END IF

//Create Transactions

for ll_trns = 1 to upperbound(lstra_trns)

	if len(lstra_trns[ll_trns].is_company_code) > 0 and len(lstra_trns[ll_trns].is_company_name) > 0 then
		//Company Name and Accounting ID are OK
	else
		ll_noco_skipcount ++
		if len(ls_noco_skiplist) > 0 then ls_noco_skiplist += ", "
		ls_noco_skiplist += lstra_trns[ll_trns].is_document_number
		continue
	end if
	
	//Create RM_Keys_MSTR entry

	IF ii_DiagnosticsFile >= 0 THEN
		FileWrite ( ii_DiagnosticsFile, "Table.Set(RM_Keys_MSTR)" )
	END IF
	
	lb_success = inv_cst_dde.of_GetRemote("Table.Set(RM_Keys_MSTR)", ls_response)

	yield()

	if lb_success and ls_response = "0" then
		//No processing needed
	else
		ll_err_skipcount ++
		if len(ls_err_skiplist) > 0 then ls_err_skiplist += ", "
		ls_err_skiplist += lstra_trns[ll_trns].is_document_number
		continue
	end if

	lstr_command_parms = lstr_empty_parms
	
	//[1] = Document Number (String)
	lstr_command_parms.anys[1] = lstra_trns[ll_trns].is_document_number
	
	//[2] = Customer Number (String)
	lstr_command_parms.anys[2] = lstra_trns[ll_trns].is_company_code
	
	//[3] = Document Date (Date)
	lstr_command_parms.anys[3] = lstra_trns[ll_trns].id_document_date
	
	choose case this.of_make_command("RM_Keys_MSTR", lstr_command_parms, ls_command)
	case 1
		//No processing needed
	case else
		ll_err_skipcount ++
		if len(ls_err_skiplist) > 0 then ls_err_skiplist += ", "
		ls_err_skiplist += lstra_trns[ll_trns].is_document_number
		continue
	end choose

	IF ii_DiagnosticsFile >= 0 THEN
		FileWrite ( ii_DiagnosticsFile, "Row.Create() :: " + ls_command )
	END IF

	lb_success = inv_cst_dde.of_SetRemote("Row.Create()", ls_command)

	yield()

	if not lb_success then
		//We are assuming that failure here is due to a duplicate existing entry.
		//This is really only the case if the SetRemote return code is -2.
		//Other return codes would indicate a different type of error.
		ll_dup_skipcount ++
		if len(ls_dup_skiplist) > 0 then ls_dup_skiplist += ", "
		ls_dup_skiplist += lstra_trns[ll_trns].is_document_number
		continue
	end if
	
	//Create RM_Sales_WORK entry

	IF ii_DiagnosticsFile >= 0 THEN
		FileWrite ( ii_DiagnosticsFile, "Table.Set(RM_Sales_WORK)" )
	END IF
	
	lb_success = inv_cst_dde.of_GetRemote("Table.Set(RM_Sales_WORK)", ls_response)

	yield()

	if lb_success and ls_response = "0" then lb_success = lb_success &
		else goto delete_RM_Keys_MSTR_entry
	
	lstr_command_parms = lstr_empty_parms
	
	//[1] = RM Document Number-WORK (String)
	lstr_command_parms.anys[1] = lstra_trns[ll_trns].is_document_number
	
	//[2] = Document Date (Date)
	lstr_command_parms.anys[2] = lstra_trns[ll_trns].id_document_date
	
	//[3] = Batch Number (String)
	lstr_command_parms.anys[3] = ls_batch_number
	
	//[4] = Customer Number (String)
	lstr_command_parms.anys[4] = lstra_trns[ll_trns].is_company_code
	
	//[5] = Customer Name (String)
	lstr_command_parms.anys[5] = lstra_trns[ll_trns].is_company_name
	
	//[6] = Address Code (String)
	ls_temp = ""
	lstr_command_parms.anys[6] = ls_temp
	
	//[7] = Sales Amount (Currency)
	lstr_command_parms.anys[7] = lstra_trns[ll_trns].ic_document_amount
	
	//[8] = *Batch Date (Date) [This is not a field in RM_Sales_WORK]
	lstr_command_parms.anys[8] = ld_batch_date
	
	choose case this.of_make_command("RM_Sales_WORK", lstr_command_parms, ls_command)
	case 1
		//No processing needed
	case else
		goto delete_RM_Keys_MSTR_entry
	end choose

	IF ii_DiagnosticsFile >= 0 THEN
		FileWrite ( ii_DiagnosticsFile, "Row.Create() :: " + ls_command )
	END IF

	lb_success = inv_cst_dde.of_SetRemote("Row.Create()", ls_command)

	yield()

	if lb_success then lb_success = lb_success &
		else goto delete_RM_Keys_MSTR_entry
	
	//For some unknown reason, the document date provided in the row create string above
	//doesn't take; you end up with 0/0/00 in the column.  It does take when you set it this way.
	//This same problem occurs with the GL Posting Date in Batch_Headers (above).

	//This seems to have been fixed in Dynamics in 6.0, so I'm going to make the attempt conditional
	//on us being running against a pre-6.0 version.  (And, because of this issue we don't support 
	//MS SQL Server in pre-6.0, so ib_NoCellUpdates should not be TRUE.)

	IF ib_SixPlus = FALSE THEN

		IF ii_DiagnosticsFile >= 0 THEN
			FileWrite ( ii_DiagnosticsFile, "Cell.SetData('Document Date') :: " + string(lstra_trns[ll_trns].id_document_date, is_date_format) )
		END IF
	
		lb_success = inv_cst_dde.of_SetRemote("Cell.SetData('Document Date')", string(lstra_trns[ll_trns].id_document_date, is_date_format))
	
		yield()

	END IF

	if lb_success then lb_success = lb_success &
		else goto delete_RM_Sales_WORK_entry
	
	//Create RM_Distribution_WORK entries

	IF ii_DiagnosticsFile >= 0 THEN
		FileWrite ( ii_DiagnosticsFile, "Table.Set(RM_Distribution_WORK)" )
	END IF
	
	lb_success = inv_cst_dde.of_GetRemote("Table.Set(RM_Distribution_WORK)", ls_response)

	yield()

	if lb_success and ls_response = "0" then lb_success = lb_success &
		else goto delete_RM_Sales_WORK_entry

	for ll_dist = 1 to upperbound(lstra_trns[ll_trns].istra_distributions)

		lstr_dist = lstra_trns[ll_trns].istra_distributions[ll_dist]

		//NOTE: the following approach assumes a credit amount to be SALES, and a debit
		//amount to be RECV.  This is probably not an adequate long-term approach.
		if lstr_dist.ib_credit then
			li_ndx = lnv_anyarray.of_Find( istr_stats.sales_accounts, lstr_dist.is_account, null_long, null_long )
			if li_ndx > 0 then ll_account_index = istr_stats.sales_account_indexes[li_ndx] &
				else goto delete_RM_Distribution_WORK_entries
		else
			li_ndx = lnv_anyarray.of_Find( istr_stats.recv_accounts, lstr_dist.is_account, null_long, null_long )
			if li_ndx > 0 then ll_account_index = istr_stats.recv_account_indexes[li_ndx] &
				else goto delete_RM_Distribution_WORK_entries
		end if

		lstr_command_parms = lstr_empty_parms

		//[1] = Document Number (String)
		lstr_command_parms.anys[1] = lstra_trns[ll_trns].is_document_number
		
		//[2] = Distribution Type (Integer)
		//See NOTE on the approach used here above.
		if lstr_dist.ib_credit then
			ll_temp = 9 // 9 = SALES
		else
			ll_temp = 3 // 3 = RECV
		end if
		lstr_command_parms.anys[2] = ll_temp
		
		//[3] = Sequence Number (Long)
		//This is a weird Dynamics thing.  Basically, they want sequence numbers spaced
		//far enough apart that an aribtrary number of other sequence numbers could be
		//squeezed in between them in the future.  16384 is the recommended initial interval.
		ll_temp = 16384 * ll_dist
		lstr_command_parms.anys[3] = ll_temp
		
		//[4] = Customer Number (String)
		lstr_command_parms.anys[4] = lstra_trns[ll_trns].is_company_code
		
		//[5] = Distribution Account Index (Long)
		lstr_command_parms.anys[5] = ll_account_index
		
		//[6] = Debit Amount (Currency)
		if not lstr_dist.ib_credit then lc_temp = lstr_dist.ic_amount else lc_temp = 0
		lstr_command_parms.anys[6] = lc_temp
		
		//[7] = Credit Amount (Currency)
		if lstr_dist.ib_credit then lc_temp = lstr_dist.ic_amount else lc_temp = 0
		lstr_command_parms.anys[7] = lc_temp
		
		choose case this.of_make_command("RM_Distribution_WORK", lstr_command_parms, ls_command)
		case 1
			//No processing needed
		case else
			goto delete_RM_Distribution_WORK_entries
		end choose

		IF ii_DiagnosticsFile >= 0 THEN
			FileWrite ( ii_DiagnosticsFile, "Row.Create() :: " + ls_command )
		END IF
	
		lb_success = inv_cst_dde.of_SetRemote("Row.Create()", ls_command)
	
		yield()
	
		if lb_success then lb_success = lb_success &
			else goto delete_RM_Distribution_WORK_entries
	
	next

	ll_BatchCount ++
	lc_BatchTotal += lstra_trns[ll_trns].ic_document_amount

	continue

	delete_RM_Distribution_WORK_entries:
//	lb_success = inv_cst_dde.of_GetRemote("Table.Set(RM_Distribution_WORK)", ls_response)
//
//	yield()
//
//	if lb_success and ls_response = "0" then lb_success = lb_success else goto failure
//	lb_success = inv_cst_dde.of_GetRemote("Row.Delete()", ls_response)
//
//	yield()
//
//	if lb_success and ls_response = "0" then lb_success = lb_success else goto failure

//	Now that we're allowing an arbitrary number of distributions, this secion needs to 
// be revised to actually set a key on the table and do a delete loop for however many
//	rows may be associated with the current document.  I don't want to divert the energy
// to this right now, however, so I'm just going to make it fail outright.

	IF ii_DiagnosticsFile >= 0 THEN
		FileWrite ( ii_DiagnosticsFile, "delete_RM_Distribution_WORK_entries" )
	END IF

	goto failure

	delete_RM_Sales_WORK_entry:
	lb_success = inv_cst_dde.of_GetRemote("Table.Set(RM_Sales_WORK)", ls_response)

	yield()

	if lb_success and ls_response = "0" then lb_success = lb_success else goto failure
	lb_success = inv_cst_dde.of_GetRemote("Row.Delete()", ls_response)

	yield()

	if lb_success and ls_response = "0" then lb_success = lb_success else goto failure

	delete_RM_Keys_MSTR_entry:
	lb_success = inv_cst_dde.of_GetRemote("Table.Set(RM_Keys_MSTR)", ls_response)

	yield()

	if lb_success and ls_response = "0" then lb_success = lb_success else goto failure
	lb_success = inv_cst_dde.of_GetRemote("Row.Delete()", ls_response)

	yield()

	if lb_success and ls_response = "0" then lb_success = lb_success else goto failure

	ll_err_skipcount ++
	if len(ls_err_skiplist) > 0 then ls_err_skiplist += ", "
	ls_err_skiplist += lstra_trns[ll_trns].is_document_number
	continue

next

//Set Batch Total and Number Of TRX

if ll_BatchCount > 0 AND ib_NoCellUpdates = FALSE then

	IF ii_DiagnosticsFile >= 0 THEN
		FileWrite ( ii_DiagnosticsFile, "Set Batch Total and Number Of TRX" )
	END IF

	IF ii_DiagnosticsFile >= 0 THEN
		FileWrite ( ii_DiagnosticsFile, "Table.Set(Batch_Headers)" )
	END IF

	lb_success = inv_cst_dde.of_GetRemote("Table.Set(Batch_Headers)", ls_response)
	if lb_success and ls_response = "0" then lb_success = lb_success else goto failure

//	IF ib_SixPlus THEN
//		yield()
//	END IF

	IF ii_DiagnosticsFile >= 0 THEN
		FileWrite ( ii_DiagnosticsFile, "Cell.SetData('Number Of TRX') :: " + string(ll_BatchCount) )
	END IF

	lb_success = inv_cst_dde.of_SetRemote("Cell.SetData('Number Of TRX')", string(ll_BatchCount))
	if lb_success then lb_success = lb_success else goto failure

//	IF ib_SixPlus THEN
//		yield()
//	END IF

	IF ii_DiagnosticsFile >= 0 THEN
		FileWrite ( ii_DiagnosticsFile, "Cell.SetData('Batch Total') :: " + string(lc_BatchTotal, "0.00000") )
	END IF

	lb_success = inv_cst_dde.of_SetRemote("Cell.SetData('Batch Total')", string(lc_BatchTotal, "0.00000"))
	if lb_success then lb_success = lb_success else goto failure

//	IF ib_SixPlus THEN
//		yield()
//	END IF

end if

lb_batch_completed = true

//Clear Batch Status Flag and Activity Record

IF ii_DiagnosticsFile >= 0 THEN
	FileWrite ( ii_DiagnosticsFile, "Clear Batch Status Flag and Activity Record" )
END IF

if this.of_batch_clearflags(lb_SY_Batch_Activity_MSTR_FLAGGED, lb_Batch_Headers_FLAGGED) &
	= false then goto failure

//Inform user of any invoices that were not included in the batch

if ll_noco_skipcount > 0 or ll_dup_skipcount > 0 or ll_err_skipcount > 0 then
	if ll_noco_skipcount > 0 then
		if ll_noco_skipcount = 1 then
			ls_work1 = "invoice was"
			ls_work2 = "company"
		else
			ls_work1 = string(ll_noco_skipcount) + " invoices were"
			ls_work2 = "companies"
		end if
		ls_message += "The following " + ls_work1 + " not included in the AR batch because the " +&
			ls_work2 + " being billed did not have a valid accounting ID:~n~n" +&
			ls_noco_skiplist
	end if
	if ll_dup_skipcount > 0 then
		if ll_dup_skipcount = 1 then
			ls_work1 = "invoice was"
			ls_work2 = "its Freight Bill Number matches a Document Number"
		else
			ls_work1 = string(ll_dup_skipcount) + " invoices were"
			ls_work2 = "their Freight Bill Numbers match Document Numbers"
		end if
		if len(ls_message) > 0 then ls_message += "~n~n"
		ls_message += "The following " + ls_work1 + " not included in the AR batch because "+&
			ls_work2 + " already entered in Dynamics:~n~n" + ls_dup_skiplist
	end if
	if ll_err_skipcount > 0 then
		if ll_err_skipcount = 1 then
			ls_work1 = "invoice was"
		else
			ls_work1 = string(ll_err_skipcount) + " invoices were"
		end if
		if len(ls_message) > 0 then ls_message += "~n~n"
		ls_message += "The following " + ls_work1 + " not included in the AR batch because "+&
			"of communication errors with Dynamics:~n~n" + ls_err_skiplist
	end if
	messagebox("Notes on Dynamics AR Batch", ls_message)
end if

return 1

failure:

if lb_batch_started then
	if lb_SY_Batch_Activity_MSTR_FLAGGED or lb_Batch_Headers_FLAGGED then &
		this.of_batch_clearflags(lb_SY_Batch_Activity_MSTR_FLAGGED, lb_Batch_Headers_FLAGGED)
	if lb_SY_Batch_Activity_MSTR_FLAGGED or lb_Batch_Headers_FLAGGED then
		if lb_batch_completed then
			ls_message = "The AR batch was created successfully, but the batch status flags "+&
				"could not be cleared."
		else
			ls_message = "There was an error in creating the AR batch, and the batch status "+&
				"flags could not be cleared."
		end if
		ls_message += "  The batch will be 'hung up' in Dynamics.  Please contact technical support."
	else
		ls_message = "There was an error in creating the AR batch, but the error could not be "+&
			"cleared.  Please delete the batch in Dynamics.  The rest of the billing process "+&
			"should not be affected."
	end if
else
	ls_message = "There was an error in creating the AR batch.  No entries were made in "+&
		"Dynamics."
end if

IF ii_DiagnosticsFile >= 0 THEN
	FileWrite ( ii_DiagnosticsFile, "***Failure :: " + ls_Message )
END IF

messagebox("Create Dynamics AR Batch", ls_message, exclamation!)

return -1
end function

protected function boolean of_batch_clearflags (ref boolean ab_sy_batch_activity_mstr_flagged, ref boolean ab_batch_headers_flagged);boolean lb_success
string ls_response

//Clear Batch Activity Entry

IF ii_DiagnosticsFile >= 0 THEN
	FileWrite ( ii_DiagnosticsFile, "Clear Batch Activity Entry :: of_Batch_ClearFlags" )
END IF

if ab_SY_Batch_Activity_MSTR_FLAGGED then

	IF ii_DiagnosticsFile >= 0 THEN
		FileWrite ( ii_DiagnosticsFile, "Table.Set(SY_Batch_Activity_MSTR)" )
	END IF

	lb_success = inv_cst_dde.of_GetRemote("Table.Set(SY_Batch_Activity_MSTR)", ls_response)

//	Yields were originally added during development of the version 6 interface as an 
//	attempt to counteract some problems.  They were still in when we solved the problem, 
//	which was a column name issue, so I believe the yields are not necessary.  So, I'm
//	commenting them out, but leaving the comments there for now in case it turns out 
//	they WERE necessary.  If this build runs fine, we can remove them.  Please note that
//	there are some yields that were in before -- these are not commented or conditional, 
//	and should be left alone.
//
//	IF ib_SixPlus THEN
//		yield()
//	END IF

	if lb_success and ls_response = "0" then

		IF ii_DiagnosticsFile >= 0 THEN
			FileWrite ( ii_DiagnosticsFile, "Row.Delete()" )
		END IF

		lb_success = inv_cst_dde.of_GetRemote("Row.Delete()", ls_response)

//		IF ib_SixPlus THEN
//			yield()
//		END IF

		if lb_success and ls_response = "0" then
			ab_SY_Batch_Activity_MSTR_FLAGGED = false
		else
			goto failure
		end if
	else
		goto failure
	end if
end if

//Clear batch status flag

if ab_Batch_Headers_FLAGGED AND ib_NoCellUpdates = FALSE then

	IF ii_DiagnosticsFile >= 0 THEN
		FileWrite ( ii_DiagnosticsFile, "Table.Set(Batch_Headers)" )
	END IF

	lb_success = inv_cst_dde.of_GetRemote("Table.Set(Batch_Headers)", ls_response)

//	IF ib_SixPlus THEN
//		yield()
//	END IF

	if lb_success and ls_response = "0" then

		IF ii_DiagnosticsFile >= 0 THEN
			FileWrite ( ii_DiagnosticsFile, "Cell.SetData('Batch Status') :: 0" )
		END IF

		lb_success = inv_cst_dde.of_SetRemote("Cell.SetData('Batch Status')", "0")

//		IF ib_SixPlus THEN
//			yield()
//		END IF

		if lb_success then
			ab_Batch_Headers_FLAGGED = false
		else
			goto failure
		end if
	else
		goto failure
	end if
end if

return true

failure:
return false
end function

protected function integer of_make_command (string as_table, s_anys astr_parms, ref string as_command);decimal {2} lc_temp
date ld_temp
long ll_temp
string ls_temp, ls_all_f

ls_all_f = fill("F", 32)
as_command = ""

choose case as_table
////////////////////////////////////////////////////////////////////////////////////////
case "Batch_Headers"

//[1] = GL Posting Date (Date)
//[2] = Batch Number (String)
//[3] = Number Of TRX (Long)
//[4] = Batch Comment (String)
//[5] = Batch Total (Currency)
//[6] = Batch Status (Integer)

//GL Posting Date (Date)
ld_temp = astr_parms.anys[1]
as_command += string(ld_temp, is_date_format) + ", "

//Batch Source (String)
as_command += "RM_Sales" + ", "

//Batch Number (String)
ls_temp = astr_parms.anys[2]
if of_command_eval(ls_temp) then ls_temp = of_command_sub(ls_temp) &
	else goto charsub_failure
as_command += "'" + ls_temp + "', "

//Series (Integer)
as_command += "3, "

//Marked To Post (Boolean)
as_command += "0, "

//Number Of TRX (Long)
ll_temp = astr_parms.anys[3]
as_command += string(ll_temp) + ", "

//Recurring Postings (Integer)
as_command += "0, "

//Delete Batch (Boolean)
as_command += "0, "

//Misc Batch Days To Increment (Integer)
as_command += "0, "

//Batch Frequency (Integer) : 1 = Single Use
as_command += "1, "

//Recurring Last Posted Date (Date)
as_command += "0/0/00, "

//Number of Postings (Integer)
as_command += "0, "

//Batch Comment (String)
ls_temp = astr_parms.anys[4]
if of_command_eval(ls_temp) then ls_temp = of_command_sub(ls_temp) &
	else goto charsub_failure
as_command += "'" + ls_temp + "', "

//Break Down Alloc (Boolean)
as_command += "0, "

//Checks Printed (Boolean)
as_command += "0, "

//Reverse Batch (Boolean)
as_command += "0, "

//User ID (String)
ls_temp = istr_stats.uid
if of_command_eval(ls_temp) then ls_temp = of_command_sub(ls_temp) &
	else goto charsub_failure
as_command += "'" + ls_temp + "', "

//Checkbook ID (String)
as_command += "'', "

//Batch Total (Currency)
lc_temp = astr_parms.anys[5]
as_command += string(lc_temp, "0.00000") + ", "

//Batch Error Messages 1 (Long - LB)
as_command += ls_all_f + ", "

//Batch Error Messages 2 (Long - LB)
as_command += ls_all_f + ", "

//Batch Date (Date)
as_command += "0/0/00, "

//Batch String 1 (String)
as_command += "'', "

//Batch String 2 (String)
as_command += "'', "

//Post To GL (Boolean)
as_command += "0, "

//Modified Date (Date)
ld_temp = today()
as_command += string(ld_temp, is_date_format) + ", "

//Created Date (Date)
ld_temp = today()
as_command += string(ld_temp, is_date_format) + ", "

//Note Index (Currency)
as_command += "0.00000, "

//Currency ID (String)
IF ib_SixPlus THEN

//	ls_temp = istr_stats.currency
//	if of_command_eval(ls_temp) then ls_temp = of_command_sub(ls_temp) &
//		else goto charsub_failure
//	as_command += "'" + ls_temp + "', "

	as_command += "'', "		//If MC is registered, this should be the functional currency
									//If MC is not registered, this should be blank.
									//Until we can support MC fully, I'm going to leave it blank.
ELSE
	as_command += "'', "		//"Reserved for future use" by Dynamics (prior to v6.0)
END IF

//Batch Status (Integer)
ll_temp = astr_parms.anys[6]
as_command += string(ll_temp) + ", "

//Control TRX Count (Long)
ll_temp = 0
as_command += string(ll_temp) + ", "

//Control Total (Currency)
lc_temp = 0.00
as_command += string(lc_temp, "0.00000") + ", "

//Posting Error TRX Count (Integer)
as_command += "0, "

//Approval (Boolean)
as_command += "0, "

//Approval Date (Date)
as_command += "0/0/00, "

//Approval User ID (String)
as_command += "'', "

//Origin (Integer) : 1 = Transaction Entry Window
as_command += "1, "

//Error State (Long)
as_command += "0, "

//GL Batch Valid (Long - LB)
as_command += ls_all_f   //END OF LINE -- NO COMMA (Unless extend for V6.0 below)

IF ib_SixPlus THEN  //Fields that Dynamics added in V6.0

	//Add comma to continue the line
	as_command += ", "

	//Computer Check Document Date (Date)
	as_command += "0/0/00, "	//Not used in RM

	//Sort Checks By (Integer)
	as_command += "0, "			//Not used in RM

	//Separate Remittance (Boolean)
	as_command += "0, "			//Not used in RM

	//Reprinted (Integer)
	as_command += "0, "			//Not used in RM

	//Check Formats (Integer)
	as_command += "0, "			//Not used in RM

	//TRX Source (String) (Set by system when posting starts -- No value here)
	as_command += "''"   //END OF LINE -- NO COMMA

END IF


IF ib_SevenPlus THEN  //Fields that Dynamics added in v7.0

	//Add comma to continue the line
	as_command += ", "

	//Payment Method (Integer)
	as_command += "0, "			//Not used in RM??

	//EFT File Format (Integer)
	as_command += "0"				//END OF LINE -- NO COMMA
	
END IF



////////////////////////////////////////////////////////////////////////////////////////
case "SY_Batch_Activity_MSTR"

//[1] = Batch Number (String)
//[2] = Posting (Boolean) -- as long

//Window Type (Integer) : 1 = TRX_WINDOW, 2 = BATCH_WINDOW, 3 = SERIES_WINDOW, 4 = MASTER_WINDOW
as_command += "2, "

//User ID (String)
ls_temp = istr_stats.uid
if of_command_eval(ls_temp) then ls_temp = of_command_sub(ls_temp) &
	else goto charsub_failure
as_command += "'" + ls_temp + "', "

//Company Name (String)
ls_temp = istr_stats.company
if of_command_eval(ls_temp) then ls_temp = of_command_sub(ls_temp) &
	else goto charsub_failure
as_command += "'" + ls_temp + "', "

//Batch Source (String)
as_command += "RM_Sales" + ", "

//Batch Number (String)
ls_temp = astr_parms.anys[1]
if of_command_eval(ls_temp) then ls_temp = of_command_sub(ls_temp) &
	else goto charsub_failure
as_command += "'" + ls_temp + "', "

//Posting (Boolean)
ll_temp = astr_parms.anys[2]
as_command += string(ll_temp) + ", "

//Transaction Source (String)
as_command += "''"

////////////////////////////////////////////////////////////////////////////////////////
case "RM_Keys_MSTR"

//[1] = Document Number (String)
//[2] = Customer Number (String)
//[3] = Document Date (Date)

//Document Number (String)
ls_temp = astr_parms.anys[1]
if of_command_eval(ls_temp) then ls_temp = of_command_sub(ls_temp) &
	else goto charsub_failure
as_command += "'" + ls_temp + "', "

//RM Document Type-All (Integer) : 1 = Sales / Invoice
as_command += "1, "

//Document Status (Integer) : 1 = Work
as_command += "1, "

//Batch Source (String)
as_command += "RM_Sales" + ", "

//TRX Source (String) : Assigned after posting
as_command += "'', "

//Customer Number (String)
ls_temp = astr_parms.anys[2]
if of_command_eval(ls_temp) then ls_temp = of_command_sub(ls_temp) &
	else goto charsub_failure
as_command += "'" + ls_temp + "', "

//Check Number (String)
//The documentation says that if the document isn't a check, the Document Number is 
//stored in this field; that doesn't seem to be the case, however, at least not for 
//Sales / Invoice documents.
as_command += "'', "

//Document Date (Date)
ld_temp = astr_parms.anys[3]
as_command += string(ld_temp, is_date_format)

////////////////////////////////////////////////////////////////////////////////////////
case "RM_Sales_WORK"

//[1] = RM Document Number-WORK (String)
//[2] = Document Date (Date)
//[3] = Batch Number (String)
//[4] = Customer Number (String)
//[5] = Customer Name (String)
//[6] = Address Code (String) [**Not Currently Used**]
//[7] = Sales Amount (Currency)
//[8] = *Batch Date (Date) [This is not a field in RM_Sales_WORK]

//Document Type (Integer) : 1 = Sales / Invoice
as_command += "1, "

//RM Document Type-All (Integer) : 1 = Sales / Invoice
as_command += "1, "

//RM Document Number-WORK (String)
ls_temp = astr_parms.anys[1]
if of_command_eval(ls_temp) then ls_temp = of_command_sub(ls_temp) &
	else goto charsub_failure
as_command += "'" + ls_temp + "', "

//Document Number (String)
ls_temp = astr_parms.anys[1]
if of_command_eval(ls_temp) then ls_temp = of_command_sub(ls_temp) &
	else goto charsub_failure
as_command += "'" + ls_temp + "', "

//Document Prefix (String)
as_command += "'', "

//Document Description (String)
as_command += "'', "

//Document Date (Date)
ld_temp = astr_parms.anys[2]
as_command += string(ld_temp, is_date_format) + ", "

//Batch Number (String)
ls_temp = astr_parms.anys[3]
if of_command_eval(ls_temp) then ls_temp = of_command_sub(ls_temp) &
	else goto charsub_failure
as_command += "'" + ls_temp + "', "

//Batch Source (String)
as_command += "RM_Sales" + ", "

//Note Index (Currency)
as_command += "0.00000, "

//Customer Number (String)
ls_temp = astr_parms.anys[4]
if of_command_eval(ls_temp) then ls_temp = of_command_sub(ls_temp) &
	else goto charsub_failure
as_command += "'" + ls_temp + "', "

//Customer Name (String)
ls_temp = astr_parms.anys[5]
if of_command_eval(ls_temp) then ls_temp = of_command_sub(ls_temp) &
	else goto charsub_failure
as_command += "'" + ls_temp + "', "

//Address Code (String)
//ls_temp = astr_parms.anys[6]
//if of_command_eval(ls_temp) then ls_temp = of_command_sub(ls_temp) &
//	else goto charsub_failure
//as_command += "'" + ls_temp + "', "
as_command += "'', "

//Salesperson ID (String)
as_command += "'', "

//Sales Territory (String)
as_command += "'', "

//Commission Applied To (Integer) : 0 = Sales, 1 = Invoice Total
as_command += "0, "

//Commission Dollar Amount (Currency)
as_command += "0.00000, "

//Non-Commissioned Amount (Currency)
as_command += "0.00000, "

//Shipping Method (String)
as_command += "'', "

//Customer PO Number (String)
as_command += "'', "

//Tax Schedule ID (String)
as_command += "'', "

//Sales Schedule ID (String)
as_command += "'', "

//Freight Schedule ID (String)
as_command += "'', "

//Misc Schedule ID (String)
as_command += "'', "

//Cost Amount (Currency)
as_command += "0.00000, "

//Sales Amount (Currency)
lc_temp = astr_parms.anys[7]
as_command += string(lc_temp, "0.00000") + ", "

//Trade Discount Amount (Currency)
as_command += "0.00000, "

//Trade Discount (Integer)
as_command += "0, "

//Freight Amount (Currency)
as_command += "0.00000, "

//Misc Amount (Currency)
as_command += "0.00000, "

//Tax Amount (Currency)
as_command += "0.00000, "

//Backout Sales Amount (Currency)
as_command += "0.00000, "

//Backout Freight Amount (Currency)
as_command += "0.00000, "

//Backout Misc Amount (Currency)
as_command += "0.00000, "

//Tax Engine Called (Boolean)
as_command += "1, " //??

//Document Amount (Currency)
lc_temp = astr_parms.anys[7] //Same as Sales Amount, for now
as_command += string(lc_temp, "0.00000") + ", "

//Applied Amount (Currency)
as_command += "0.00000, "

//Cash Amount (Currency)
as_command += "0.00000, "

//Checkbook ID Cash (String)
as_command += "'', "

//Cash Date (Date)
as_command += "0/0/00, "

//Document Number Cash (String)
as_command += "'', "

//Check Amount (Currency)
as_command += "0.00000, "

//Checkbook ID Check (String)
as_command += "'', "

//Checkbook ID Credit Card (String)
as_command += "'', "

//Check Number (String)
as_command += "'', "

//Check Date (Date)
as_command += "0/0/00, "

//Document Number Check (String)
as_command += "'', "

//Credit Card Amount (Currency)
as_command += "0.00000, "

//Credit Card Name (String)
as_command += "'', "

//Receipt Number Credit Card (String)
as_command += "'', "

//Credit Card Date (Date)
as_command += "0/0/00, "

//Document Number Credit Card (String)
as_command += "'', "

//Discount Returned (Currency)
as_command += "0.00000, "

//Discount Taken Amount (Currency)
as_command += "0.00000, "

//Discount Available Taken (Currency)
as_command += "0.00000, "

//Write Off Amount (Currency)
as_command += "0.00000, "

//PPS Amount Deducted (Currency)
as_command += "0.00000, "

//GST Discount Amount (Currency)
as_command += "0.00000, "

//Account Amount (Currency)
lc_temp = astr_parms.anys[7] //Same as Sales Amount, for now
as_command += string(lc_temp, "0.00000") + ", "

//Payment Terms ID (String)
as_command += "'', " //?? : This should be addressed later.

IF ib_SixPlus = FALSE THEN  //**THIS FIELD WAS REMOVED IN 6.0**
	//Grace Period Days (Integer)
	as_command += "0, "  //Do we need a value here ??
END IF

//Discount Available Amount (Currency)
as_command += "0.00000, "

//Discount Date (Date)
//?? : This may need to be addressed further if we implement payment terms.  When there
//are no payment terms, the value is supposed to be the same as the document date [2].
ld_temp = astr_parms.anys[2]
as_command += string(ld_temp, is_date_format) + ", "

//Due Date (Date)
//?? : This may need to be addressed further if we implement payment terms.  When there
//are no payment terms, the value is supposed to be the same as the document date [2].
ld_temp = astr_parms.anys[2]
as_command += string(ld_temp, is_date_format) + ", "

//Discount Dollar Amount (Currency)
as_command += "0.00000, "

//Discount Percent Amount (Integer)
as_command += "0, "

//Currency ID (String)
IF ib_SixPlus THEN
	as_command += "'', "  //For non-MC, we're not supposed to send the currency id in 6.0+
								//For MC, we should send it, so when we add mc, we'll have to 
								//conditionally execute the code below
ELSE
	ls_temp = istr_stats.currency
	if of_command_eval(ls_temp) then ls_temp = of_command_sub(ls_temp) &
		else goto charsub_failure
	as_command += "'" + ls_temp + "', "
END IF

//Posted (Boolean)
as_command += "0, "

//Last Edit Date (Date)
ld_temp = today()
as_command += string(ld_temp, is_date_format) + ", "

//Last User to Edit (String)
ls_temp = istr_stats.uid
if of_command_eval(ls_temp) then ls_temp = of_command_sub(ls_temp) &
	else goto charsub_failure
as_command += "'" + ls_temp + "', "

//RM TRX Posting Error Messages (Long - LB)
as_command += ls_all_f + ", "

//RM Dist Posting Error Messages (Long - LB)
as_command += ls_all_f + ", "

//GL Posting Date (Date)
//The documentation says: "If the Posting Setup window is set to post by batch date, 
//this field should be left empty.  If ... by transaction date, this field is set to 
//the date that should go with distributions when posting to General Ledger."
//The "left empty" part doesn't seem to be accurate;  when posting is setup by 
//batch date, the batch date is in this field, at least for Sales/Invoice docs.
if istr_stats.post_date_from = "BATCH" then
	ld_temp = astr_parms.anys[8] //Batch Date
else
	ld_temp = astr_parms.anys[2] //Document Date
end if
as_command += string(ld_temp, is_date_format) + ", "

//Posted Date (Date)
as_command += "0/0/00, "

//Posted User ID (String)
as_command += "''"   //END OF LINE -- NO COMMA

IF ib_SixPlus THEN   //Fields that Dynamics added in V6.0

	//Add comma to continue the line
	as_command += ", "

	//Tax Date (Date)
	//The documentation says: Date used on VAT reports different from the document date that 
	//is used for tax reporting purposes.  This can only be entered if VAT Line Analysis is 
	//turned on.  Otherwise it defaults to the document date.
	//So, I'm going to use the document date...
	ld_temp = astr_parms.anys[2]  //Document Date
	as_command += string(ld_temp, is_date_format) + ", "

	//Apply Withholding (Boolean)
	//The documentation says: Set to true if this document is subject to withholding.
	//I don't think this is, so I'm going to set it to false...
	as_command += "0, "   //A rebuild after import was saying "Invalid value for boolean Apply Withholding -- so I tried 1, but that didn't work either

	//Sale Date (Date)
	as_command += "0/0/00, "

	//Correction (Boolean)
	as_command += "0, "

	//Simplified (Boolean)
	as_command += "0, "

	//Correction to Nonexisting Transaction (Boolean)
	as_command += "0, "

	//Document Number Corrected (String)
	as_command += "'', "

	//RM TRX Posting Error Messages 2 (Long - LB)
	as_command += ls_all_f + ", "

	//DocPrinted (Boolean)
	as_command += "0, "

	//Discount Grace Period (Integer)
	as_command += "0, "

	//Due Date Grace Period (Integer)
	as_command += "0, "

	//Electronic (Boolean)
	as_command += "0, "

	//EC Transaction (Boolean)
	as_command += "0, "

	//Posting Status (Integer) : TRX_UNPOSTED = 20
	as_command += "20"  //END OF LINE -- NO COMMA

END IF


IF ib_SevenPlus THEN
	
   //Fields that Dynamics added in V7.0

	//Add comma to continue the line
	as_command += ", "

	//Backout Trade Discount Amount (Currency)
	as_command += "0.00000"  //END OF LINE -- NO COMMA
	
END IF


////////////////////////////////////////////////////////////////////////////////////////
case "RM_Distribution_WORK"

//[1] = Document Number (String)
//[2] = Distribution Type (Integer)
//[3] = Sequence Number (Long)
//[4] = Customer Number (String)
//[5] = Distribution Account Index (Long)
//[6] = Debit Amount (Currency)
//[7] = Credit Amount (Currency)

//TRX Source (String)
as_command += "'', "

//Posted (Boolean)
as_command += "0, "

//Posted Date (Date)
as_command += "0/0/00, "

//Posting Status (Integer) : 3 = Unposted
as_command += "3, "

//Changed (Boolean)
as_command += "0, "

//Document Number (String)
ls_temp = astr_parms.anys[1]
if of_command_eval(ls_temp) then ls_temp = of_command_sub(ls_temp) &
	else goto charsub_failure
as_command += "'" + ls_temp + "', "

//Document Status (Integer) : 1 = Work
as_command += "1, "

//Distribution Type (Integer)
ll_temp = astr_parms.anys[2]
as_command += string(ll_temp) + ", "

//RM Document Type-All (Integer) : 1 = Sales / Invoice
as_command += "1, "

//Sequence Number (Long)
ll_temp = astr_parms.anys[3]
as_command += string(ll_temp) + ", "

//Customer Number (String)
ls_temp = astr_parms.anys[4]
if of_command_eval(ls_temp) then ls_temp = of_command_sub(ls_temp) &
	else goto charsub_failure
as_command += "'" + ls_temp + "', "

//Distribution Account Index (Long)
ll_temp = astr_parms.anys[5]
as_command += string(ll_temp) + ", "

//Debit Amount (Currency)
lc_temp = astr_parms.anys[6]
as_command += string(lc_temp, "0.00000") + ", "

//Credit Amount (Currency)
lc_temp = astr_parms.anys[7]
as_command += string(lc_temp, "0.00000") + ", "

//Project ID (String) : "Reserved for later use"
as_command += "'', "

//User ID (String) : "For Internal Use Only" -- Not supposed to be set.
as_command += "'', "

//Category Used (Integer) : "Reserved for later use"
as_command += "0, "

//Currency ID (String)
IF ib_SixPlus THEN
	as_command += "'', "  //For non-MC, we're not supposed to send the currency id in 6.0+
								//For MC, we should send it, so when we add mc, we'll have to 
								//conditionally execute the code below
ELSE
	ls_temp = istr_stats.currency
	if of_command_eval(ls_temp) then ls_temp = of_command_sub(ls_temp) &
		else goto charsub_failure
	as_command += "'" + ls_temp + "', "
END IF

//Currency Index (Integer)
IF ib_SixPlus THEN
	as_command += "0, "  //Hard to tell for sure from the documentation, but I don't think
								//we're supposed to send this if we're not sending a Currency ID.
								//(See above.)
ELSE
	as_command += string(istr_stats.currency_index) + ", "
END IF

//Originating Credit Amount (Currency)
as_command += "0.00000, "

//Originating Debit Amount (Currency)
as_command += "0.00000, "

//Distribution Reference (String) : "Reserved for later use"
as_command += "''"

end choose

return 1

//general_failure:  (Not currently used)
//as_command = ""
//return -1

charsub_failure:
as_command = ""
return -2
end function

protected function integer of_batch_list (ref string asa_list[]);boolean lb_success
string ls_response
string lsa_list[]

asa_list = lsa_list

lb_success = inv_cst_dde.of_GetRemote("Table.Set(Batch_Headers)", ls_response)
if lb_success and ls_response = "0" then lb_success = lb_success else goto failure

lb_success = inv_cst_dde.of_GetRemote("Key.Set(Batch_Header_Key7)", ls_response)
if lb_success and ls_response = "0" then lb_success = lb_success else goto failure

if not inv_cst_dde.of_SetRemote("Key.SetData()", "3, RM_Sales, '!', 3, RM_Sales, 'z'") &
	then goto failure

lb_success = inv_cst_dde.of_GetRemote("Row.SetSelection('Batch Number')", ls_response)
if lb_success and ls_response = "0" then lb_success = lb_success else goto failure

lb_success = inv_cst_dde.of_GetRemote("Row.GetFirst()", ls_response)
if lb_success and len(ls_response) > 0 then &
	lsa_list[upperbound(lsa_list) + 1] = ls_response else goto finished

do
	lb_success = inv_cst_dde.of_GetRemote("Row.GetNext()", ls_response)
	if lb_success and len(ls_response) > 0 then &
		lsa_list[upperbound(lsa_list) + 1] = ls_response else lb_success = false
	//The else above shouldn't be necessary.  It's just an added precaution
	//against getting into an infinite loop.
loop while lb_success

finished:
asa_list = lsa_list
return 1

failure:
return -1
end function

public function boolean of_link_close ();boolean lb_success
string ls_response

setpointer(hourglass!)

//Close all open tables

IF ii_DiagnosticsFile >= 0 THEN
	FileWrite ( ii_DiagnosticsFile, "of_Link_Close" )
END IF

if istr_stats.SY_Batch_Activity_MSTR_OPEN then

	IF ii_DiagnosticsFile >= 0 THEN
		FileWrite ( ii_DiagnosticsFile, "Table.Set(SY_Batch_Activity_MSTR)" )
	END IF

	lb_success = inv_cst_dde.of_GetRemote("Table.Set(SY_Batch_Activity_MSTR)", ls_response)
	if lb_success and ls_response = "0" then

		IF ii_DiagnosticsFile >= 0 THEN
			FileWrite ( ii_DiagnosticsFile, "Table.Close()" )
		END IF

		lb_success = inv_cst_dde.of_GetRemote("Table.Close()", ls_response)
		if lb_success and ls_response = "0" then istr_stats.SY_Batch_Activity_MSTR_OPEN = false
	end if
end if

if istr_stats.Batch_Headers_OPEN then

	IF ii_DiagnosticsFile >= 0 THEN
		FileWrite ( ii_DiagnosticsFile, "Table.Set(Batch_Headers)" )
	END IF

	lb_success = inv_cst_dde.of_GetRemote("Table.Set(Batch_Headers)", ls_response)
	if lb_success and ls_response = "0" then

		IF ii_DiagnosticsFile >= 0 THEN
			FileWrite ( ii_DiagnosticsFile, "Table.Close()" )
		END IF

		lb_success = inv_cst_dde.of_GetRemote("Table.Close()", ls_response)
		if lb_success and ls_response = "0" then istr_stats.Batch_Headers_OPEN = false
	end if
end if

if istr_stats.GL_Account_MSTR_OPEN then

	IF ii_DiagnosticsFile >= 0 THEN
		FileWrite ( ii_DiagnosticsFile, "Table.Set(GL_Account_MSTR)" )
	END IF

	lb_success = inv_cst_dde.of_GetRemote("Table.Set(GL_Account_MSTR)", ls_response)
	if lb_success and ls_response = "0" then

		IF ii_DiagnosticsFile >= 0 THEN
			FileWrite ( ii_DiagnosticsFile, "Table.Close()" )
		END IF

		lb_success = inv_cst_dde.of_GetRemote("Table.Close()", ls_response)
		if lb_success and ls_response = "0" then istr_stats.GL_Account_MSTR_OPEN = false
	end if
end if

if istr_stats.SY_Posting_Journal_Settings_OPEN then

	IF ii_DiagnosticsFile >= 0 THEN
		FileWrite ( ii_DiagnosticsFile, "Table.Set(SY_Posting_Journal_Settings)" )
	END IF

	lb_success = inv_cst_dde.of_GetRemote("Table.Set(SY_Posting_Journal_Settings)", ls_response)
	if lb_success and ls_response = "0" then

		IF ii_DiagnosticsFile >= 0 THEN
			FileWrite ( ii_DiagnosticsFile, "Table.Close()" )
		END IF

		lb_success = inv_cst_dde.of_GetRemote("Table.Close()", ls_response)
		if lb_success and ls_response = "0" then istr_stats.SY_Posting_Journal_Settings_OPEN = false
	end if
end if

if istr_stats.MC_SETP_OPEN then

	IF ii_DiagnosticsFile >= 0 THEN
		FileWrite ( ii_DiagnosticsFile, "Table.Set(MC_SETP)" )
	END IF

	lb_success = inv_cst_dde.of_GetRemote("Table.Set(MC_SETP)", ls_response)
	if lb_success and ls_response = "0" then

		IF ii_DiagnosticsFile >= 0 THEN
			FileWrite ( ii_DiagnosticsFile, "Table.Close()" )
		END IF

		lb_success = inv_cst_dde.of_GetRemote("Table.Close()", ls_response)
		if lb_success and ls_response = "0" then istr_stats.MC_SETP_OPEN = false
	end if
end if

if istr_stats.RM_Distribution_WORK_OPEN then

	IF ii_DiagnosticsFile >= 0 THEN
		FileWrite ( ii_DiagnosticsFile, "Table.Set(RM_Distribution_WORK)" )
	END IF

	lb_success = inv_cst_dde.of_GetRemote("Table.Set(RM_Distribution_WORK)", ls_response)
	if lb_success and ls_response = "0" then

		IF ii_DiagnosticsFile >= 0 THEN
			FileWrite ( ii_DiagnosticsFile, "Table.Close()" )
		END IF

		lb_success = inv_cst_dde.of_GetRemote("Table.Close()", ls_response)
		if lb_success and ls_response = "0" then istr_stats.RM_Distribution_WORK_OPEN = false
	end if
end if

if istr_stats.RM_Sales_WORK_OPEN then

	IF ii_DiagnosticsFile >= 0 THEN
		FileWrite ( ii_DiagnosticsFile, "Table.Set(RM_Sales_WORK)" )
	END IF

	lb_success = inv_cst_dde.of_GetRemote("Table.Set(RM_Sales_WORK)", ls_response)
	if lb_success and ls_response = "0" then

		IF ii_DiagnosticsFile >= 0 THEN
			FileWrite ( ii_DiagnosticsFile, "Table.Close()" )
		END IF

		lb_success = inv_cst_dde.of_GetRemote("Table.Close()", ls_response)
		if lb_success and ls_response = "0" then istr_stats.RM_Sales_WORK_OPEN = false
	end if
end if

if istr_stats.RM_Keys_MSTR_OPEN then

	IF ii_DiagnosticsFile >= 0 THEN
		FileWrite ( ii_DiagnosticsFile, "Table.Set(RM_Keys_MSTR)" )
	END IF

	lb_success = inv_cst_dde.of_GetRemote("Table.Set(RM_Keys_MSTR)", ls_response)
	if lb_success and ls_response = "0" then

		IF ii_DiagnosticsFile >= 0 THEN
			FileWrite ( ii_DiagnosticsFile, "Table.Close()" )
		END IF

		lb_success = inv_cst_dde.of_GetRemote("Table.Close()", ls_response)
		if lb_success and ls_response = "0" then istr_stats.RM_Keys_MSTR_OPEN = false
	end if
end if

if istr_stats.logged_in then

	//ib_SixPlus condition added for 3.5.20 BKW 2-7-03.
	//Can't tell whether the Logout command has been discontinued or changed in Dynamics, but it fails in
	//SixPlus, and it appears that it is OK to just skip it and Close the DDE Link.  So, that's what we'll do.
	//Note that we'll also force logged in to false below after the CloseChannel

	IF ib_SixPlus = FALSE THEN

		IF ii_DiagnosticsFile >= 0 THEN
			FileWrite ( ii_DiagnosticsFile, "DBMS.Logout('" + of_command_sub(istr_stats.set) + "', '" +&
			of_command_sub(istr_stats.dic) + "', '" + of_command_sub(istr_stats.company) + "', '" +&
			of_command_sub(istr_stats.uid) + "')" )
		END IF
	
		lb_success = inv_cst_dde.of_GetRemote("DBMS.Logout('" + of_command_sub(istr_stats.set) + "', '" +&
			of_command_sub(istr_stats.dic) + "', '" + of_command_sub(istr_stats.company) + "', '" +&
			of_command_sub(istr_stats.uid) + "')", ls_response)
		if lb_success and ls_response = "0" then istr_stats.logged_in = false else return false

	END IF

end if

if istr_stats.connected then

	IF ii_DiagnosticsFile >= 0 THEN
		FileWrite ( ii_DiagnosticsFile, "inv_cst_dde.of_CloseChannel()" )
	END IF

	lb_success = inv_cst_dde.of_CloseChannel()
	if lb_success then
		istr_stats.logged_in = false  //Added 3.5.20 BKW 2-7-03  In SixPlus, login will not be a separate step.  See note above.
		istr_stats.connected = false 
	else
		return false
	end if

end if

return true
end function

protected function boolean of_command_eval (string as_target);if isnull(as_target) or pos(as_target, "`") > 0 then return false else return true
end function

protected function string of_command_sub (string as_target);return substitute(as_target, "'", "`")
end function

on n_cst_acctlink_dynamics.create
call super::create
end on

on n_cst_acctlink_dynamics.destroy
call super::destroy
end on

event constructor;//Tables and Keys Referenced in the Dynamics Integration  
//
//Batch_Headers						Batch_Header_Key7
//RM_Keys_MSTR
//RM_Sales_WORK
//RM_Distribution_WORK
//SY_Batch_Activity_MSTR
//GL_Account_MSTR						GL_Account_MSTR_Key6
//MC_SETP
//SY_Posting_Journal_Settings		Journal_Settings_Key_1
//RM_Customer_MSTR					RM_Customer_MSTR_Key1
//
//Dynamics v4 - v5 changes to these tables:
//(All tables had key changes.  I've only listed changes to keys we use explicitly)
//
//Batch_Header_Key7  Case sensitive to case insensitive
//GL_Account_MSTR_Key6   Case sensitive to case insensitive
//Journal_Settings_Key_1   Clustered to non-clustered, Case sensitive to case insensitive
//RM_Customer_MSTR_Key1    Clustered to non-clustered, Case sensitive to case insensitive
//
//These changes should have no impact on our integration
//
//
//Updated for Dynamics v7.0  3.9.00  4/16/04  BKW
//Dynamics had column additions to tables we work with in this release, but no
//modifications or deletions.  Two of the affected tables we only use keys with
//(GL_Account_MSTR, RM_Customer_MSTR) and therefore the change should not impact
//our code, and no code changes were made.  Two tables we feed data into 
//(Batch_Headers and RM_Sales_WORK), and these adjustments were made in 
//of_MakeCommand based on the value of ib_SevenPlus, which is set to TRUE in Constructor
//if the system setting is DYNAMICS7! (and should also be set for later versions.)
//
/////////////////////////////////////////////////////////


n_cst_Settings	lnv_Settings
Any		la_Package, &
			la_SqlServer
String	ls_Value


//Initialize the DDE object
inv_cst_dde = create n_cst_dde


//Initialize the value for ib_SixPlus to Null, then attempt to determine it below.
//If it can't be determined, we'll leave it null so the batch attempt will fail.

SetNull ( ib_SixPlus )


CHOOSE CASE lnv_Settings.of_GetSetting ( 20, la_Package )

CASE 1

	ls_Value = la_Package

	//Translate the enumerated value to an acctlink classname.

	CHOOSE CASE ls_Value

	CASE "DYNAMICS4AND5!"
		ib_SixPlus = FALSE

	CASE "DYNAMICS6!"
		ib_SixPlus = TRUE
		
	CASE "DYNAMICS7!"
		ib_SixPlus = TRUE
		ib_SevenPlus = TRUE

	END CHOOSE

END CHOOSE



//Initialize the value for ib_NoCellUpdates to FALSE.
//If the system setting for "Dynamics on MS SQL Server" has been set to yes, 
//set ib_NoCellUpdates = TRUE.  If the setting is no or has not been set, 
//leave ib_NoCellUpdates = FALSE.   This setting is here because under MS SQL 
//Server, the Cell.SetData command does not work.  Therefore, we can't update
//cell values.  So, we can't do things like append to batch, because that needs
//to update the batch count and batch total.

//There was a bug processing this setting in 3.5.00 to 3.5.02.
//This was fixed in 3.5.03

ib_NoCellUpdates = FALSE

CHOOSE CASE lnv_Settings.of_GetSetting ( 95, la_SqlServer )

CASE 1

	CHOOSE CASE String ( la_SqlServer )

	CASE "YES!"
		ib_NoCellUpdates = TRUE

	END CHOOSE

END CHOOSE
end event

event destructor;destroy inv_cst_dde

IF ii_DiagnosticsFile >= 0 THEN
	FileClose ( ii_DiagnosticsFile )
END IF
end event

