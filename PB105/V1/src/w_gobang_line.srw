$PBExportHeader$w_gobang_line.srw
forward
global type w_gobang_line from window
end type
type cb_2 from commandbutton within w_gobang_line
end type
type dw_coordinates from datawindow within w_gobang_line
end type
type sle_1 from singlelineedit within w_gobang_line
end type
type dw_1 from datawindow within w_gobang_line
end type
type cb_1 from commandbutton within w_gobang_line
end type
type st_1 from statictext within w_gobang_line
end type
end forward

global type w_gobang_line from window
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
cb_2 cb_2
dw_coordinates dw_coordinates
sle_1 sle_1
dw_1 dw_1
cb_1 cb_1
st_1 st_1
end type
global w_gobang_line w_gobang_line

type prototypes

end prototypes

type variables
long il_width = 88,il_height =70 //方格尺寸
long il_First = 0 //1白旗，0黑棋 ○ ●
string is_any_name[],is_any_null[]

string is_white = '○',is_black = '●' //棋子
long is_white_color = 16777215,is_black_color = 0 //背景色

long il_size = 15 //15*15
long il_num = 5 //5子相连,胜利条件
boolean ilb_start = true

uo_tip tip
end variables

forward prototypes
public function boolean wf_boolean_column (string as_data)
public subroutine wf_determine_victory ()
public function long wf_retrun_column (string as_name)
public subroutine wf_back ()
public function boolean wf_judge_outcome (integer al_row, string as_name, integer al_qz)
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

public function boolean wf_judge_outcome (integer al_row, string as_name, integer al_qz);//is_any_name
Long ll_i,ll_column
String ls_qz

ll_column = wf_retrun_column(as_name)
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

on w_gobang_line.create
this.cb_2=create cb_2
this.dw_coordinates=create dw_coordinates
this.sle_1=create sle_1
this.dw_1=create dw_1
this.cb_1=create cb_1
this.st_1=create st_1
this.Control[]={this.cb_2,&
this.dw_coordinates,&
this.sle_1,&
this.dw_1,&
this.cb_1,&
this.st_1}
end on

on w_gobang_line.destroy
destroy(this.cb_2)
destroy(this.dw_coordinates)
destroy(this.sle_1)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.st_1)
end on

event open;cb_1.triggerevent(clicked!) 


end event

type cb_2 from commandbutton within w_gobang_line
integer x = 1001
integer y = 40
integer width = 210
integer height = 128
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Back"
end type

event clicked;wf_back()
If il_First = 1 Then
	Parent.BackColor = is_white_color
Else
	Parent.BackColor = is_black_color
End If

end event

type dw_coordinates from datawindow within w_gobang_line
boolean visible = false
integer x = 1842
integer y = 676
integer width = 549
integer height = 320
integer taborder = 30
string title = "none"
string dataobject = "d_coordinates"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type sle_1 from singlelineedit within w_gobang_line
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
string facename = "Tahoma"
long textcolor = 33554432
string text = "20"
end type

type dw_1 from datawindow within w_gobang_line
integer x = 64
integer y = 184
integer width = 1330
integer height = 1412
integer taborder = 20
string title = "none"
boolean border = false
boolean livescroll = true
end type

event clicked;String ls_data,ls_name
Boolean lbl_bool
String ls_text = ''
Long ll_insertrow

This.AcceptText( )

If row > 0 And wf_boolean_column(dwo.Name) And ilb_start Then
	ls_data =  This.GetItemString(row,String(dwo.Name))
	If IsNull(ls_data) Then ls_data = ''
	
	If ls_data <> is_white And ls_data <> is_black Then
		//record chess points
		ll_insertrow = dw_coordinates.InsertRow(0)
		dw_coordinates.Object.a[ll_insertrow] = row
		dw_coordinates.Object.b[ll_insertrow] = wf_retrun_column(dwo.Name)
		dw_coordinates.Object.c[ll_insertrow] = il_First
		
		If il_First = 1 Then
			This.SetItem(row,dwo.Name,is_white)
			lbl_bool = wf_judge_outcome(row,dwo.Name,il_First)
			il_First = 0
			ls_text = 'White wins'
			Parent.BackColor = is_black_color
		Else
			This.SetItem(row,dwo.Name,is_black)
			lbl_bool = wf_judge_outcome(row,dwo.Name,il_First)
			il_First = 1
			ls_text = 'Black wins'
			Parent.BackColor = is_white_color
		End If
		
		//Finish
		If lbl_bool Then
			tip.st_1.Text = ls_text
			OpenUserObject(tip,(Parent.Width/2) - (tip.Width/2),(Parent.Height/2) - (tip.Height/2))
			ilb_start = False
		End If
	End If
End If



end event

type cb_1 from commandbutton within w_gobang_line
integer x = 539
integer y = 40
integer width = 425
integer height = 128
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Start Game"
end type

event clicked;Long ll_count,ll_i
String ls_visible,ls_name,ls_msg,ls_column
Long ll_x,ll_y,ll_width,ll_height,ll_total_width = 0
Long ll_for
Long ll_insertrow
String ls_syntax,ls_err = ''

//initial
dw_1.Reset()
dw_coordinates.Reset()
ilb_start = True
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
ls_syntax = ls_syntax +")"

dw_1.Create(ls_syntax, ls_err)
If Len(ls_err) > 0 Then
	MessageBox('Error', 'Create DW failed! ~r~n' + ls_err)
	Return
End If
dw_1.Object.datawindow.detail.Height = il_height

//Insert square (field)
For ll_for = 1 To il_size
	ll_insertrow = dw_1.InsertRow(0)
	ls_column = 'a_'+String(ll_for)
	
	dw_1.Modify('create column(band=detail id='+String(ll_for)+' alignment="2" tabsequence=32766 border="0" color="33554432" x="'+String(il_width * (ll_for - 1)) +'" y="6" ' +&
		'height="'+String(il_height)+'" width="'+String(il_width)+'" format="[general]" html.valueishtml="0"  name='+ls_column+' visible="1" edit.limit=0 edit.case=any ' +&
		'edit.autoselect=yes edit.imemode=0  font.face="Arial" font.height="-14" font.weight="400"  font.family="2" ' +&
		'font.pitch="2" font.charset="134" background.mode="2" background.color="16777215" )')
Next
//messagebox("",dw_1.Describe("datawindow.syntax"))

//vertical bar
For ll_i = 1 To il_size
	ls_name = is_any_name[ll_i]
	ll_x = Long(dw_1.Describe(ls_name+".x"))
	ll_width = Long(dw_1.Describe(ls_name+".width"))
	ll_total_width = ll_total_width + ll_width
	ll_x = (ll_x+ll_width -3) - (il_width / 2)
	ll_y = il_height / 2
	//subsequent lines
	dw_1.Modify('create line(band=detail x1="'+String(ll_x)+'" x2="'+String(ll_x)+'" '+&
		'y1="0~tif(getrow() = 1,'+String(ll_y)+',0)" y2="'+String(ll_y)+'~tif(getrow() = '+String(il_size)+','+String(ll_y)+','+String(il_height)+')"  name=l_1 visible="1" pen.style="0"'  +&
		'pen.width="4" pen.color="33554432"  background.mode="2" background.color="1073741824")')
Next

//=====================================================================
ll_y = (il_height / 2) + 5
ll_x = il_width / 2
//horizontal line
dw_1.Modify('create line(band=detail y1="'+String(ll_y)+'"  y2="'+String(ll_y)+'" x1="'+String(ll_x)+'"  x2="'+String(ll_total_width - ll_x)+'" name=l_2 visible="1" pen.style="0"'  +&
	'pen.width="4" pen.color="33554432"  background.mode="2" background.color="1073741824")')

dw_1.SetRedraw(True)
dw_1.Object.datawindow.Selected.Mouse = 'No'

dw_1.Width = il_width * il_size
dw_1.Height = (il_height + 1) * il_size
Parent.Width = (il_width * il_size) + PixelsToUnits(dw_1.X,XPixelsToUnits!)
Parent.Height = (il_height * il_size) + 400
Parent.center = True
end event

type st_1 from statictext within w_gobang_line
integer x = 46
integer y = 48
integer width = 174
integer height = 100
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "Size:"
alignment alignment = center!
boolean focusrectangle = false
end type

