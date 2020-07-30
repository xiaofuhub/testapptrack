$PBExportHeader$u_sle_time.sru
forward
global type u_sle_time from u_sle
end type
end forward

global type u_sle_time from u_sle
end type
global u_sle_time u_sle_time

type variables
protected:
powerobject ipoa_suspend_list[]
boolean ib_suspend
end variables

forward prototypes
public function Time of_gettime ()
end prototypes

public function Time of_gettime ();if isTime(this.text) then return Time(this.text) else return null_Time
end function

event modified;Time lt_work
integer li_ndx
powerobject lpo_focus
n_cst_string lnv_string

if len(this.text) > 0 then
	lt_work = lnv_string.of_SpecialTime(this.text)
	if isnull(lt_work)    THEN      //and not ib_suspend then
//		if not keydown(keytab!) then
//			lpo_focus = getfocus()
//			if isvalid(lpo_focus) then
//				for li_ndx = 1 to upperbound(ipoa_suspend_list)
//					if isvalid(ipoa_suspend_list[li_ndx]) then
//						if ipoa_suspend_list[li_ndx] = lpo_focus then return
//					end if
//				next
//			end if
//		end if
//
		post beep(1)
		this.post selecttext(1, len(this.text))
		this.post setfocus()
		This.text = This.text
		//return
	end if
else
	setnull(lt_work)
end if
this.text = string(lt_work, "hh:mm")
return 1
end event

