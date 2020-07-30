$PBExportHeader$n_cst_acctlink_quickbooks_direct_2002.sru
$PBExportComments$[n_cst_AcctLink_QuickBooks_Direct]
forward
global type n_cst_acctlink_quickbooks_direct_2002 from n_cst_acctlink_quickbooks_direct
end type
end forward

global type n_cst_acctlink_quickbooks_direct_2002 from n_cst_acctlink_quickbooks_direct
end type
global n_cst_acctlink_quickbooks_direct_2002 n_cst_acctlink_quickbooks_direct_2002

on n_cst_acctlink_quickbooks_direct_2002.create
TriggerEvent( this, "constructor" )
end on

on n_cst_acctlink_quickbooks_direct_2002.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;call super::constructor;/*
QBFC2 can issue qbXML 1.1 and 1.0 requests to QuickBooks 2002, you do that by setting the version of 
qbXML you want QBFC to generate in your call to CreateMsgSetRequest, providing the major and minor 
version numbers:

CreateMsgSetRequest(2,0)  will return an IMsgSetRequest for qbXML 2.0 (QB2003)

CreateMsgSetRequest(1,1)  will return an IMsgSetRequest for qbXML 1.1 (QB 2002 R2 and later)

CreateMsgSetRequest(1,0)  will return an IMsgSetRequest for qbXML 1.0 (QB 2002 R1)

You can tell the version of QuickBooks you have by holding down CTRL and typing "1" while in the QuickBooks UI.
*/

ii_QBSDK_MajorVersion = 1
ii_QBSDK_MinorVersion = 0
is_QBSDK_COMObject = "QBFC2.QBSessionManager"

ib_DirectConnect = TRUE
end event

