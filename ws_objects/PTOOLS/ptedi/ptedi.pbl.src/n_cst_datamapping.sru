$PBExportHeader$n_cst_datamapping.sru
forward
global type n_cst_datamapping from n_base
end type
end forward

global type n_cst_datamapping from n_base
end type
global n_cst_datamapping n_cst_datamapping

type variables
DataStore ids_Source

DataStore ids_NotificationSettings
end variables

forward prototypes
protected function string of_getsource (string as_transfertype, string as_direction, long al_companyid, string as_topic, string as_target)
protected function string of_getsettingforaction (string as_transfertype, string as_direction, long al_coid, string as_action)
end prototypes

protected function string of_getsource (string as_transfertype, string as_direction, long al_companyid, string as_topic, string as_target);String	ls_Find
Long		ll_RowCount
Long		ll_Find
String	ls_Return

ls_Find = "transferType = '" + as_TransferType + "' AND direction = '" + as_Direction + &
				"' AND topic = '" + as_Topic +&
				"' AND target = '" + as_Target + & 
				"' AND companyid = " + string ( al_companyid )
				
ll_RowCount = ids_Source.RowCount ( )


ll_Find = ids_Source.Find ( ls_Find , 1 , ll_RowCount + 1 )

IF ll_Find > 0 THEN
	ls_return = ids_Source.GetItemString ( ll_Find , "source" )
END IF

RETURN ls_Return


end function

protected function string of_getsettingforaction (string as_transfertype, string as_direction, long al_coid, string as_action);String	ls_Find
Long		ll_RowCount
Long		ll_Find
String	ls_Return

ls_Find = "transferType = '" + as_TransferType + "' AND direction = '" + as_Direction + &
				"' AND companyid = " + string ( al_CoID ) +&
				" AND action = '" + as_Action + "'"
				
ll_RowCount = ids_NotificationSettings.RowCount ( )


ll_Find = ids_NotificationSettings.Find ( ls_Find , 1 , ll_RowCount + 1 )

IF ll_Find > 0 THEN
	ls_return = ids_NotificationSettings.GetItemString ( ll_Find , "setting" )
END IF

RETURN ls_Return

end function

on n_cst_datamapping.create
TriggerEvent( this, "constructor" )
end on

on n_cst_datamapping.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;ids_Source = CREATE DataStore
ids_Source.DataObject = "d_importDataMapping"
ids_Source.SetTransObject ( sqlca )
ids_Source.Retrieve ( ) 

ids_NotificationSettings = CREATE DataStore
ids_NotificationSettings.DataObject = "d_importNotificationSettings"
ids_NotificationSettings.SetTransObject ( sqlca )
ids_NotificationSettings.Retrieve ( ) 
end event

event destructor;DESTROY ( ids_Source )
DESTROY ( ids_NotificationSettings )
end event

