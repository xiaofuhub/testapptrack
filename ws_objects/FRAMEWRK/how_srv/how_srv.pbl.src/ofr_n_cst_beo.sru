$PBExportHeader$ofr_n_cst_beo.sru
$PBExportComments$Business Object base class
forward
global type ofr_n_cst_beo from n_cst_base
end type
end forward

shared variables

end variables

global type ofr_n_cst_beo from n_cst_base
event type integer ofr_predelete ( )
event type integer ofr_postnew ( )
event type integer ofr_validate ( )
event type integer ofr_presave ( )
event type integer ofr_postsave ( )
end type
global ofr_n_cst_beo ofr_n_cst_beo

type variables
protected:

// Pointer to associated BCM
n_cst_bcm	inv_bcm

// BEO Index for this BEO
Long		il_beo_index

// Array of required attribute indicators
int ii_required
string is_required[]
boolean ib_required[]

end variables

forward prototypes
protected function n_cst_ofrerror addofrerror ()
public function integer deletebeo ()
public function any get (readonly string as_attribute)
protected function integer GetAttribute (readonly string as_name, ref any aa_value)
public function n_cst_bcm GetBCM ()
public function long GetBEOIndex ()
protected function n_cst_beo getownerbeo ()
protected function any getvalue (string as_attribute)
public function integer isrequired (readonly string as_attribute)
public function integer RegisterClass ()
public function integer Set (readonly string as_attribute, readonly boolean ab_value)
public function integer Set (readonly string as_attribute, readonly date ad_value)
public function integer Set (readonly string as_attribute, readonly datetime adt_value)
public function integer Set (readonly string as_attribute, readonly double adb_value)
public function integer Set (readonly string as_attribute, readonly string as_value)
public function integer Set (readonly string as_attribute, readonly time at_value)
public function integer setany (string as_attribute, any aany_value)
protected function integer SetAttribute (readonly string as_name, readonly any aa_value)
public function integer SetRelatedClass (readonly n_cst_beo anv_beo)
public function integer SetRelatedClass (readonly n_cst_beo anv_beo, readonly string as_relationship)
public function integer SetRequired (readonly string as_attribute)
public function integer setrequired (readonly string as_attribute, readonly boolean ab_flag)
protected function integer setvalue (string as_attribute, readonly any aa_value)
public function integer Validate ()
public function boolean validateclass (readonly string as_class)
public function n_cst_beokey getkey ()
public function integer setrelationship (string as_relationname, n_cst_base anv_ofrclass)
public function boolean isnew ()
public function boolean ismodified ()
public function n_cst_bcm getrelationshipwithsso (readonly string as_relationship, readonly string as_dlk, readonly string as_dlk_relation)
public function n_cst_bcm getrelationship (n_cst_bcm anv_bcm, readonly string as_dlk, readonly string as_query, readonly string as_dlk_relation, readonly string as_dlkdiff)
public function n_cst_beo getrelationship (n_cst_beo anv_beo, readonly string as_dlk, readonly string as_query, readonly string as_dlk_relation, readonly string as_dlkdiff, readonly string as_beo)
end prototypes

event ofr_predelete;call super::ofr_predelete;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			ofr_PreDelete
//
//	Arguments:		none
//
//	returns:			integer
//						1		OK for delete
//						<> 1	Disallow delete
//
//	Description:	This event is fired before deleting this business object.
//						Code needed to verify that this delete is valid for
//						descendent business objects should be put in this event
//						in the descendent objects.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.

//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
//	By default allow delete
return 1

end event

event ofr_postnew;call super::ofr_postnew;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			ofr_PostNew
//
//	Arguments:		none
//
//	returns:			integer
//						1		Success
//						-1		Error
//
//	Description:	This event is fired after creating this new business object.
//						Code needed to initialize attributes of descendent business
//						objects should be put in this event in the descendent
//						business objects.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
//		By default return success
return 1
end event

event ofr_validate;call super::ofr_validate;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			ofr_Validate
//
//	Arguments:		as_attribute	Reference argument specifying the attribute
//											that is in error.
//
//	returns:			integer
//						1		Success
//						-1		Error
//
//	Description:	This event is triggered in order to validate the business
//						object. By default this event is triggered by ofr_n_cst_bcm
//						prior to saving.  Additionally this event can be invoked by
//						calling the Validate method on the business object to
//						perform validation at any time.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0.2   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
//		By default return success
return 1

end event

event ofr_presave;call super::ofr_presave;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			ofr_PreSave
//
//	Arguments:		none
//
//	returns:			integer
//						1		Success
//						-1		Error
//
//	Description:	This event is fired prior to saving this business object.
//						Code should be put in this event in the descendent
//						business objects.
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
//		By default return success
return 1
end event

event ofr_postsave;call super::ofr_postsave;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			ofr_PostSave
//
//	Arguments:		none
//
//	returns:			integer
//						1		Success
//						-1		Error
//
//	Description:	This event is fired after saving this business object.
//						Code should be put in this event in the descendent
//						business objects.
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
//		By default return success

return 1
end event

protected function n_cst_ofrerror addofrerror ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		AddOFRError
//
//	Arguments:		none
//
//	returns:			n_cst_ofrerror		Added error object
//
//	Description:	Creates a OFR error object associated to this BEO.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0.2   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
n_cst_ofrerror lnv_ofrerror

lnv_ofrerror = super::AddOFRError()
lnv_ofrerror.SetErrorType(1)
lnv_ofrerror.SetBCM(this.inv_bcm)
lnv_ofrerror.SetClass(this.ClassName())
lnv_ofrerror.SetBEOIndex(il_beo_index)

return lnv_ofrerror

end function

public function integer deletebeo ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		deleteBEO
//
//	Arguments:		none
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Deletes this business object.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc

//		Check first to see if we are allowed to delete this BEO
li_rc = this.Event ofr_PreDelete ( )
if li_rc = 1 then
	// GK - Removed this reference for importing into 5.0
	powerobject po_temp
	po_temp = this
	li_rc = inv_bcm.deletebeo ( po_temp ) 
else
	li_rc = -1 
end if

return li_rc 
end function

public function any get (readonly string as_attribute);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		get
//
//	Arguments:		as_attribute	Attribute to get value for
//
//	returns:			Any	Value of attribute
//
//	Description:	returns data value of specified attribute.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
any la_retval

this.GetAttribute (as_attribute, la_retval)

return la_retval

end function

protected function integer GetAttribute (readonly string as_name, ref any aa_value);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetAttribute
//
//	Arguments:		as_name		Attribute name to get value for
//						aa_value		Reference - returned value for attribute
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	This stub function which is elabeorated in the
//						descendent business objects.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

return 0

end function

public function n_cst_bcm GetBCM ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetBCM
//
//	Arguments:		none
//
//	returns:			n_cst_bcm	BCM that this BEO belongs to.
//
//	Description:	returns BCM pointer that the BEO instance is part of.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
return inv_bcm

end function

public function long GetBEOIndex ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetBEOIndex
//
//	Arguments:		none
//
//	returns:			Long	BEO_Index value for this BEO
//
//	Description:	returns BEO_Index for the BEO.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
return il_beo_index
end function

protected function n_cst_beo getownerbeo ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetOwnerBEO
//
//	Arguments:		none
//
//	returns:			ofr_n_cst_beo - the owner business object
//
//	Description:	returns the owner business object that is associated
//						(related) to this BEO in aggregation relationships.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////

//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
return inv_bcm.GetOwnerBEO()

end function

protected function any getvalue (string as_attribute);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetValue
//
//	Arguments:		as_attribute	Attribute value to get
//
//	Returns:			Any
//						value
//
//	Description:	Gets attribute value.  Called after validation
//                has been done.
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
return inv_bcm.get ( il_beo_index, this.ClassName(), as_attribute )

	
end function

public function integer isrequired (readonly string as_attribute);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		IsRequired
//
//	Arguments:		as_attribute	Attribute to check
//
//	returns:			Integer
//						-1 invalid or missing attribute
//						0 not required
//						1 required
//
//	Description:	Checks to seee if specified attribute is required
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	1.0.1	Update call GetColumnID to include classname
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc = -1, li_required

for li_required = 1 to ii_required
	if as_attribute = is_required[li_required] then
		if ib_required[li_required] then
			li_rc = 1
		else
			li_rc = 0
		end if
		exit
	end if
next

return li_rc

end function

public function integer RegisterClass ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		RegisterClass
//
//	Arguments:		none
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	This function should be extended in the descendent
//						business objects to register information abeout the
//						business object such as table/column mappings, required
//						fields, key information, etc.
//						Note that this function is only called from the BCM.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
return -1

end function

public function integer Set (readonly string as_attribute, readonly boolean ab_value);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Set
//
//	Arguments:		as_attribute	Attribute value to set
//						ab_value			Boolean value to asssign to the attribute
//
//	Returns:			Integer
//						2	Success set and other attributes updated
//						1	Success set
//						0	Unregistered attribute
//						-1	Error
//
//	Description:	Assigns value to specified attribute
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
return this.SetAny ( as_attribute, ab_value )
end function

public function integer Set (readonly string as_attribute, readonly date ad_value);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Set
//
//	Arguments:		as_attribute	Attribute value to set
//						ad_value			Date value to asssign to the attribute
//
//	Returns:			Integer
//						2	Success set and other attributes updated
//						1	Success set
//						0	Unregistered attribute
//						-1	Error
//
//	Description:	Assigns value to specified attribute
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
return this.SetAny ( as_attribute, ad_value )
end function

public function integer Set (readonly string as_attribute, readonly datetime adt_value);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Set
//
//	Arguments:		as_attribute	Attribute value to set
//						adt_value		DateTime value to asssign to the attribute
//
//	Returns:			Integer
//						2	Success set and other attributes updated
//						1	Success set
//						0	Unregistered attribute
//						-1	Error
//
//	Description:	Assigns value to specified attribute
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
return this.SetAny ( as_attribute, adt_value )
end function

public function integer Set (readonly string as_attribute, readonly double adb_value);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Set
//
//	Arguments:		as_attribute	Attribute value to set
//						adb_value		Numeric value to asssign to the attribute
//
//	Returns:			Integer
//						2	Success set and other attributes updated
//						1	Success set
//						0	Unregistered attribute
//						-1	Error
//
//	Description:	Assigns value to specified attribute
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
return this.SetAny ( as_attribute, adb_value )
end function

public function integer Set (readonly string as_attribute, readonly string as_value);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Set
//
//	Arguments:		as_attribute	Attribute value to set
//						as_value			String value to asssign to the attribute
//
//	Returns:			Integer
//						2	Success set and other attributes updated
//						1	Success set
//						0	Unregistered attribute
//						-1	Error
//
//	Description:	Assigns value to specified attribute
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
return this.SetAny ( as_attribute, as_value )
	
end function

public function integer Set (readonly string as_attribute, readonly time at_value);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Set
//
//	Arguments:		as_attribute	Attribute value to set
//						at_value			Time value to asssign to the attribute
//
//	Returns:			Integer
//						2	Success set and other attributes updated
//						1	Success set
//						0	Unregistered attribute
//						-1	Error
//
//	Description:	Assigns value to specified attribute
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
return this.SetAny ( as_attribute, at_value )
end function

public function integer setany (string as_attribute, any aany_value);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetAny
//
//	Arguments:		as_attribute	Attribute value to set
//						aa_value			Value to set attribute to
//
//	Returns:			Integer
//						2	Success set and other attributes updated
//						1	Success set
//						0	Unregistered attribute
//						-1	Error
//
//	Description:	Sets attribute to specified value.  Can handle either
//						attribute name or dbname.  
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	1.0.1	Pass classname to GetRegType()
//	1.0.2	BTR 6761 - return 0 for unregistered attributes
//	1.2	Add call to GetHOWType
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc = -1, li_viewcol

This.ClearOFRErrors()

if inv_bcm.GetHOWType(This.ClassName(), as_attribute) = 'boolean' then
	if not IsNull(aany_value) then
		choose case ClassName(aany_value)
			case 'string'
				if Upper(aany_value) <> "N" AND aany_value <> "0" then
					aany_value = TRUE
				else
					aany_value = FALSE
				end if
			case 'boolean'
				//	Already boolean, no need to convert
			case else		//	Else assume numeric
				if aany_value <> 0 then
					aany_value = TRUE
				else
					aany_value = FALSE
				end if
		end choose
	end if
end if
//	Note that SetAttribute will return either -1, 0, 1, 2
li_rc = this.SetAttribute(as_attribute, aany_value) 

return li_rc
	
end function

protected function integer SetAttribute (readonly string as_name, readonly any aa_value);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetAttribute
//
//	Arguments:		as_name	Attribute value to set
//						aa_value			Time value to asssign to the attribute
//
//	Returns:			Integer
//						1		success
//						-1		error
//                0     attribute function not found
//	Description:	This function should also be present in the descendant.
//                It's purpose is to route generic Set calls to the appropriate
//                Set function in the descendant for validation.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

return 0
end function

public function integer SetRelatedClass (readonly n_cst_beo anv_beo);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetRelatedClass
//
//	Arguments:		anv_beo				Business object to relate to
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Overload function - called when relationship name does
//						not have to be specified.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
return this.SetRelatedClass(anv_beo, "")

end function

public function integer SetRelatedClass (readonly n_cst_beo anv_beo, readonly string as_relationship);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetRelatedClass
//
//	Arguments:		anv_beo				Business object to relate to
//						as_relationship	Unique name of relationship
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Relates the specified business object to this business
//						object by assigning FK values.  If more than one
//						relationship exists between the classes then the
//						relationship name is used to identify the correct
//						relationship.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

string ls_relationship
n_cst_beo lnv_beo

// GK - Removed this reference for importing into 5.0
powerobject po_temp
po_temp = this
return inv_bcm.RelateClasses(po_temp, anv_beo, as_relationship)

end function

public function integer SetRequired (readonly string as_attribute);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetRequired
//
//	Arguments:		as_attribute	Attribute to set required indicator on
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Sets specified attribute as required
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
Return This.SetRequired(as_attribute, TRUE)

end function

public function integer setrequired (readonly string as_attribute, readonly boolean ab_flag);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetRequired
//
//	Arguments:		as_attribute	Attribute to set required indicator on
//						ab_flag			New required indicator
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Sets required flag for the specified attribute.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	1.0.1	Update call GetColumnID to include classname
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_required

for li_required = 1 to ii_required
	if is_required[li_required] = as_attribute then
		ib_required[li_required] = ab_flag
		return 1
	end if
next

ii_required++
is_required[ii_required] = as_attribute
ib_required[ii_required] = ab_flag


return 1

end function

protected function integer setvalue (string as_attribute, readonly any aa_value);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetValue
//
//	Arguments:		as_attribute	Attribute value to set
//						aa_value			Value to set attribute to
//
//	Returns:			Integer
//						-1 Error
//						1 Success set
//						2 Success set and other attributes updated
//
//	Description:	Sets attribute to specified value.  Called after validation
//                has been done.
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

return inv_bcm.setany ( il_beo_index, This.ClassName(), as_attribute, aa_value )

	
end function

public function integer Validate ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Validate
//
//	Arguments:		none
//
//	returns:			integer		1	success
//										-1	error
//
//	Description:	Validates the business object by invoking the
//						ofr_validate event.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0.2   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
return this.event ofr_validate()

end function

public function boolean validateclass (readonly string as_class);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		ValidateClass
//
//	Arguments:		none
//
//	Returns:			Boolean indicating if class is part of hierarchy
//
//	Description:	Insures the specified class is part class	hierarchy for
//						this business object.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
if as_class = this.ClassName() then
	return true
else
	return inv_bcm.ValidateClass(this.ClassName(), as_class)
end if

end function

public function n_cst_beokey getkey ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetKey
//
//	Arguments:		none
//
//	returns:			n_cst_beokey	BEOKey object
//
//	Description:	Returns BEOKey object for this BEO.
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
n_cst_beokey lnv_beokey

lnv_beokey = create n_cst_beokey
lnv_beokey.Initialize(this)

return lnv_beokey

end function

public function integer setrelationship (string as_relationname, n_cst_base anv_ofrclass);return 0
end function

public function boolean isnew ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		isNew
//
//	Arguments:		none
//
//	returns:			Boolean
//						True		BEO is new
//						False		BEO is not new
//
//	Description:	Determines if a BEO is new
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
boolean lb_new

powerobject po_temp
po_temp = this
return inv_bcm.isNew ( po_temp ) 


end function

public function boolean ismodified ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		isModified
//
//	Arguments:		none
//
//	returns:			Boolean
//						True		BEO is modified
//						False		BEO is not modified
//
//	Description:	Determines if a BEO is modified
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
boolean lb_new

powerobject po_temp
po_temp = this
return inv_bcm.isModified ( po_temp ) 


end function

public function n_cst_bcm getrelationshipwithsso (readonly string as_relationship, readonly string as_dlk, readonly string as_dlk_relation);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetRelationshipWithSSO
//
//	Arguments:		as_relationshipname	The attribute relationship name
//						as_dlk					The datalink to be used
//
//	Returns:			inv_bcm					A bcm
//
//	Description:	Gets fk/pk attributes for a beo and a specified relationship, then
//						based on these attributes, get the value(s), then populate the
//						argument(s).  Retrieve via the sso, which returns a bcm represented 
//						by s_bcmreference.  Create a bcm based on s_bcmreference and return it.
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.1   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

n_cst_database		lnv_database
n_cst_attribute	lnv_attr[]
n_cst_query			lnv_query
string            ls_class
string				ls_column
any					la_value[]
integer				li_attr, li_attr_last, li_rc
n_cst_bcm			lnv_bcm


ls_class = this.ClassName()
inv_bcm.GetAttribute(ls_class, as_relationship, lnv_attr[])

li_attr_last = Min(UpperBound(lnv_attr), 16)
for li_attr = 1 to li_attr_last
	ls_column = lnv_attr[li_attr].GetName()
	if ls_column = "" then
		exit
	else
		li_rc = this.GetAttribute(ls_column,la_value[li_attr])
	end if
next

lnv_database = inv_bcm.GetDatabase( )
if not isValid(lnv_database) then
	lnv_database = this.GetBCMMGR().GetDefaultDatabase()
end if

lnv_query = lnv_database.GetQuery()
if not isValid(lnv_query) then
	lnv_database.CreateQuery()
	lnv_query = lnv_database.GetQuery() 
end if

if isValid(lnv_query) then
	lnv_query.SetArguments(la_value)
	lnv_bcm = lnv_query.ExecuteQuery(as_dlk, as_relationship, as_dlk_relation)
end if

return lnv_bcm
	
end function

public function n_cst_bcm getrelationship (n_cst_bcm anv_bcm, readonly string as_dlk, readonly string as_query, readonly string as_dlk_relation, readonly string as_dlkdiff);n_cst_bcm  lnv_bcm
string     ls_dlk

if as_dlkdiff = "" or IsNull(as_dlkdiff) then
	ls_dlk = as_dlk
else
	ls_dlk = as_dlkdiff
end if

if isValid(anv_bcm) then
   if anv_bcm.GetDLKName() = ls_dlk then
      return anv_bcm
   end if 
end if

lnv_bcm = this.GetRelationshipWithSSO( as_query, ls_dlk, as_dlk_relation )

if NOT isValid(lnv_bcm) then
 	this.GetBCMMgr().DestroyBCM ( lnv_bcm )
else
//	lnv_bcm.SetOwnerBEO(this, as_query)
	//svh hack related to btr 12282
//	if len(as_query) = 0 then
		lnv_bcm.SetOwnerBEO(this, as_dlk_relation)
//	else
//		lnv_bcm.SetOwnerBEO(this, as_query)
//	end if
end if

return lnv_bcm

end function

public function n_cst_beo getrelationship (n_cst_beo anv_beo, readonly string as_dlk, readonly string as_query, readonly string as_dlk_relation, readonly string as_dlkdiff, readonly string as_beo);n_cst_bcm lnv_bcm
String ls_dlk


if as_dlkdiff = "" or IsNull(as_dlkdiff) then
	ls_dlk = as_dlk
else
	ls_dlk = as_dlkdiff
end if

if isValid(anv_beo) then
   lnv_bcm = anv_beo.GetBCM()
   if lnv_bcm.GetDLKName() = ls_dlk then
      return anv_beo
   end if 
end if

lnv_bcm = this.GetRelationshipWithSSO(as_query, ls_dlk, as_dlk_relation)
if isValid(lnv_bcm) then
	anv_beo = lnv_bcm.GetFirst(as_beo)
 	if not isValid( anv_beo ) then
    	this.GetBCMMgr().DestroyBCM (lnv_bcm)
 	end if
end if
//@(text)--

//@(text)(recreate=yes)<Return BEO>
return anv_beo
//@(text)--

end function

on ofr_n_cst_beo.create
TriggerEvent( this, "constructor" )
end on

on ofr_n_cst_beo.destroy
TriggerEvent( this, "destructor" )
end on

event destructor;call super::destructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			destructor
//
//	Description:	Turns off log service if it is on
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
if isvalid(this.GetBCMMgr()) then
	if IsValid(this.GetBCMMGR().inv_beolog) then
		// GK - Removed this reference for importing into 5.0
		powerobject po_temp
		po_temp = this
		this.GetBCMMGR().inv_beolog.LogDestroy(po_temp)
	end if
end if

end event

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			Constructor
//
//	Arguments:		none
//
//	returns:			None
//
//	Description:	Initialize this business object.  Get a pointer to its BCM, etc.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
n_cst_beo_init lnv_beo_init

lnv_beo_init = 		Message.PowerObjectParm
il_beo_index = 		lnv_beo_init.il_beo_index
inv_bcm = 			lnv_beo_init.inv_bcm

// Determine if logging is turned on and create entry.
if IsValid(this.GetBCMMGR().inv_beolog) then
	// GK - Removed this reference for importing into 5.0
	powerobject po_temp
	po_temp = this
	this.GetBCMMGR().inv_beolog.LogCreate(po_temp)
end if

end event

