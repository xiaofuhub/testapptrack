$PBExportHeader$w_pcm_connection.srw
forward
global type w_pcm_connection from Window
end type
type st_1 from statictext within w_pcm_connection
end type
type st_3 from statictext within w_pcm_connection
end type
type st_2 from statictext within w_pcm_connection
end type
type cb_cancel from commandbutton within w_pcm_connection
end type
type cb_convert from commandbutton within w_pcm_connection
end type
type cb_ok from commandbutton within w_pcm_connection
end type
type cb_conn from commandbutton within w_pcm_connection
end type
type st_instruct from statictext within w_pcm_connection
end type
type ln_1 from line within w_pcm_connection
end type
end forward

global type w_pcm_connection from Window
int X=457
int Y=240
int Width=1865
int Height=1364
boolean TitleBar=true
string Title="PC*Miler Connection"
long BackColor=12632256
boolean ControlMenu=true
WindowType WindowType=response!
st_1 st_1
st_3 st_3
st_2 st_2
cb_cancel cb_cancel
cb_convert cb_convert
cb_ok cb_ok
cb_conn cb_conn
st_instruct st_instruct
ln_1 ln_1
end type
global w_pcm_connection w_pcm_connection

type variables
n_cst_trip		inv_trip
n_cst_routing	inv_routing
string		is_windowtitle="PC*Miler Connection"

end variables

event open;/*
 	Check co_pcm column to see if data has been converted 
	to new format (comma between city and state).
	If it hasn't then make window bigger to show convert
	message.
	
*/

SetPointer(HourGlass!)
long		ll_count, &
			ll_trip, &
			ll_buflen=256
string	ls_locater, &
			ls_match, &
			ls_productname, &
			ls_productversion, &
			ls_about="ProductName"
integer 	li_result, &
			ll_match
boolean	lb_OldFormat, &
			lb_connected

n_cst_Privileges	lnv_Privileges

/*
	Replaced all direct calls to pcms functions with functions on routing object.
	n_cst_trip determines correct routing object
*/
inv_trip = create n_cst_trip

if inv_trip.of_isconnected() then
	if inv_trip.of_connect(inv_routing) then
		if inv_routing.of_isvalid() then
			ls_productname=inv_routing.of_about("ProductName")
			ls_productversion=inv_routing.of_about("ProductVersion")
			if len(ls_productname) > 0 then
				this.title = is_windowtitle + " - " + ls_productname + ' Version ' + ls_productversion
			end if
			lb_connected = true
		else
			lb_connected = false
		end if
		
	end if
else
	lb_connected = false
end if
	
if lb_connected then
	
	st_instruct.text = "You are currently connected."
	cb_conn.text = "Disconnect"
	cb_ok.default = true
	cb_ok.setfocus()
	if pos(upper(ls_productname),"STREET",1) = 0 THEN
		//Check for a regular PC*Miler data conversion
		IF lnv_Privileges.of_HasSysAdminRights ( ) THEN
			
			if inv_routing.of_isoldpcmilerversion() then

				this.height=476
				cb_convert.enabled=FALSE
		
			ELSE
				
				DECLARE companies_pcm CURSOR FOR
				
				SELECT co_pcm
				  FROM companies 
				 WHERE co_pcm not LIKE '%,%' AND LENGTH(TRIM(co_pcm)) > 0;
				
				OPEN companies_pcm ;
				
				FETCH companies_pcm into :ls_locater;
				LI_RESULT=	sqlca.sqlcode	
				IF sqlca.sqlcode <> 0 THEN
					ll_count = 1		
				END IF
			
				CLOSE companies_pcm;
				
				COMMIT;
					
				IF ll_count = 0 THEN
					this.height=1364
					cb_convert.enabled=TRUE
				ELSE
					this.height=476
				END IF
		
		
			END IF
		
		else
			
			this.height=476
			cb_convert.enabled=FALSE
			
		END IF
	
	else
		
		this.height=476
		cb_convert.enabled=FALSE
		
	end if
else
	st_instruct.text = "You are not currently connected."
	cb_conn.text = "Connect"
	cb_conn.default = true
	cb_conn.setfocus()
	this.height=476
end if



end event

on w_pcm_connection.create
this.st_1=create st_1
this.st_3=create st_3
this.st_2=create st_2
this.cb_cancel=create cb_cancel
this.cb_convert=create cb_convert
this.cb_ok=create cb_ok
this.cb_conn=create cb_conn
this.st_instruct=create st_instruct
this.ln_1=create ln_1
this.Control[]={this.st_1,&
this.st_3,&
this.st_2,&
this.cb_cancel,&
this.cb_convert,&
this.cb_ok,&
this.cb_conn,&
this.st_instruct,&
this.ln_1}
end on

on w_pcm_connection.destroy
destroy(this.st_1)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.cb_cancel)
destroy(this.cb_convert)
destroy(this.cb_ok)
destroy(this.cb_conn)
destroy(this.st_instruct)
destroy(this.ln_1)
end on

event close;if isvalid(inv_trip) then
	destroy inv_trip
end if

end event

type st_1 from statictext within w_pcm_connection
int X=288
int Y=464
int Width=695
int Height=76
boolean Enabled=false
string Text="Converting your data:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_pcm_connection
int X=288
int Y=900
int Width=1088
int Height=184
boolean Enabled=false
string Text="Click on the conversion button below to convert your data."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
boolean Italic=true
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_pcm_connection
int X=288
int Y=552
int Width=1285
int Height=328
boolean Enabled=false
string Text="Profit Tools has detected an old format of the PC*MILER data in your database.  Your data needs to be converted in order to support versions of PC*MILER higher than version 11."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_cancel from commandbutton within w_pcm_connection
int X=937
int Y=1132
int Width=352
int Height=88
int TabOrder=30
string Text="Cancel"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type cb_convert from commandbutton within w_pcm_connection
int X=530
int Y=1132
int Width=352
int Height=88
int TabOrder=20
boolean Enabled=false
string Text="Convert"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;SetPointer(HourGlass!)
  
  UPDATE companies 
     SET co_pcm = substr(co_pcm, 1, 6) + 
	  		trim(substr(co_pcm, 7, 14)) + 
			', ' + 
			substr(co_pcm, 21, 2)
	where length( trim(co_pcm) ) > 0 and 
			patindex('%,%', co_pcm) = 0 ;

	choose case sqlca.sqlcode
	case 0
		commit ;
		messagebox('Conversion', &
						'The conversion was successfully completed.', Exclamation!)
	case else
		rollback ;
		messagebox('Conversion', &
						'The conversion has encountered errors. ' + &
						'You can still use your Profit Tools application ' + &
						'but please call Profit Tools to inform them of the problem.', StopSign!)
	end choose


end event

type cb_ok from commandbutton within w_pcm_connection
int X=530
int Y=228
int Width=352
int Height=88
int TabOrder=10
string Text="OK"
boolean Cancel=true
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type cb_conn from commandbutton within w_pcm_connection
int X=937
int Y=228
int Width=352
int Height=88
int TabOrder=40
string Text="Connect"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string	ls_buffer, &
			ls_productname, &
			ls_productversion
			
boolean	lb_pcmilerinstalled

n_cst_AppServices	lnv_AppServices
n_cst_licensemanager	lnv_licensemanager

IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_PCMiler ) or &
	lnv_LicenseManager.of_usepcmilerstreets() THEN
	//ok to proceed
	IF pcmm_inst = FALSE THEN
		MessageBox ( 'PCMiler', "You must set the 'PC*Miler Server Installed' setting in System Settings to 'YES' "+&
		"in order to use this feature.  You will also need to exit and restart Profit Tools in order for the "+&
		"change to take effect." )
		lb_pcmilerinstalled = false
	else
		lb_pcmilerinstalled = true
	end if
else
	MessageBox ( 'PCMiler', "You must have a Profit Tools PC*Miler Interface license in order to use this feature." +&
		"  Please contact your Profit Tools sales representative, or Profit Tools technical support." )
		lb_pcmilerinstalled = false
END IF


if lb_pcmilerinstalled then
	if not inv_trip.of_isconnected() then
		if inv_trip.of_connect(inv_routing) then
			if inv_routing.of_isvalid() then
				st_instruct.text = "Connected successfully."
				ls_productname=inv_routing.of_about("ProductName")
				ls_productversion=inv_routing.of_about("ProductVersion")
				if len(ls_productname) > 0 then
					parent.title = is_windowtitle + " - " + ls_productname + ' Version ' + ls_productversion
				end if
				this.text = "Disconnect"
				cb_ok.setfocus()
			else
				messagebox("Connect to PC*Miler", "Could not establish connection.", exclamation!)
			end if
		end if
	elseif isvalid(lnv_AppServices.of_GetFrame ( ).getfirstsheet()) then
		messagebox("Disconnect from PC*Miler", "You must close all open windows before "+&
			"disconnecting.")
		close(parent)
	else
		inv_trip.of_disconnect()
		st_instruct.text = "Disconnected successfully."
		this.text = "Connect"
		cb_ok.setfocus()
	end if
end if
end event

type st_instruct from statictext within w_pcm_connection
int X=480
int Y=72
int Width=878
int Height=76
boolean Enabled=false
string Text="You are not currently connected."
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type ln_1 from line within w_pcm_connection
boolean Enabled=false
int BeginX=256
int BeginY=408
int EndX=1577
int EndY=408
int LineThickness=8
long LineColor=33554432
end type

