$PBExportHeader$u_cst_privs.sru
forward
global type u_cst_privs from u_base
end type
type ddlb_todivision from dropdownlistbox within u_cst_privs
end type
type st_2 from statictext within u_cst_privs
end type
type st_1 from statictext within u_cst_privs
end type
type ddlb_users from dropdownlistbox within u_cst_privs
end type
type st_3 from statictext within u_cst_privs
end type
type cb_copy from commandbutton within u_cst_privs
end type
type sle_currentmodule from singlelineedit within u_cst_privs
end type
type sle_currentdivision from singlelineedit within u_cst_privs
end type
type st_module from statictext within u_cst_privs
end type
type st_division from statictext within u_cst_privs
end type
type st_privs from statictext within u_cst_privs
end type
type dw_users from u_dw within u_cst_privs
end type
type dw_privsummary from u_dw within u_cst_privs
end type
type gb_privs from groupbox within u_cst_privs
end type
type dw_divisiondetail from u_dw_privdetail within u_cst_privs
end type
type cbx_copyprivs from checkbox within u_cst_privs
end type
type cbx_copydivs from checkbox within u_cst_privs
end type
end forward

global type u_cst_privs from u_base
integer width = 3333
integer height = 1536
long backcolor = 12632256
string text = "none"
long picturemaskcolor = 536870912
event ue_userchanged ( long al_userid )
event ue_privchanged ( long al_row,  dwobject adwo_dwo,  string as_data )
event ue_detailchanged ( boolean ab_checked,  long al_functionid )
event ue_dwprivsdoubleclicked ( dwobject adwo_object,  long al_row )
event ue_loaddetails ( )
event ue_geticons ( ref string asa_icons[] )
event ue_focuschanged ( dwobject adwo,  long al_row,  string as_whatchanged )
event ue_copytouser ( )
event type long ue_getdivisioncol ( long al_divisionid )
event ue_getprivmanager ( ref n_cst_privsmanager anv_privmanager )
event ue_getdivisionid ( string as_division,  ref long al_divisionid )
event ue_geticonid ( string as_icon,  ref long ai_iconid )
event ue_geticon ( long al_iconid,  ref string as_icon,  integer ai_class )
event type n_cst_privsmanager ue_getmyprivmanager ( )
event ue_enable ( boolean ab_enable )
ddlb_todivision ddlb_todivision
st_2 st_2
st_1 st_1
ddlb_users ddlb_users
st_3 st_3
cb_copy cb_copy
sle_currentmodule sle_currentmodule
sle_currentdivision sle_currentdivision
st_module st_module
st_division st_division
st_privs st_privs
dw_users dw_users
dw_privsummary dw_privsummary
gb_privs gb_privs
dw_divisiondetail dw_divisiondetail
cbx_copyprivs cbx_copyprivs
cbx_copydivs cbx_copydivs
end type
global u_cst_privs u_cst_privs

type variables
Public:
	constant	string	ics_allDivisions = "All_Divisions"
	constant string	ics_allModules = "All Modules"
	
	constant string	ics_user = "User"
	constant string	ics_priv = "priv"
	
	constant	string	ics_multipleUsers = "{ MULTIPLE USERS } "
	constant int		ici_multipleUserID = 1
	constant	string	ics_multipleDivs = "{ MULTIPLE DIVISIONS }"
PRIVATE:
	long ila_userIdsInList[]
	string isa_divisionNames[] 
	
	boolean	ib_initialized
	
	constant int ci_width = 550

end variables

forward prototypes
public subroutine of_initializeprivsdw (string as_select)
public subroutine of_initializeprivsdw (ref string asa_columnlist[], ref string asa_modules[])
public function integer of_initialize (string asa_modules[], string asa_divisions[])
public function long of_getuserid ()
public function n_cst_privDetails of_getprivdetail ()
public function integer of_initialize (string asa_modules[], datastore ads_divisions)
public function boolean of_inititcomplete ()
public function string of_getmodule (long al_row)
public function string of_getdivission (long al_col)
private function integer of_changealldivisions (string as_module, string as_data)
private function integer of_changeallmodules (string as_division, string as_data)
public function long of_getcopytouser ()
public function integer of_getdivisionlistfromds (datastore ads_divisions, ref string asa_divisions[])
private function long of_getmodulerow (string as_module)
public function integer of_initializelistbox ()
private function integer of_setborder (dwobject adwo_obj, long al_row)
public function integer of_setprivdetail (n_cst_privdetails anv_privdetail)
private function integer of_updateprivsfrom (string as_module, string as_division, string as_data)
public function integer of_updatevisuals (n_cst_privdetails anva_privchanges[])
public function integer of_setuser (long al_id)
public function string of_getcopyfromusername ()
public function string of_getcopytousername ()
public function string of_getusername ()
public function integer of_getalluser (ref long ala_ids[])
public function integer of_getcopytodivs (ref string asa_copytodivs[])
end prototypes

event ue_loaddetails();//implemented at ancestor level
end event

event ue_focuschanged(dwobject adwo, long al_row, string as_whatchanged);Long		ll_Col
Long		li_Continue = 1
String	ls_module
String	ls_division
String	ls_firstName
String	ls_lastName
Long		ll_index

	
CHOOSE CASE as_whatChanged
	CASE ics_priv
		
		//Check for valid row/column
		IF isValid(adwo) AND al_Row > 0 THEN
			IF adwo.Type = "column" THEN
				ll_Col = Long(adwo.Id)
				IF ll_Col = 1 THEN //First col is module list
					li_Continue = -1
				END IF
			ELSE
				li_Continue = -1
			END IF
		ELSE
			li_Continue = -1
		END IF
		
		IF li_Continue = 1 THEN
			ls_division = this.of_getDivission(ll_Col)
			sle_currentdivision.text = ls_division
			ls_division = this.of_getDivission(ll_Col)
			ls_module = dw_privsummary.getItemString( al_row,1 )
			sle_currentmodule.text = ls_module
			ll_index = ddlb_todivision.finditem( ls_division, 0 )
			IF ll_index > 0 THEN
				ddlb_todivision.selectitem( ll_index )
			END IF
			
			IF ls_division = "ALL DIVISIONS" THEN
				ddlb_todivision.enabled = false
			ELSE
				ddlb_todivision.enabled = true
			END IF
		END IF

	CASE ics_user
		
		ls_firstName = dw_users.getItemString( al_row, "em_fn" )
		ls_lastName = dw_users.getItemString( al_row, "em_ln" )
		st_privs.text =  ls_firstName + " "+ls_lastName
		dw_divisiondetail.visible = false

END CHOOSE

end event

event type long ue_getdivisioncol(long al_divisionid);//meant to be overridden at ancestor level

RETURN 0
end event

event ue_getprivmanager(ref n_cst_privsManager anv_privmanager);//intended to be implemented at ancestor level
end event

event ue_getdivisionid(string as_division, ref long al_divisionid);//meant to be implemented on descendent
end event

event ue_geticonid(string as_icon, ref long ai_iconid);//intended to be implemented on ancestor
end event

event ue_geticon(long al_iconid, ref string as_icon, integer ai_class);//implemented on ancestor
end event

event type n_cst_privsManager ue_getmyprivmanager();//meant to be overriden on the window level
n_cst_privsManager	lnv_dummyManager
RETURN lnv_dummyManager
end event

event ue_enable(boolean ab_enable);cb_copy.Enabled = ab_Enable
ddlb_users.Enabled = ab_Enable
sle_currentdivision.enabled = ab_enable
sle_currentmodule.enabled = ab_enable
cbx_copydivs.enabled = ab_enable
cbx_copyprivs.enabled = ab_enable
ddlb_todivision.enabled = ab_enable

dw_users.Event ue_Enable(ab_Enable)
dw_privsummary.Event ue_Enable(ab_Enable)   //this will clear detail images
dw_divisiondetail.Event ue_Enable(ab_Enable)

IF ab_Enable THEN
	This.Event ue_Loaddetails() //restore detail images
END IF



end event

public subroutine of_initializeprivsdw (string as_select);String	ls_Presentation, &
			ls_Error, &
			ls_Syntax

ls_presentation = "style(type=tabular)"
ls_Syntax = SQLCA.SyntaxFromSQL ( as_Select, ls_Presentation, ls_Error )

dw_privsummary.Create ( ls_Syntax )
dw_privsummary.SetTransObject ( SQLCA )


end subroutine

public subroutine of_initializeprivsdw (ref string asa_columnlist[], ref string asa_modules[]);//Set up datawindow with the specified column names  (all columns will be long varchar type)

String	ls_Select
Integer	li_Count, &
			li_Ndx
Long		ll_index
Long		ll_max
Long		ll_newRow

String	ls_objList[]
n_cst_String	lnv_String
String			ls_x
String			ls_name
String			ls_result



SetPointer ( HourGlass! )

li_Count = UpperBound ( asa_ColumnList )
ls_Select = ""


FOR li_Ndx = 1 TO li_Count
	asa_ColumnList [ li_Ndx ] = "convert(long varchar, null) AS " +"'"+ asa_ColumnList [ li_Ndx ]+"'"
	lnv_String.of_ArrayToString ( asa_ColumnList, ", ", ls_Select )
NEXT

ls_Select = "SELECT " + ls_Select + " FROM dummy"


//this call creates all the columns and rows in the datawindow
this.of_initializeprivsdw( ls_select )
end subroutine

public function integer of_initialize (string asa_modules[], string asa_divisions[]);Long	ll_max
Long	ll_index
Long	ll_newRow


Int	 li_return
Int	li_colHeight

string	ls_Mod
String	ls_objType
String	ls_result
String	ls_x
String	ls_name
String	ls_Icon
String	lsa_one[]
String   lsa_two[]
String lsa_objList[]

//creates the columns
isa_divisionNames = asa_divisions

this.of_initializeprivsdw( asa_divisions, asa_modules )


//the following makes it look normal
dw_privsummary.inv_base.of_getObjects( lsa_objList)
ll_max = upperBOund( lsa_objList )
FOR ll_index = 1 TO ll_max
	ls_objType = dw_privsummary.describe( lsa_objList[ll_index]+".type")
	
	//make header objects look normal
	IF ls_objType = "text" and len(lsa_objList[ll_index]) > 1 THEN
		dw_privsummary.Modify(lsa_objList[ll_index]+".font.underline = yes")
		dw_privsummary.Modify(lsa_objList[ll_index]+".font.height = 10")
		dw_privsummary.Modify(lsa_objList[ll_index]+".font.weight = 700")
		dw_privsummary.Modify(lsa_objList[ll_index]+".alignment = 0")
	END IF
	
	dw_privsummary.Modify( lsa_objList[ll_index]+".width="+string( ci_width +100 ))
	ls_x = string(((ll_index -1)*ci_width) + 100)
	dw_privsummary.Modify( lsa_objList[ll_index]+".x ="+ ls_x)
	
	
NEXT

//the following inserts a row for every module specified.
ll_max = upperBound ( asa_modules )
FOR ll_index = 1 TO ll_max
	ll_newRow = dw_privsummary.insertRow( 0 )
	dw_privsummary.setItem( ll_newRow, 1, asa_modules[ll_index] )
NEXT

ll_max = Long(dw_privsummary.Object.DataWindow.Column.Count)
FOR ll_index = 1 TO ll_max
	ls_name = dw_privSummary.Describe("#"+String(ll_Index)+".name")
	ls_x = string(((ll_index -1)*ci_width) + 100)
	dw_privsummary.modify(ls_name+".Width = "+string( ci_width ))
	dw_privsummary.modify(ls_name+".x = "+ls_x)
	dw_PrivSummary.Modify(ls_Name + ".protect = 1")
	dw_privsummary.modify(ls_name+".width = 366")	//366
	IF ll_index > 1 THEN
		dw_privsummary.modify(ls_name+".BitmapName = yes")
	ELSE
		//column 1 properties
		dw_privsummary.Modify(ls_name+".font.weight = 700")
		dw_privsummary.Modify("c_t.visible = 0" )
	END IF
	
NEXT

//Default split scroll position
dw_privsummary.Modify ("datawindow.horizontalscrollsplit=" + String(ci_width)) 


this.event ue_loaddetails( )


//this is here so that the user data window knows its ok call items on the dw_privs datawindow
ib_initialized = true

RETURN li_return
end function

public function long of_getuserid ();//Returns the currently selected UserId
Long	ll_userId
Long	ll_row

ll_row = dw_users.getRow( )

IF ll_row > 0 THEN
	ll_userId = dw_users.getItemNumber( ll_row, "em_id")
END IF

RETURN ll_userId
end function

public function n_cst_privDetails of_getprivdetail ();return dw_divisiondetail.of_getPrivdetail( )
end function

public function integer of_initialize (string asa_modules[], datastore ads_divisions);Int	 li_return

String	lsa_divisions[]



li_return = this.of_initialize( asa_modules, lsa_divisions )

RETURN li_return
end function

public function boolean of_inititcomplete ();//returns true if of_initialize has been called
return ib_initialized
end function

public function string of_getmodule (long al_row);String	ls_module

//the first column is the module column, so it must be greater than one
IF al_row > 0 THEN
	ls_module = dw_privsummary.getItemString( al_row, 1 )
END IF

RETURN ls_module
end function

public function string of_getdivission (long al_col);String	ls_division
Long		ll_col

//The first column is the module column so it can't be a division
IF al_col > 1 THEN
	//ls_division = dw_privSummary.describe("#"+String(ll_col)+".name")
	ls_division = isa_divisionnames[al_col]
END IF

RETURN ls_division
end function

private function integer of_changealldivisions (string as_module, string as_data);Int 	li_return
Int	li_index
Int	li_max
Long	ll_row
Long	ll_rowMax
//the following will change all the divisions for the module that was set

ll_rowMax = dw_privsummary.rowCount()

FOR ll_row = 1 TO ll_rowMax
	IF dw_privSummary.getItemString( ll_row, 1) = as_module THEN
		EXIT
	END IF
NEXT

li_max = integer( dw_privSummary.Object.DataWindow.Column.Count )
//we start at 2 because the first column is the module column
FOR li_index = 2 TO li_max
	dw_privSummary.setItem( ll_row, li_index, as_data )
NEXT

RETURN li_return
end function

private function integer of_changeallmodules (string as_division, string as_data);Int 	li_return
long	ll_index
Long	ll_max
Long	ll_column

//the following will change all of the modules listed under the division to 
//the value in as_data

ll_max = dw_privSummary.rowCount()

FOR ll_index = 1 TO ll_max
	//column number
	IF isNumber( as_division ) THEN
		dw_privSummary.setItem( ll_index, long(as_division), as_data )
	ELSE
		//column name
		dw_privSummary.setItem( ll_index, as_division, as_data )
	END IF
NEXT

RETURN li_return
end function

public function long of_getcopytouser ();//returns the id of the user that is being copied to

Long	ll_index
Long	ll_userId
//finds the index that the current selected user is at
ll_index = ddlb_users.finditem( ddlb_users.text , 0 )

IF upperBound( ila_useridsinlist ) > 0 AND ll_index > 0 THEN
	IF not isNULL( ila_useridsinlist[ll_index] )  THEN
		ll_userId = ila_useridsinlist[ll_index] 
	END IF
END IF
RETURN ll_userId
end function

public function integer of_getdivisionlistfromds (datastore ads_divisions, ref string asa_divisions[]);Int	li_return = 1
String	lsa_divisions[]
//Long	ll_foundAll
Long	ll_divCount
Long	i
String	ls_temp

IF isValid( ads_divisions ) THEN
	lsa_divisions[1] = "_"			//for the first column which is the module column

	ll_DivCount = ads_divisions.RowCount()
	
	FOR i = 1 TO ll_DivCount
		ls_Temp = ads_divisions.Object.st_name[i]
		lsa_Divisions[UpperBound(lsa_Divisions[]) + 1] = ls_Temp
	NEXT 
ELSE
	li_return = -1
END IF

asa_divisions = lsa_divisions

RETURN li_return
end function

private function long of_getmodulerow (string as_module);//Returns the number of the row where the specified module is located
//returns -1 if not found

Long	ll_index
Long	ll_max
Long	ll_return
String	ls_module

ll_max = dw_privSummary.rowCount( )
FOR ll_index = 1 TO ll_max
	ls_module = dw_privSummary.getItemString( ll_index, 1 )
	IF ls_module = as_module THEN
		EXIT
	END IF
NEXT

IF ls_module = as_module THEN
	ll_return = ll_index
ELSE
	ll_return = -1 
END IF

RETURN ll_return
end function

public function integer of_initializelistbox ();int 	li_return
long	ll_index
long	ll_max

Long		ll_id
String 	ls_lastName
String	ls_firstName
String 	ls_fullName

ll_max = dw_users.rowCount( )

ddlb_users.addItem( ics_multipleUsers )
ila_userIdsInList[1] = ici_multipleuserid				//have to add a dummy id to the list


//initializes the user list box
FOR ll_index = 1 TO ll_max
	ls_lastName = dw_users.getItemString( ll_index, "em_ln"  )
	ls_firstName = dw_users.getItemString( ll_index, "em_fn"  )
	ls_fullName = ls_lastName+ ", "+ ls_firstName
	ll_id = dw_users.getItemNumber( ll_index, "em_id" )
	
	ila_userIdsInList[upperBound(ila_userIdsInList)+1] = ll_id
	li_return = ddlb_users.addItem( ls_fullName )
NEXT

//initialize the to division listbox
ll_max = upperBound( isa_divisionnames )
ddlb_todivision.addItem( ics_multipledivs )
//start at 2 so we dont' add the underscore or all divisions
FOR ll_index = 3 to ll_Max
	ddlb_todivision.addItem( isa_divisionNames[ll_index] )
NEXT

RETURN li_return
end function

private function integer of_setborder (dwobject adwo_obj, long al_row);String	lsa_ObjList[]
Long		i, ll_Max

dw_privsummary.inv_base.of_GetObjects( lsa_ObjList, "column", "*", TRUE)
ll_Max = UpperBound(lsa_ObjList[])
FOR i = 1 TO ll_Max
	dw_privsummary.Modify(lsa_ObjList[i] + ".Border = 0")
NEXT

IF isValid(adwo_obj) THEN
	IF adwo_obj.Name <> "c" THEN
		dw_privsummary.Modify(adwo_obj.Name + ".Border='0~tif(GetRow() =" + string(al_row) +",2,0)'")
	END IF
END IF

Return 1
end function

public function integer of_setprivdetail (n_cst_privdetails anv_privdetail);//anv_privDetail.of_setDivisionDisplay( this.of_getDivission())

return dw_divisiondetail.of_setprivdetail( anv_privDetail, this.pointery() + 100 )

end function

private function integer of_updateprivsfrom (string as_module, string as_division, string as_data);//Rick didn't like this function so it isn't actually called by anything anymore
//If for some reason we want the window to modify its cells this function will
//do it.  Instead of calling this function now, the window is informed when
//there are changes that it can get from the privManager.  From that the window
//gets the lattest changes in the form of non visuals, and makes the changes
//appropriately.

//the following does an update to dw_privSummary based on the the data in 
//as_module, as_division,  the data is as_data.
Int	li_return

String	ls_division
Long	ll_index
Long	ll_max

IF lower(as_module) = lower(ics_allModules) AND lower(as_division) = lower(ics_allDivisions) THEN
	//must change every item
	ll_max = long( dw_privSummary.Object.DataWindow.Column.Count )
	
	//start at two because the first column is the module column
	FOR ll_index = 2 TO ll_max
		this.of_changeAllModules( string(ll_index) ,as_data )
	NEXT
ELSE
	IF lower(as_module) = lower(ics_allModules) THEN
		this.of_changeallmodules( as_division, as_data )
	END IF
	
	IF lower(as_division) = lower(ics_allDivisions) THEN
		this.of_changeAlldivisions( as_module, as_data )
	END IF
END IF
Return li_return
end function

public function integer of_updatevisuals (n_cst_privdetails anva_privchanges[]);//the following function updates the u_dwprivSummary object by looping
//through the array of nonvisuals, and getting the module and division
//it represents, and the icon to display at the location.
Int	li_cnt

LONG	ll_index
LONG  ll_max
Long	ll_module

String	ls_module
String	ls_division
String	ls_icon

Int		li_override

Long		ll_icon
Long		ll_divisionId
Long		ll_divisionCol

Long		ll_currentUserId
Long		ll_privUserId

ll_currentUserId = this.of_getuserid( )

ll_max = upperBound( anva_privchanges[] )
FOR ll_index = 1 TO ll_max
	IF isValid( anva_privchanges[ll_index] ) THEN
		li_cnt = 1
	ELSE
		li_cnt = -1
	END IF
	
	//it only makes sense to update the visuals if the user id on the lattest change matches
	//the current user we are displaying
	IF li_cnt = 1 AND  ll_currentUserId = anva_privChanges[ll_index].of_getUserId() THEN
		ls_module = anva_privChanges[ll_index].of_getModule( )
		ll_divisionId = anva_privChanges[ll_index].of_getDivision( )
		ll_module = this.of_getmodulerow( ls_module )
		
		ll_divisionCol = this.event ue_getdivisioncol( ll_divisionId )
		
		IF ll_divisionCol > 0 THEN
			
			anva_privChanges[ll_index].of_getUserClass( ll_icon, li_override  )
			
			this.event  ue_getIcon( ll_icon, ls_icon, li_override )
			IF len( ls_icon ) > 0 THEN

				IF ll_module > 1 AND ll_DivisionCol > 2 THEN
					dw_privSummary.setItem( ll_module, ll_divisionCol, ls_icon )
					  
				END IF
				
			END IF
		END IF
	END IF
NEXT

RETURN li_cnt
end function

public function integer of_setuser (long al_id);Long	ll_max
Long	ll_index

ll_max = dw_users.rowCount()
FOR ll_index = 1 TO ll_max
	IF dw_users.getItemNumber( ll_index, "em_id" ) = al_id THEN
		dw_users.setRow( ll_Index )
		exit
	END IF
NEXT

return 1
end function

public function string of_getcopyfromusername ();String	ls_firstName
String	ls_lastName
long 		ll_row 

ll_row =dw_users.getRow()

IF ll_row > 0 THEN
	ls_firstName = dw_users.getItemString( ll_row, "em_fn" )
	ls_lastName = dw_users.getItemString( ll_row, "em_ln" )
END IF
RETURN   ls_lastName+", "+ ls_firstName
end function

public function string of_getcopytousername ();return ddlb_users.text
end function

public function string of_getusername ();String ls_firstname
String ls_lastname
String ls_Name

ls_firstName = dw_users.getItemString( dw_users.GetRow(), "em_fn" )
ls_lastName = dw_users.getItemString( dw_users.GetRow(), "em_ln" )
ls_Name = ls_firstname + " " + ls_lastName 

Return ls_Name
end function

public function integer of_getalluser (ref long ala_ids[]);//need ed this so that i can retrieve all the ids into the cache for divisions if
//they copy them.
Long	ll_index
Long	ll_max

ll_max = upperBOund( ila_useridsinlist )
//start at 2 to skip over the multiple users entry
FOR ll_index = 2 TO ll_max
	ala_ids[ll_index - 1] = ila_useridsinlist[ll_index]
NEXT

RETURN upperBound( ala_ids )
end function

public function integer of_getcopytodivs (ref string asa_copytodivs[]);//This function finds out which divisions are going to be copied to.
String	lsa_copy[]
String	ls_selected
Long		ll_selectedIndex

Long		ll_index
Long	 	ll_max

String	lsa_alldivisions[]

n_cst_msg	lnv_msg
S_parm		lstr_parm

//ll_selectedIndex = ll_index = ddlb_users.finditem( ddlb_users.text , 0 )
ls_selected = ddlb_todivision.text //ddlb_todivision.text( ll_selectedIndex )

IF isNull( ls_selected ) OR ls_selected = "" THEN
	//do nothign
ELSE
	IF ls_selected = ics_multipledivs THEN
		//open a window that will return a list of multiple divisions selected from.
		ll_max = upperBOund( isa_divisionnames )
		FOR ll_index = 3 TO ll_max
			IF isa_divisionnames[ll_index] <> ics_alldivisions THEN
				lsa_alldivisions[upperBound(lsa_allDivisions)+ 1] = isa_divisionnames[ll_index]
			END IF
		NEXT
		lstr_parm.is_label = "ALLDIVISIONS"
		lstr_parm.ia_value = lsa_alldivisions
		lnv_msg.of_add_parm( lstr_parm )
		OPENwithParm( w_response_getdivisions, lnv_msg )
		
		
		IF IsValid ( Message.PowerobjectParm ) THEN
			If UPPER( Message.PowerObjectParm.ClassName ( ) ) = "N_CST_MSG" Then 
				lnv_Msg = Message.PowerobjectParm
				
				IF isValid ( lnv_Msg ) THEN
					IF lnv_Msg.of_get_parm( "ALLDIVS", lstr_Parm) > 0 THEN
						lsa_copy = lstr_Parm.ia_Value
					END IF
				END IF
			End IF
		END IF
		
		
	ELSEIF ls_selected = ics_alldivisions THEN
		//get all division names
		ll_max = upperBOund( isa_divisionnames )
		FOR ll_index =1 TO ll_max
			IF isa_divisionNames[ll_index] <> ics_alldivisions THEN
				lsa_copy[upperBOund(lsa_copy)+ 1] = isa_divisionnames[ll_index]
			END IF
		NEXT
	ELSE
		//get the selected division
		lsa_copy[1] = ls_selected
	END IF
	
END IF


asa_copyToDivs = lsa_copy

RETURN upperBound( asa_copyToDivs )









end function

on u_cst_privs.create
int iCurrent
call super::create
this.ddlb_todivision=create ddlb_todivision
this.st_2=create st_2
this.st_1=create st_1
this.ddlb_users=create ddlb_users
this.st_3=create st_3
this.cb_copy=create cb_copy
this.sle_currentmodule=create sle_currentmodule
this.sle_currentdivision=create sle_currentdivision
this.st_module=create st_module
this.st_division=create st_division
this.st_privs=create st_privs
this.dw_users=create dw_users
this.dw_privsummary=create dw_privsummary
this.gb_privs=create gb_privs
this.dw_divisiondetail=create dw_divisiondetail
this.cbx_copyprivs=create cbx_copyprivs
this.cbx_copydivs=create cbx_copydivs
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ddlb_todivision
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.ddlb_users
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.cb_copy
this.Control[iCurrent+7]=this.sle_currentmodule
this.Control[iCurrent+8]=this.sle_currentdivision
this.Control[iCurrent+9]=this.st_module
this.Control[iCurrent+10]=this.st_division
this.Control[iCurrent+11]=this.st_privs
this.Control[iCurrent+12]=this.dw_users
this.Control[iCurrent+13]=this.dw_privsummary
this.Control[iCurrent+14]=this.gb_privs
this.Control[iCurrent+15]=this.dw_divisiondetail
this.Control[iCurrent+16]=this.cbx_copyprivs
this.Control[iCurrent+17]=this.cbx_copydivs
end on

on u_cst_privs.destroy
call super::destroy
destroy(this.ddlb_todivision)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.ddlb_users)
destroy(this.st_3)
destroy(this.cb_copy)
destroy(this.sle_currentmodule)
destroy(this.sle_currentdivision)
destroy(this.st_module)
destroy(this.st_division)
destroy(this.st_privs)
destroy(this.dw_users)
destroy(this.dw_privsummary)
destroy(this.gb_privs)
destroy(this.dw_divisiondetail)
destroy(this.cbx_copyprivs)
destroy(this.cbx_copydivs)
end on

event constructor;call super::constructor;this.of_setresize( true )

inv_resize.of_register( dw_privsummary , inv_resize.scalerightbottom )
inv_resize.of_register( dw_divisiondetail , inv_resize.scaleBottom )
inv_resize.of_register( dw_users , inv_resize.scalebottom )
inv_resize.of_register( gb_privs , inv_resize.fixedbottom )
inv_resize.of_register( sle_currentdivision, inv_resize.fixedbottom )
inv_resize.of_register( sle_currentmodule, inv_resize.fixedbottom )
inv_resize.of_register( st_division , inv_resize.fixedbottom )
inv_resize.of_register( st_module , inv_resize.fixedbottom )
inv_resize.of_register( cb_copy, inv_resize.fixedbottom )
inv_resize.of_register( ddlb_users , inv_resize.fixedbottom )
inv_resize.of_register( st_3 , inv_resize.fixedbottom )
inv_resize.of_register( cbx_copydivs , inv_resize.fixedbottom )
inv_resize.of_register( cbx_copyprivs , inv_resize.fixedbottom )		
inv_resize.of_register( ddlb_todivision , inv_resize.fixedbottom )		
inv_resize.of_register( st_2 , inv_resize.fixedbottom )	
inv_resize.of_register( st_division , inv_resize.fixedbottom )

end event

type ddlb_todivision from dropdownlistbox within u_cst_privs
integer x = 1696
integer y = 1384
integer width = 713
integer height = 544
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 134217737
boolean sorted = false
boolean hscrollbar = true
boolean vscrollbar = true
string item[] = {""}
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within u_cst_privs
integer x = 1650
integer y = 1392
integer width = 55
integer height = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "/"
boolean focusrectangle = false
end type

type st_1 from statictext within u_cst_privs
integer x = 841
integer y = 24
integer width = 786
integer height = 104
boolean bringtotop = true
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "PRIVILEGES FOR:"
boolean focusrectangle = false
end type

type ddlb_users from dropdownlistbox within u_cst_privs
integer x = 896
integer y = 1384
integer width = 736
integer height = 544
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 134217737
boolean sorted = false
boolean hscrollbar = true
boolean vscrollbar = true
string item[] = {""}
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within u_cst_privs
integer x = 901
integer y = 1316
integer width = 475
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "To User / Division"
boolean focusrectangle = false
end type

type cb_copy from commandbutton within u_cst_privs
integer x = 2450
integer y = 1380
integer width = 251
integer height = 88
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Copy"
end type

event clicked;parent.event ue_copytouser( )
end event

type sle_currentmodule from singlelineedit within u_cst_privs
integer x = 901
integer y = 1228
integer width = 718
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type sle_currentdivision from singlelineedit within u_cst_privs
integer x = 1691
integer y = 1228
integer width = 699
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type st_module from statictext within u_cst_privs
integer x = 887
integer y = 1156
integer width = 617
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "From Module / Division"
boolean focusrectangle = false
end type

type st_division from statictext within u_cst_privs
integer x = 1637
integer y = 1236
integer width = 41
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "/"
boolean focusrectangle = false
end type

type st_privs from statictext within u_cst_privs
integer x = 1765
integer y = 24
integer width = 1472
integer height = 104
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean focusrectangle = false
end type

type dw_users from u_dw within u_cst_privs
event ue_enable ( boolean ab_enable )
event ue_keydown pbm_dwnkey
integer x = 41
integer y = 136
integer width = 763
integer height = 1364
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_appusers"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event ue_enable(boolean ab_enable);This.Enabled = ab_Enable

IF ab_Enable THEN
	This.Modify("DataWindow.Color = " + String(n_cst_Constants.cl_Color_White))
ELSE
	This.Modify("DataWindow.Color = " + String(n_cst_Constants.cl_Color_NA))
END IF
end event

event ue_keydown;Long	ll_index
Long	ll_max
String	ls_key

ll_max = this.rowCOunt()

//ls_key = char(key)	//doesn't do what i want, so i ahve to do the blasted choose case
////MessageBox(ls_key, ls_key)
CHOOSE CASE key
	CASE keyA!
		ls_key= "A"
	CASE keyB!
		ls_key= "B"
	CASE keyC!
		ls_key= "C"
	CASE keyD!
		ls_key= "D"
	CASE keyE!
		ls_key= "E"
	CASE keyF!
		ls_key= "F"
	CASE keyG!
		ls_key= "G"
	CASE keyH!
		ls_key= "H"
	CASE keyI!
		ls_key= "I"
	CASE keyJ!
		ls_key= "J"
	CASE keyK!
		ls_key= "K"
	CASE keyL!
		ls_key= "L"
	CASE keyM!
		ls_key= "M"
	CASE keyN!
		ls_key= "N"
	CASE keyO!
		ls_key= "O"
	CASE keyP!
		ls_key= "P"
	CASE keyQ!
		ls_key= "Q"
	CASE keyR!
		ls_key= "R"
	CASE keyS!
		ls_key= "S"
	CASE keyT!
		ls_key= "T"
	CASE keyU!
		ls_key= "U"
	CASE keyV!
		ls_key= "V"
	CASE keyW!
		ls_key= "W"
	CASE keyX!
		ls_key= "X"
	CASE keyY!
		ls_key= "Y"
	CASE keyZ!
		ls_key= "Z"
																												
END CHOOSE

FOR ll_index = 1 TO ll_max
	IF char(this.getItemString( ll_index, "em_ln" )) = LS_KEY THEN
		this.setrow(ll_index)
		EXIT
	END IF
NEXT

RETURN 1
end event

event constructor;call super::constructor;this.of_SetDeleteable( False )
This.of_SetInsertable( False )
this.of_setrowselect( TRUE )
this.inv_rowselect.of_setrequestor( this )

This.Modify("em_ln.protect = 1")
This.Modify("em_fn.protect = 1")

THIS.setTransobject( SQLCA )
THIS.retrieve()

commit;


this.setsort("em_ln A, em_fn A")
this.sort()

end event

event rowfocuschanged;call super::rowfocuschanged;Long		ll_userId
dwobject	ldwo_dummy

IF currentRow > 0 THEN
	ll_userId = this.getItemNumber( currentRow, "em_id" )
	parent.event ue_userchanged( ll_userid )
	parent.event ue_focuschanged( ldwo_dummy, currentRow , ics_user )
	Post of_SetBorder(ldwo_dummy, 0)

END IF
end event

event rbuttondown;call super::rbuttondown;STRING lsa_parm_labels[]
ANY	 laa_parm_values[]
String	ls_result

n_cst_msg	lnv_Msg
s_Parm		lstr_Parm

IF row > 0 THEN
	lsa_parm_labels[1] = "ADD_ITEM"
	laa_parm_values[1] = "Default Divisions"
	
	lsa_parm_labels[2] = "XPOS"
	laa_parm_values[2] = pointerx()+ 100
	
	lsa_parm_labels[3] = "YPOS"
	laa_parm_values[3] = pointery()+ 300
	
	ls_result = f_pop_standard(lsa_parm_labels, laa_parm_values)

END IF


IF ls_result = "DEFAULT DIVISIONS" THEN
	lstr_Parm.is_Label = "EM_NAME"
	lstr_Parm.ia_value = parent.of_getuserName()
	lnv_Msg.of_add_parm( lstr_Parm )

	lstr_Parm.is_Label = "EM_ID"
	lstr_Parm.ia_value = parent.of_getuserId()
	lnv_Msg.of_add_parm( lstr_Parm )
	
	OpenWithParm( w_employeedivisiondefaults, lnv_Msg )	
			
END IF
		
end event

type dw_privsummary from u_dw within u_cst_privs
event ue_enable ( boolean ab_enable )
integer x = 846
integer y = 136
integer width = 2409
integer height = 884
integer taborder = 20
boolean bringtotop = true
boolean hscrollbar = true
boolean hsplitscroll = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event ue_enable(boolean ab_enable);Long	i, j
Long	ll_RowCount, ll_ColCount

This.Enabled = ab_Enable

IF ab_Enable THEN
	This.Modify("DataWindow.Color = " + String(n_cst_Constants.cl_Color_White))
ELSE
	
	//Clear bmp images
	ll_RowCount = This.RowCount()
	ll_ColCount = Long(This.Describe("DataWindow.Column.Count"))
	FOR i = 1 TO ll_RowCount
		FOR j = 2 TO ll_ColCount //start at 2 becuase 1 is reserved for module list
			This.SetItem(i, j, "greyout.invalid") //sets all images to an invalid image
		NEXT
	NEXT
	
	This.Modify("DataWindow.Color = " + String(n_cst_Constants.cl_Color_NA))
	
END IF
end event

event constructor;call super::constructor;this.of_setbase( true )

end event

event doubleclicked;call super::doubleclicked;parent.event ue_dwprivsdoubleclicked( dwo, row )
end event

event rbuttondown;call super::rbuttondown;//overrides ancestor
String	lsa_parm_labels[]
any 		laa_parm_values[]
int		li_res = 1
int		li_index
int		li_Pos
int		li_result

String	ls_result
String	ls_value
String	lsa_icons[]

String	ls_module
String	ls_division
Long		ll_Col
Long 		ll_userId
Long		ll_role
Long		ll_division
String	ls_newRole
String	ls_Col
N_cst_privsManager	lnv_privManager
N_cst_privDetails		lnv_privDetail


IF isValid(dwo) AND row > 0 THEN
	IF dwo.Type = "column" THEN
		ll_Col = Long(dwo.Id)
		IF ll_Col = 1 THEN //First column, no action
			li_res = -1
		END IF
	ELSE
		li_res = -1
	END IF
ELSE
	li_res = -1
END IF

IF li_res = 1 THEN
			
	of_SetBorder(dwo, row)
	
	dw_divisiondetail.visible = false
	parent.event ue_focusChanged(dwo, row, ics_priv )
	ls_value = this.getItemString( row, ll_Col )
	
	parent.Event ue_getIcons( lsa_icons )
	
	li_res = upperBound( lsa_icons )  

	//create a menu with all the icons
	li_Pos = Pos(ls_value, "+")
	IF li_Pos = 0 THEN
		li_Pos = Pos(ls_value, "-")
	END If
	IF li_Pos = 0 THEN
		li_Pos = Pos(ls_value, ".")
	END IF
	ls_value = Left( ls_value, li_Pos - 1 )
	
	
	FOR li_index = 1 TO li_res
		lsa_parm_labels[ li_index ] = "ADD_ITEM"
		laa_parm_values[ li_index ] = left( lsa_icons[li_index], len(lsa_icons[li_index]) - 4 )
	NEXT
	
	IF li_res > 0 THEN
		lsa_parm_labels[ li_res + 1 ] = "CHECK"
		laa_parm_values[ li_res + 1 ] = ls_Value
		
		lsa_parm_labels[ li_res + 2 ] = "XPOS"
		laa_parm_values[ li_res + 2 ] = this.x + pointerx( )
		 
		lsa_parm_labels[ li_res + 3 ] = "YPOS"
		laa_parm_values[ li_res + 3 ] = this.y + pointery( )
		
		ls_result =  f_pop_standard(lsa_parm_labels, laa_parm_values)
	
	END IF
	
	
	IF li_res > 0 THEN
		//if something is set, then inform the parent., and make other changes
		//graphically if necessary.
		IF ls_result = "LOOKUP" THEN
			ls_newRole = appeon_constant.cs_lookup		
		ELSEIF ls_result = "ENTRY" THEN
			ls_newRole = appeon_constant.cs_entry	
		ELSEIF ls_result = "AUDIT" THEN
			ls_newRole = appeon_constant.cs_audit
		ELSEIF ls_result = "ADMIN" THEN
			ls_newRole = appeon_constant.cs_admin		
		ELSE
			li_res = -1
		END IF	
	END IF
	
	//get the corresponding nonVisual for the module and division that was changed.
	//Change it to the new value.
	IF li_res > 0 THEN
		
//		IF row > 1 AND ll_Col <> 2 THEN 
//			this.setItem(row, ll_col, ls_newRole )
//		END IF
		parent.event ue_getprivmanager( lnv_privManager ) 
			
		IF isValid( lnv_privManager )	THEN
			ls_module = parent.of_getModule(row)
			ls_division = parent.of_getdivission(ll_col)
			ll_userId = parent.of_getUserid( )
			
			parent.event ue_getdivisionid( ls_division, ll_division ) 
			
			IF ll_division > 0 THEN
				lnv_privDetail = lnv_privManager.of_getdetails( ll_userId, ls_module, ll_division )
				lnv_privDetail.of_getDetails()		//this line iniitializes the function cache on the object.
				
				//IF the object has  non-division based prives , we actually want to change all of the division objects,
				//so we initialize the collection object instead.
				IF lnv_privDetail.of_hasnondivisionbasedprivs( ) THEN
					li_result = MESSAGEBOX( "Modify Privilege", "This privilege is a non-division based privilege.  Changing it will change it for all divisions. Continue?", question!, yesno!, 1 )
					IF li_result = 1 THEN
						Destroy lnv_privDetail
						
						lnv_privDetail = lnv_privManager.of_getdetails( ll_userId, ls_module, lnv_privManager.cl_alldivisions )
					ELSE
						//this will keep the change from rolling through
						Destroy lnv_privDetail
					END IF
				END IF
			END IF	
		END IF
		
		IF isValid( lnv_privDetail ) THEN
			parent.event ue_geticonid( ls_newRole, ll_role )
			
			IF ll_role > 0 THEN
				lnv_privDetail.of_changeRole( ll_role )		//this call will take care of the cache changes
				
//				IF row > 1 AND ll_Col <> 2 THEN 
//					this.setItem(row, ll_col, ls_newRole )
//				END IF
			END IF
		END IF
		
	END IF
	
	parent.dw_divisiondetail.visible = false
	
END IF

IF isValid( lnv_privDetail ) THEN
	Destroy lnv_privDetail
END IF

end event

event clicked;call super::clicked;of_SetBorder(dwo, row)

dw_divisiondetail.visible = false
parent.event ue_focusChanged(dwo, row, ics_priv )

end event

event scrollhorizontal;call super::scrollhorizontal;//Supress scrolling back to module header columns
IF pane = 2 THEN
	IF scrollpos < ci_width then
		this.Modify("DataWindow.HorizontalScrollPosition2 = " + String(ci_width))
	end if
END IF
end event

type gb_privs from groupbox within u_cst_privs
integer x = 850
integer y = 1020
integer width = 1906
integer height = 484
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type dw_divisiondetail from u_dw_privdetail within u_cst_privs
event ue_enable ( boolean ab_enable )
boolean visible = false
integer x = 2117
integer y = 980
integer width = 1161
integer height = 380
integer taborder = 50
end type

event ue_enable(boolean ab_enable);This.Enabled = ab_Enable

IF NOT ab_Enable THEN
	This.Visible = FALSE
END IF
end event

event itemchanged;call super::itemchanged;
Integer	li_Return = 0
String	ls_Data
String	ls_originalData
Long		ll_modFnID
Long		ll_currentDivision
Int		li_result

Boolean	lb_changePrivs

n_cst_privsManager 	lnv_manager
n_cst_privDetails		lnv_collection
ls_Data = data

Parent.setRedraw(false)
IF data = "?" THEN
	
	ls_Data = "Y"
	SetItem(row, "functionvalue", ls_Data)
	
	
	//Return 2 - do not allow item to change
	li_Return = 2
	
END IF


ls_originalData = this.getItemString( row, "functionValue", PRIMARY!, true )
ll_modFNID = this.getItemNumber( row, "modfnid" )


//If the data clicked isn't divisional based then ask.
IF this.inv_currentdetails.of_isNonDivisionBasedPriv( ll_modFnId ) THEN
	li_result = MESSAGEBOX( "Modify Privilege", "This privilege is a non-division based privilege.  Changing it will change it for all divisions. Continue?", question!, yesno!, 1 )
ELSE
	lb_changePrivs = true
END IF

//if they have opted to change the setting for all of them, I get the collection object and
//make the change on that object instead. 
IF li_result = 1 THEN
	lnv_manager = parent.event ue_getMyPrivManager()
	
	IF isValid( lnv_manager ) THEN
		//create a collection object and  set it to be the current detail, and call 
		//change detail on the collection.  Swap it back to the old one afterwards.
		
		ll_currentDivision = inv_currentdetails.of_getDivision( )		
		lnv_collection = lnv_manager.of_getdetails( parent.of_getuserid( ) , parent.sle_currentmodule.text, lnv_manager.cl_alldivisions )
		this.of_setprivdetail( lnv_collection, this.pointery() + 100 )		//this line changes the reference of inv_currentDetails to be the collection object
		
		lb_changePrivs = true
	END IF
ELSEIF li_result = 2 THEN
	SetItem(row, "functionvalue", ls_originalData )
	li_return = 2		//do not allow item to change
END IF

IF lb_changePrivs THEN
	inv_currentdetails.of_detailChanged( dwo, row, ls_Data )
	
	//change it back to the correct detail
	IF isValid( lnv_collection )THEN
		lnv_collection = lnv_manager.of_getdetails( parent.of_getuserid( ) , parent.sle_currentmodule.text, ll_currentDivision )
		this.of_setPrivDetail( lnv_collection, this.pointery() + 100 )
		
	END IF
	this.SetItem(row, "functionvalue", ls_Data)
END IF
parent.setRedraw(true)
Return li_Return
end event

type cbx_copyprivs from checkbox within u_cst_privs
integer x = 910
integer y = 1080
integer width = 434
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
string text = "Copy Privileges"
boolean checked = true
end type

event clicked;IF this.checked THEN
	sle_currentdivision.backcolor = RGB(255,255,255)
	sle_currentmodule.backcolor = RGB(255,255,255)
	ddlb_todivision.backcolor = RGB(255,255,255)
	ddlb_users.backcolor  = RGB(255,255,255)
ELSE
	sle_currentdivision.backcolor = RGB(192,192,192)
	sle_currentmodule.backcolor = RGB(192,192,192)
	ddlb_todivision.backcolor = RGB(192,192,192)
	ddlb_users.backcolor  = RGB(192,192,192)
END IF
end event

type cbx_copydivs from checkbox within u_cst_privs
integer x = 1390
integer y = 1080
integer width = 599
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
string text = "Copy Default Divisions"
boolean checked = true
end type

