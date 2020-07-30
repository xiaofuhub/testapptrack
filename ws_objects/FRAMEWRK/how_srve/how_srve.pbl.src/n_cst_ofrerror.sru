$PBExportHeader$n_cst_ofrerror.sru
forward
global type n_cst_ofrerror from ofr_n_cst_ofrerror
end type
end forward

global type n_cst_ofrerror from ofr_n_cst_ofrerror
end type
global n_cst_ofrerror n_cst_ofrerror

type variables
Protected:
String	is_MessageHeader
end variables

forward prototypes
public function integer setmessageheader (readonly string as_messageheader)
public function string getmessageheader ()
end prototypes

public function integer setmessageheader (readonly string as_messageheader);is_MessageHeader = as_MessageHeader
RETURN 1
end function

public function string getmessageheader ();RETURN is_MessageHeader
end function

on n_cst_ofrerror.create
TriggerEvent( this, "constructor" )
end on

on n_cst_ofrerror.destroy
TriggerEvent( this, "destructor" )
end on

