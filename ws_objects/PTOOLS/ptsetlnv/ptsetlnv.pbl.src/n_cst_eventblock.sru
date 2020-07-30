$PBExportHeader$n_cst_eventblock.sru
forward
global type n_cst_eventblock from nonvisualobject
end type
end forward

global type n_cst_eventblock from nonvisualobject
end type
global n_cst_eventblock n_cst_eventblock

type variables
Private:
long		il_FirstDisplayRow
long		il_LastDisplayRow
long		il_FirstSourceRow
long		il_LastSourceRow
long		il_RowCount
long		ila_eventId[]
long		il_OriginId
long		il_DestinationID
string		is_status
boolean		ib_primaryblock
boolean		ib_Indented
date		id_Start
date		id_End
long		ila_SelectedTemplateId[]
boolean		ib_BlockLocked

end variables

forward prototypes
public subroutine of_setstatus (string as_status)
public function string of_getstatus ()
public subroutine of_seteventidlist (long ala_eventidlist[])
public subroutine of_setrowcount (long al_row)
public function long of_getrowcount ()
public subroutine of_geteventidlist (ref long ala_eventid[])
public function boolean of_isprimaryblock ()
public subroutine of_setprimaryblock (boolean ab_Primary)
public subroutine of_setstartdate (date ad_Start)
public subroutine of_setenddate (date ad_End)
public function date of_getstartdate ()
public function date of_getenddate ()
public function long of_getfirstdisplayrow ()
public function long of_getlastdisplayrow ()
public function long of_getfirstsourcerow ()
public function long of_getlastsourcerow ()
public subroutine of_setfirstdisplayrow (long al_row)
public subroutine of_setlastdisplayrow (long al_row)
public subroutine of_setfirstsourcerow (long al_row)
public subroutine of_setlastsourcerow (long al_row)
public function long of_getselectedtemplateid (ref long ala_Id[])
public subroutine of_setselectedtemplateid (ref long ala_Id[])
public function boolean of_isblocklocked ()
public subroutine of_setblocklocked (boolean ab_locked)
public function boolean of_isblockindented ()
public subroutine of_setindented (boolean ab_indented)
public subroutine of_setoriginid (long al_value)
public subroutine of_setdestinationid (long al_value)
public function long of_getoriginid ()
public function long of_getdestinationid ()
end prototypes

public subroutine of_setstatus (string as_status);is_status = as_status
end subroutine

public function string of_getstatus ();return is_status
end function

public subroutine of_seteventidlist (long ala_eventidlist[]);ila_eventid = ala_eventidlist
end subroutine

public subroutine of_setrowcount (long al_row);il_rowcount = al_row
end subroutine

public function long of_getrowcount ();return il_rowcount
end function

public subroutine of_geteventidlist (ref long ala_eventid[]); ala_Eventid = ila_eventid
end subroutine

public function boolean of_isprimaryblock ();return ib_primaryblock
end function

public subroutine of_setprimaryblock (boolean ab_Primary);ib_primaryblock = ab_Primary
end subroutine

public subroutine of_setstartdate (date ad_Start);id_start = ad_Start
end subroutine

public subroutine of_setenddate (date ad_End);id_end = ad_End
end subroutine

public function date of_getstartdate ();return id_start
end function

public function date of_getenddate ();return id_end
end function

public function long of_getfirstdisplayrow ();return il_firstdisplayrow
end function

public function long of_getlastdisplayrow ();return il_lastdisplayrow
end function

public function long of_getfirstsourcerow ();return il_FirstSourceRow
end function

public function long of_getlastsourcerow ();return il_LastSourceRow
end function

public subroutine of_setfirstdisplayrow (long al_row);il_firstdisplayrow = al_row
end subroutine

public subroutine of_setlastdisplayrow (long al_row);il_lastdisplayrow = al_row
end subroutine

public subroutine of_setfirstsourcerow (long al_row);il_firstsourcerow = al_row
end subroutine

public subroutine of_setlastsourcerow (long al_row);il_lastsourcerow = al_row
end subroutine

public function long of_getselectedtemplateid (ref long ala_Id[]);long	ll_ArrayCount

ll_ArrayCount = upperbound ( ila_selectedtemplateid )

ala_Id = ila_selectedtemplateid

return ll_ArrayCount
end function

public subroutine of_setselectedtemplateid (ref long ala_Id[]);ila_selectedtemplateid = ala_Id
end subroutine

public function boolean of_isblocklocked ();return ib_blocklocked
end function

public subroutine of_setblocklocked (boolean ab_locked);ib_blocklocked = ab_locked
end subroutine

public function boolean of_isblockindented ();return ib_indented
end function

public subroutine of_setindented (boolean ab_indented);ib_indented = ab_indented
end subroutine

public subroutine of_setoriginid (long al_value);il_OriginId = al_value
end subroutine

public subroutine of_setdestinationid (long al_value);il_DestinationId = al_value
end subroutine

public function long of_getoriginid ();return il_OriginId
end function

public function long of_getdestinationid ();return il_DestinationId
end function

on n_cst_eventblock.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_eventblock.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

