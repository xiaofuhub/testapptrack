$PBExportHeader$u_dw_ediprofile.sru
forward
global type u_dw_ediprofile from u_dw
end type
end forward

global type u_dw_ediprofile from u_dw
integer width = 2569
integer height = 316
string dataobject = "d_ediprofile"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
event ue_keydown pbm_dwnkey
event ue_clearblankrows ( )
end type
global u_dw_ediprofile u_dw_ediprofile

forward prototypes
public subroutine of_settemplate (string as_template)
public subroutine of_setfolder (string as_value)
end prototypes

event ue_keydown;Int li_rtn 
String ls_Filepath, ls_Filename
		
IF key = KeyDownArrow! THEN
	choose case upper(this.getcolumnname( )) 
		case 'TEMPLATE'
			li_rtn = GetFileOpenName("Select File",ls_Filepath, ls_Filename, "", &
				 + "All Files (*.*), *.*", &
				 "C:\", 18)
			IF li_rtn > 0 THEN  	 
				this.of_Settemplate(ls_FilePath)
			END IF
			
		case 'FOLDER'
			li_Rtn = GetFolder("Select a Folder", ls_filepath )
			IF li_rtn > 0 THEN  	 
				this.of_Setfolder(ls_FilePath)
			END IF		

	end choose
END IF

RETURN li_rtn


end event

event ue_clearblankrows();if this.accepttext() = 1 then
	this.setredraw(false)
	
	Long	ll_RowCount
	Long	i
	
	ll_RowCount = THIS.RowCount ( )
	FOR i = ll_RowCount TO 1 STEP -1
		IF IsNull (  THIS.GetItemNumber ( i , "companyid", Primary!, false )  ) or &
			THIS.GetItemNumber ( i , "companyid", Primary!, false ) = 0 THEN
			THIS.RowsDiscard ( i, i, Primary! ) 
		END IF	
	NEXT
		
	ll_RowCount = THIS.FilteredCount ( )
	FOR i = ll_RowCount TO 1 STEP -1
		IF IsNull (  THIS.GetItemNumber ( i , "companyid", Filter!, false )  ) or &
			THIS.GetItemNumber ( i , "companyid", Filter!, false ) = 0 THEN
			THIS.RowsDiscard ( i, i, Filter! ) 
		END IF	
	NEXT
		
	this.setredraw(true)
end if
end event

public subroutine of_settemplate (string as_template);long	ll_row

ll_row = this.getrow()

if ll_row > 0 then
	this.object.template[ll_row] = as_template
end if
end subroutine

public subroutine of_setfolder (string as_value);long	ll_row

ll_row = this.getrow()

if ll_row > 0 then
	this.object.folder[ll_row] = as_value
end if
end subroutine

on u_dw_ediprofile.create
end on

on u_dw_ediprofile.destroy
end on

event buttonclicked;call super::buttonclicked;Integer	li_rtn 
String 	ls_Filepath, &
			ls_Filename, &
			ls_object
Long	ll_max
Long	ll_index

	
ls_Object = String(dwo.name)

choose case ls_Object
	case "cb_browsefile"
		li_rtn = GetFileOpenName("Select File",ls_Filepath, ls_Filename, "", "All Files (*.*), *.*", "C:\", 18)
		IF li_rtn > 0 THEN  	 
			this.of_Settemplate(ls_FilePath)
		END IF
	case "cb_browsefolder"
		li_Rtn = GetFolder("Select a Folder", ls_filepath )
		IF li_rtn > 0 THEN  	 
			this.of_Setfolder(ls_FilePath)
		END IF		
	//added by Dan 1-24-2006 	
	case "b_browsesef"	
		//li_rtn = GetFolder ( "SEF File Path", ls_path )
		li_rtn = GetFileOpenName("Select File",ls_Filepath, ls_Filename,  "SEF","SEF Files (*.SEF),*.SEF" , "C:\", 18)
		IF li_rtn = 1 THEN
			ll_max = this.rowCount()
			//right now all sef files will be in one place for all transactions.
			FOR ll_index = 1 TO ll_max
				this.setItem( ll_index, "seffilepath", ls_filepath)
			NEXT
		END IF
		//--------------------------------------------------
end choose

RETURN li_rtn


end event

