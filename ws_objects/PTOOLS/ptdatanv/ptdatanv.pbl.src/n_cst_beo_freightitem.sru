$PBExportHeader$n_cst_beo_freightitem.sru
$PBExportComments$FreightItem (Non-persistent Class from PBL map PTData) //@(*)[75694609|167]
forward
global type n_cst_beo_freightitem from n_cst_base
end type
end forward

shared variables
//@(text)(recreate=opt)<Synchronized Shared Variables>
//The following variables will be synchronized with HOW.
//You may edit these variables, add new variables or delete variables.
//Please add one variable declaration per line.
n_cst_beo_freightitem sn_n_cst_beo_freightitem_a[] //@(*)[75694609|167:n]<nosync>
Integer sn_n_cst_beo_freightitem_c //@(*)[75694609|167:c]<nosync>
//@(text)--

//Add your implementation-only shared variables after this line.
//These variables will NOT be synchronized with HOW.

end variables

global type n_cst_beo_freightitem from n_cst_base
end type
global n_cst_beo_freightitem n_cst_beo_freightitem

type variables
//@(text)(recreate=opt)<Synchronized Instance Variables>
//The following variables will be synchronized with HOW.
//You may edit these variables, add new variables or delete variables.
//Please add one variable declaration per line.
private Double id_length //@(*)[76071769|168]
private Double id_height //@(*)[76208024|170]
private Double id_width //@(*)[76157238|169]
private Double id_actualweight //@(*)[76236720|171]
private Double id_volume //@(*)[76278947|172]
private Double id_dimweight //@(*)[76307455|173]
//@(text)--

//Add your implementation-only instance variables after this line.
//These variables will NOT be synchronized with HOW.

end variables

forward prototypes
public function Double of_GetLength ()
public function Integer of_SetLength (Double ad_length)
public function Double of_GetHeight ()
public function Integer of_SetHeight (Double ad_height)
public function Double of_GetWidth ()
public function Integer of_SetWidth (Double ad_width)
public function Double of_GetActualweight ()
public function Integer of_SetActualweight (Double ad_actualweight)
public function Double of_GetVolume ()
public function Integer of_SetVolume (Double ad_volume)
public function Double of_GetDimweight ()
public function Integer of_SetDimweight (Double ad_dimweight)
end prototypes

public function Double of_GetLength ();//@(*)[76071769|168:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

return id_length
//@(text)--

end function

public function Integer of_SetLength (Double ad_length);//@(*)[76071769|168:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

id_length = ad_length
return 1
//@(text)--

end function

public function Double of_GetHeight ();//@(*)[76208024|170:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

return id_height
//@(text)--

end function

public function Integer of_SetHeight (Double ad_height);//@(*)[76208024|170:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

id_height = ad_height
return 1
//@(text)--

end function

public function Double of_GetWidth ();//@(*)[76157238|169:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

return id_width
//@(text)--

end function

public function Integer of_SetWidth (Double ad_width);//@(*)[76157238|169:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

id_width = ad_width
return 1
//@(text)--

end function

public function Double of_GetActualweight ();//@(*)[76236720|171:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

return id_actualweight
//@(text)--

end function

public function Integer of_SetActualweight (Double ad_actualweight);//@(*)[76236720|171:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

id_actualweight = ad_actualweight
return 1
//@(text)--

end function

public function Double of_GetVolume ();//@(*)[76278947|172:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

return id_volume
//@(text)--

end function

public function Integer of_SetVolume (Double ad_volume);//@(*)[76278947|172:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

id_volume = ad_volume
return 1
//@(text)--

end function

public function Double of_GetDimweight ();//@(*)[76307455|173:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

return id_dimweight
//@(text)--

end function

public function Integer of_SetDimweight (Double ad_dimweight);//@(*)[76307455|173:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

id_dimweight = ad_dimweight
return 1
//@(text)--

end function

on n_cst_beo_freightitem.create
TriggerEvent(this, "constructor")
end on

on n_cst_beo_freightitem.destroy
TriggerEvent(this, "destructor")
end on

event constructor;call super::constructor;//@(text)(recreate=yes)<init>

//@(text)--

end event

