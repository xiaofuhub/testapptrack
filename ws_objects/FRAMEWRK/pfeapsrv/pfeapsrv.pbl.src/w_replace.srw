$PBExportHeader$w_replace.srw
$PBExportComments$Extension Replace window
forward
global type w_replace from pfc_w_replace
end type
end forward

global type w_replace from pfc_w_replace
int Height=712
end type
global w_replace w_replace

on w_replace.create
call super::create
end on

on w_replace.destroy
call super::destroy
end on

event open;integer	li_count
integer	li_i
integer	li_adjust

//Make a local copy of attribute nvo-structure
inv_findattrib = message.powerobjectparm

//Allow window to close without the CloseQuery checks being performed.
ib_disableclosequery = True

//////////////////////////////////////////////////////////////////////////////
// Set the Enabled/Visible attributes for the appropriate controls.
//////////////////////////////////////////////////////////////////////////////

//The Whole Word control.
cbx_wholeword.Visible = inv_findattrib.ib_wholewordvisible
cbx_wholeword.Enabled = inv_findattrib.ib_wholewordenabled

//The Match Case control.
cbx_matchcase.Visible = inv_findattrib.ib_matchcasevisible
cbx_matchcase.Enabled = inv_findattrib.ib_matchcaseenabled

//The lookup controls.
ddlb_findwhere.Visible = inv_findattrib.ib_lookvisible
st_findwhere.Visible = inv_findattrib.ib_lookvisible
ddlb_findwhere.Enabled = inv_findattrib.ib_lookenabled
st_findwhere.Enabled = inv_findattrib.ib_lookenabled

//The direction controls.
ddlb_searchdirection.Visible = inv_findattrib.ib_directionvisible
st_searchdirection.Visible = inv_findattrib.ib_directionvisible
ddlb_searchdirection.Enabled = inv_findattrib.ib_directionenabled
st_searchdirection.Enabled = inv_findattrib.ib_directionenabled

//////////////////////////////////////////////////////////////////////////////
// Initialize controls with the appropriate data.
//////////////////////////////////////////////////////////////////////////////

//Set the lookup values.
If ddlb_findwhere.visible Then
	li_count = upperbound(inv_findattrib.is_lookdata)
	// Sort initail list of columns by bubble method
	long ll_index1, ll_index2, ll_prev
	string ls_temp_data, ls_temp_display
	for ll_index1 = 1 to li_count
		ll_prev = 0
		for ll_index2 = 1 to li_count
			if ll_prev > 0 then
				if inv_findattrib.is_lookdisplay[ll_index2] < inv_findattrib.is_lookdisplay[ll_prev] then
					ls_temp_data = inv_findattrib.is_lookdata[ll_index2]
					ls_temp_display = inv_findattrib.is_lookdisplay[ll_index2]
					inv_findattrib.is_lookdata[ll_index2] = inv_findattrib.is_lookdata[ll_prev]
					inv_findattrib.is_lookdisplay[ll_index2] = inv_findattrib.is_lookdisplay[ll_prev]
					inv_findattrib.is_lookdata[ll_prev] = ls_temp_data
					inv_findattrib.is_lookdisplay[ll_prev] = ls_temp_display
				end if
			end if
			ll_prev = ll_index2
		next
	next	
	// Get name of current column
	string ls_current
	n_cst_dwsrv_find lnv_find
	lnv_find = inv_findattrib.ipo_requestor
	lnv_find.of_GetDW( idw_active )
	ls_current = idw_active.Describe( "#" + string( idw_active.GetColumn( ) ) + ".Name" )
	// Fill in ddlb and remember current column index in inv_findattrib.is_lookdata[] array
	long ll_current = 0
	if li_count >0  THEN 
		for li_i=1 TO li_count
			ddlb_findwhere.additem(inv_findattrib.is_lookdisplay[li_i])
			if inv_findattrib.is_lookdata[li_i] = ls_current then ll_current = li_i
		next
	end if
	// Set DDLB current item syncronized with active column
	if ll_current > 0 then ddlb_findwhere.SelectItem( ll_current )
End If

//Set text to Find What.
sle_findwhat.text = inv_findattrib.is_find

//Set the text to replace with.
sle_replace.text = inv_findattrib.is_replacewith

//Set the WholeWord flag.
If cbx_wholeword.Visible Then
	cbx_wholeword.Checked = inv_findattrib.ib_wholeword
End If

//Set the MatchCase flag.
If cbx_matchcase.Visible Then
	cbx_matchcase.Checked = inv_findattrib.ib_matchcase
End If	

//Set the Direction attribute.
If ddlb_searchdirection.visible Then
	If Lower(inv_findattrib.is_direction)= 'up' Then
		ddlb_searchdirection.Text = 'Up'
	Else
		ddlb_searchdirection.Text = 'Down'
	End If
End If

//////////////////////////////////////////////////////////////////////////////
// Resize window and Move controls, if appropriate.
//////////////////////////////////////////////////////////////////////////////

//If the lookup controls are not visible, moving of other controls is required.
if ddlb_findwhere.visible = False then
	// calculate Y position to adjust.
	li_adjust = sle_findwhat.y - ddlb_findwhere.y

	//Move Controls up
	cbx_matchcase.y = cbx_matchcase.y - li_adjust
	cbx_wholeword.y = cbx_wholeword.y - li_adjust
	st_searchdirection.y = st_searchdirection.y - li_adjust	
	ddlb_searchdirection.y = ddlb_searchdirection.y - li_adjust
	st_replace.y = st_replace.y - li_adjust	
	sle_replace.y = sle_replace.y  - li_adjust
	st_findwhat.y = st_findwhat.y - li_adjust	
	sle_findwhat.y = sle_findwhat.y - li_adjust
	
	//Set focus on the appropriate control.
	sle_findwhat.setfocus()
end if

//If the wholeword is not visible, move the matchase control.
If cbx_wholeword.visible = False and cbx_matchcase.Visible Then
	cbx_matchcase.Y = cbx_wholeword.Y
End If

//If all bottom conrols are not visible, adjust the size of the window.
If ddlb_searchdirection.Visible=False And cbx_wholeword.visible = False And &
	cbx_matchcase.Visible= False Then
End If
end event

event pfc_default;call super::pfc_default;this.SetFocus( )
end event

type ddlb_findwhere from pfc_w_replace`ddlb_findwhere within w_replace
int Height=948
end type

type cb_findnext from pfc_w_replace`cb_findnext within w_replace
boolean Default=true
end type

