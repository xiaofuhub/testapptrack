$PBExportHeader$n_cst_propertymanager.sru
forward
global type n_cst_propertymanager from n_base
end type
end forward

global type n_cst_propertymanager from n_base
end type
global n_cst_propertymanager n_cst_propertymanager

type variables
Int	iia_LicensedCategories[]
n_cst_settingscategory	inva_cats[]

end variables

forward prototypes
public function integer of_getlicensedcategories (ref n_cst_settingscategory anv_categories[])
private function integer of_initializelicensedlist ()
public function n_cst_settingscategory of_getcategory ()
end prototypes

public function integer of_getlicensedcategories (ref n_cst_settingscategory anv_categories[]);Int li_ReturnValue = 1
Int li_Ctr
Int li_Count

n_cst_SettingsCategory	lnva_Cats[]

li_Count = UpperBound(iia_licensedcategories)

FOR li_Ctr = 1 TO li_Count
	lnva_Cats[ li_Ctr ] = inva_Cats [ iia_licensedcategories [ li_Ctr ] ] 
NEXT

anv_categories = lnva_Cats

Return li_ReturnValue


end function

private function integer of_initializelicensedlist ();Int li_Ctr
Int li_Count	

li_Count = UpperBound ( inva_cats )

FOR  li_Ctr = 1 to li_Count
	IF inva_cats[li_Ctr].of_IsLicensed ( ) THEN 
		iia_licensedcategories [ UpperBound (iia_licensedcategories) + 1 ] = li_Ctr
	END IF
NEXT

li_Count = UpperBound(iia_licensedcategories)
Return li_Count
end function

public function n_cst_settingscategory of_getcategory ();n_Cst_SettingsCategory	lnv_Cat


// 1. Order Entry
inva_Cats[ Upperbound ( inva_cats ) + 1 ]  = CREATE n_Cst_settingsCategory
inva_Cats[ Upperbound ( inva_cats ) ].of_SetName 		("Order Entry")
inva_Cats[ Upperbound ( inva_cats ) ].of_SetPicture 	("Export.bmp")
inva_Cats[ Upperbound ( inva_cats ) ].of_setaccociatedmodules({n_cst_Constants.cs_module_orderentry})
inva_Cats[ Upperbound ( inva_cats ) ].of_SetTabPages 	({"u_tabpg_prprties_orderentry_general" 		&
																		 ,"u_tabpg_prprties_orderentry_DockIds" 	&
																		 ,"u_tabpg_prprties_orderentry_defaults" 		&
																		 ,"u_tabpg_prprties_orderentry_Validation"	&
																		 ,"u_tabpg_prprties_orderentry_permissions" 	& 
																		 ,"u_tabpg_prprties_orderentry_Files"			&																		 
																		 ,"u_tabpg_prprties_orderentry_notes"			& 
																		 ,"u_tabpg_prprties_orderentry_Fuel"			&
																		 ,"u_tabpg_prprties_Billing_DelRec"})			

// 2. Routing
inva_Cats[ Upperbound ( inva_cats ) + 1 ]  = CREATE n_Cst_settingsCategory
inva_Cats[ Upperbound ( inva_cats ) ].of_SetName 		("Routing")
inva_Cats[ Upperbound ( inva_cats ) ].of_SetPicture 	("insert2.bmp")
inva_Cats[ Upperbound ( inva_cats ) ].of_setaccociatedmodules({n_cst_Constants.cs_Module_Dispatch})
inva_Cats[ Upperbound ( inva_cats ) ].of_SetTabPages 	({"u_tabpg_prprties_Routing_general" 		& 
																		 ,"u_tabpg_prprties_Routing_Defaults"})



// 3. Equipment
inva_Cats[ Upperbound ( inva_cats ) + 1 ]  = CREATE n_Cst_settingsCategory
inva_Cats[ Upperbound ( inva_cats ) ].of_SetName 		("Equipment")
inva_Cats[ Upperbound ( inva_cats ) ].of_SetPicture 	("eqnew2.bmp")
inva_Cats[ Upperbound ( inva_cats ) ].of_setaccociatedmodules({n_cst_Constants.cs_Module_Dispatch})
inva_Cats[ Upperbound ( inva_cats ) ].of_SetTabPages 	({"u_tabpg_prprties_Equipment_general" 		& 
																		 ,"u_tabpg_prprties_Equipment_Permissions" 	& 
																		 ,"u_tabpg_prprties_Equipment_Files" &
																		 ,"u_tabpg_prprties_Equipment_TT"})


// 4. Rating
inva_Cats[ Upperbound ( inva_cats ) + 1 ]  = CREATE n_Cst_settingsCategory
inva_Cats[ Upperbound ( inva_cats ) ].of_SetName 		("Rating")
inva_Cats[ Upperbound ( inva_cats ) ].of_SetPicture 	("plusequal.bmp")
inva_Cats[ Upperbound ( inva_cats ) ].of_setaccociatedmodules({n_cst_Constants.cs_module_autorating})
inva_Cats[ Upperbound ( inva_cats ) ].of_SetTabPages 	({"u_tabpg_prprties_Rating_general"  &
																			, "u_tabpg_prprties_Rating_NextBreak" })  
//																		 ,"u_tabpg_prprties_Rating_Files"})  // removed this b.c. I moved the only setting on the tab page off to the oe files tabpage
//																		  ,"u_tabpg_prprties_Rating_Permissions" // removed b.c. all settings were 
																																//copied to Order entry -> Permissions. 
																																//The settings still remain on the tab page.

																		 

// 5. Imaging
inva_Cats[ Upperbound ( inva_cats ) + 1 ]  = CREATE n_Cst_settingsCategory
inva_Cats[ Upperbound ( inva_cats ) ].of_SetName 		("Imaging")
inva_Cats[ Upperbound ( inva_cats ) ].of_SetPicture 	("copy.bmp")
inva_Cats[ Upperbound ( inva_cats ) ].of_setaccociatedmodules({n_cst_Constants.cs_module_Imaging})
inva_Cats[ Upperbound ( inva_cats ) ].of_SetTabPages 	({"u_tabpg_prprties_Imaging_general" 		& 
																		 ,"u_tabpg_prprties_Imaging_files"      &
																		 ,"u_tabpg_prprties_Imaging_Permissions" 	& 
																		 ,"u_tabpg_prprties_Imaging_Default"})



// 6. Billing
inva_Cats[ Upperbound ( inva_cats ) + 1 ]  = CREATE n_Cst_settingsCategory
inva_Cats[ Upperbound ( inva_cats ) ].of_SetName 		("Billing")
inva_Cats[ Upperbound ( inva_cats ) ].of_SetPicture 	("Invoice.bmp")
inva_Cats[ Upperbound ( inva_cats ) ].of_setaccociatedmodules({n_cst_Constants.cs_module_billing})
inva_Cats[ Upperbound ( inva_cats ) ].of_SetTabPages 	({"u_tabpg_prprties_Billing_General" 	&
																		 ,"u_tabpg_prprties_Billing_Print" 	&
																		 ,"u_tabpg_prprties_Billing_Files"		&
																		 ,"u_tabpg_prprties_Billing_Links" 	& 
																		 ,"u_tabpg_prprties_Billing_Imaging"})															 
																		 
// 7.Settlements
inva_Cats[ Upperbound ( inva_cats ) + 1 ]  = CREATE n_Cst_settingsCategory
inva_Cats[ Upperbound ( inva_cats ) ].of_SetName 		("Settlements")
inva_Cats[ Upperbound ( inva_cats ) ].of_SetPicture 	("EventNew.bmp")
inva_Cats[ Upperbound ( inva_cats ) ].of_setaccociatedmodules({n_cst_Constants.cs_module_settlements})
inva_Cats[ Upperbound ( inva_cats ) ].of_SetTabPages 	({"u_tabpg_prprties_settlements_general" & 
																		 ,"u_tabpg_prprties_settlements_interactive" & 
																		 ,"u_tabpg_prprties_settlements_payables" & 
																		 ,"u_tabpg_prprties_settlements_payroll"})
// 8.Notifications
inva_Cats[ Upperbound ( inva_cats ) + 1 ]  = CREATE n_Cst_settingsCategory
inva_Cats[ Upperbound ( inva_cats ) ].of_SetName 		("Notifications")
inva_Cats[ Upperbound ( inva_cats ) ].of_SetPicture 	("PackYellow.bmp")
inva_Cats[ Upperbound ( inva_cats ) ].of_setaccociatedmodules({n_cst_Constants.cs_module_notification})
inva_Cats[ Upperbound ( inva_cats ) ].of_SetTabPages 	({"u_tabpg_prprties_Notification"})


		
																		 
																		 
// 9.EDI
inva_Cats[ Upperbound ( inva_cats ) + 1 ]  = CREATE n_Cst_settingsCategory
inva_Cats[ Upperbound ( inva_cats ) ].of_SetName 		("EDI")
inva_Cats[ Upperbound ( inva_cats ) ].of_SetPicture 	("Info.bmp")
inva_Cats[ Upperbound ( inva_cats ) ].of_setaccociatedmodules({n_cst_Constants.cs_module_EDI210		&
																				 ,n_cst_Constants.cs_module_edi204		&
                                                             ,n_cst_Constants.cs_module_edi214	   & 	   
                                                             ,n_cst_Constants.cs_module_edi322}) 	
																				 
inva_Cats[ Upperbound ( inva_cats ) ].of_SetTabPages 	({"u_tabpg_prprties_EDI_general" & 
																		 ,"u_tabpg_prprties_EDI_204" 		& 
																		 ,"u_tabpg_prprties_EDI_210" 		&
																		 ,"u_tabpg_prprties_EDI_214"		&
																		 ,"u_tabpg_prprties_EDI_990"})

// 10.Mobile Communication
inva_Cats[ Upperbound ( inva_cats ) + 1 ]  = CREATE n_Cst_settingsCategory
inva_Cats[ Upperbound ( inva_cats ) ].of_SetName 		("Mobile Communication")
inva_Cats[ Upperbound ( inva_cats ) ].of_SetPicture 	("lbolt1.bmp")
inva_Cats[ Upperbound ( inva_cats ) ].of_setaccociatedmodules({n_cst_Constants.cs_module_qualcomm &
																					,n_cst_Constants.cs_module_intouch &				
																					,n_cst_Constants.cs_module_cadec &				
																					,n_cst_Constants.cs_module_atroad &
																					,n_cst_constants.cs_module_Nextel})
inva_Cats[ Upperbound ( inva_cats ) ].of_SetTabPages 	({"u_tabpg_prprties_MobileComm_general"})
																		 //"u_tabpg_prprties_MobileComm_files" 
					

							
// 11. LiveLoad
inva_Cats[ Upperbound ( inva_cats ) + 1 ]  = CREATE n_Cst_settingsCategory 
inva_Cats[ Upperbound ( inva_cats ) ].of_SetName 		("Liveload")
inva_Cats[ Upperbound ( inva_cats ) ].of_SetPicture 	("liveload2.bmp")
//inva_Cats[ Upperbound ( inva_cats ) ].of_setaccociatedmodules({lnv_Constants.cs_module_}) // to be done later
inva_Cats[ Upperbound ( inva_cats ) ].of_SetTabPages 	({"u_tabpg_prprties_Liveload_general"})


// 12. PC*Miler
inva_Cats[ Upperbound ( inva_cats ) + 1 ]  = CREATE n_Cst_settingsCategory
inva_Cats[ Upperbound ( inva_cats ) ].of_SetName 		("PC*Miler")
inva_Cats[ Upperbound ( inva_cats ) ].of_SetPicture 	("pcm.bmp")
inva_Cats[ Upperbound ( inva_cats ) ].of_setaccociatedmodules({n_cst_Constants.cs_module_pcmiler})
inva_Cats[ Upperbound ( inva_cats ) ].of_SetTabPages 	({"u_tabpg_prprties_PCMiler_general"})


// 13. Brokerage
inva_Cats[ Upperbound ( inva_cats ) + 1 ]  = CREATE n_Cst_settingsCategory
inva_Cats[ Upperbound ( inva_cats ) ].of_SetName 		("Brokerage")
inva_Cats[ Upperbound ( inva_cats ) ].of_SetPicture 	("itin.bmp")
inva_Cats[ Upperbound ( inva_cats ) ].of_setaccociatedmodules({n_cst_Constants.cs_module_brokerage})
inva_Cats[ Upperbound ( inva_cats ) ].of_SetTabPages 	({"u_tabpg_prprties_brokerage_payables"})

// 14. Dynamic Objects
inva_Cats[ Upperbound ( inva_cats ) + 1 ]  = CREATE n_Cst_settingsCategory
inva_Cats[ Upperbound ( inva_cats ) ].of_SetName 		("Dynamic Objects")
inva_Cats[ Upperbound ( inva_cats ) ].of_SetPicture 	("dyn_win.bmp")
inva_Cats[ Upperbound ( inva_cats ) ].of_SetTabPages 	({"u_tabpg_prprties_dynamicobjects_general"})

// 15. Applications
inva_Cats[ Upperbound ( inva_cats ) + 1 ]  = CREATE n_Cst_settingsCategory
inva_Cats[ Upperbound ( inva_cats ) ].of_SetName 		("Applications")
inva_Cats[ Upperbound ( inva_cats ) ].of_SetPicture 	("ptools.ico")
inva_Cats[ Upperbound ( inva_cats ) ].of_SetTabPages 	({"u_tabpg_prprties_application" &
																			,"u_tabpg_prprties_application2" &
																			,"u_tabpg_prprties_application_email" &
																			,"u_tabpg_prprties_application3"})





Return lnv_Cat
end function

on n_cst_propertymanager.create
call super::create
end on

on n_cst_propertymanager.destroy
call super::destroy
end on

event constructor;call super::constructor;of_getcategory( )
of_initializelicensedlist( )
end event

