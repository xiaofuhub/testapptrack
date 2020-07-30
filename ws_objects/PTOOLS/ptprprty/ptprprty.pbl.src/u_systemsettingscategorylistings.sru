$PBExportHeader$u_systemsettingscategorylistings.sru
forward
global type u_systemsettingscategorylistings from u_plb
end type
end forward

global type u_systemsettingscategorylistings from u_plb
integer width = 923
integer height = 1744
boolean sorted = false
event ue_categorychanged ( n_cst_settingscategory anv_category )
end type
global u_systemsettingscategorylistings u_systemsettingscategorylistings

type variables
n_cst_PropertyManager inv_PropertyManager



end variables

forward prototypes
public function integer of_populatecategories (n_cst_settingscategory anva_cats[])
end prototypes

public function integer of_populatecategories (n_cst_settingscategory anva_cats[]);/* ////////////////////////////////////////////////////////
 
 n_cst_settingscategory				anva_cats[]
 
   Function		: of_PopulateCategories
   Arguments 	: as_CategoryName, String
   Returns 		: 1 = Success, -1 = Failure
   Description : Receives the category name as an argument & populates the 
					  categories
   Author		: ZMC
   Created on 	: Add timestamp here
   Modified by : Add Author here	TimeStamp
				
///////////////////////////////////////////////////////// */

Int li_RetunValue = 1
Int li_Ctr
Int li_Pic
Int li_position
Int li_UpperBound
String ls_Name
String ls_PicName

li_UpperBound = UpperBound(anva_cats)

FOR li_Ctr = 1 TO li_UpperBound
	ls_Name 			= anva_cats[li_Ctr].of_GetName		( )
	ls_PicName		= anva_cats[li_Ctr].of_GetPicture 	( )
	li_Pic 			= 	This.AddPicture(ls_PicName)
	li_position 	= 	This.AddItem(ls_name, li_pic)
NEXT 
This.SetFocus()

Return li_RetunValue

end function

on u_systemsettingscategorylistings.create
end on

on u_systemsettingscategorylistings.destroy
end on

event constructor;call super::constructor;
n_Cst_SettingsCategory	lnva_Cats[]
inv_PropertyManager = CREATE n_cst_PropertyManager

inv_PropertyManager.of_getlicensedcategories(lnva_Cats[])

of_PopulateCategories(lnva_Cats[])

This.event selectionchanged(1)
This.SelectItem(1)



end event

event destructor;call super::destructor;DESTROY inv_PropertyManager
end event

event selectionchanged;call super::selectionchanged;n_Cst_settingsCategory	lnv_Cat[]

inv_PropertyManager.of_GetLicensedcategories(lnv_Cat[])

THIS.event ue_categorychanged( lnv_Cat[index] )
end event

