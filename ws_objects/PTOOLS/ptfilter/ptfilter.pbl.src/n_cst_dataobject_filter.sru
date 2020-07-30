$PBExportHeader$n_cst_dataobject_filter.sru
forward
global type n_cst_dataobject_filter from n_cst_dataobject
end type
end forward

global type n_cst_dataobject_filter from n_cst_dataobject
end type
global n_cst_dataobject_filter n_cst_dataobject_filter

type variables
Boolean    ib_Change

Private:


n_cst_Mediator_DataManager inv_Mediator

String is_Filter

String is_Column
String is_Operator
String is_DataType
Any    ia_Value

dataStore  ids_Values

String	is_ID
String	is_PicturePath


/////////

end variables

forward prototypes
public function integer of_setfilter (string as_filter)
public function string of_getfilter ()
public function integer of_setcolumnname (string as_columnname)
public function String of_getcolumnname ()
public function string of_getdatatype ()
public function integer of_setoperator (string as_operator)
public function int of_setdatatype (String as_DataType)
public function any of_getvalue ()
public function integer of_populate (dwobject adwo_dataobject)
public function integer of_setmediator (n_cst_Mediator_DataManager anv_Mediator)
public function string of_getdisplaystring ()
public function integer of_displaydetails (dwobject adwo_data)
public function n_cst_filterattrib of_getfilterattribs ()
public function integer of_setpicture (string as_filepath)
public function string of_getpicture ()
end prototypes

public function integer of_setfilter (string as_filter);is_Filter = as_Filter
IF isValid ( idwo_dataobject ) THEN
	idwo_DataObject.tag = is_Filter 
END IF

inv_mediator.ib_Change = TRUE

Return 1
end function

public function string of_getfilter ();return is_Filter
end function

public function integer of_setcolumnname (string as_columnname);is_Column = Trim ( as_ColumnName )
Return 1
end function

public function String of_getcolumnname ();Return is_Column
end function

public function string of_getdatatype ();RETURN is_DataType
end function

public function integer of_setoperator (string as_operator);//is_Operator = as_Operator
Return 1
end function

public function int of_setdatatype (String as_DataType);is_DataType = as_DataType

Return 1
end function

public function any of_getvalue ();RETURN ia_Value
end function

public function integer of_populate (dwobject adwo_dataobject);
IF Not IsValid ( adwo_DataObject ) THEN RETURN -1

//idwo_DataObject = adwo_dataobject

THIS.of_setFilter ( adwo_DataObject.tag )
THIS.of_SetColor ( Long (adwo_DataObject.background.Color ) )
THIS.of_SetLabel ( adwo_DataObject.Text )


RETURN 1

end function

public function integer of_setmediator (n_cst_Mediator_DataManager anv_Mediator);inv_mediator = anv_Mediator
Return 1
end function

public function string of_getdisplaystring ();String ls_ReturnString
String ls_Data
String ls_Label
String ls_Name
String ls_Picture
Long	 ll_ID


ll_ID = THIS.of_GetID ( ) 

ls_Name = "do_" + String ( ll_ID )
ls_Label= THIS.of_GetLabel ( ) 
ls_Data = THIS.of_GetFilter ( )
ls_Picture = THIS.of_GetPicture ( )

ls_ReturnString = 'create button(band=header text="' + ls_Label + '" filename=" ' + ls_Picture + '" action="0" border="0" color="0" x="40" y="46" height="55" width="55" vtextalign="1" htextalign="0"  tag="' + ls_Data + '"  resizeable=1  moveable=1 name=' + ls_Name + '  font.face="Arial" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="2" background.color="16776960" )'

RETURN ls_ReturnString
end function

public function integer of_displaydetails (dwobject adwo_data);idwo_dataobject = adwo_data

openWithParm ( w_DataPadObjectSettings , THIS ) 
Return 1
end function

public function n_cst_filterattrib of_getfilterattribs ();
RETURN inv_mediator.of_GetFilterAttribs ( )
end function

public function integer of_setpicture (string as_filepath);is_picturepath = as_FilePath
IF IsValid ( idwo_dataobject ) THEN
		idwo_dataobject.fileName = is_picturepath
END IF

RETURN 1
end function

public function string of_getpicture ();return is_PicturePath
end function

on n_cst_dataobject_filter.create
TriggerEvent( this, "constructor" )
end on

on n_cst_dataobject_filter.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;ids_values = CREATE	DataStore
ids_Values.DataObject = "d_valuesdddw_mod"
end event

