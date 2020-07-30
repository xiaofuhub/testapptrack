$PBExportHeader$n_cst_bso_imagemanager_paperwise.sru
$PBExportComments$ImageManager_PaperWise (Non-persistent Class from PBL map PTData) //@(*)[3696507|57]
forward
global type n_cst_bso_imagemanager_paperwise from n_cst_bso_imagemanager
end type
end forward

shared variables
//@(text)(recreate=opt)<Synchronized Shared Variables>
//The following variables will be synchronized with HOW.
//You may edit these variables, add new variables or delete variables.
//Please add one variable declaration per line.
n_cst_bso_imagemanager_paperwise sn_n_cst_bso_imagemanager_paperwise_a[] //@(*)[3696507|57:n]<nosync>
Integer sn_n_cst_bso_imagemanager_paperwise_c //@(*)[3696507|57:c]<nosync>
//@(text)--

//Add your implementation-only shared variables after this line.
//These variables will NOT be synchronized with HOW.

end variables

global type n_cst_bso_imagemanager_paperwise from n_cst_bso_imagemanager
end type
global n_cst_bso_imagemanager_paperwise n_cst_bso_imagemanager_paperwise

type variables
//@(text)(recreate=opt)<Synchronized Instance Variables>
//The following variables will be synchronized with HOW.
//You may edit these variables, add new variables or delete variables.
//Please add one variable declaration per line.
private n_cst_dde in_dde_query //@(*)[79991183|94]
private n_cst_dde in_dde_display //@(*)[65657150|97]
//@(text)--

//Add your implementation-only instance variables after this line.
//These variables will NOT be synchronized with HOW.

end variables

forward prototypes
protected function Integer of_makeconnection ()
protected function Integer of_closeconnection ()
public function Integer of_print (n_cst_msg an_msgobj)
public function Integer of_display (n_cst_msg an_msgobj)
protected function Integer of_search (n_cst_msg an_msgobj)
protected function n_cst_dde of_GetDde_query ()
protected function Integer of_SetDde_query (n_cst_dde an_dde_query)
protected function n_cst_dde of_GetDde_display ()
protected function Integer of_SetDde_display (n_cst_dde an_dde_display)
end prototypes

protected function Integer of_makeconnection ();//@(*)[66028372|91]//@(-)Do not edit, move or copy this line//

/*@(-)<<ERROR>> This script has been commented out due to the following compilation errors:
//@(-)
(0016): Error       C0051: Unknown function name: of_getdde
//@(-)--
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

Boolean 	lb_Result = TRUE
Int			li_ReturnValue = 1

n_cst_dde lnv_dde

lnv_DDE = of_GetDDE()

IF NOT lnv_DDE.of_IsConnected() THEN
	lb_Result = lnv_DDE.of_openChannel("Query","Query")
END IF

If lb_Result = FALSE THEN
	li_ReturnValue = -1
END IF

Return li_ReturnValue

@(-)*/

//@(-)
Integer x; return x
//@(-)--

end function

protected function Integer of_closeconnection ();//@(*)[66059220|92]//@(-)Do not edit, move or copy this line//

/*@(-)<<ERROR>> This script has been commented out due to the following compilation errors:
//@(-)
(0014): Error       C0051: Unknown function name: of_getdde
//@(-)--
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--
Boolean 	lb_Result = False
Int			li_ReturnValue

n_cst_dde  	lnv_DDE
lnv_DDE = of_GetDDE()

lb_Result = lnv_dde.of_CloseChannel()

If lb_Result = True THEN
	li_ReturnValue = 1
END IF


Return li_ReturnValue
@(-)*/

//@(-)
Integer x; return x
//@(-)--

end function

public function Integer of_print (n_cst_msg an_msgobj);//@(*)[4111391|65]//@(-)Do not edit, move or copy this line//

/*@(-)<<ERROR>> This script has been commented out due to the following compilation errors:
//@(-)
(0013): Error       C0051: Unknown function name: of_getdde
//@(-)--
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--
n_cst_dde 	lnv_DDE
Int 		li_ReturnValue

lnv_DDE = of_GetDDE()

lnv_DDE.of_ExecRemote("ImageDisplay(Off)")
This.of_Search(an_msgobj)
lnv_DDE.of_ExecRemote("PrintTo(Local)")
lnv_DDE.of_ExecRemote("PrintOpen()")
lnv_DDE.of_ExecRemote("PrintAdd(All)")
IF lnv_DDE.of_ExecRemote("PrintExecute()") THEN
	li_ReturnValue = 1
END IF

Return li_ReturnValue 

@(-)*/

//@(-)
Integer x; return x
//@(-)--

end function

public function Integer of_display (n_cst_msg an_msgobj);//@(*)[65796023|88]//@(-)Do not edit, move or copy this line//

/*@(-)<<ERROR>> This script has been commented out due to the following compilation errors:
//@(-)
(0014): Error       C0051: Unknown function name: of_getdde
//@(-)--
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

Int			li_ReturnValue = -1

n_cst_dde lnv_DDE
lnv_DDE = of_GetDDE()


lnv_DDE.of_ExecRemote("ImageDisplay(On)")
li_ReturnValue = This.of_Search(an_msgobj)
lnv_DDE.of_ExecRemote("ApplicationRestore()")
lnv_DDE.of_ExecRemote("ApplicationActivate()")

return li_ReturnValue

@(-)*/

//@(-)
Integer x; return x
//@(-)--

end function

protected function Integer of_search (n_cst_msg an_msgobj);//@(*)[2498321|95]//@(-)Do not edit, move or copy this line//

/*@(-)<<ERROR>> This script has been commented out due to the following compilation errors:
//@(-)
(0015): Error       C0051: Unknown function name: of_getdde
//@(-)--
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--
n_cst_DDE 	lnv_DDE
Int			li_ReturnValue = -1
s_Parm 		lstr_parm
String 		ls_Data
String		ls_Value
lnv_DDE = of_getDDE()

an_msgobj.of_Get_Parm(cs_type_label,lstr_parm)
ls_Value = String(lstr_Parm.ia_Value)
IF ls_Value = cs_type_shipment THEN
	an_msgobj.of_Get_Parm(cs_data_tempno,lstr_parm)
	ls_Data = String(lstr_parm.ia_Value)
    lnv_DDE.of_ExecRemote("FieldFill(" + cs_type_shipment + "," + ls_Data + ")" )
End IF

IF lnv_DDE.of_ExecRemote("QueryExecute()") THEN
	li_ReturnValue = 1
END IF

return li_ReturnValue


@(-)*/

//@(-)
Integer x; return x
//@(-)--

end function

protected function n_cst_dde of_GetDde_query ();//@(*)[79991183|94:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=no)<body>


//@(text)--

//If Not IsValid(in_DDE) THEN
//	in_DDE = create n_cst_DDE
//END IF
//
//Return in_DDE

n_cst_dde	lnv_dde
return lnv_dde
end function

protected function Integer of_SetDde_query (n_cst_dde an_dde_query);//@(*)[79991183|94:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

in_dde_query = an_dde_query
return 1
//@(text)--

end function

protected function n_cst_dde of_GetDde_display ();//@(*)[65657150|97:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

return in_dde_display
//@(text)--

end function

protected function Integer of_SetDde_display (n_cst_dde an_dde_display);//@(*)[65657150|97:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

in_dde_display = an_dde_display
return 1
//@(text)--

end function

on n_cst_bso_imagemanager_paperwise.create
TriggerEvent( this, "constructor" )
end on

on n_cst_bso_imagemanager_paperwise.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;call super::constructor;//@(text)(recreate=yes)<init>

//@(text)--
This.of_MakeConnection()
end event

event destructor;call super::destructor;
This.of_CloseConnection()

end event

