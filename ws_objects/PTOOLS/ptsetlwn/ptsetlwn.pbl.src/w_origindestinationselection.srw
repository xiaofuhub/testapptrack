$PBExportHeader$w_origindestinationselection.srw
forward
global type w_origindestinationselection from w_response
end type
type uo_destination from u_cst_ratinglocation within w_origindestinationselection
end type
type uo_origin from u_cst_ratinglocation within w_origindestinationselection
end type
type cb_1 from u_cbok within w_origindestinationselection
end type
type gb_origin from groupbox within w_origindestinationselection
end type
type gb_destination from groupbox within w_origindestinationselection
end type
end forward

global type w_origindestinationselection from w_response
integer width = 1847
integer height = 848
string title = "Origin / Destination Selection"
long backcolor = 12632256
uo_destination uo_destination
uo_origin uo_origin
cb_1 cb_1
gb_origin gb_origin
gb_destination gb_destination
end type
global w_origindestinationselection w_origindestinationselection

event open;call super::open;integer	li_ndx, &
			li_MsgCount

long		ll_coid

n_cst_beo_company	lnv_company
n_cst_msg			lnv_msg
s_parm				lstr_parm
lnv_Msg = message.powerobjectparm

if isvalid(lnv_Msg) then
	li_MsgCount = 	lnv_msg.of_get_count()
	FOR li_Ndx = 1 to li_MsgCount
		lnv_msg.of_get_parm(li_ndx, lstr_parm)
		
		CHOOSE CASE upper(lstr_parm.is_label)
					
			CASE "ORIGINBEO"
				if isvalid(lstr_Parm.ia_Value) then
					lnv_company = lstr_Parm.ia_Value
					THIS.uo_origin.of_setcompany(lnv_company)
				end if
			CASE "ORIGINID"
				ll_coid = lstr_Parm.ia_Value
				THIS.uo_origin.of_setcompany(ll_coid)
				
			CASE "DESTINATIONBEO"
				if isvalid(lstr_Parm.ia_Value) then
					lnv_company = lstr_Parm.ia_Value
					THIS.uo_destination.of_setcompany(lnv_company)
				end if
				
			CASE "DESTINATIONID"
				ll_coid = lstr_Parm.ia_Value
				THIS.uo_destination.of_setcompany(ll_coid)
								
		END CHOOSE
	NEXT
end if

uo_origin.event post ue_setfocus("SITE")
uo_origin.post setfocus()



end event

event pfc_default;call super::pfc_default;long	ll_return = 1, &
		ll_coid

n_cst_Msg	lnv_Msg
s_parm		lstr_Parm
	
ll_coid = uo_origin.of_GetSiteid()
if ll_coid > 0 then
	lstr_Parm.is_Label = "ORIGIN"
	lstr_Parm.ia_Value = ll_coid
	lnv_Msg.of_Add_Parm (lstr_Parm)
else
	MessageBox ( "Origin / Destination Selection" , "Please select an origin.")
	ll_return = -1
end if

if ll_return = 1 then
	ll_coid = uo_destination.of_GetSiteid()
	if ll_coid > 0 then
		lstr_Parm.is_Label = "DESTINATION"
		lstr_Parm.ia_Value = ll_coid
		lnv_Msg.of_Add_Parm (lstr_Parm)
	else
		MessageBox ( "Origin / Destination Selection" , "Please select a destination.")
		ll_return = -1
	end if
	
end if

if ll_return = 1 then
	CloseWithReturn ( THIS, lnv_msg )
end if
	


end event

on w_origindestinationselection.create
int iCurrent
call super::create
this.uo_destination=create uo_destination
this.uo_origin=create uo_origin
this.cb_1=create cb_1
this.gb_origin=create gb_origin
this.gb_destination=create gb_destination
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_destination
this.Control[iCurrent+2]=this.uo_origin
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.gb_origin
this.Control[iCurrent+5]=this.gb_destination
end on

on w_origindestinationselection.destroy
call super::destroy
destroy(this.uo_destination)
destroy(this.uo_origin)
destroy(this.cb_1)
destroy(this.gb_origin)
destroy(this.gb_destination)
end on

type cb_help from w_response`cb_help within w_origindestinationselection
integer x = 1714
integer y = 672
integer taborder = 40
end type

type uo_destination from u_cst_ratinglocation within w_origindestinationselection
integer x = 142
integer y = 380
integer height = 196
integer taborder = 20
boolean bringtotop = true
end type

on uo_destination.destroy
call u_cst_ratinglocation::destroy
end on

event ue_sitechanged;call super::ue_sitechanged;cb_1.post setfocus()

end event

type uo_origin from u_cst_ratinglocation within w_origindestinationselection
integer x = 142
integer y = 84
integer height = 196
integer taborder = 10
boolean bringtotop = true
end type

on uo_origin.destroy
call u_cst_ratinglocation::destroy
end on

event ue_sitechanged;call super::ue_sitechanged;uo_destination.event post ue_setfocus("SITE")
uo_destination.post setfocus()

end event

type cb_1 from u_cbok within w_origindestinationselection
integer x = 832
integer y = 644
integer width = 233
integer taborder = 30
boolean bringtotop = true
boolean default = false
end type

type gb_origin from groupbox within w_origindestinationselection
integer x = 37
integer y = 20
integer width = 1751
integer height = 264
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Origin"
end type

type gb_destination from groupbox within w_origindestinationselection
integer x = 37
integer y = 320
integer width = 1751
integer height = 276
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Destination"
end type

