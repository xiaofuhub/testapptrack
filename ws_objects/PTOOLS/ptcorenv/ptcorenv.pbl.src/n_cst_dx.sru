$PBExportHeader$n_cst_dx.sru
forward
global type n_cst_dx from nonvisualobject
end type
end forward

global type n_cst_dx from nonvisualobject autoinstantiate
end type

type variables
Private:
PowerObject	ipo_Requestor
DataWindow	idw_Requestor
DataStore	ids_Requestor
Object		ie_RequestorType
end variables

forward prototypes
public function integer of_setrequestor (powerobject apo_requestor)
public function long of_rowcount ()
public function long of_filteredcount ()
public function long of_deletedcount ()
public function double of_getitemnumber (long r, string c, dwbuffer b, boolean o)
public function object of_resolverequestor (ref datawindow adw_target, ref datastore ads_target)
public function object of_resolverequestor ()
end prototypes

public function integer of_setrequestor (powerobject apo_requestor);n_cst_Dws	lnv_Dws

ie_RequestorType = lnv_Dws.of_ResolvePowerObject ( apo_Requestor, &
	idw_Requestor, ids_Requestor )

ipo_Requestor = apo_Requestor

CHOOSE CASE ie_RequestorType
CASE DataWindow!, DataStore!
	RETURN 1
CASE ELSE
	RETURN -1
END CHOOSE
end function

public function long of_rowcount ();Long	ll_RowCount

IF IsValid ( idw_Requestor ) THEN
	ll_RowCount = idw_Requestor.RowCount ( )
ELSEIF IsValid ( ids_Requestor ) THEN
	ll_RowCount = ids_Requestor.RowCount ( )
ELSE
	SetNull ( ll_RowCount )
END IF

RETURN ll_RowCount
end function

public function long of_filteredcount ();Long	ll_FilteredCount

IF IsValid ( idw_Requestor ) THEN
	ll_FilteredCount = idw_Requestor.FilteredCount ( )
ELSEIF IsValid ( ids_Requestor ) THEN
	ll_FilteredCount = ids_Requestor.FilteredCount ( )
ELSE
	SetNull ( ll_FilteredCount )
END IF

RETURN ll_FilteredCount
end function

public function long of_deletedcount ();Long	ll_DeletedCount

IF IsValid ( idw_Requestor ) THEN
	ll_DeletedCount = idw_Requestor.DeletedCount ( )
ELSEIF IsValid ( ids_Requestor ) THEN
	ll_DeletedCount = ids_Requestor.DeletedCount ( )
ELSE
	SetNull ( ll_DeletedCount )
END IF

RETURN ll_DeletedCount
end function

public function double of_getitemnumber (long r, string c, dwbuffer b, boolean o);Double	ldbl_Result

IF IsValid ( idw_Requestor ) THEN
	ldbl_Result = idw_Requestor.GetItemNumber ( r, c, b, o )
ELSEIF IsValid ( ids_Requestor ) THEN
	ldbl_Result = ids_Requestor.GetItemNumber ( r, c, b, o )
ELSE
	//Should set properties of error object here
	SignalError ( )
END IF

RETURN ldbl_Result
end function

public function object of_resolverequestor (ref datawindow adw_target, ref datastore ads_target);adw_Target = idw_Requestor
ads_Target = ids_Requestor

RETURN ie_RequestorType
end function

public function object of_resolverequestor ();RETURN ie_RequestorType
end function

on n_cst_dx.create
TriggerEvent( this, "constructor" )
end on

on n_cst_dx.destroy
TriggerEvent( this, "destructor" )
end on

