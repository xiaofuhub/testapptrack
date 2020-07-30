$PBExportHeader$u_dw_imagetypelist.sru
$PBExportComments$ImageTypeList (Data Control from PBL map PTData) //@(*)[45132220|995]
forward
global type u_dw_imagetypelist from u_dw
end type
end forward

global type u_dw_imagetypelist from u_dw
integer width = 1659
integer height = 620
boolean bringtotop = true
string dataobject = "d_dlkc_imagetype"
boolean hscrollbar = true
boolean hsplitscroll = true
event ue_searchfilteredlist ( )
end type
global u_dw_imagetypelist u_dw_imagetypelist

type variables
//@(text)(recreate=opt)<Synchronized Instance Variables>
//The following variables will be synchronized with HOW.
//You may edit these variables, add new variables or delete variables.
//Please add one variable declaration per line.
protected String is_topic //@(*)[70769428|1258]
//@(text)--

//Add your implementation-only instance variables after this line.
//These variables will NOT be synchronized with HOW.
protected String is_Action
end variables

forward prototypes
function any gettaskattribute (String as_name)
function integer settaskattribute (String as_name, n_cst_parameters anv_parameters)
public function String GetTopic ()
public function Integer SetTopic (String as_topic)
public function integer setaction (string as_action)
public function string getaction ()
public function integer of_validatetypes (ref string as_error)
end prototypes

function any gettaskattribute (String as_name);//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Attributes>
Any la_null

Choose Case Lower(as_name)
Case "topic"
     Return is_topic
End Choose

Return la_null
//@(text)--

end function

function integer settaskattribute (String as_name, n_cst_parameters anv_parameters);//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Attributes>
any la_any
anv_parameters.GetParameterValue2(as_name, la_any)
Choose Case Lower(as_name)
   Case "topic"
     If ClassName(la_any) = "any" then
           SetNull(is_topic)
     Else
           is_topic = la_any
     End If
End Choose

Return 1
//@(text)--

end function

public function String GetTopic ();//@(*)[70769428|1258:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

return is_topic
//@(text)--

end function

public function Integer SetTopic (String as_topic);//@(*)[70769428|1258:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

is_topic = as_topic
return 1
//@(text)--

end function

public function integer setaction (string as_action);is_action = as_action
return 1

end function

public function string getaction ();return is_action
end function

public function integer of_validatetypes (ref string as_error);Long	ll_RowCount
Long	i
String	ls_Type
Int	li_Return
String	ls_Error
ll_RowCount = THIS.RowCount ( )

FOR i = 1 TO ll_RowCount
	ls_Type = THIS.GetItemString( i, "imagetype_type" )
	IF Match ( ls_Type , "[\/:*?~"<>|]" ) THEN
		li_Return = -1
		ls_error = "An Imagetype Type cannot contain any of the following characters:~r~n \/:*?~"<>|"    
	END IF
	
NEXT

IF li_Return = -1 THEN
	as_error = ls_Error
END IF

RETURN li_Return
end function

on u_dw_imagetypelist.destroy
end on

event constructor;n_cst_msg 	lnv_msg
lnv_msg = message.powerobjectparm

IF isValid ( w_imageType  ) THEN
	w_imageType.wf_setmsg ( lnv_msg)
END IF




//@(data)(recreate=yes)<GenerationOptions>
SetUILink(TRUE)
inv_uilink.SetClass("n_cst_beo_imagetype")
inv_uilink.SetDLK("n_cst_dlkc_imagetype")
of_SetTransObject(SQLCA)
of_SetSort(TRUE)
inv_sort.of_SetStyle(0)
inv_sort.of_SetColumnHeader(TRUE)
this.SetUseTaskRetrieve(FALSE)
//@(data)--
//

n_cst_privileges	lnv_Privs

if  lnv_Privs.of_hasSysAdminRights ( ) THEN
	
	ib_rmbmenu = TRUE
ELSE
	ib_rmbmenu = False
END IF


//Instantiate the default row focus indicator
This.Event ue_SetFocusIndicator ( TRUE )




end event

on u_dw_imagetypelist.create
end on

