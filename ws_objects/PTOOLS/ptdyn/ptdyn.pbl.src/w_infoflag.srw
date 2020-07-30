$PBExportHeader$w_infoflag.srw
forward
global type w_infoflag from window
end type
type mle_text from multilineedit within w_infoflag
end type
end forward

global type w_infoflag from window
boolean visible = false
integer width = 480
integer height = 80
windowtype windowtype = child!
long backcolor = 134217752
string icon = "AppIcon!"
string pointer = "Arrow!"
boolean center = true
mle_text mle_text
end type
global w_infoflag w_infoflag

type variables
Constant Integer	ci_Margin_Top = 1
Constant Integer  ci_Margin_Bottom = 1
Constant Integer	ci_Margin_Right = 10
Constant Integer	ci_Margin_Left = 10
end variables

forward prototypes
public function integer of_resize (string as_text)
public function integer of_settext (string as_text)
end prototypes

public function integer of_resize (string as_text);Integer	li_Return = 1
String 	ls_infoString
String	ls_Display
Long 		ll_infoLength
Long 		ll_Index
Long		ll_LongestLine
Long		ll_NumberOfLines
Long		ll_CurrentLineLength
Long		ll_pbWidth
Long		ll_pbHeight
Integer	li_pxHeight
Integer	li_pxWidth
Integer	li_Textsize
String	lsa_LinesArray[]
String 	ls_LongestLine

Boolean	lb_Bold

Window	lw_TempWindow

n_cst_string 			lnv_infoString
n_cst_PlatformWin32	lnv_PlatForm

lnv_PlatForm = Create n_cst_PlatformWin32 

lw_TempWindow = This

ls_infoString = as_text
ll_infoLength = Len(ls_infoString)

//parse ls_infoString into an array of Lines
lnv_infoString.of_parsetoarray( ls_infoString, "~r~n", lsa_LinesArray)

ll_NumberOfLines = upperBound(lsa_LinesArray)

IF ll_NumberOfLines <> 0 THEN
	//Get the Longest Line in the String
	FOR ll_Index = 1 to ll_NumberOfLines
		ll_CurrentLineLength = Len(lsa_LinesArray[ll_Index])
		IF ll_CurrentLineLength > ll_LongestLine THEN
			ll_LongestLine = Len(lsa_LinesArray[ll_Index])
			ls_LongestLine = lsa_LinesArray[ll_Index]
		END IF
	NEXT
ELSE
	li_Return = -1
END IF

IF li_Return = 1 THEN
	
	IF mle_text.Weight = 700 THEN
		lb_Bold = TRUE
	END IF
	
	//Abs() because gettextsize does not support negative numbers
	li_TextSize = abs(mle_text.textsize)
	
	lnv_PlatForm.of_GetTextsize(lw_TempWindow, ls_LongestLine, mle_text.facename, li_TextSize, lb_Bold, mle_text.Underline, mle_text.italic, li_pxHeight, li_pxWidth)
	
	ll_pbWidth = PixelsToUnits ( li_pxWidth, XPixelsToUnits!)
	ll_pbHeight = PixelsToUnits( li_pxHeight, YPixelsToUnits!) * ll_NumberOfLines 
	
	
	//set the width and length of static text based text size
	this.mle_text.width = ll_pbWidth
	this.mle_text.height = ll_pbHeight
	
	//set width and lenght of window based on text size plus margins
	this.width = ll_pbWidth + Long(ci_Margin_Right + ci_Margin_Left)
	this.height = ll_pbHeight + Long(ci_Margin_Bottom + ci_Margin_Top) 
	
	//Set margins
	this.mle_text.x = Long(ci_Margin_Right)
	This.mle_text.y = Long(ci_Margin_Bottom)
	
END IF

Destroy lnv_PlatForm

Return li_Return
end function

public function integer of_settext (string as_text);this.mle_text.text = as_text

return 1

end function

on w_infoflag.create
this.mle_text=create mle_text
this.Control[]={this.mle_text}
end on

on w_infoflag.destroy
destroy(this.mle_text)
end on

type mle_text from multilineedit within w_infoflag
integer width = 471
integer height = 72
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217752
string text = "none"
boolean border = false
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

