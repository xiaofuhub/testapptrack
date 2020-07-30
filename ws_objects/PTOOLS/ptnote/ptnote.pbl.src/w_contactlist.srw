$PBExportHeader$w_contactlist.srw
forward
global type w_contactlist from w_response
end type
type dw_contacts from u_dw_notificationrecipients within w_contactlist
end type
type cb_1 from u_cbok within w_contactlist
end type
end forward

global type w_contactlist from w_response
int X=1134
int Y=628
int Width=933
int Height=1132
boolean TitleBar=true
string Title="Active Contact List"
dw_contacts dw_contacts
cb_1 cb_1
end type
global w_contactlist w_contactlist

event open;call super::open;n_cst_Msg	lnv_Msg
S_Parm		lstr_Parm
Long			lla_Contacts[]

lnv_Msg = Message.PowerObjectParm 

ib_DisableCloseQuery = TRUE

IF lnv_Msg.of_get_Parm ( "CONTACTS" , lstr_Parm ) <> 0 THEN
	
	lla_Contacts = lstr_Parm.ia_Value 
	
END IF

dw_contacts.of_Refresh ( lla_Contacts )
end event

event pfc_default;CLOSE ( THIS ) 
end event

on w_contactlist.create
int iCurrent
call super::create
this.dw_contacts=create dw_contacts
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_contacts
this.Control[iCurrent+2]=this.cb_1
end on

on w_contactlist.destroy
call super::destroy
destroy(this.dw_contacts)
destroy(this.cb_1)
end on

type dw_contacts from u_dw_notificationrecipients within w_contactlist
int X=32
int Y=28
int Width=846
int TabOrder=10
boolean BringToTop=true
end type

type cb_1 from u_cbok within w_contactlist
int X=338
int Y=912
int TabOrder=11
boolean BringToTop=true
boolean Cancel=true
end type

