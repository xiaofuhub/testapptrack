$PBExportHeader$u_dw_emp_list.sru
forward
global type u_dw_emp_list from u_dw
end type
end forward

global type u_dw_emp_list from u_dw
integer width = 1367
string dataobject = "d_emp_list"
event type integer ue_selectionmade ( long al_empid )
event ue_key pbm_dwnkey
end type
global u_dw_emp_list u_dw_emp_list

forward prototypes
public function integer of_retrieve (string as_value)
public function integer of_retrieve (string as_value, date ad_available)
public function integer of_markunavailable (date ad_value)
end prototypes

public function integer of_retrieve (string as_value);DATE ld_Null
SetNull ( ld_Null ) 

RETURN THIS.of_Retrieve( as_value , ld_Null)


end function

public function integer of_retrieve (string as_value, date ad_available);String	ls_OriginalSelect
String 	ls_Where
String 	ls_Ref
Long		ll_Retrieve


 
ll_Retrieve = THIS.Retrieve ( )

IF ll_Retrieve > 0 THEN
	THIS.Visible = TRUE
	THIS.SelectRow ( 1, TRUE )
END IF

IF Not IsNull ( ad_available )THEN
	THIS.of_markunavailable( ad_available )
END IF

RETURN ll_Retrieve

end function

public function integer of_markunavailable (date ad_value);Integer	li_Exists
Long	ll_RowCount
Long	ll_EventCount
Long	i
Long	ll_Driver

ll_RowCount = THIS.RowCount ( )

FOR i = 1 To ll_RowCount
	
	ll_Driver = THIS.Object.di_id [i]
	
	/*SELECT Count ( "disp_events"."de_id"  )
   INTO :ll_EventCount  
   FROM "disp_events"  
   WHERE ( "disp_events"."de_driver" = :ll_Driver ) AND  
         ( "disp_events"."de_arrdate" = :ad_Value )   ;
			
	Commit;

	IF ll_EventCount > 0 THEN
		THIS.Object.di_Available[i] = 0
	END IF*/
	
	//MFS 5/2/07 - Exists yields better performance than select count(*)
	SELECT IF EXISTS (
				 SELECT de_id 
				 FROM disp_events
				 WHERE de_driver = :ll_Driver AND  de_arrdate = :ad_Value )
				 
			 THEN 1

			 ELSE 0
		
			 ENDIF  //Yes this is the correct syntax (no space between END/IF).
		
	INTO :li_Exists
		
	FROM sys.dummy;
	
	Commit;
	
	IF li_Exists = 1 THEN
		THIS.Object.di_Available[i] = 0
	END IF

	
NEXT

RETURN 1

 
end function

on u_dw_emp_list.create
end on

on u_dw_emp_list.destroy
end on

event constructor;call super::constructor;ib_rmbmenu = FALSE

This.of_SetAutoSort(True)

end event

