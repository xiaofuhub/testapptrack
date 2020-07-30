$PBExportHeader$w_codriving.srw
$PBExportComments$PTLOG:
forward
global type w_codriving from Window
end type
type cb_print from u_cb within w_codriving
end type
type st_4 from statictext within w_codriving
end type
type st_3 from statictext within w_codriving
end type
type st_2 from statictext within w_codriving
end type
type dw_codriver from datawindow within w_codriving
end type
type r_codriver from rectangle within w_codriving
end type
type r_current from rectangle within w_codriving
end type
type r_overlap from rectangle within w_codriving
end type
end forward

global type w_codriving from Window
int X=306
int Y=752
int Width=3131
int Height=764
boolean TitleBar=true
string Title="Codriver's Log"
long BackColor=12632256
boolean ControlMenu=true
WindowType WindowType=response!
cb_print cb_print
st_4 st_4
st_3 st_3
st_2 st_2
dw_codriver dw_codriver
r_codriver r_codriver
r_current r_current
r_overlap r_overlap
end type
global w_codriving w_codriving

type variables
protected:
w_log w_par

end variables

on w_codriving.create
this.cb_print=create cb_print
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.dw_codriver=create dw_codriver
this.r_codriver=create r_codriver
this.r_current=create r_current
this.r_overlap=create r_overlap
this.Control[]={this.cb_print,&
this.st_4,&
this.st_3,&
this.st_2,&
this.dw_codriver,&
this.r_codriver,&
this.r_current,&
this.r_overlap}
end on

on w_codriving.destroy
destroy(this.cb_print)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.dw_codriver)
destroy(this.r_codriver)
destroy(this.r_current)
destroy(this.r_overlap)
end on

event open;w_par = message.powerobjectparm
this.x = 330
this.y = 1009

long coid, curid
date curdate
string colog, curlog

curdate = w_par.dw_log_list.getitemdate(w_par.dw_log_list.getselectedrow(0), "dl_date")
curlog = w_par.dw_log_list.getitemstring(w_par.dw_log_list.getselectedrow(0), "dl_log")
curid = w_par.cur_driver.em_id
coid = w_par.uo_codriver.cur_emp.em_id

select dl_log into :colog from driver_logs where dl_id = :coid and dl_date = :curdate ;
if sqlca.sqlcode = 0 or sqlca.sqlcode = 100 then
	commit ;
else 
	rollback ;
	messagebox("View Codriver's Log", "The codriver's log could not be retrieved.~n~nPlease retry.")
	close(this)
	return
end if

if isnull(colog) or len(trim(colog)) = 0 or left(colog, 1) = "7" then
	messagebox("View Codriver's Log", "The codriver's log has not been entered for this date.")
	close(this)
	return
elseif left(colog, 1) = "5" then  
	messagebox("View Codriver's Log", "The codriver's log has been reported as missing.")
	close(this)
	return
elseif left(colog, 1) = "6" then  
	messagebox("View Codriver's Log", "The codriver's hours were reported using the 100 "+&
		"Air-Mile Radius rules.  No log information is available.")
	close(this)
	return
end if

dw_codriver.setredraw(false)
dw_codriver.insertrow(0)
dw_codriver.setitem(1, "dl_log", curlog)
dw_codriver.setitem(1, "dl_log2", colog)
dw_codriver.setitem(1, "dl_id", curid)
dw_codriver.setitem(1, "dl_id2", coid)
dw_codriver.setredraw(true)


end event

type cb_print from u_cb within w_codriving
int X=2825
int Y=16
int Width=256
int Height=88
int TabOrder=10
string Text="&Print"
end type

event clicked;dw_Codriver.Print ( )
end event

type st_4 from statictext within w_codriving
int X=9
int Y=28
int Width=375
int Height=68
boolean Enabled=false
string Text="Driver's Log:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_codriving
int X=827
int Y=28
int Width=448
int Height=76
boolean Enabled=false
string Text="Codriver's Log:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_codriving
int X=1719
int Y=28
int Width=640
int Height=76
boolean Enabled=false
string Text="Overlapping Sections:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_codriver from datawindow within w_codriving
int X=18
int Y=112
int Width=3067
int Height=540
int TabOrder=20
string DataObject="d_log_codriving"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event dberror;return 1
end event

event rbuttondown;string lsa_parm_labels[]
any laa_parm_values[]

//if upper(dwo.type) = "DATAWINDOW" then
	lsa_parm_labels[1] = "MENU_TYPE"
	laa_parm_values[1] = "PRINT"
	lsa_parm_labels[2] = "PRINT_OBJECT"
	laa_parm_values[2] = this
	f_pop_standard(lsa_parm_labels, laa_parm_values)
//end if
end event

type r_codriver from rectangle within w_codriving
int X=1289
int Y=60
int Width=389
int Height=12
boolean Enabled=false
LineStyle LineStyle=transparent!
int LineThickness=4
long LineColor=8421504
long FillColor=8421504
end type

type r_current from rectangle within w_codriving
int X=398
int Y=60
int Width=389
int Height=12
boolean Enabled=false
LineStyle LineStyle=transparent!
int LineThickness=4
long LineColor=8421504
long FillColor=16711680
end type

type r_overlap from rectangle within w_codriving
int X=2373
int Y=60
int Width=389
int Height=12
boolean Enabled=false
LineStyle LineStyle=transparent!
int LineThickness=4
long LineColor=8421504
long FillColor=255
end type

