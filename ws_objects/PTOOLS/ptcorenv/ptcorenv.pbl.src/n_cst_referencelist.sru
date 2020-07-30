$PBExportHeader$n_cst_referencelist.sru
forward
global type n_cst_referencelist from n_cst_base
end type
end forward

global type n_cst_referencelist from n_cst_base
end type
global n_cst_referencelist n_cst_referencelist

type variables
Public:
Constant String  cs_ReferenceType = "REFERENCETYPE"



end variables

forward prototypes
public function integer of_getreferencelist (ref string asa_list[], string as_category)
public function integer of_getequipmenttyperefids (ref long ala_ids[])
end prototypes

public function integer of_getreferencelist (ref string asa_list[], string as_category);/*

<DESC> Populates reference names depending on the category. </DESC>

<RETURN> 
Integer
1  - Successful operation.
-1 - An error was encountered.
</RETURN>

<ARGS> 
asa_list[]	 	 String Array to populate reference names - passed by reference.
as_Category		 Passed as a retrieval argument to extract reference names.
</ARGS>

<REVISION> zmc : 2-17-04 </REVISION>

*/

Int li_RtnVal = -1

Long 	ll_RowCnt
Long ll_Ctr

String lsa_List[]

lsa_List = {""}

DataStore ldw_RefList

ldw_RefList = Create DataStore
ldw_RefList.DataObject = 'd_referencelist'
ldw_RefList.SetTransobject(SQLCA)

IF IsValid(ldw_RefList) THEN
	li_RtnVal = 1	
	ldw_RefList.Retrieve(as_Category)
	ll_RowCnt = ldw_RefList.RowCount( )
	IF ll_RowCnt > 0 THEN
		FOR ll_Ctr = 1 TO ll_RowCnt
			lsa_List[ll_Ctr] = ldw_RefList.Object.referencename[ll_Ctr]
		NEXT
	END IF	
END IF

asa_List = lsa_List

Destroy ( ldw_RefList )

RETURN li_RtnVal
end function

public function integer of_getequipmenttyperefids (ref long ala_ids[]);Long	lla_Return[]

lla_Return = {20,23,26,28}

ala_ids = lla_Return

RETURN UpperBound ( ala_ids )

end function

on n_cst_referencelist.create
call super::create
end on

on n_cst_referencelist.destroy
call super::destroy
end on

