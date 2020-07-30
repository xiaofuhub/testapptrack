$PBExportHeader$ofr_n_cst_bso.sru
forward
global type ofr_n_cst_bso from n_cst_base
end type
end forward

global type ofr_n_cst_bso from n_cst_base
end type
global ofr_n_cst_bso ofr_n_cst_bso

type variables
protected:
constant boolean PASSBYREFERENCE= true
constant boolean PASSBYVALUE = false

private:
boolean ib_bcmpassbymode
n_cst_bcmmgr inv_bcmmgr

end variables

forward prototypes
protected function integer setbcmpassbymode (readonly boolean ab_mode)
protected function boolean getbcmpassbymode ()
protected function s_bcmreference getbcm (readonly n_cst_bcm lnv_bcm)
protected function integer getbcm (readonly n_cst_bcm lnv_bcm, ref any any_bcm)
protected function integer getbcm (readonly n_cst_bcm lnv_bcm, ref blob ablb_bcm)
end prototypes

protected function integer setbcmpassbymode (readonly boolean ab_mode);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetBCMPassByMode
//
//	Arguments:		ab_mode	BCM passing mode
//
//	Returns:			Integer
//						1	Success
//						-1	Error
//
//	Description:	Sets the mode in which BCM's are passed to/from BSO's.
//						The argument should be specified using the argument mode
//						constants: PASSBYVALUE, PASSBYREFERENCE.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.2   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
ib_bcmpassbymode = ab_mode

return 1

end function

protected function boolean getbcmpassbymode ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetBCMPassByMode
//
//	Arguments:		ab_mode	BCM passing mode
//
//	Returns:			Integer
//						1	Success
//						-1	Error
//
//	Description:	Sets the mode in which BCM's are passed to/from BSO's.
//						The argument should be specified using the argument mode
//						constants: PASSBYVALUE, PASSBYREFERENCE.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.2   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
return ib_bcmpassbymode

end function

protected function s_bcmreference getbcm (readonly n_cst_bcm lnv_bcm);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetBCM
//
//	Arguments:		lnv_bcm		BCM to get
//
//	Returns:			s_bcmreference		Structure containing either reference
//												to BCM or BCM data serialized.
//
//	Description:	Returns a structure containing the BCM.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.2   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
s_bcmreference lstr_bcmref

lstr_bcmref = lnv_bcm.GetBCM(ib_bcmpassbymode)

return lstr_bcmref

end function

protected function integer getbcm (readonly n_cst_bcm lnv_bcm, ref any any_bcm);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetBCM
//
//	Arguments:		lnv_bcm		BCM to get
//						any_bcm		Serialized BCM or BCM reference
//
//	Returns:			Integer		1	Success
//										-1	Error
//
//	Description:	Returns a blob containing the BCM.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc

if lnv_bcm.GetBCM(ib_bcmpassbymode, any_bcm) = 1 then
	li_rc = 1
else
	li_rc = -1
end if

return li_rc


end function

protected function integer getbcm (readonly n_cst_bcm lnv_bcm, ref blob ablb_bcm);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetBCM
//
//	Arguments:		lnv_bcm		BCM to get
//						ablb_bcm		Serialized BCM
//
//	Returns:			Integer		1	Success
//										-1	Error
//
//	Description:	Returns a blob containing the BCM.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc = -1
any lany_bcm

if ib_bcmpassbymode = passbyvalue then
	if lnv_bcm.GetBCM(ib_bcmpassbymode, lany_bcm) = 1 then
		ablb_bcm = lany_bcm
		li_rc = 1
	end if
end if

return li_rc


end function

on ofr_n_cst_bso.create
TriggerEvent( this, "constructor" )
end on

on ofr_n_cst_bso.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			Constructor
//
//	Arguments:		none
//
//	returns:			None
//
//	Description:	Initialize BCM argument mode
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.2   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
if not IsValid(this.GetBCMMGR()) then
	inv_bcmmgr = create n_cst_bcmmgr
end if

this.SetBCMPassByMode(PASSBYREFERENCE)

end event

event destructor;call super::destructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			Destructor
//
//	Arguments:		none
//
//	returns:			None
//
//	Description:	Remove BCMMGR if created
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
//		Destroy bcmmgr if this bso created it
if IsValid(inv_bcmmgr) then
	destroy inv_bcmmgr
end if

end event

