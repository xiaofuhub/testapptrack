$PBExportHeader$n_cst_dataobject.sru
forward
global type n_cst_dataobject from nonvisualobject
end type
end forward

shared variables
////begin modification Shared Variables by appeon  20070730
//Long	sl_NextID
////end modification Shared Variables by appeon  20070730
//
end variables

global type n_cst_dataobject from nonvisualobject
end type
global n_cst_dataobject n_cst_dataobject

type variables

Private:
Long il_ID
// external data
Long  il_Color
Long  il_TextColor
String is_Label

Protected:
dwobject	idwo_DataObject

//begin modification Shared Variables by appeon  20070730
Long	sl_NextID
//end modification Shared Variables by appeon  20070730






end variables

forward prototypes
public function integer of_populate (dwobject adwo_Data)
public function integer of_setcolor (long al_color)
public function long of_getcolor ()
public function integer of_setlabel (string as_label)
public function string of_getlabel ()
public function string of_getdisplaystring ()
public function long of_getnextid ()
public function long of_getid ()
public function integer of_setid (long al_ID)
public function integer of_settextcolor (long al_color)
public function Long of_gettextcolor ()
end prototypes

public function integer of_populate (dwobject adwo_Data);



IF Not IsValid ( adwo_Data ) THEN RETURN -1



end function

public function integer of_setcolor (long al_color);il_Color = al_Color
IF isValid ( idwo_dataobject ) THEN
	idwo_dataobject.Background.Color = il_Color
END IF
	


return 1
end function

public function long of_getcolor ();RETURN il_Color
end function

public function integer of_setlabel (string as_label);is_Label = as_label

IF isValid ( idwo_dataobject ) THEN
	idwo_dataobject.Text = is_Label
END IF

Return 1
end function

public function string of_getlabel ();return is_Label
end function

public function string of_getdisplaystring ();//Implemented by desendants
Return null_Str
end function

public function long of_getnextid ();sl_NextID ++

Return sl_NextID
end function

public function long of_getid ();Return il_ID
end function

public function integer of_setid (long al_ID);il_ID = al_ID
Return 1
end function

public function integer of_settextcolor (long al_color);il_TextColor = al_Color
IF isValid ( idwo_dataobject ) THEN
	idwo_dataobject.Color = al_Color
END IF

return 1
end function

public function Long of_gettextcolor ();Return il_TextColor
end function

on n_cst_dataobject.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_dataobject.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

