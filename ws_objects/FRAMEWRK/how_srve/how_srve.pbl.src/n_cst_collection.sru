$PBExportHeader$n_cst_collection.sru
$PBExportComments$Business Object Manager base class
forward
global type n_cst_collection from ofr_n_cst_collection
end type
end forward

global type n_cst_collection from ofr_n_cst_collection
end type
global n_cst_collection n_cst_collection

type variables
Private:
n_cst_Bso	inv_Context
end variables

forward prototypes
public function integer setcontext (readonly n_cst_bso anv_context)
public function n_cst_bso getcontext ()
public function boolean hascontext ()
public function boolean isbcm ()
public function integer getcodetable (ref string as_codetable)
end prototypes

public function integer setcontext (readonly n_cst_bso anv_context);//Returns: 1, -1

inv_Context = anv_Context
RETURN 1
end function

public function n_cst_bso getcontext ();RETURN inv_Context
end function

public function boolean hascontext ();RETURN IsValid ( GetContext ( ) )
end function

public function boolean isbcm ();RETURN Lower ( This.ClassName ( ) ) = "n_cst_bcm"
end function

public function integer getcodetable (ref string as_codetable);//This function will generate a CodeTable creation string listing the elements
//in the collection.  

//Return : 1 = Success (may be an empty list), -1 = Failure

n_cst_beo	lnv_Beo
String		ls_CodeTableEntry

as_CodeTable = ""

IF IsBcm ( ) THEN

	lnv_Beo = This.GetFirst ( )
	
	DO WHILE IsValid ( lnv_Beo )
	
		IF lnv_Beo.GetCodeTableEntry ( ls_CodeTableEntry ) = 1 THEN
	
			as_CodeTable += ls_CodeTableEntry
	
		ELSE
	
			as_CodeTable = ""
			RETURN -1
	
		END IF
	
		lnv_Beo = This.GetNext ( )
	
	LOOP

	RETURN 1

ELSE
	RETURN -1

END IF
end function

on n_cst_collection.create
TriggerEvent( this, "constructor" )
end on

on n_cst_collection.destroy
TriggerEvent( this, "destructor" )
end on

