$PBExportHeader$n_cst_file.sru
forward
global type n_cst_file from nonvisualobject
end type
end forward

global type n_cst_file from nonvisualobject autoinstantiate
end type

forward prototypes
public function integer of_getfilesavename (string as_title, ref string as_pathname, ref string as_filename, string as_extension, string as_filter, string as_cancelwarning)
public function integer of_getfilesavename (string as_title, ref string as_pathname, ref string as_filename, string as_extension, string as_filter)
end prototypes

public function integer of_getfilesavename (string as_title, ref string as_pathname, ref string as_filename, string as_extension, string as_filter, string as_cancelwarning);//Return Values : 1 = Success (values returned in as_PathName and as_FileName ), 
//						-1 = Failure, or User-Initiated Cancel (user has to "approve" failure)

String	ls_PathName, &
			ls_FileName, &
			ls_Message
Integer	li_Result

ls_PathName = as_PathName
ls_FileName = ""

as_PathName = ""
as_FileName = ""

DO

	li_Result = GetFileSaveName ( as_Title, ls_PathName, ls_FileName, as_Extension, as_Filter )

	CHOOSE CASE li_Result
	CASE 1
		IF FileExists ( ls_PathName ) THEN
			IF MessageBox ( as_Title, "The file ~"" + ls_PathName + "~" already exists."+&
				"~n~nOverwrite it?", Exclamation!, YesNo!, 2 ) = 2 THEN
					ls_FileName = ""
					CONTINUE
			END IF
		END IF
	CASE ELSE
		IF li_Result = 0 THEN
			//User chose cancel in filename dialog.  Proceed to warning.
		ELSE
			//There was an error in filename dialog.
			IF MessageBox ( as_Title, "Error attempting to determine filename.", &
				Exclamation!, RetryCancel!, 1 ) = 1 THEN
					ls_FileName = ""
					CONTINUE
			END IF
		END IF

		IF IsNull ( as_CancelWarning ) THEN

			//No cancel warning required

			RETURN -1

		ELSE

			//Issue cancel warning

			ls_Message = as_CancelWarning
			IF Len ( ls_Message ) > 0 THEN
				ls_Message += "~n~n"
			END IF
			ls_Message += "Are you sure you want to cancel?"

			IF MessageBox ( "Cancel File Create", ls_Message, Exclamation!, YesNo!, 2 ) = 2 THEN
				ls_FileName = ""
				CONTINUE
			ELSE
				RETURN -1
			END IF
		END IF

	END CHOOSE

LOOP UNTIL Len ( ls_FileName ) > 0

as_FileName = ls_FileName
as_PathName = ls_PathName

RETURN 1
end function

public function integer of_getfilesavename (string as_title, ref string as_pathname, ref string as_filename, string as_extension, string as_filter);//Overload of of_GetFileSaveName, with no Cancel Warning

String	ls_CancelWarning
SetNull ( ls_CancelWarning )  //Do not issue a cancel warning

RETURN of_GetFileSaveName ( as_Title, as_PathName, as_FileName, as_Extension, as_Filter, &
	ls_CancelWarning )
end function

on n_cst_file.create
TriggerEvent( this, "constructor" )
end on

on n_cst_file.destroy
TriggerEvent( this, "destructor" )
end on

