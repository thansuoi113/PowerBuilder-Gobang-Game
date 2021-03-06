$PBExportHeader$w_gobang_zl.srw
forward
global type w_gobang_zl from window
end type
type cbx_1 from checkbox within w_gobang_zl
end type
type cb_3 from commandbutton within w_gobang_zl
end type
type cb_2 from commandbutton within w_gobang_zl
end type
type dw_coordinates from datawindow within w_gobang_zl
end type
type sle_1 from singlelineedit within w_gobang_zl
end type
type dw_1 from datawindow within w_gobang_zl
end type
type cb_1 from commandbutton within w_gobang_zl
end type
type st_1 from statictext within w_gobang_zl
end type
end forward

global type w_gobang_zl from window
integer width = 4590
integer height = 3084
boolean titlebar = true
string title = "Gobang Game"
boolean controlmenu = true
boolean minbox = true
boolean resizable = true
long backcolor = 16777215
string icon = "AppIcon!"
boolean center = true
cbx_1 cbx_1
cb_3 cb_3
cb_2 cb_2
dw_coordinates dw_coordinates
sle_1 sle_1
dw_1 dw_1
cb_1 cb_1
st_1 st_1
end type
global w_gobang_zl w_gobang_zl

type prototypes

end prototypes

type variables
Long il_width = 90, il_height = 75 //square size
String is_any_name[],is_any_null[]
Long il_First = 0 //1 white flag, 0 black ○ ●
String is_white = '○',is_black = '●' //chess pieces
Long is_white_color = 16777215,is_black_color = 0 //background color

Long il_size = 15 //15*15
Long il_num = 5 //5 children are connected, victory condition
Boolean ilb_start = True

uo_tip tip

Long il_x, il_y, il_num_new = 0

end variables

forward prototypes
public function boolean wf_boolean_column (string as_data)
public subroutine wf_determine_victory ()
public function long wf_retrun_column (string as_name)
public subroutine wf_back ()
public subroutine wf_computer ()
public function integer wf_gz (integer al_i, integer al_j, string as_msg, string as_bs)
public function boolean wf_judge_outcome (integer al_row, long al_column, integer al_qz)
public subroutine wf_partition (integer al_i, integer al_j, string as_msg, string as_bs)
end prototypes

public function boolean wf_boolean_column (string as_data);//Check if column exists
Boolean lbl_bool = False

Long ll_count,ll_i

ll_count = Long(dw_1.Describe("DataWindow.Column.Count"))

For ll_i = 1 To UpperBound(is_any_name)
	If as_data = is_any_name[ll_i] Then Return True
Next

Return False

end function

public subroutine wf_determine_victory ();
end subroutine

public function long wf_retrun_column (string as_name);//reverse serial number
Long ll_i,ll_column = 0

For ll_i = 1 To UpperBound(is_any_name)
	If as_name = is_any_name[ll_i] Then
		ll_column = ll_i
		Exit
	End If
Next

Return ll_column

end function

public subroutine wf_back ();//regret
Long ll_rowcount
Long ll_row,ll_column,ll_First

ll_rowcount = dw_coordinates.RowCount()

If ll_rowcount > 0 Then
	ll_row = dw_coordinates.Object.a[ll_rowcount]
	ll_column = dw_coordinates.Object.b[ll_rowcount]
	ll_First = dw_coordinates.Object.c[ll_rowcount]
	
	dw_1.SetItem(ll_row,ll_column,'')
	il_First = ll_First
	
	dw_coordinates.DeleteRow(ll_rowcount)
End If







end subroutine

public subroutine wf_computer ();//computer
//To judge whether it can be 5, if it is the machine side, give 100000 points, if it is the human side, give 100000 points;
//Determine whether it can survive 4 or die 4 or die 4 live 3, if it is the machine side, give 10000 points, if it is the human side, give 10000 points;
//Determine whether it has become dual-active 3, if it is the machine side, give 5000 points, if it is the human side, give 5000 points;
//Determine whether it is dead or alive 3 (advanced), if it is a machine side, give 1000 points, if it is a human side, give 1000 points;
//Determine whether it can become a death 4, if it is a machine side, give 500 points, if it is a human side, give 500 points;
//Judging whether it can become a low-level death 4, if it is a machine side, give 400 points, if it is a human side, give 400 points;
//Determine whether it can be a single job 3, if it is a machine side, give 100 points, if it is a human side, give 100 points;
//Determine whether it can become a jump 3, if it is a machine side, give 90 points, if it is a human side, give 90 points;
//Determine whether it can be double-live 2, if it is a machine side, give 50 points, if it is a human side, give 50 points;
//Determine whether it can survive 2, if it is the machine side, give 10 points, if it is the human side, give 10 points;
//Judging whether it can be a low-level job 2, if it is a machine side, give 9 points, if it is a human side, give 9 points;
//Determine whether it can be dead 3, if it is the machine side, give 5 points, if it is the human side, give 5 points;
//Determine whether it can become a death 2, if it is a machine side, give 2 points, if it is a human side, give 2 points.
//Determine whether there are other situations (nothing), if it is a machine side, give 1 point, if it is a human side, give 1 point.
//==================================================== =========================================

Long ll_i,ll_j,ll_for
String ls_con
Long ll_row,ll_column
Long ll_row_two,ll_column_two
String ls_pieces = ''
Boolean lb_bool,lb_bool_two
Long ll_num = 0,ll_num_new = 0
String ls_arr[]
Long ll_x,ll_y

il_x = 0
il_y = 0
il_num_new = 0

For ll_i = 1 To il_size //Row
	For ll_j = 1 To il_size //Column
		ls_con = dw_1.GetItemString(ll_i,ll_j)
		If IsNull(ls_con) Then ls_con = ''
		If ls_con <> '' Then Continue;
		wf_gz(ll_i,ll_j,ls_con,'z')
		wf_gz(ll_i,ll_j,ls_con,'y')
		wf_gz(ll_i,ll_j,ls_con,'s')
		wf_gz(ll_i,ll_j,ls_con,'x')
		wf_gz(ll_i,ll_j,ls_con,'zs')
		wf_gz(ll_i,ll_j,ls_con,'zx')
		wf_gz(ll_i,ll_j,ls_con,'ys')
		wf_gz(ll_i,ll_j,ls_con,'yx')
		
	Next
Next

//dw_1.setitem(il_x,il_y,'○')


end subroutine

public function integer wf_gz (integer al_i, integer al_j, string as_msg, string as_bs);Long ll_for,ll_num = 0,ll_j,ll_i
String ls_con,ls_pieces
Long ll_column,ll_row

ll_i = al_i
ll_j = al_j

ll_column = al_j
ls_con = as_msg
ls_pieces = ''
ll_num = 0

For ll_for = 1 To 5
	If as_bs = 'z' Then
		ll_row = al_i
		ll_column = ll_j - ll_for
		If ll_column <= 0 Then Continue;
	ElseIf as_bs = 'y' Then
		ll_row = al_i
		ll_column = ll_j + ll_for
		If ll_column > il_size Then Continue;
	ElseIf as_bs = 's' Then
		ll_row = al_i - ll_for
		ll_column = ll_j
		If ll_row <= 0 Then Continue;
	ElseIf as_bs = 'x' Then
		ll_row = al_i + ll_for
		ll_column = ll_j
		If ll_row > il_size Then Continue;
		
	ElseIf as_bs = 'zs' Then
		ll_row = al_i - ll_for
		ll_column = ll_j - ll_for
		If ll_row <= 0 Then Continue;
		If ll_column <= 0 Then Continue;
	ElseIf as_bs = 'yx' Then
		ll_row = al_i + ll_for
		ll_column = ll_j + ll_for
		If ll_row > il_size Then Continue;
		If ll_column > il_size Then Continue;
	ElseIf as_bs = 'ys' Then
		ll_row = al_i - ll_for
		ll_column = ll_j + ll_for
		If ll_row <= 0 Then Continue;
		If ll_column > il_size Then Continue;
	ElseIf as_bs = 'zx' Then
		ll_row = al_i + ll_for
		ll_column = ll_j - ll_for
		If ll_row > il_size Then Continue;
		If ll_column <= 0 Then Continue;
	End If
	
	ls_con = dw_1.GetItemString(ll_row,ll_column)
	If IsNull(ls_con) Then ls_con = ''
	If ls_con = '' And ll_for = 1 Then Exit
	
	If ll_for = 1 Then
		ls_pieces = ls_con
		ll_num = 20 // die one
	Else
		If ll_for = 2 And ls_con = '' Then
			ll_num = 40 //live one
		ElseIf ll_for = 3 And ls_con = '' Then
			ll_num = 400 //live two
		ElseIf ll_for = 4 And ls_con = '' Then
			ll_num = 3000 //live three
		ElseIf ll_for = 5 And ls_con = '' Then
			ll_num = 10000 //live four
		Else
			If ls_pieces = ls_con Then
				If ll_for = 2 Then ll_num = 200 //die two
				If ll_for = 3 Then ll_num = 500 //die three
				If ll_for = 4 Then ll_num = 6000 //die four
			Else
				Exit
			End If
		End If
	End If
	
	If il_num_new <= ll_num Then
		il_num_new = ll_num
		il_x = ll_i
		il_y = ll_j
	End If
	If ls_con = '' And ll_for <> 1 Then Exit
Next

Return il_num_new


end function

public function boolean wf_judge_outcome (integer al_row, long al_column, integer al_qz);//is_any_name
Long ll_i,ll_column
String ls_qz

ll_column = al_column //wf_retrun_column(as_name)
// ● ○ 
If al_qz = 1 Then
	ls_qz = is_white
Else
	ls_qz = is_black
End If


Long ll_for
Long ll_top,ll_below
Long ll_left,ll_right
Long ll_number = 1
Boolean lbl_bool_one = True,lbl_bool_two = True
//up and down
For ll_for = 1 To il_num - 1
	ll_top = al_row - ll_for
	If ll_top > 0 Then
		If lbl_bool_one And dw_1.GetItemString(ll_top,ll_column) = ls_qz Then
			ll_number = ll_number + 1
		Else
			lbl_bool_one = False
		End If
	End If
	
	ll_below = al_row + ll_for
	If ll_below <= dw_1.RowCount() Then
		If lbl_bool_two And dw_1.GetItemString(ll_below,ll_column) = ls_qz Then
			ll_number = ll_number + 1
		Else
			lbl_bool_two = False
		End If
	End If
	
	If ll_number >= il_num Then
		Return True
	End If
Next


ll_number = 1
lbl_bool_one = True
lbl_bool_two = True

//left and right
For ll_for = 1 To il_num - 1
	ll_left = ll_column - ll_for
	If ll_left > 0 Then
		If lbl_bool_one And dw_1.GetItemString(al_row,ll_left) = ls_qz Then
			ll_number = ll_number + 1
		Else
			lbl_bool_one = False
		End If
	End If
	
	ll_right = ll_column + ll_for
	If ll_right <= il_size Then
		If lbl_bool_two And dw_1.GetItemString(al_row,ll_right) = ls_qz Then
			ll_number = ll_number + 1
		Else
			lbl_bool_two = False
		End If
	End If
	
	If ll_number >= il_num Then
		Return True
	End If
Next



ll_number = 1
lbl_bool_one = True
lbl_bool_two = True

//left top right bottom
For ll_for = 1 To il_num -1
	ll_top = al_row - ll_for
	ll_left = ll_column - ll_for
	If ll_left > 0 And ll_top > 0 Then
		If lbl_bool_one And dw_1.GetItemString(ll_top,ll_left) = ls_qz Then
			ll_number = ll_number + 1
		Else
			lbl_bool_one = False
		End If
	End If
	
	ll_top = al_row + ll_for
	ll_right = ll_column + ll_for
	If ll_right <= il_size And ll_top <= dw_1.RowCount() Then
		If lbl_bool_two And dw_1.GetItemString(ll_top,ll_right) = ls_qz Then
			ll_number = ll_number + 1
		Else
			lbl_bool_two = False
		End If
	End If
	
	If ll_number >= il_num Then
		Return True
	End If
Next

ll_number = 1
lbl_bool_one = True
lbl_bool_two = True

//Bottom left top right
For ll_for = 1 To il_num - 1
	ll_top = al_row + ll_for
	ll_left = ll_column - ll_for
	If ll_left > 0 And ll_top <= dw_1.RowCount() Then
		If lbl_bool_one And dw_1.GetItemString(ll_top,ll_left) = ls_qz Then
			ll_number = ll_number + 1
		Else
			lbl_bool_one = False
		End If
	End If
	ll_top = al_row - ll_for
	ll_right = ll_column + ll_for
	
	If ll_right <= il_size And ll_top > 0 Then
		If lbl_bool_two And dw_1.GetItemString(ll_top,ll_right) = ls_qz Then
			ll_number = ll_number + 1
		Else
			lbl_bool_two = False
		End If
	End If
	
	If ll_number >= il_num Then
		Return True
	End If
Next

Return False

end function

public subroutine wf_partition (integer al_i, integer al_j, string as_msg, string as_bs);//
Long ll_for,ll_num = 0,ll_j,ll_i
String ls_con,ls_pieces
Long ll_column,ll_row


ll_i = al_i
ll_j = al_j

ll_column = al_j
ls_con = as_msg
ls_pieces = ''
ll_num = 0

For ll_for = 1 To 5
	If as_bs = 'z' Then
		ll_row = al_i
		ll_column = ll_j - ll_for
		If ll_column <= 0 Then Continue;
	End If
	
	ls_con = dw_1.GetItemString(ll_row,ll_column)
	If IsNull(ls_con) Then ls_con = ''
	If ls_con = '' And ll_for = 1 Then Exit
	
	If ll_for = 1 Then
		ls_pieces = ls_con
		ll_num = 20 // die one
	Else
		If ll_for = 2 And ls_con = '' Then
			ll_num = 40 //live one
		ElseIf ll_for = 3 And ls_con = '' Then
			ll_num = 400 //live two
		ElseIf ll_for = 4 And ls_con = '' Then
			ll_num = 3000 //live three
		ElseIf ll_for = 5 And ls_con = '' Then
			ll_num = 10000 //live four
		Else
			If ls_pieces = ls_con Then
				If ll_for = 2 Then ll_num = 200 //die two
				If ll_for = 3 Then ll_num = 500 //die three
				If ll_for = 4 Then ll_num = 6000 //die four
			Else
				Exit
			End If
		End If
	End If
	
	If il_num_new <= ll_num Then
		il_num_new = ll_num
		il_x = ll_i
		il_y = ll_j
	End If
	If ls_con = '' And ll_for <> 1 Then Exit
Next



end subroutine

on w_gobang_zl.create
this.cbx_1=create cbx_1
this.cb_3=create cb_3
this.cb_2=create cb_2
this.dw_coordinates=create dw_coordinates
this.sle_1=create sle_1
this.dw_1=create dw_1
this.cb_1=create cb_1
this.st_1=create st_1
this.Control[]={this.cbx_1,&
this.cb_3,&
this.cb_2,&
this.dw_coordinates,&
this.sle_1,&
this.dw_1,&
this.cb_1,&
this.st_1}
end on

on w_gobang_zl.destroy
destroy(this.cbx_1)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.dw_coordinates)
destroy(this.sle_1)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.st_1)
end on

event open;cb_1.triggerevent(clicked!) 


end event

type cbx_1 from checkbox within w_gobang_zl
integer x = 1253
integer y = 48
integer width = 567
integer height = 92
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Machine Battle"
end type

type cb_3 from commandbutton within w_gobang_zl
integer x = 1902
integer y = 24
integer width = 457
integer height = 128
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;wf_computer()
il_First = 0
end event

type cb_2 from commandbutton within w_gobang_zl
integer x = 1001
integer y = 40
integer width = 229
integer height = 128
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Back"
end type

event clicked;wf_back()
If il_First = 1 Then
	Parent.BackColor = is_white_color
Else
	Parent.BackColor = is_black_color
End If

end event

type dw_coordinates from datawindow within w_gobang_zl
boolean visible = false
integer x = 1586
integer y = 444
integer width = 1417
integer height = 612
integer taborder = 30
string title = "none"
string dataobject = "d_coordinates"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type sle_1 from singlelineedit within w_gobang_zl
integer x = 242
integer y = 52
integer width = 256
integer height = 96
integer taborder = 30
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "20"
end type

type dw_1 from datawindow within w_gobang_zl
integer x = 64
integer y = 184
integer width = 1330
integer height = 1412
integer taborder = 20
string title = "none"
boolean border = false
boolean livescroll = true
end type

event clicked;

String ls_data,ls_name
Boolean lbl_bool
String ls_text = ''
Long ll_insertrow,ll_for
Long ll_column,ll_row

This.AcceptText( )

If row > 0 And wf_boolean_column(dwo.Name) And ilb_start Then
	ls_data =  This.GetItemString(row,String(dwo.Name))
	If IsNull(ls_data) Then ls_data = ''
	
	If ls_data <> is_white And ls_data <> is_black Then
		ll_column = wf_retrun_column(dwo.Name)
		ll_row = row
		
		//Man-machine white chess
		If il_First = 1 And cbx_1.Checked Then
			wf_computer()
			ll_row = il_x
			ll_column = il_y
		End If
		
		//record chess points
		ll_insertrow = dw_coordinates.InsertRow(0)
		dw_coordinates.Object.a[ll_insertrow] = ll_row
		dw_coordinates.Object.b[ll_insertrow] = ll_column
		dw_coordinates.Object.c[ll_insertrow] = il_First
		
		//Show red dot
		For ll_for = 1 To dw_1.RowCount()
			dw_1.Object.pd[ll_for] = 0
		Next
		dw_1.SetItem(ll_row,'pd',ll_column)
		
		If il_First = 1 Then
			This.SetItem(ll_row,ll_column,is_white)
			lbl_bool = wf_judge_outcome(ll_row,ll_column,il_First)
			il_First = 0
			ls_text = 'White wins'
			Parent.BackColor = is_black_color
		Else
			This.SetItem(ll_row,ll_column,is_black)
			lbl_bool = wf_judge_outcome(ll_row,ll_column,il_First)
			il_First = 1
			ls_text = 'Black wins'
			Parent.BackColor = is_white_color
		End If
		
		//Finish
		If lbl_bool Then
			tip.st_1.Text = ls_text
			OpenUserObject(tip,(Parent.Width/2) - (tip.Width/2),(Parent.Height/2) - (tip.Height/2))
			ilb_start = False
			Return
		End If
		
		If il_First = 1 And cbx_1.Checked Then
			This.Event Clicked(1,1,1, dw_1.Object.a_1)
		End If
	End If
End If



end event

type cb_1 from commandbutton within w_gobang_zl
integer x = 539
integer y = 40
integer width = 430
integer height = 128
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Start Game"
end type

event clicked;Long ll_count,ll_i
String ls_visible,ls_name,ls_msg,ls_column
Long ll_x,ll_y,ll_width,ll_height,ll_total_width = 0
Long ll_for
Long ll_insertrow
String ls_syntax,ls_err = ''


//initial
il_x = 0
il_y = 0
il_num_new = 0
//=======================
dw_1.Reset()
dw_coordinates.Reset()
ilb_start = True
il_First = 0
is_any_name = is_any_null
il_size = Long(sle_1.Text)
Parent.CloseUserObject(tip)
tip = Create uo_tip
If il_First = 1 Then
	Parent.BackColor = is_white_color
Else
	Parent.BackColor = is_black_color
End If

dw_1.SetRedraw( False)


//Create DW
ls_syntax = "release 10.5;~r~n" +&
	"table("
For ll_for = 1 To il_size
	ls_column = 'a_'+String(ll_for)
	is_any_name[UpperBound(is_any_name) + 1] = ls_column
	ls_syntax =  ls_syntax +'column=(type=char(10) updatewhereclause=no name='+ls_column+' dbname="'+ls_column+'" )~r~n'
Next
ls_syntax =  ls_syntax +'column=(type=number updatewhereclause=no name=pd dbname="pd" )~r~n'
ls_syntax = ls_syntax +")"

dw_1.Create(ls_syntax, ls_err)
If Len(ls_err) > 0 Then
	MessageBox('Error', 'Create DW failed! ~r~n' + ls_err)
	Return
End If
dw_1.Object.datawindow.detail.Height = il_height
dw_1.Object.datawindow.Header.Height = il_height


//Insert square (field)
For ll_for = 1 To il_size
	ll_insertrow = dw_1.InsertRow(0)
	ls_column = 'a_'+String(ll_for)
	ll_x = il_width * (ll_for - 1) +il_width
	dw_1.Modify('create column(band=detail id='+String(ll_for)+' alignment="2" tabsequence=32766 border="0" color="33554432~tif (pd = '+String(ll_for)+',255,0)" x="'+String(ll_x) +'" y="6" ' +&
		'height="'+String(il_height)+'" width="'+String(il_width)+'" format="[general]" html.valueishtml="0"  name='+ls_column+' visible="1" edit.limit=0 edit.case=any ' +&
		'edit.autoselect=yes edit.imemode=0  font.face="Arial" font.height="-14" font.weight="400"  font.family="2" ' +&
		'font.pitch="2" font.charset="134" background.mode="0" background.color="553648127" )') //~tif (pd = '+string(ll_for)+',255,553648127)
Next
//messagebox("",dw_1.Describe("datawindow.syntax"))

//vertical bar
ll_x = 0
For ll_i = 1 To il_size
	ls_name = is_any_name[ll_i]
	ll_x = Long(dw_1.Describe(ls_name+".x"))
	ll_width = Long(dw_1.Describe(ls_name+".width"))
	ll_total_width = ll_total_width + ll_width
	
	ll_x = (ll_x+ll_width -3) - (il_width / 2)
	ll_y = (il_height / 2 ) + 8
	//subsequent lines
	dw_1.Modify('create line(band=detail x1="'+String(ll_x)+'" x2="'+String(ll_x)+'" '+&
		'y1="0~tif(getrow() = 1,'+String(ll_y)+',0)" y2="'+String(ll_y)+'~tif(getrow() = '+String(il_size)+','+String(ll_y)+','+String(il_height)+')"  name=l_1 visible="1" pen.style="0"'  +&
		'pen.width="4" pen.color="33554432"  background.mode="2" background.color="1073741824")')
	
	
Next


ll_y = (il_height / 2) + 5
ll_x = (il_width / 2) + il_width
ll_total_width = ll_total_width + ll_width + ll_width
//horizontal line
dw_1.Modify('create line(band=detail y1="'+String(ll_y)+'"  y2="'+String(ll_y)+'" x1="'+String(ll_x)+'"  x2="'+String(ll_total_width - ll_x )+'" name=l_2 visible="1" pen.style="0"'  +&
	'pen.width="4" pen.color="33554432"  background.mode="2" background.color="1073741824")')

// //increase serial number
dw_1.Modify("create compute(band=Detail"  +  &
	" color='0' alignment='2' border='0'" + &
	" x='0' y='0' height='"+String(il_height)+"' width='"+String(il_width)+"'" + &
	" name=serial  expression='getrow()' " + &
	" font.height='-12' font.face='Arial' background.mode='2' background.color='16777215')")

ll_x = 0
For ll_i = 1 To il_size
	dw_1.Modify("create text(band=Header"  +  &
		"  alignment='2' border='0'"  +  &
		"  x='"+String(ll_x+il_width)+"' y='"+String(0)+"' height='"+String(il_height)+"' width='"+String(il_width)+"'  text='"+String(ll_i)+"' name=t_serialnumber "  +  &
		"  font.height='-12' font.face='Arial' background.mode='2' background.color='16777215')")
	ll_x = ll_x + il_width
Next

dw_1.SetRedraw(True)
dw_1.Object.datawindow.Selected.Mouse = 'No'

dw_1.Width = il_width * il_size + il_width
dw_1.Height = ((il_height + 1) * il_size)  + il_height
Parent.Width = dw_1.Width  + PixelsToUnits(dw_1.X,XPixelsToUnits!)
Parent.Height = dw_1.Height + 400 // 
Parent.center = True




end event

type st_1 from statictext within w_gobang_zl
integer x = 69
integer y = 52
integer width = 160
integer height = 104
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "size:"
alignment alignment = center!
boolean focusrectangle = false
end type

