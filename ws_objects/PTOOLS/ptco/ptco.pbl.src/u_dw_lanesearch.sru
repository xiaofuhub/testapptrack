$PBExportHeader$u_dw_lanesearch.sru
forward
global type u_dw_lanesearch from u_dw
end type
end forward

global type u_dw_lanesearch from u_dw
int Width=3150
int Height=496
string DataObject="d_lanesearch"
event type integer ue_showcompany ( long al_row )
end type
global u_dw_lanesearch u_dw_lanesearch

type variables
Private:
String	is_OriginalSelect

end variables

forward prototypes
public function integer of_retrieve (string asa_originzones[], string asa_destinationzones[])
end prototypes

event ue_showcompany;w_Company	lw_Company

Long	ll_CoID 

ll_CoID = THIS.GetItemNumber ( al_Row , "carrier" )
IF ll_CoID > 0 THEN
	opensheetwithparm(lw_Company, ll_CoID, gnv_App.of_GetFrame ( ), 0, original!)
END IF

RETURN 1
end event

public function integer of_retrieve (string asa_originzones[], string asa_destinationzones[]);Long		ll_Return = -1
String	lsa_OriginZones[]
String	lsa_DestZones[]
String	ls_Where
String 	ls_InClause
String	ls_Select

n_cst_sql	lnv_Sql
lsa_OriginZones = asa_originzones[]
lsa_DestZones  = asa_destinationzones[]

IF UpperBound ( lsa_OriginZones ) > 0 THEN
	ls_InClause = lnv_Sql.of_makeinclausefromstrings ( lsa_OriginZones )
	ls_Where += " and origin " + ls_InClause 
END IF

IF UpperBound ( lsa_DestZones ) > 0 THEN
	ls_InClause = lnv_Sql.of_makeinclausefromstrings ( lsa_DestZones )
	ls_Where += " and Destination " + ls_InClause 	
END IF

IF Len ( ls_Where ) > 0 THEN
	ls_select = is_OriginalSelect	
	ls_select += " " + ls_Where
	THIS.object.datawindow.table.select = ls_select

	ll_Return = THIS.Retrieve ( )		
END IF

RETURN ll_Return
end function

event constructor;SetTransObject ( SQLCA )
of_SetAutoSort ( TRUE ) 
of_SetAutoFilter ( TRUE ) 


is_OriginalSelect =  THIS.object.datawindow.table.select
end event

event doubleclicked;IF row > 0 THEN
	THIS.Event ue_ShowCompany ( row )
END IF
	
end event

