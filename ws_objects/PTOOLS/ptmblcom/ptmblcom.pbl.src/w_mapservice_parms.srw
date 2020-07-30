$PBExportHeader$w_mapservice_parms.srw
forward
global type w_mapservice_parms from w_response
end type
type em_hours from u_em within w_mapservice_parms
end type
type sle_streetaddress from u_sle within w_mapservice_parms
end type
type sle_city from u_sle within w_mapservice_parms
end type
type sle_state from u_sle within w_mapservice_parms
end type
type sle_postalcode from u_sle within w_mapservice_parms
end type
type em_radius from u_em within w_mapservice_parms
end type
type sle_startdate from u_sle_date within w_mapservice_parms
end type
type sle_starttime from u_sle_time within w_mapservice_parms
end type
type sle_enddate from u_sle_date within w_mapservice_parms
end type
type sle_endtime from u_sle_time within w_mapservice_parms
end type
type em_minutes from u_em within w_mapservice_parms
end type
type st_1 from statictext within w_mapservice_parms
end type
type st_2 from statictext within w_mapservice_parms
end type
type st_3 from statictext within w_mapservice_parms
end type
type st_4 from statictext within w_mapservice_parms
end type
type st_5 from statictext within w_mapservice_parms
end type
type st_6 from statictext within w_mapservice_parms
end type
type st_7 from statictext within w_mapservice_parms
end type
type st_8 from statictext within w_mapservice_parms
end type
type st_9 from statictext within w_mapservice_parms
end type
type st_10 from statictext within w_mapservice_parms
end type
type st_11 from statictext within w_mapservice_parms
end type
type st_12 from statictext within w_mapservice_parms
end type
type st_13 from statictext within w_mapservice_parms
end type
type em_refresh from u_em within w_mapservice_parms
end type
type st_14 from statictext within w_mapservice_parms
end type
type st_15 from statictext within w_mapservice_parms
end type
type cb_1 from u_cbok within w_mapservice_parms
end type
type cb_2 from u_cbcancel within w_mapservice_parms
end type
type gb_1 from groupbox within w_mapservice_parms
end type
type gb_2 from groupbox within w_mapservice_parms
end type
type gb_3 from groupbox within w_mapservice_parms
end type
end forward

global type w_mapservice_parms from w_response
integer x = 800
integer y = 600
integer width = 2162
integer height = 1636
string title = "Position Map Options"
em_hours em_hours
sle_streetaddress sle_streetaddress
sle_city sle_city
sle_state sle_state
sle_postalcode sle_postalcode
em_radius em_radius
sle_startdate sle_startdate
sle_starttime sle_starttime
sle_enddate sle_enddate
sle_endtime sle_endtime
em_minutes em_minutes
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
st_5 st_5
st_6 st_6
st_7 st_7
st_8 st_8
st_9 st_9
st_10 st_10
st_11 st_11
st_12 st_12
st_13 st_13
em_refresh em_refresh
st_14 st_14
st_15 st_15
cb_1 cb_1
cb_2 cb_2
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
end type
global w_mapservice_parms w_mapservice_parms

type variables
s_Nextel_MapServiceParms	istr_MapParms

Boolean	ib_ValidateClose = FALSE
end variables

on w_mapservice_parms.create
int iCurrent
call super::create
this.em_hours=create em_hours
this.sle_streetaddress=create sle_streetaddress
this.sle_city=create sle_city
this.sle_state=create sle_state
this.sle_postalcode=create sle_postalcode
this.em_radius=create em_radius
this.sle_startdate=create sle_startdate
this.sle_starttime=create sle_starttime
this.sle_enddate=create sle_enddate
this.sle_endtime=create sle_endtime
this.em_minutes=create em_minutes
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.st_6=create st_6
this.st_7=create st_7
this.st_8=create st_8
this.st_9=create st_9
this.st_10=create st_10
this.st_11=create st_11
this.st_12=create st_12
this.st_13=create st_13
this.em_refresh=create em_refresh
this.st_14=create st_14
this.st_15=create st_15
this.cb_1=create cb_1
this.cb_2=create cb_2
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_hours
this.Control[iCurrent+2]=this.sle_streetaddress
this.Control[iCurrent+3]=this.sle_city
this.Control[iCurrent+4]=this.sle_state
this.Control[iCurrent+5]=this.sle_postalcode
this.Control[iCurrent+6]=this.em_radius
this.Control[iCurrent+7]=this.sle_startdate
this.Control[iCurrent+8]=this.sle_starttime
this.Control[iCurrent+9]=this.sle_enddate
this.Control[iCurrent+10]=this.sle_endtime
this.Control[iCurrent+11]=this.em_minutes
this.Control[iCurrent+12]=this.st_1
this.Control[iCurrent+13]=this.st_2
this.Control[iCurrent+14]=this.st_3
this.Control[iCurrent+15]=this.st_4
this.Control[iCurrent+16]=this.st_5
this.Control[iCurrent+17]=this.st_6
this.Control[iCurrent+18]=this.st_7
this.Control[iCurrent+19]=this.st_8
this.Control[iCurrent+20]=this.st_9
this.Control[iCurrent+21]=this.st_10
this.Control[iCurrent+22]=this.st_11
this.Control[iCurrent+23]=this.st_12
this.Control[iCurrent+24]=this.st_13
this.Control[iCurrent+25]=this.em_refresh
this.Control[iCurrent+26]=this.st_14
this.Control[iCurrent+27]=this.st_15
this.Control[iCurrent+28]=this.cb_1
this.Control[iCurrent+29]=this.cb_2
this.Control[iCurrent+30]=this.gb_1
this.Control[iCurrent+31]=this.gb_2
this.Control[iCurrent+32]=this.gb_3
end on

on w_mapservice_parms.destroy
call super::destroy
destroy(this.em_hours)
destroy(this.sle_streetaddress)
destroy(this.sle_city)
destroy(this.sle_state)
destroy(this.sle_postalcode)
destroy(this.em_radius)
destroy(this.sle_startdate)
destroy(this.sle_starttime)
destroy(this.sle_enddate)
destroy(this.sle_endtime)
destroy(this.em_minutes)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.st_8)
destroy(this.st_9)
destroy(this.st_10)
destroy(this.st_11)
destroy(this.st_12)
destroy(this.st_13)
destroy(this.em_refresh)
destroy(this.st_14)
destroy(this.st_15)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event open;call super::open;//Capture the map service parms structure, if one is passed in.
//(If no structure is passed in, a blank default structure will be used instead.)

IF IsValid ( Message.PowerObjectParm ) THEN
	IF Classname ( Message.PowerObjectParm ) = "s_nextel_mapserviceparms" THEN
		istr_MapParms = Message.PowerObjectParm
	END IF
END IF
end event

event pfc_postopen;call super::pfc_postopen;String	ls_Date, &
			ls_Time
			
s_Nextel_MapServiceParms	lstr_MapParms
n_cst_Setting_NextelMappingAddress	lnv_NextelMappingAddress

n_cst_String	lnv_String

//The values for is_Start and is_End should be one of 2 formats: mmddyyhhmm or hhmm

//Parse & Process is_Start

IF Len ( istr_MapParms.is_Start ) = 10 THEN
	
	ls_Date = Left ( istr_MapParms.is_Start, 6 )
	ls_Time = Right ( istr_MapParms.is_Start, 4 )
	
ELSEIF Len ( istr_MapParms.is_Start ) = 4 THEN
	
	ls_Date = ""
	ls_Time = istr_MapParms.is_Start
	
ELSE
	
	ls_Date = ""
	ls_Time = ""
	
END IF


IF IsDate ( ls_Date ) AND IsTime ( ls_Time ) THEN
	sle_StartDate.Text = String ( Date ( ls_Date ), "mm/dd/yy" )
	sle_StartTime.Text = String ( Time ( ls_Time ), "hh:mm" )
ELSEIF IsTime ( ls_Time ) THEN
	sle_StartTime.Text = String ( Time ( ls_Time ), "hh:mm" )
END IF


//Parse & Process is_End

IF Len ( istr_MapParms.is_End ) = 10 THEN
	
	ls_Date = Left ( istr_MapParms.is_End, 6 )
	ls_Time = Right ( istr_MapParms.is_End, 4 )
	
ELSEIF Len ( istr_MapParms.is_End ) = 4 THEN
	
	ls_Date = ""
	ls_Time = istr_MapParms.is_End
	
ELSE
	
	ls_Date = ""
	ls_Time = ""
	
END IF


IF IsDate ( ls_Date ) AND IsTime ( ls_Time ) THEN
	sle_EndDate.Text = String ( Date ( ls_Date ), "mm/dd/yy" )
	sle_EndTime.Text = String ( Time ( ls_Time ), "hh:mm" )
ELSEIF IsTime ( ls_Time ) THEN
	sle_EndTime.Text = String ( Time ( ls_Time ), "hh:mm" )
END IF


//Process Hours & Minutes

IF istr_MapParms.ii_Hours > 0 THEN
	em_Hours.Text = String ( istr_MapParms.ii_Hours )
END IF

IF istr_MapParms.ii_Minutes > 0 THEN
	em_Minutes.Text = String ( istr_MapParms.ii_Minutes )
END IF


//Process Address & Radius

IF istr_MapParms.istr_Center.co_Addr1 > "" THEN
	sle_StreetAddress.Text = istr_MapParms.istr_Center.co_Addr1
END IF

IF istr_MapParms.istr_Center.co_City > "" THEN
	sle_City.Text = istr_MapParms.istr_Center.co_City
END IF

IF istr_MapParms.istr_Center.co_State > "" THEN
	sle_State.Text = istr_MapParms.istr_Center.co_State
END IF

IF istr_MapParms.istr_Center.co_Zip > "" THEN
	IF Match ( Left ( istr_MapParms.istr_Center.co_Zip, 5 ), "^[0-9]+$" ) THEN
		sle_PostalCode.Text = Left ( istr_MapParms.istr_Center.co_Zip, 5 )
	ELSE
		sle_PostalCode.Text = Left ( lnv_String.of_GlobalReplace ( istr_MapParms.istr_Center.co_Zip, " ", "" ), 6 )
	END IF
END IF


IF istr_MapParms.ii_Radius > 0 THEN
	em_Radius.Text = String ( istr_MapParms.ii_Radius )
END IF

IF istr_MapParms.ii_Refresh > 0 THEN
	em_Refresh.Text = String ( istr_MapParms.ii_Refresh )
END IF


//Carry over non-displayed values into the fresh structure.

IF istr_MapParms.is_ServicePath > "" THEN
	lstr_MapParms.is_ServicePath = istr_MapParms.is_ServicePath
ELSE
	lnv_NextelMappingAddress = CREATE n_cst_Setting_NextelMappingAddress
	lstr_MapParms.is_ServicePath = Trim ( lnv_NextelMappingAddress.of_GetValue ( ) )
	DESTROY lnv_NextelMappingAddress
END IF

lstr_MapParms.is_IdList = istr_MapParms.is_IdList
lstr_MapParms.is_GroupIdList = istr_MapParms.is_GroupIdList
lstr_MapParms.is_Lat = istr_MapParms.is_Lat
lstr_MapParms.is_Lon = istr_MapParms.is_Lon

//Replace the instance structure with the fresh structure.
istr_MapParms = lstr_MapParms


end event

event pfc_preclose;call super::pfc_preclose;String	ls_Work
Integer	li_Work

Integer	li_Return = 1


//Put validation here.  If anything fails, setting li_Return = -1 will prevent close.
//If ib_DisableCloseQuery = TRUE, don't bother, we're cancelling.

IF li_Return = 1 AND ib_ValidateClose = TRUE THEN
	
	//If the user filled in any of the center point values, then Address, City, State are all required.
	
	IF Trim ( sle_StreetAddress.Text ) > "" OR Trim ( sle_City.Text ) > "" OR Trim ( sle_State.Text ) > "" OR Trim ( sle_PostalCode.Text ) > "" THEN
		
		IF Trim ( sle_StreetAddress.Text ) > "" AND Trim ( sle_City.Text ) > "" AND Trim ( sle_State.Text ) > "" /*AND Trim ( sle_PostalCode.Text ) > "" Hopefully, ZIP is NOT a required value!!  Elutions has not verified this.*/ THEN
			
			//OK
			
		ELSE
			
			MessageBox ( "Map Option Validation", "If you specify a Target Location (Center Point), you must specify Street Address, City, and State." )
			li_Return = -1
			
		END IF
		
	END IF
	
END IF

//Now that we've checked it, reset the ib_ValidateClose flag.
ib_ValidateClose = FALSE


IF li_Return = 1 THEN

	//Populate the instance structure.  It will be passed out during close.
	
	//The values for is_Start and is_End should be one of 2 formats: mmddyyhhmm or hhmm
	
	//Process is_Start
	
	ls_Work = ""
	
	IF sle_StartDate.Text > "" THEN
		
		ls_Work = String ( Date ( sle_StartDate.Text ), "mmddyy" )
		
		IF sle_StartTime.Text > "" THEN
			ls_Work += String ( Time ( sle_StartTime.Text ), "hhmm" )
		ELSE
			ls_Work += "0000"
		END IF
		
	ELSEIF sle_StartTime.Text > "" THEN
		
		ls_Work = String ( Time ( sle_StartTime.Text ), "hhmm" )
		
	END IF
	
	istr_MapParms.is_Start = ls_Work
	
	
	//Process is_End
	
	ls_Work = ""
	
	IF sle_EndDate.Text > "" THEN
		
		ls_Work = String ( Date ( sle_EndDate.Text ), "mmddyy" )
		
		IF sle_EndTime.Text > "" THEN
			ls_Work += String ( Time ( sle_EndTime.Text ), "hhmm" )
		ELSE
			ls_Work += "2359"
		END IF
		
	ELSEIF sle_EndTime.Text > "" THEN
		
		ls_Work = String ( Time ( sle_EndTime.Text ), "hhmm" )
		
	END IF
	
	istr_MapParms.is_End = ls_Work
	
	
	//Process Hours & Minutes
	
	li_Work = Integer ( em_Hours.Text )
	
	IF li_Work > 0 THEN
		istr_MapParms.ii_Hours = li_Work
	ELSE
		istr_MapParms.ii_Hours = 0
	END IF
	
	
	li_Work = Integer ( em_Minutes.Text )
	
	IF li_Work > 0 THEN
		istr_MapParms.ii_Minutes = li_Work
	ELSE
		istr_MapParms.ii_Minutes = 0
	END IF
	
	
	//Process Address & Radius
	
	istr_MapParms.istr_Center.co_Addr1 = Trim ( sle_StreetAddress.Text )
	istr_MapParms.istr_Center.co_City = Trim ( sle_City.Text )
	istr_MapParms.istr_Center.co_State = Trim ( sle_State.Text )
	istr_MapParms.istr_Center.co_Zip = Trim ( sle_PostalCode.Text )
	
	//If the address option was used, clear any values that may be present in Lat/Lon
	
	IF istr_MapParms.istr_Center.co_Addr1 > "" THEN
		istr_MapParms.is_Lat = ""
		istr_MapParms.is_Lon = ""
	END IF
	
	
	li_Work = Integer ( em_Radius.Text )
	
	IF li_Work > 0 THEN
		istr_MapParms.ii_Radius = li_Work
	ELSE
		istr_MapParms.ii_Radius = 0
	END IF
	
	
	li_Work = Integer ( em_Refresh.Text )
	
	IF li_Work > 0 THEN
		istr_MapParms.ii_Refresh = li_Work
	ELSE
		istr_MapParms.ii_Refresh = 0
	END IF

END IF


RETURN li_Return
end event

event pfc_cancel;call super::pfc_cancel;Close ( This )
end event

type cb_help from w_response`cb_help within w_mapservice_parms
end type

type em_hours from u_em within w_mapservice_parms
integer x = 818
integer y = 412
integer taborder = 50
boolean bringtotop = true
integer accelerator = 104
string mask = "#####"
end type

type sle_streetaddress from u_sle within w_mapservice_parms
integer x = 498
integer y = 700
integer width = 1486
integer taborder = 70
boolean bringtotop = true
integer accelerator = 97
end type

type sle_city from u_sle within w_mapservice_parms
integer x = 498
integer y = 816
integer width = 640
integer taborder = 80
boolean bringtotop = true
integer accelerator = 99
end type

type sle_state from u_sle within w_mapservice_parms
integer x = 1568
integer y = 816
integer width = 151
integer taborder = 90
boolean bringtotop = true
integer limit = 2
integer accelerator = 116
end type

type sle_postalcode from u_sle within w_mapservice_parms
integer x = 503
integer y = 940
integer width = 306
integer height = 84
integer taborder = 100
boolean bringtotop = true
integer limit = 6
integer accelerator = 122
end type

type em_radius from u_em within w_mapservice_parms
integer x = 1243
integer y = 940
integer taborder = 110
boolean bringtotop = true
integer accelerator = 114
string mask = "####"
end type

type sle_startdate from u_sle_date within w_mapservice_parms
integer x = 485
integer y = 200
integer taborder = 10
boolean bringtotop = true
integer accelerator = 115
end type

type sle_starttime from u_sle_time within w_mapservice_parms
integer x = 814
integer y = 200
integer width = 261
integer taborder = 20
boolean bringtotop = true
end type

type sle_enddate from u_sle_date within w_mapservice_parms
integer x = 1385
integer y = 200
integer taborder = 30
boolean bringtotop = true
integer accelerator = 101
end type

type sle_endtime from u_sle_time within w_mapservice_parms
integer x = 1710
integer y = 200
integer width = 261
integer taborder = 40
boolean bringtotop = true
end type

type em_minutes from u_em within w_mapservice_parms
integer x = 1321
integer y = 412
integer taborder = 60
boolean bringtotop = true
integer accelerator = 109
string mask = "#####"
boolean spin = true
double increment = 15
end type

type st_1 from statictext within w_mapservice_parms
integer x = 114
integer y = 208
integer width = 343
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "&Starting At:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_mapservice_parms
integer x = 489
integer y = 132
integer width = 293
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Date"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_mapservice_parms
integer x = 786
integer y = 132
integer width = 293
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Time"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within w_mapservice_parms
integer x = 1079
integer y = 208
integer width = 288
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "&Ending At:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_5 from statictext within w_mapservice_parms
integer x = 1376
integer y = 132
integer width = 293
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Date"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_6 from statictext within w_mapservice_parms
integer x = 1691
integer y = 132
integer width = 293
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Time"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_7 from statictext within w_mapservice_parms
integer x = 265
integer y = 424
integer width = 521
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Duration: &Hours:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_8 from statictext within w_mapservice_parms
integer x = 1051
integer y = 424
integer width = 256
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "&Minutes:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_9 from statictext within w_mapservice_parms
integer x = 82
integer y = 708
integer width = 411
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Street &Address:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_10 from statictext within w_mapservice_parms
integer x = 142
integer y = 824
integer width = 343
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "&City:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_11 from statictext within w_mapservice_parms
integer x = 1152
integer y = 824
integer width = 402
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "S&tate/Province:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_12 from statictext within w_mapservice_parms
integer x = 96
integer y = 948
integer width = 393
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "&Zip/Postal:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_13 from statictext within w_mapservice_parms
integer x = 818
integer y = 956
integer width = 416
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "&Radius (Miles):"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_refresh from u_em within w_mapservice_parms
integer x = 1147
integer y = 1208
integer taborder = 120
boolean bringtotop = true
integer accelerator = 119
string mask = "####"
end type

type st_14 from statictext within w_mapservice_parms
integer x = 101
integer y = 1224
integer width = 1038
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Bro&wser Auto-Refresh Interval (Minutes):"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_15 from statictext within w_mapservice_parms
integer x = 448
integer y = 300
integer width = 1563
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "(Note:  Dates / Times are for Base Home Office Time Zone)"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from u_cbok within w_mapservice_parms
integer x = 768
integer y = 1404
integer width = 233
integer taborder = 130
boolean bringtotop = true
end type

event clicked;call super::clicked;//Flag that we're closing by OK request rather than the "X"
//The flag will be reset to FALSE in pfc_PreClose
ib_ValidateClose = TRUE

IF Parent.Event pfc_PreClose ( ) = 1 THEN

	CloseWithReturn ( Parent, istr_MapParms )
	
END IF
end event

type cb_2 from u_cbcancel within w_mapservice_parms
integer x = 1129
integer y = 1404
integer width = 233
integer taborder = 140
boolean bringtotop = true
end type

type gb_1 from groupbox within w_mapservice_parms
integer x = 69
integer y = 52
integer width = 1979
integer height = 496
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Breadcrumb Trail"
end type

type gb_2 from groupbox within w_mapservice_parms
integer x = 73
integer y = 604
integer width = 1975
integer height = 492
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Target Location (Center Point)"
end type

type gb_3 from groupbox within w_mapservice_parms
integer x = 73
integer y = 1140
integer width = 1975
integer height = 200
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

