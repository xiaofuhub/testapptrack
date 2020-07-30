$PBExportHeader$ofr_n_cst_uilink_lvs.sru
forward
global type ofr_n_cst_uilink_lvs from ofr_n_cst_uilink
end type
end forward

global type ofr_n_cst_uilink_lvs from ofr_n_cst_uilink
end type
global ofr_n_cst_uilink_lvs ofr_n_cst_uilink_lvs

type variables
protected:

u_lvs ilvs_requestor

end variables

forward prototypes
public function integer setrequestor (readonly powerobject apo_requestor)
public function integer setdatasource (readonly n_ds ads_source)
public function n_cst_beo getbeo (readonly integer ai_index, readonly string as_classname)
public function n_cst_beo getbeo (readonly integer ai_index)
public function n_cst_bcm getbcm (n_ds ads_source)
end prototypes

public function integer setrequestor (readonly powerobject apo_requestor);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetRequestor
//
//	Arguments:		apo_requestor	Requestor ListView
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Identifies the requestor ListView to the
//						business object services.
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
int li_rc = 1

if super::SetRequestor(apo_requestor) = 1 then
	ilvs_requestor = apo_requestor
else
	li_rc = -1
end if

return li_rc

end function

public function integer setdatasource (readonly n_ds ads_source);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  SetDataSource
//
//	Arguments:
//	ads_source				Requestor source DS
//
//	Returns:		integer	1  Success
//								-1	Error
//
//	Description:	Redirects retrieve to UILink
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
int li_class, li_classes

ads_source.SetUILink(TRUE)

li_classes = UpperBound(is_class)
for li_class = 1 to li_classes
	ads_source.inv_uilink.AddClass(is_class[li_class])
next

if is_dlk_name <> '' then
	ads_source.inv_uilink.SetDLK(is_dlk_name)
end if

return 1

end function

public function n_cst_beo getbeo (readonly integer ai_index, readonly string as_classname);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetBEO
//
//	Arguments:		ai_index			Requestor index to get BEO for
//						as_classname	Classname
//
//	Returns:			Business object (n_cst_beo) for specified row.  Returns
//						null if an error occurs.
//
//	Description:	Returns a business object for the specified class and
//						specified requestor row.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.0	   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
n_cst_beo lnv_beo
long ll_beo_index, ll_row
n_ds lds_DataStore

// Get the row in the DataStore
if ilvs_requestor.inv_datasource.of_GetDataRow(ai_index, lds_DataStore, ll_Row) = 1 then
	if IsValid(lds_datastore.inv_uilink) then
		ll_beo_index = lds_datastore.inv_uilink.GetBEOIndex(ll_row)
		if ll_beo_index > 0 then
			if as_classname <> '' then
				lnv_beo = lds_datastore.inv_uilink.GetBCM().GetAt(ll_beo_index, as_classname)
			else
				lnv_beo = lds_datastore.inv_uilink.GetBCM().GetAt(ll_beo_index)
			end if
			if not IsValid(lnv_beo) then
				this.PushException("getbeo()")
			end if
		end if
	end if
end if

return lnv_beo

end function

public function n_cst_beo getbeo (readonly integer ai_index);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetBEO
//
//	Arguments:		ai_index			Requestor index to get BEO for
//						as_classname	Classname
//
//	Returns:			Business object (n_cst_beo) for specified row.  Returns
//						null if an error occurs.
//
//	Description:	Returns a business object for the specified class and
//						specified requestor row.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.0	   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
return this.GetBEO(ai_index, '')

end function

public function n_cst_bcm getbcm (n_ds ads_source);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetBCM
//
//	Arguments:		ads_source datastore associated with the bcm
//
//	Returns:			BCM (n_cst_bcm) associated to BEO service
//
//	Description:	Returns BCM associated to BEO service
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

if NOT isValid(inv_bcm) then
	RETURN ads_source.inv_uilink.GetBCM()
end if

return inv_bcm
end function

on ofr_n_cst_uilink_lvs.create
TriggerEvent( this, "constructor" )
end on

on ofr_n_cst_uilink_lvs.destroy
TriggerEvent( this, "destructor" )
end on

