$PBExportHeader$ofr_n_cst_bcm_init.sru
forward
global type ofr_n_cst_bcm_init from n_cst_base
end type
end forward

global type ofr_n_cst_bcm_init from n_cst_base
end type
global ofr_n_cst_bcm_init ofr_n_cst_bcm_init

type variables
long ll_bcm_index
string is_beo_classname[]
string is_bcm_classname

n_cst_beo inv_ownerbeo	// Owner BEO
string is_ownerrelationshipname   // Relationship to owner (for many-to-many)

boolean ib_copy                      // Is BCM being copied?
n_bcm_ds ids_view		// BEO view
transaction itrx_view	// transaction object reference for BCM's ids_view.

// Business Object array.
n_cst_beo inv_beolist[]	// BEO list

// next availabel bo index.
long il_next_beo_index

end variables

on ofr_n_cst_bcm_init.create
TriggerEvent( this, "constructor" )
end on

on ofr_n_cst_bcm_init.destroy
TriggerEvent( this, "destructor" )
end on

