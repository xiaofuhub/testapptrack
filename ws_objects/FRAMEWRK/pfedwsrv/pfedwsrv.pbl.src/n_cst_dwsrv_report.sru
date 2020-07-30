$PBExportHeader$n_cst_dwsrv_report.sru
$PBExportComments$Extension DataWindow Reporting service
forward
global type n_cst_dwsrv_report from pfc_n_cst_dwsrv_report
end type
end forward

global type n_cst_dwsrv_report from pfc_n_cst_dwsrv_report
end type
global n_cst_dwsrv_report n_cst_dwsrv_report

forward prototypes
public function integer of_createcomposite (string as_datawindow[], boolean ab_vertical, string as_trailfooter[], string as_slide[], border abo_border[])
end prototypes

public function integer of_createcomposite (string as_datawindow[], boolean ab_vertical, string as_trailfooter[], string as_slide[], border abo_border[]);//////////////////////////////////////////////////////////////////////////////
//
//   Function:  of_createcomposite
//   OVERRIDE OF ANCESTOR TO FIX PFC BUG : REPLACE "AboveAll" WITH "AllAbove"
//   "AllAbove" is the correct value.
//
//   Access:  public
//
//   Arguments:
//   as_Expr                  The expression to be added as the computed column.
//   as_DataWindow[]      An array of DataWindows to place on the composite.
//   ab_Vertical            True - arrange the DataWindows vertically down the page,
//                           False - arrange the DataWindows horizontally.
//   as_TrailFooter[]         An array of values ("yes" or "no") to set the individual 
//                           trail_footer attributes for each DataWindow.
//   as_NewPage[]         An array of values ("yes" or "no") to set the individual 
//                           NewPage attributes for each DataWindow.
//   as_Slide[]               An array of values to set the individual slide attributes
//                           for each DataWindow; if ab_Vertical is true this sets SlideUp
//                           and valid values are "AllAbove", "DirectlyAbove" or "No;
//                           if ab_Vertical is false this sets SlideLeft and valid values are
//                           "yes" or "no".
//   abo_Border[]            An array of values (NoBorder!, ShadowBox!, Box!, 
//                           ResizeBorder!, Underline!, Lowered!, Raised!) to use as 
//                           the border for each DataWindow.
//
//   Returns:      Integer
//               1 if successful, -1 if an error occurrs.
//
//   Description:   Create a composite DataWindow from an array of DataWindows.
//
//////////////////////////////////////////////////////////////////////////////
//
//   Revision History
//
//   Version
//   5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//   Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//   Any distribution of the PowerBuilder Foundation Classes (PFC)
//   source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
    
String   ls_Modify, ls_Version, ls_TrailFooter, ls_NewPage, ls_Slide, ls_Border
Integer   li_Return, li_NumDWs, li_Count, li_Width, li_X = 1, li_Y = 1, &
         li_NumTrail, li_NumSlide, li_NumBorder
    
idw_Requestor.SetRedraw(False)
    
li_NumDWs = UpperBound(as_Datawindow[])
li_NumTrail = UpperBound(as_TrailFooter[])
li_NumSlide = UpperBound(as_Slide[])
li_NumBorder = UpperBound(abo_Border[])
    
// Build Modify syntax to create the new DataWindow
ls_Version = String(gnv_App.ienv_Object.pbmajorrevision)
ls_Modify = "Release " + ls_Version + ";"
    
ls_Modify = ls_Modify + " datawindow(units=0 color=16777215 processing=5 print.orientation = 0 ) " + &
                        "detail(height=289 color='16777215'  height.autosize=yes) " + &
                        "table(column=(type=char(10) name=a dbname='a' ) unbound = 'yes') "
    
For li_Count = 1 To li_NumDWs
   
   // Add each report to the composite
   idw_Requestor.DataObject = as_Datawindow[li_Count]
   li_Width = of_GetWidth()
   ls_Modify = ls_Modify + " report(band=detail dataobject='" + as_Datawindow[li_Count] + "'" + &
            " x='" + String(li_X) + "' y='" + String(li_Y) + "' height='97' width='" + String(li_Width) + "'" + &
            " height.autosize=yes criteria=''"
    
   If li_Count <= li_NumBorder Then
      Choose Case abo_Border[li_Count]
         Case NoBorder!
            ls_Border = "0"
         Case ShadowBox!
            ls_Border = "1"
         Case Box!
            ls_Border = "2"
         Case ResizeBorder!
            ls_Border = "3"
         Case Underline!
            ls_Border = "4"
         Case Lowered!
            ls_Border = "5"
         Case Raised!
            ls_Border = "6"
      End Choose
   Else
      ls_Border = "0"
   End If
   
   ls_Modify = ls_Modify + " border='" + ls_Border + "'"
   
   If li_Count <= li_NumTrail Then
      If as_TrailFooter[li_Count] = "" Then
         ls_TrailFooter = "yes"
      Else
         ls_TrailFooter = as_TrailFooter[li_Count]
      End if
   Else
      ls_TrailFooter = "yes"
   End if
    
   ls_Modify = ls_Modify + " trail_footer=" + ls_TrailFooter
    
   If ab_Vertical Then
      li_Y = li_Y + 100
    
      If li_Count <= li_NumSlide Then
         If as_Slide[li_Count] = "" Then
            ls_Slide = "AllAbove"
         Else
            ls_Slide = as_Slide[li_Count]
         End if
      Else
         ls_Slide = "AllAbove"
      End if
    
      ls_Modify = ls_Modify + " slideup=" + ls_Slide + ")"
    
   Else
      li_X = li_X + li_Width + 20
    
      If li_Count <= li_NumSlide Then
         If as_Slide[li_Count] = "" Then
            ls_Slide = "yes"
         Else
            ls_Slide = as_Slide[li_Count]
         End if
      Else
         ls_Slide = "yes"
      End if
    
      ls_Modify = ls_Modify + " slideleft=" + ls_Slide + ")"
   End if
Next
    
li_Return = idw_Requestor.Create(ls_Modify)
    
idw_Requestor.SetRedraw(True)
    
Return li_Return
    

end function

on n_cst_dwsrv_report.create
TriggerEvent( this, "constructor" )
end on

on n_cst_dwsrv_report.destroy
TriggerEvent( this, "destructor" )
end on

