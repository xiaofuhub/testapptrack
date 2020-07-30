$PBExportHeader$u_tabpg_prprties_rating_nextbreak.sru
forward
global type u_tabpg_prprties_rating_nextbreak from u_tabpg_prprties_rating
end type
type st_2 from statictext within u_tabpg_prprties_rating_nextbreak
end type
type st_1 from statictext within u_tabpg_prprties_rating_nextbreak
end type
type uo_1 from u_cst_syssettings_nextbreaktables within u_tabpg_prprties_rating_nextbreak
end type
end forward

global type u_tabpg_prprties_rating_nextbreak from u_tabpg_prprties_rating
integer height = 1640
string text = "Next Break"
st_2 st_2
st_1 st_1
uo_1 uo_1
end type
global u_tabpg_prprties_rating_nextbreak u_tabpg_prprties_rating_nextbreak

on u_tabpg_prprties_rating_nextbreak.create
int iCurrent
call super::create
this.st_2=create st_2
this.st_1=create st_1
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.uo_1
end on

on u_tabpg_prprties_rating_nextbreak.destroy
call super::destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.uo_1)
end on

type st_2 from statictext within u_tabpg_prprties_rating_nextbreak
integer x = 110
integer y = 28
integer width = 608
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Auto Rating a shipment "
boolean focusrectangle = false
end type

type st_1 from statictext within u_tabpg_prprties_rating_nextbreak
integer x = 110
integer y = 104
integer width = 1723
integer height = 204
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "If using these selected tables the next break will be checked to see if it would be cheaper at that break. This is like ~'as weight~' but works on any rate type."
boolean focusrectangle = false
end type

type uo_1 from u_cst_syssettings_nextbreaktables within u_tabpg_prprties_rating_nextbreak
integer x = 82
integer y = 324
integer taborder = 30
end type

on uo_1.destroy
call u_cst_syssettings_nextbreaktables::destroy
end on

