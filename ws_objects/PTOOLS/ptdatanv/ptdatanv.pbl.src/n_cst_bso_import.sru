$PBExportHeader$n_cst_bso_import.sru
$PBExportComments$Base import object
forward
global type n_cst_bso_import from n_cst_bso
end type
end forward

global type n_cst_bso_import from n_cst_bso
end type
global n_cst_bso_import n_cst_bso_import

type variables
Public String is_FileGroup = "Import"

Protected:
Constant String cs_IniFile = "trucking.ini"


end variables

forward prototypes
protected function long of_createdatastore (string as_dataobject, string as_filename, ref datastore ads_import)
protected function string of_isfilevalid (string asa_parmlabels[], string asa_parmvalues[])
protected function integer of_getparmlabels (string as_filegroup, string as_key, integer ai_parmsexpected, ref string asa_parmlabels[])
protected function integer of_getparms (string as_filegroup, string as_key, integer ai_parmsexpected, string asa_parmlabels[], ref string asa_parmvalues[])
public function integer of_import ()
end prototypes

protected function long of_createdatastore (string as_dataobject, string as_filename, ref datastore ads_import);/*
	Function:  		of_CreateDataStore
	Access:  		public
 
	Arguments:		as_dataobject
						as_filename
						ads_import (by reference)
						
	Returns:  		integer	
						1 	= success
						-1 = failure
	
	Description:	Create the datastore and import the file
		
		
*/
SetPointer(HourGlass!)

Long		ll_Return
String	ls_MessageText

n_cst_dws lnv_dws

ll_Return = long ( lnv_Dws.of_CreateDataStoreByDataObject ( as_dataobject, ads_import, TRUE ) )

IF ll_return = 1 THEN

	ll_Return = ads_import.ImportFile( as_filename )
	
	Choose case ll_Return
	
	case 0  
		ls_MessageText = "End of file; too many rows"
	case -1 
		ls_MessageText = "No rows"
	case -2 
		ls_MessageText = "Empty file"
	case -3 
		ls_MessageText = "Invalid argument"
	case -4 
		ls_MessageText = "Invalid input"
	case -5 
		ls_MessageText = "Could not open the file"
	case -6 
		ls_MessageText = "Could not close the file"
	case -7 
		ls_MessageText = "Error reading the text"
	case -8 
		ls_MessageText = "Not a TXT file"
	case -9  
		ls_MessageText = "The user canceled the import"				
	end choose
	
END IF

IF ll_Return < 0 THEN
	messagebox ( "Importing data", "Import file error: " + &
						string ( ll_Return ) + " " + ls_MessageText + ".", StopSign! )
END IF

return ll_Return

end function

protected function string of_isfilevalid (string asa_parmlabels[], string asa_parmvalues[]);/*
	Function:  		of_IsFileValid
	Access:  		protected
 
	Arguments:		as_FileName
						
	Returns:  		integer	
						1 	= success
						-1 = failure
	
	Description:	get filename from Parms and check that file exists.
						if the file is valid return the name including path

*/
SetPointer(HourGlass!)

Integer	li_Return, &
			li_Parms, &
			li_index

String	ls_Filename

li_Return = 1

li_Parms = upperbound( asa_ParmValues [] )

IF li_Parms = 0 THEN
	li_Return = -1
END IF

IF li_Return = 1 THEN

	//get filename and make sure it exists
	FOR li_Index = 1 to li_Parms
		
		IF upper ( asa_parmlabels[li_Index] ) = "FILENAME" THEN
			ls_Filename = asa_ParmValues [li_Index]
			exit
		END IF
		
	NEXT
	
	IF ls_Filename = '' or isnull ( ls_Filename ) THEN

		messagebox ( "Importing Data", &
				"Invalid filename in the [Import] section of trucking.ini file.",  StopSign! )
		li_Return = -1

	END IF

END IF

IF li_Return = 1 THEN
	
	IF FileExists ( ls_Filename ) THEN
		//CONTINUE
	ELSE
		messagebox ( "Importing Data", &
				"File " + ls_Filename + " not found",  StopSign! )
		li_Return = -1

	END IF
	
END IF	

IF li_Return = -1 THEN
	ls_Filename = ''
END IF

Return ls_Filename
end function

protected function integer of_getparmlabels (string as_filegroup, string as_key, integer ai_parmsexpected, ref string asa_parmlabels[]);/*
	Function:  		of_ImportLoop
	Access:  		public
 
	Arguments:		as_FileGroup
						as_Key
						ai_ParmsExpected
						asa_parmLabels [] by reference
						
	Returns:  		integer	
						1 	= success
						-1 = failure
	
	Description:	Look at the first key value in the section and use that 
						to determine the labels for the parameters.
						(string before the '=')
		
		
*/
SetPointer(HourGlass!)

integer	li_Return, &
			li_Parms, &
			li_Index, &
			li_Label
			
string	ls_command, &
			lsa_parms []	

n_cst_string	lnv_String

li_Return = 1

ls_Command = ProfileString ( cs_IniFile, as_FileGroup, as_Key, "" )

li_Parms = lnv_String.of_ParseToArray ( ls_Command, ";", lsa_Parms )

IF ai_ParmsExpected > 0 THEN  //CHECK FOR NUMBER OF PARMS

	IF li_Parms = ai_ParmsExpected THEN
		//OK
	ELSE
		li_Return = -1 
	END IF
	
END IF

IF li_Return = 1 THEN

	FOR li_Index = 1 to li_Parms
		
		li_label = Pos ( lsa_Parms [li_Index], '=')
		
		IF li_label > 0 THEN
			asa_parmlabels[li_Index] = &
					Trim ( Left ( lsa_Parms [li_Index], li_Label - 1))
		END IF

	NEXT
END IF

return li_Return
end function

protected function integer of_getparms (string as_filegroup, string as_key, integer ai_parmsexpected, string asa_parmlabels[], ref string asa_parmvalues[]);/*

	Function:  		of_GetParms
	Access:  		private
 
	Arguments:
	
 	as_FileGroup		The section in the application ini file.
	as_Key				The key value to be parsed.
	ai_ParmsExpected	If this is > 0 then check for number of parms.
	asa_ParmLabels	 	Labels for the values
	asa_ParmValues		BY reference


	Returns:  		integer	
						1 	= success
						-1 = failure
	
	Description:  	Gets the values from the key and labels passed in.
	
*/
SetPointer(HourGlass!)

String	ls_Command, &
			lsa_Parms[]
Integer	li_Parms, &
			li_Index, &
			li_Return

n_cst_string	lnv_string
n_cst_IniFile	lnv_IniFile

li_Return = 1

ls_Command = ProfileString ( cs_IniFile, as_FileGroup, as_Key, "" )

li_Parms = lnv_String.of_ParseToArray ( ls_Command, ";", lsa_Parms )

IF ai_ParmsExpected > 0 THEN  //CHECK FOR NUMBER OF PARMS

	IF li_Parms <> ai_ParmsExpected THEN
		messagebox ( "Importing Data", &
				"The number of parameters in the trucking.ini file " + &
				"do no match the expected amount.", StopSign!)
		li_Return = -1
	END IF
	
END IF

IF li_Return = 1 THEN

	FOR li_Index = 1 to li_Parms
		
		asa_ParmValues [ li_Index ] = lnv_string.Of_GetKeyValue( ls_command, asa_ParmLabels [ li_Index ], ";" )

//		IF len ( asa_ParmValues [ li_Index ] ) = 0 THEN
//			messagebox ( "Importing Data", &
//					"No parameter was given for " + &
//					asa_ParmLabels [ li_Index ] +&
//					" in the trucking.ini file.", StopSign!)
//			li_Return = -1
//			EXIT
//		END IF		

	NEXT
	
END IF

Return li_Return
end function

public function integer of_import ();/*

	Function:  		of_Import
	Access:  		public
 
	Arguments:		none

	Returns:  		integer	
						1 	= success
						-1 = failure
	
	Description:  	Control the importing of files listed in the 
						Import section of the application ini file.
						Create descendant specific object for mapping of data.
	
*/
SetPointer(HourGlass!)

String	lsa_Keys[], &
			lsa_ParmLabels [], &
			lsa_ParmValues[], &
			lsa_empty[], &
			ls_Filename, &
			ls_Script
Integer	li_Keys, &
			li_column, &
			li_Return, &
			li_ParmIndex, &
			li_Parms
			
Long		ll_ImportCount, &
			ll_pos

n_cst_string	lnv_string
n_cst_IniFile	lnv_IniFile
n_cst_bso_import lnv_import

li_Return = 1

//Get a list of keys (import files) in the ini file for the requested file group.

li_Keys = lnv_IniFile.of_GetKeys ( cs_IniFile, is_FileGroup, lsa_Keys )

CHOOSE CASE li_Keys
CASE -1 		//	"Can't open or read the " + cs_IniFile + " file."
	li_Return = -1

CASE -2		//	"The " + cs_IniFile + " was not found."
	li_Return = -1

CASE 0 		//	"There are no files listed in the [Import] section of the "+ cs_IniFile + " file to import."
	messagebox("Importing Data", "No import file defined.", Information!)
	li_Return = -1
	
END CHOOSE

IF li_Return = 1 THEN
	/*	If the li_keys is equal to 1 then go ahead and import it.
		If the li_keys is more than 1 then bring up a selection dialog
		and return the selected key and import.
	*/
	
	IF li_keys > 1 THEN 
		//SELECTION DIALOG
		//Pick a key any key
		//RETURN SELECTED KEY
		messagebox("Importing Data", "More than 1 key in the ini file. " + &
						"Need a selection dialog.", Information!)
		li_keys=0
		
	END IF
	
	IF li_Keys > 0 THEN
		
		this.Of_GetParmLabels ( is_FileGroup, lsa_Keys [ li_Keys ], 0, lsa_ParmLabels )
		this.Of_GetParms( is_FileGroup, lsa_keys [ li_Keys ], 0, lsa_ParmLabels, lsa_ParmValues )	
		li_Parms = upperbound ( lsa_ParmLabels )
		IF lsa_ParmValues = lsa_empty THEN
			//	Invalid Parameters
			messagebox ( "Importing Data", &
							"Invalid parameters in the [Import] section of trucking.ini file.",  StopSign! )
			li_Return = -1
		ELSE	
			//get object and script for specific import object
			FOR li_ParmIndex = 1 to li_Parms
				
				CHOOSE CASE upper ( lsa_parmlabels[li_ParmIndex] )
				CASE "OBJECT" 
					IF LEN ( lsa_ParmValues [li_ParmIndex] ) > 0 THEN
						lnv_import = Create Using lsa_ParmValues [li_ParmIndex]
					ELSE
						messagebox ( "Importing Data", &
								"No Object parameter in the [Import] section of trucking.ini file.",  StopSign! )
						li_Return = -1
					END IF
				CASE "SCRIPT"
					IF LEN ( lsa_ParmValues [li_ParmIndex] ) > 0 THEN
						ls_Script = lsa_ParmValues [li_ParmIndex] 
					ELSE
						messagebox ( "Importing Data", &
							"No Script parameter in the [Import] section of trucking.ini file.",  StopSign! )
						li_Return = -1
					END IF
				END CHOOSE
				
			NEXT
		END IF
		
		//map data 
		IF li_Return = 1 THEN
			IF isvalid ( lnv_import ) THEN
				
				choose case messagebox ( "Importing Data", &
									"Are you sure you want to import your file ?",  Question!, YesNo!, 2 )				
		
				case 1	//This return is for triggerevent not the user event
					li_Return = lnv_import.TriggerEvent ( ls_Script, 0, lsa_Keys [li_keys] )
					
				//this success message is in the triggered event
//					IF li_Return = 1 THEN
//						messagebox ( "Importing Data", "Import completed successfully.",Information!)
//					END IF
		
				case 2
					li_return = -1
		
				end choose
				
			END IF
		END IF
						
		IF li_Return = -1 then	
			messagebox ( "Importing Data", "Import aborted.",  StopSign! )
		END IF	

		IF isvalid ( lnv_import ) THEN
			DESTROY lnv_Import
		END IF
		
	END IF

END IF

Return li_Return
end function

on n_cst_bso_import.create
TriggerEvent( this, "constructor" )
end on

on n_cst_bso_import.destroy
TriggerEvent( this, "destructor" )
end on

