$PBExportHeader$u_dw_mappingfiles.sru
forward
global type u_dw_mappingfiles from u_dw
end type
end forward

global type u_dw_mappingfiles from u_dw
integer width = 1797
integer height = 208
string dataobject = "d_mappingfiles"
boolean border = false
borderstyle borderstyle = stylebox!
event ue_keydown pbm_dwnkey
end type
global u_dw_mappingfiles u_dw_mappingfiles

forward prototypes
protected function long of_setnextids ()
public function integer of_setfile (string as_file)
public function integer of_browsefile ()
end prototypes

event ue_keydown;Int li_rtn 
		
IF key = KeyDownArrow! THEN
	choose case upper(this.getcolumnname( )) 
		case 'MAPPINGFILE'
			li_rtn = THIS.of_browsefile( )
		
	end choose
END IF

RETURN li_rtn


end event

protected function long of_setnextids ();Long	ll_RowCount
long	i
Long	ll_MaxID

Select Max ( id ) into :ll_MaxID FROM EdiMappingFiles;
Commit;

IF IsNull ( ll_MaxID ) THEN
	ll_MaxID = 0
END IF

ll_RowCount = THIS.RowCount ( )



FOR i = 1 TO ll_RowCount
	IF IsNull ( THIS.GetITemnumber(  i , "id" ) )THEN
		ll_MaxID ++
		THIS.SetItem( i , "id" , ll_MaxID )
	END IF
NEXT

RETURN 1

end function

public function integer of_setfile (string as_file);long	ll_row

ll_row = this.getrow()

if ll_row > 0 then
	this.object.MappingFile[ll_row] = as_file
end if

RETURN 1
end function

public function integer of_browsefile ();Int	li_Rtn
String	ls_FilePath
String	ls_FileName
li_rtn = GetFileOpenName("Select File",ls_Filepath, ls_Filename, "", "All Files (*.*), *.*", "C:\", 18)
IF li_rtn > 0 THEN  	 
	this.of_SetFile (ls_FilePath)
END IF

RETURN li_Rtn
end function

on u_dw_mappingfiles.create
end on

on u_dw_mappingfiles.destroy
end on

event pfc_preupdate;call super::pfc_preupdate;THIS.of_Setnextids( )
RETURN AncestorReturnValue
end event

event buttonclicked;call super::buttonclicked;Integer	li_rtn 

choose case dwo.name
	case "cb_browsefile"
		li_rtn = THIS.of_Browsefile( )
			
end choose

RETURN li_rtn


end event

event constructor;call super::constructor;ib_Rmbmenu = FALSE
end event

