$PBExportHeader$w_custompcmlocator.srw
forward
global type w_custompcmlocator from w_response
end type
type st_1 from statictext within w_custompcmlocator
end type
type sle_1 from singlelineedit within w_custompcmlocator
end type
type cb_1 from u_cbok within w_custompcmlocator
end type
type cb_2 from u_cbcancel within w_custompcmlocator
end type
type st_degrees from statictext within w_custompcmlocator
end type
end forward

global type w_custompcmlocator from w_response
int X=1074
int Y=932
int Width=1797
int Height=528
boolean TitleBar=true
string Title="PCMiler Locator"
st_1 st_1
sle_1 sle_1
cb_1 cb_1
cb_2 cb_2
st_degrees st_degrees
end type
global w_custompcmlocator w_custompcmlocator

type variables
n_cst_trip		inv_trip
n_cst_routing	inv_routing

end variables

on w_custompcmlocator.create
int iCurrent
call super::create
this.st_1=create st_1
this.sle_1=create sle_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_degrees=create st_degrees
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.sle_1
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.st_degrees
end on

on w_custompcmlocator.destroy
call super::destroy
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_degrees)
end on

event open;call super::open;integer	li_ndx, &
			li_msgcount, &
			li_return = 1

string	ls_pcm
n_cst_msg	lnv_msg
s_parm	lstr_parm

lnv_Msg = message.powerobjectparm
if isvalid(lnv_msg) then
	IF lnv_msg.of_Get_Parm ("LOCATOR", lstr_Parm ) <> 0 THEN
		if isnull(lstr_Parm.ia_Value ) then
			sle_1.text = ''
		else
			sle_1.text = lstr_Parm.ia_Value 
		end if
	END IF
else
	li_return = -1
end if

if li_return = 1 then
	sle_1.post selecttext(1,len(sle_1.text))

	inv_trip = create n_cst_trip
	
	//destroyed in close event
	if inv_trip.of_connect(inv_routing) then
		if inv_routing.of_isvalid() then
			//connected
		else
			li_return = -1
		end if
	else
		li_return = -1
	end if

end if

if li_return = -1 then
	close(this)
end if
end event

event close;call super::close;if isvalid(inv_trip) then
	destroy(inv_trip)
end if

end event

event pfc_default;string	ls_latlong, &
			ls_pcm

n_cst_licensemanager	lnv_licensemanager

ls_pcm = sle_1.text

if len(trim(ls_pcm)) > 0 then
	if lnv_LicenseManager.of_usepcmilerstreets() then
		ls_latlong = inv_routing.of_addresstolatlong(ls_pcm)
		if len(ls_latlong) > 0 then
			ls_pcm = ls_latlong
		end if
			
	end if
end if

n_cst_Msg	lnv_Msg
s_parm		lstr_Parm
	
lstr_Parm.is_Label = "LOCATOR"
lstr_Parm.ia_Value = ls_pcm
lnv_Msg.of_Add_Parm (lstr_Parm)

closewithreturn(this, lnv_Msg)
end event

event pfc_cancel;call super::pfc_cancel;n_cst_Msg	lnv_Msg
s_parm		lstr_Parm
	
lstr_Parm.is_Label = "CANCELLED"
lstr_Parm.ia_Value = sle_1.TEXT
lnv_Msg.of_Add_Parm (lstr_Parm)

closewithreturn(this, lnv_Msg)

end event

type st_1 from statictext within w_custompcmlocator
int X=151
int Y=32
int Width=1486
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Delete or replace the current locator with a custom locator."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_1 from singlelineedit within w_custompcmlocator
int X=507
int Y=156
int Width=791
int Height=76
int TabOrder=10
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
TextCase TextCase=Upper!
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;integer	li_return=1, &
			li_retval
long		ll_pos
string 	ls_foundpcm, &
			ls_locator, &
			lsa_Result[], &
			ls_matchstring = "^[0-9]?[0-9]?[0-9]?[0-9][.][0-9]*[NnWw]$"
			
boolean	lb_decimal

n_cst_String	lnv_String
st_degrees.visible=false
ls_locator = this.text

if len(trim(ls_locator)) = 0 then
	//user is clearing locator
	li_return = 0
end if

if li_return = 1 then
	//parse locator and check format
	lnv_String.of_ParseToArray ( ls_locator , "," , lsa_Result )

	IF UpperBound ( lsa_Result ) = 2 THEN
		
		IF match (lsa_Result [1], ls_MatchString ) THEN
			IF	match (lsa_Result [2], ls_MatchString ) THEN 
					lb_decimal = TRUE 
			END IF
		END IF
		
	END IF

	if lb_decimal then
		//decimal format, must be converted to degrees
		ls_locator = inv_routing.of_decimaltodms(lsa_Result[1]) + "," + inv_routing.of_decimaltodms(lsa_Result[2])
	end if

	//look it up
	li_retval = inv_routing.of_locationcheck(ls_locator, ls_foundpcm, true)
	
	choose case li_retval
		case 1, 2
			//good match
			if lb_decimal then
				st_degrees.visible=true
			end if
			if inv_routing.of_isstreets() then
				this.text = inv_routing.of_addresstolatlong(ls_foundpcm)
				st_degrees.visible=true
			else
				this.text=ls_foundpcm	
			end if
			
		case 0, -1
			messagebox("PCMiler Location", "Locator not found")
			sle_1.setfocus()
			
	end choose
	
end if
end event

type cb_1 from u_cbok within w_custompcmlocator
int X=622
int Y=284
int TabOrder=20
boolean BringToTop=true
end type

type cb_2 from u_cbcancel within w_custompcmlocator
int X=919
int Y=284
int TabOrder=30
boolean BringToTop=true
end type

type st_degrees from statictext within w_custompcmlocator
int X=978
int Y=12
int Width=731
int Height=76
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
string Text="Converted to latlong degrees"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

