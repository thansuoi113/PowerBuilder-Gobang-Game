$PBExportHeader$w_gobang.srw
forward
global type w_gobang from window
end type
type mle_1 from multilineedit within w_gobang
end type
type cb_5 from commandbutton within w_gobang
end type
type cb_4 from commandbutton within w_gobang
end type
type cb_3 from commandbutton within w_gobang
end type
type st_scrolling from statictext within w_gobang
end type
type rb_middlerank from radiobutton within w_gobang
end type
type rb_primary from radiobutton within w_gobang
end type
type rb_1 from radiobutton within w_gobang
end type
type dw_weight from datawindow within w_gobang
end type
type cb_2 from commandbutton within w_gobang
end type
type dw_coordinates from datawindow within w_gobang
end type
type sle_1 from singlelineedit within w_gobang
end type
type cb_1 from commandbutton within w_gobang
end type
type st_1 from statictext within w_gobang
end type
type dw_1 from datawindow within w_gobang
end type
end forward

global type w_gobang from window
integer width = 2505
integer height = 1820
boolean titlebar = true
string title = "Gobang Game"
boolean controlmenu = true
boolean minbox = true
boolean resizable = true
long backcolor = 16777215
string icon = "AppIcon!"
boolean center = true
mle_1 mle_1
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
st_scrolling st_scrolling
rb_middlerank rb_middlerank
rb_primary rb_primary
rb_1 rb_1
dw_weight dw_weight
cb_2 cb_2
dw_coordinates dw_coordinates
sle_1 sle_1
cb_1 cb_1
st_1 st_1
dw_1 dw_1
end type
global w_gobang w_gobang

type prototypes

end prototypes

type variables
Long il_width = 100, il_height = 85 //square size
String is_any_name[],is_any_null[]
Long il_First = 2 //1 white, 2 black ○ ●
String is_white = '○',is_black = '●' //chess pieces
Long is_white_color = 16777215,is_black_color = 0 //background color

Long il_size = 15 //15*15
Long il_num = 5 //5 children are connected, victory condition
Boolean ilb_start = False

uo_tip tip

Long il_x, il_y, il_num_new = 0

end variables

forward prototypes
public subroutine wf_determine_victory ()
public function long wf_retrun_column (string as_name)
public subroutine wf_computer ()
public function boolean wf_estimate_fiveeven (integer al_row, long al_column, string as_chess)
public function long wf_choose (string as_pieces)
public function long wf_unionweight (integer a, integer b)
public subroutine wf_computer_primary (string as_bs)
public subroutine wf_computer_middlerank ()
public subroutine wf_draw_checkerboard ()
public function boolean wf_where_column (string as_data)
public subroutine wf_switch_st_scrolling ()
public subroutine wf_button_enabled (boolean as_bool)
public function integer wf_z_demo2 ()
public function long wf_z_alphabeta (long player, long alpha, long beta, long depth)
public function integer wf_z_demo2_3 (string as_bs)
end prototypes

public subroutine wf_determine_victory ();
end subroutine

public function long wf_retrun_column (string as_name);//====================================================================
// Function: w_gobang.wf_retrun_column()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	string	as_name	
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2022/01/14
//--------------------------------------------------------------------
// Usage: w_gobang.wf_retrun_column ( string as_name )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

//reverse serial number
Long ll_i,ll_column = 0

For ll_i = 1 To UpperBound(is_any_name)
	If as_name = is_any_name[ll_i] Then
		ll_column = ll_i
		Exit
	End If
Next

Return ll_column

end function

public subroutine wf_computer ();//====================================================================
// Function: w_gobang.wf_computer()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2022/01/14
//--------------------------------------------------------------------
// Usage: w_gobang.wf_computer ( )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

//computer
Long ll_i,ll_j,ll_for
String ls_con
Long ll_row,ll_column,ll_number,ll_max_number
Long ll_row_two,ll_column_two
String ls_pieces = ''
Boolean lb_bool,lb_bool_two
Long ll_num = 0,ll_num_new = 0
String ls_arr[]
Long ll_x,ll_y

il_x = 0
il_y = 0
il_num_new = 0

//reset dw
For ll_i = 1 To il_size //Row
	For ll_j = 1 To il_size //vertical	
		dw_weight.SetItem(ll_i,ll_j,'0')
	Next
Next

Randomize(0)


//Man-machine level
If rb_primary.Checked Then
	wf_computer_middlerank()
	//	if rand(2) = 1 then
	//		wf_computer_primary('z')
	//		wf_computer_primary('y')
	//		wf_computer_primary('s')
	//		wf_computer_primary('x')
	//		wf_computer_primary('zs')
	//		wf_computer_primary('zx')
	//		wf_computer_primary('ys')
	//		wf_computer_primary('yx')
	//	else
	//		wf_computer_middlerank()
	//	end if
ElseIf rb_middlerank.Checked Then
	//wf_computer_middlerank()
End If


//loop for maximum value
For ll_i = 1 To il_size //Row
	For ll_j = 1 To il_size //vertical	
		ll_number = Long(dw_weight.GetItemString(ll_i,ll_j))
		If ll_number >= ll_max_number Then
			ll_max_number = ll_number
			il_x = ll_i
			il_y = ll_j
		End If
		//mle_1.text = mle_1.text +'~r~n' +string(ll_i)+':' +string(ll_j)+':' + string(ll_number)
		
	Next
Next

end subroutine

public function boolean wf_estimate_fiveeven (integer al_row, long al_column, string as_chess);//====================================================================
// Function: w_gobang.wf_estimate_fiveeven()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	integer	al_row   	
// 	long   	al_column	
// 	string 	as_chess 	
//--------------------------------------------------------------------
// Returns:  boolean
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2022/01/14
//--------------------------------------------------------------------
// Usage: w_gobang.wf_estimate_fiveeven ( integer al_row, long al_column, string as_chess )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

//is_any_name
//Determine whether the same piece is five in a row in a diagonal form

Long ll_i,ll_column
String ls_qz
Long ll_for
Long ll_top,ll_below
Long ll_left,ll_right
Long ll_number = 1
Boolean lbl_bool_one = True,lbl_bool_two = True
Long ll_Array_row[],ll_Array_column[]
Boolean lb_bool = False

ll_column = al_column
ls_qz = as_chess

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

public function long wf_choose (string as_pieces);//====================================================================
// Function: w_gobang.wf_choose()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	string	as_pieces	
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2022/01/14
//--------------------------------------------------------------------
// Usage: w_gobang.wf_choose ( string as_pieces )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Long ll_num
//Weight table
Choose Case as_pieces
	Case '02'
		ll_num = 25
	Case '01'
		ll_num = 22
	Case '002'
		ll_num = 17
	Case '001'
		ll_num = 12
	Case '0002'
		ll_num = 17
	Case '0001'
		ll_num = 12
		
	Case '0201'
		ll_num = 25
	Case '0102'
		ll_num = 22
	Case '0021'
		ll_num = 15
	Case '0012'
		ll_num = 10
	Case '02001'
		ll_num = 19
	Case '01002'
		ll_num = 22
	Case '00201'
		ll_num = 17
	Case '00102'
		ll_num = 12
	Case '00021'
		ll_num = 15
	Case '00012'
		ll_num = 10
		
	Case '02000'
		ll_num = 25
	Case '01000'
		ll_num = 22
	Case '00200'
		ll_num = 19
	Case '00100'
		ll_num = 14
	Case '00020'
		ll_num = 17
	Case '00010'
		ll_num = 12
	Case '00002'
		ll_num = 15
	Case '00001'
		ll_num = 10
		
	Case '0202'
		ll_num = 65
	Case '0101'
		ll_num = 60
	Case '0220'
		ll_num = 80
	Case '0110'
		ll_num = 76
	Case '022'
		ll_num = 80
	Case '011'
		ll_num = 76
	Case '0022'
		ll_num = 65
	Case '0011'
		ll_num = 60
		
	Case '02021'
		ll_num = 65
	Case '01012'
		ll_num = 60
	Case '02201'
		ll_num = 80
	Case '01102'
		ll_num = 76
	Case "01120"
		ll_num = 76
	Case "02210"
		ll_num = 80
	Case '00221'
		ll_num = 65
	Case '00112'
		ll_num = 60
		
	Case '02200'
		ll_num = 80
	Case '01100'
		ll_num = 76
	Case '02020'
		ll_num = 75
	Case '01010'
		ll_num = 70
	Case '00220'
		ll_num = 75
	Case '00110'
		ll_num = 70
	Case '00022'
		ll_num = 75
	Case '00011'
		ll_num = 70
		
		
	Case '0222'
		ll_num = 150
	Case '0111'
		ll_num = 140
		
	Case '02221'
		ll_num = 150
	Case '01112'
		ll_num = 140
		
	Case '02220'
		ll_num = 1100
	Case '01110'
		ll_num = 1050
	Case '02202'
		ll_num = 1000
	Case '01101'
		ll_num = 800
	Case '02022'
		ll_num = 1000
	Case '01011'
		ll_num = 800
		
	Case '02222'
		ll_num = 3000
	Case '01111'
		ll_num = 3500
	Case '11011' //,'10111','11101','11110'
		ll_num = 3500
	Case Else
		ll_num = 0
End Choose
Return ll_num

end function

public function long wf_unionweight (integer a, integer b);//====================================================================
// Function: w_gobang.wf_unionweight()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	integer	a	
// 	integer	b	
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2022/01/14
//--------------------------------------------------------------------
// Usage: w_gobang.wf_unionweight ( integer a, integer b )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

If(IsNull(a) Or IsNull(b)) Then
Return 0;

//one by one:101/202
ElseIf((a >= 22) And (a <= 25) And (b >= 22) And (b <= 25)) Then
Return 60

//one two, two one:1011/2022
ElseIf(((a >= 22) And (a <= 25) And (b >= 76) And (b <= 80)) Or ((a >= 76) And (a <= 80) And (b >= 22) And (b <= 25))) Then
Return 800;

//One three, three one, two two:10111/20222
ElseIf(((a >= 10) And (a <= 25) And (b >= 1050) And (b <= 1100)) Or ((a >= 1050) And (a <= 1100) And (b >= 10) And (b <= 25)) Or ((a >= 76) And (a <= 80) And (b >= 76) And (b <= 80))) Then

Return 3000;

//Sleep three consecutive and sleep one consecutive. one three, three one
ElseIf(((a >= 22) And (a <= 25) And (b >= 140) And (b <= 150)) Or ((a >= 140) And (a <= 150) And (b >= 22) And (b <= 25))) Then
Return 3000;

//two three, three two:110111
ElseIf(((a >= 76) And (a <= 80) And (b >= 1050) And (b <= 1100)) Or ((a >= 1050) And (a <= 1100) And (b >= 76) And (b <= 80))) Then
Return 3000;
Else
	Return 0;
End If

end function

public subroutine wf_computer_primary (string as_bs);//====================================================================
// Function: w_gobang.wf_computer_primary()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	string	as_bs	
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2022/01/14
//--------------------------------------------------------------------
// Usage: w_gobang.wf_computer_primary ( string as_bs )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

//wf_weighting_algorithm
Long ll_for,ll_num = 0,ll_j,ll_i
String ls_con,ls_con_two,ls_pieces = ''
Long ll_column,ll_row
Long ll_number,ll_max_number = 0
String ls_qzcon,ls_color

//Human machine

For ll_i = 1 To il_size //Row
	For ll_j = 1 To il_size //vertical
		ls_con = dw_1.GetItemString(ll_i,ll_j)
		If IsNull(ls_con) Then ls_con = ''
		If ls_con <> '' Then Continue;
		
		For ll_for = 1 To 5 //Row
			If as_bs = 'z' Then
				ll_row = ll_i
				ll_column = ll_j - ll_for
				If ll_column <= 0 Then Exit;
			ElseIf as_bs = 'y' Then
				ll_row = ll_i
				ll_column = ll_j + ll_for
				If ll_column > il_size Then Exit;
			ElseIf as_bs = 's' Then
				ll_row = ll_i - ll_for
				ll_column = ll_j
				If ll_row <= 0 Then Exit;
			ElseIf as_bs = 'x' Then
				ll_row = ll_i + ll_for
				ll_column = ll_j
				If ll_row > il_size Then Exit;
			ElseIf as_bs = 'zs' Then
				ll_row = ll_i - ll_for
				ll_column = ll_j - ll_for
				If ll_row <= 0 Then Exit;
				If ll_column <= 0 Then Exit;
			ElseIf as_bs = 'yx' Then
				ll_row = ll_i + ll_for
				ll_column = ll_j + ll_for
				If ll_row > il_size Then Exit;
				If ll_column > il_size Then Exit;
			ElseIf as_bs = 'ys' Then
				ll_row = ll_i - ll_for
				ll_column = ll_j + ll_for
				If ll_row <= 0 Then Exit;
				If ll_column > il_size Then Exit;
			ElseIf as_bs = 'zx' Then
				ll_row = ll_i + ll_for
				ll_column = ll_j - ll_for
				If ll_row > il_size Then Exit;
				If ll_column <= 0 Then Exit;
			End If
			
			
			ls_con_two = dw_1.GetItemString(ll_row,ll_column)
			If IsNull(ls_con_two) Then ls_con_two = '-1'
			If ls_color = ls_con_two Then Exit
			
			If ls_con_two = is_white Then
				ls_con_two = '1'
			ElseIf ls_con_two = is_black Then
				ls_con_two = '2'
			Else
				ls_con_two = '0'
				ls_color = '-1'
			End If
			ls_pieces = ls_pieces + ls_con_two
		Next
		
		//Weight table
		Choose Case ls_pieces
			Case '11110'
				ll_num = 11110
			Case '1111'
				ll_num = 15000
			Case '11112'
				ll_num = 16000
			Case '1110'
				ll_num = 5000
			Case '111'
				ll_num = 550
			Case '1112'
				ll_num = 600
			Case '110'
				ll_num = 500
			Case '11'
				ll_num = 200
			Case '112'
				ll_num = 220
			Case '10'
				ll_num = 100
			Case '12'
				ll_num = 40
			Case '1'
				ll_num = 25
			Case '22220'
				ll_num = 20000
			Case '2222'
				ll_num = 17000
			Case '22221'
				ll_num = 18000
			Case '2220'
				ll_num = 10000
			Case '2221'
				ll_num = 650
			Case '222'
				ll_num = 600
			Case '220'
				ll_num = 400
			Case '221'
				ll_num = 270
			Case '22'
				ll_num = 250
			Case '20'
				ll_num = 200
			Case '21'
				ll_num = 120
			Case '2'
				ll_num = 40
			Case '1'
				ll_num = 3
			Case Else
				ll_num = 0
		End Choose
		
		ll_number = Long(dw_weight.GetItemString(ll_i,ll_j))
		ll_number = ll_number + ll_num
		dw_weight.SetItem(ll_i,ll_j,String(ll_number))
		
		ls_pieces = ''
		ll_num = 0
		ls_color = ''
	Next
Next




end subroutine

public subroutine wf_computer_middlerank ();//====================================================================
// Function: w_gobang.wf_computer_middlerank()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2022/01/14
//--------------------------------------------------------------------
// Usage: w_gobang.wf_computer_middlerank ( )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Long ll_for,ll_j,ll_i,ll_num = 0
String ls_con,ls_con_two,ls_pieces = ''
Long ll_number
Long jmin,ll_value,ll_value_tow

For ll_i = 1 To il_size //Row
	For ll_j = 1 To il_size //vertical
		
		ls_con = dw_1.GetItemString(ll_i,ll_j)
		If IsNull(ls_con) Then ls_con = ''
		If ls_con = '' Then
			//Left
			ls_pieces = '0'
			jmin = Max(1,ll_j - 4)
			For ll_for = ll_j -1  To jmin Step -1 //Row
				ls_con_two = dw_1.GetItemString(ll_i,ll_for)
				If IsNull(ls_con_two) Then ls_con_two = '0'
				
				If ls_con_two = is_white Then
					ls_con_two = '1'
				ElseIf ls_con_two = is_black Then
					ls_con_two = '2'
				Else
					ls_con_two = '0'
				End If
				ls_pieces = ls_pieces + ls_con_two
			Next
			
			ll_value = wf_choose(ls_pieces)
			ll_number = Long(dw_weight.GetItemString(ll_i,ll_j)) + ll_value
			dw_weight.SetItem(ll_i,ll_j,String(ll_number))
			//mle_1.text = mle_1.text+'~r~n'+string(ll_i)+':'+string(ll_j)+':'+ls_pieces+':'+string(ll_valueleft)
			//right
			ls_pieces = '0'
			jmin = Min(il_size,ll_j + 4)
			For ll_for = ll_j +1  To jmin //Row
				ls_con_two = dw_1.GetItemString(ll_i,ll_for)
				If IsNull(ls_con_two) Then ls_con_two = '0'
				
				If ls_con_two = is_white Then
					ls_con_two = '1'
				ElseIf ls_con_two = is_black Then
					ls_con_two = '2'
				Else
					ls_con_two = '0'
				End If
				ls_pieces = ls_pieces + ls_con_two
			Next
			
			ll_value_tow = wf_choose(ls_pieces)
			ll_number = Long(dw_weight.GetItemString(ll_i,ll_j)) + ll_value_tow
			dw_weight.SetItem(ll_i,ll_j,String(ll_number))
			
			//joint judgment
			ll_number = Long(dw_weight.GetItemString(ll_i,ll_j))
			ll_number = ll_number + wf_unionWeight(ll_value,ll_value_tow)
			dw_weight.SetItem(ll_i,ll_j,String(ll_number))
			
			//up
			ls_pieces = '0'
			jmin = Max(1,ll_i - 4)
			For ll_for = ll_i -1  To jmin Step -1 //Row
				ls_con_two = dw_1.GetItemString(ll_for,ll_j)
				If IsNull(ls_con_two) Then ls_con_two = '0'
				
				If ls_con_two = is_white Then
					ls_con_two = '1'
				ElseIf ls_con_two = is_black Then
					ls_con_two = '2'
				Else
					ls_con_two = '0'
				End If
				ls_pieces = ls_pieces + ls_con_two
			Next
			
			ll_value = wf_choose(ls_pieces)
			ll_number = Long(dw_weight.GetItemString(ll_i,ll_j)) + ll_value
			dw_weight.SetItem(ll_i,ll_j,String(ll_number))
			//Down
			ls_pieces = '0'
			jmin = Min(il_size,ll_i + 4)
			For ll_for = ll_i +1  To jmin //Row
				ls_con_two = dw_1.GetItemString(ll_for,ll_j)
				If IsNull(ls_con_two) Then ls_con_two = '0'
				
				If ls_con_two = is_white Then
					ls_con_two = '1'
				ElseIf ls_con_two = is_black Then
					ls_con_two = '2'
				Else
					ls_con_two = '0'
				End If
				ls_pieces = ls_pieces + ls_con_two
			Next
			
			ll_value_tow = wf_choose(ls_pieces)
			ll_number = Long(dw_weight.GetItemString(ll_i,ll_j)) + ll_value_tow
			dw_weight.SetItem(ll_i,ll_j,String(ll_number))
			
			//Joint judgment, judgment line
			ll_number = Long(dw_weight.GetItemString(ll_i,ll_j))
			ll_number = ll_number + wf_unionWeight(ll_value,ll_value_tow)
			dw_weight.SetItem(ll_i,ll_j,String(ll_number))
			//upper left
			ls_pieces = '0'
			For ll_for = 1  To 4
				//mle_1.text = mle_1.text+'~r~n'+string(ll_i)+':'+string(ll_j)+':'+string(ll_i -ll_for)+':'+string(ll_i -ll_for)+':'+string(ll_j -ll_for)+':'+string(ll_j -ll_for)
				If((ll_i -ll_for > 0) And (ll_i -ll_for <= il_size) And (ll_j -ll_for > 0) And (ll_j -ll_for <= il_size)) Then
				ls_con_two = dw_1.GetItemString(ll_i -ll_for,ll_j -ll_for)
				If IsNull(ls_con_two) Then ls_con_two = '0'
				
				If ls_con_two = is_white Then
					ls_con_two = '1'
				ElseIf ls_con_two = is_black Then
					ls_con_two = '2'
				Else
					ls_con_two = '0'
				End If
				ls_pieces = ls_pieces + ls_con_two
			End If
		Next
		
		ll_value = wf_choose(ls_pieces)
		ll_number = Long(dw_weight.GetItemString(ll_i,ll_j)) + ll_value
		dw_weight.SetItem(ll_i,ll_j,String(ll_number))
		//lower right
		ls_pieces = '0'
		For ll_for = 1  To 4
			//mle_1.text = mle_1.text+'~r~n'+string(ll_i)+':'+string(ll_j)+':'+string(ll_i -ll_for)+':'+string(ll_i -ll_for)+':'+string(ll_j -ll_for)+':'+string(ll_j -ll_for)
			If((ll_i +ll_for > 0) And (ll_i +ll_for <= il_size) And (ll_j +ll_for > 0) And (ll_j +ll_for <= il_size)) Then
			ls_con_two = dw_1.GetItemString(ll_i +ll_for,ll_j +ll_for)
			If IsNull(ls_con_two) Then ls_con_two = '0'
			
			If ls_con_two = is_white Then
				ls_con_two = '1'
			ElseIf ls_con_two = is_black Then
				ls_con_two = '2'
			Else
				ls_con_two = '0'
			End If
			ls_pieces = ls_pieces + ls_con_two
		End If
	Next
	
	ll_value_tow = wf_choose(ls_pieces)
	ll_number = Long(dw_weight.GetItemString(ll_i,ll_j)) + ll_value_tow
	dw_weight.SetItem(ll_i,ll_j,String(ll_number))
	
	//Joint judgment, judgment line
	ll_number = Long(dw_weight.GetItemString(ll_i,ll_j))
	ll_number = ll_number + wf_unionWeight(ll_value,ll_value_tow)
	dw_weight.SetItem(ll_i,ll_j,String(ll_number))
	
	//Bottom left i plus, j minus
	ls_pieces = '0'
	For ll_for = 1  To 4
		If((ll_i +ll_for > 0) And (ll_i +ll_for <= il_size) And (ll_j -ll_for > 0) And (ll_j -ll_for <= il_size)) Then
		ls_con_two = dw_1.GetItemString(ll_i +ll_for,ll_j -ll_for)
		If IsNull(ls_con_two) Then ls_con_two = '0'
		
		If ls_con_two = is_white Then
			ls_con_two = '1'
		ElseIf ls_con_two = is_black Then
			ls_con_two = '2'
		Else
			ls_con_two = '0'
		End If
		ls_pieces = ls_pieces + ls_con_two
	End If
Next

ll_value = wf_choose(ls_pieces)
ll_number = Long(dw_weight.GetItemString(ll_i,ll_j)) + ll_value
dw_weight.SetItem(ll_i,ll_j,String(ll_number))

//In the upper right, i subtract, j add
ls_pieces = '0'
For ll_for = 1  To 4
	//mle_1.text = mle_1.text+'~r~n'+string(ll_i)+':'+string(ll_j)+':'+string(ll_i -ll_for)+':'+string(ll_i -ll_for)+':'+string(ll_j -ll_for)+':'+string(ll_j -ll_for)
	If((ll_i -ll_for > 0) And (ll_i -ll_for <= il_size) And (ll_j +ll_for > 0) And (ll_j +ll_for <= il_size)) Then
	ls_con_two = dw_1.GetItemString(ll_i -ll_for,ll_j +ll_for)
	If IsNull(ls_con_two) Then ls_con_two = '0'
	
	If ls_con_two = is_white Then
		ls_con_two = '1'
	ElseIf ls_con_two = is_black Then
		ls_con_two = '2'
	Else
		ls_con_two = '0'
	End If
	ls_pieces = ls_pieces + ls_con_two
End If
Next

ll_value_tow = wf_choose(ls_pieces)
ll_number = Long(dw_weight.GetItemString(ll_i,ll_j)) + ll_value_tow
dw_weight.SetItem(ll_i,ll_j,String(ll_number))

//Joint judgment, judgment line
ll_number = Long(dw_weight.GetItemString(ll_i,ll_j))
ll_number = ll_number + wf_unionWeight(ll_value,ll_value_tow)
dw_weight.SetItem(ll_i,ll_j,String(ll_number))


End If


Next
Next




end subroutine

public subroutine wf_draw_checkerboard ();//====================================================================
// Function: w_gobang.wf_draw_checkerboard()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2022/01/14
//--------------------------------------------------------------------
// Usage: w_gobang.wf_draw_checkerboard ( )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Long ll_count,ll_i
String ls_name,ls_column
Long ll_x,ll_y,ll_width,ll_height,ll_total_width = 0
Long ll_for
Long ll_insertrow
String ls_syntax,ls_err = ''

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
	ll_x = il_width * (ll_for - 1) +il_width + 6
	dw_1.Modify('create column(band=detail id='+String(ll_for)+' alignment="2" tabsequence=32766 border="0" color="33554432~tif (pd = '+String(ll_for)+',255,0)" x="'+String(ll_x) +'" y="6" ' +&
		'height="'+String(il_height)+'" width="'+String(il_width)+'" format="[general]" html.valueishtml="0"  name='+ls_column+' visible="1" edit.limit=0 edit.case=any ' +&
		'edit.autoselect=yes edit.imemode=0  font.face="Arial" font.height="-16" font.weight="400"  font.family="2" ' +&
		'font.pitch="2" font.charset="134" background.mode="0" background.color="553648127" )') //~tif (pd = '+string(ll_for)+',255,553648127)
		
Next

//vertical bar
ll_x = 0
For ll_i = 1 To il_size
	ls_name = is_any_name[ll_i]
	ll_x = Long(dw_1.Describe(ls_name+".x"))
	ll_width = Long(dw_1.Describe(ls_name+".width"))
	ll_total_width = ll_total_width + ll_width
	
	ll_x = (ll_x+ll_width -3) - (il_width / 2)
	ll_y = (il_height / 2 )
	//follow line
	dw_1.Modify('create line(band=detail x1="'+String(ll_x)+'" x2="'+String(ll_x)+'" '+&
		'y1="0~tif(getrow() = 1,'+String(ll_y)+',0)" y2="'+String(ll_y)+'~tif(getrow() = '+String(il_size)+','+String(ll_y)+','+String(il_height)+')"  name=l_1 visible="1" pen.style="0"'  +&
		'pen.width="4" pen.color="33554432"  background.mode="2" background.color="1073741824")')
	
	
Next

ll_y = (il_height / 2)
ll_x = (il_width / 2) + il_width + 5
ll_total_width = ll_total_width + ll_width + ll_width - ll_x +10
//horizontal line
dw_1.Modify('create line(band=detail y1="'+String(ll_y)+'"  y2="'+String(ll_y)+'" x1="'+String(ll_x)+'"  x2="'+String(ll_total_width)+'" name=l_2 visible="1" pen.style="0"'  +&
	'pen.width="4" pen.color="33554432"  background.mode="2" background.color="1073741824")')

// Increase the serial number
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

//Copy a copy of dw to store the weight algorithm
dw_weight.Create(String(dw_1.Object.datawindow.Syntax), ls_err)
dw_1.RowsCopy(1,dw_1.RowCount(),Primary!,dw_weight,1,Primary!)

dw_1.SetRedraw(True)
dw_1.Object.datawindow.Selected.Mouse = 'No'





end subroutine

public function boolean wf_where_column (string as_data);//====================================================================
// Function: w_gobang.wf_where_column()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	string	as_data	
//--------------------------------------------------------------------
// Returns:  boolean
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2022/01/14
//--------------------------------------------------------------------
// Usage: w_gobang.wf_where_column ( string as_data )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

//Check if column exists
Boolean lbl_bool = False

Long ll_count,ll_i

ll_count = Long(dw_1.Describe("DataWindow.Column.Count"))

For ll_i = 1 To UpperBound(is_any_name)
	If as_data = is_any_name[ll_i] Then Return True
Next

Return False

end function

public subroutine wf_switch_st_scrolling ();//====================================================================
// Function: w_gobang.wf_switch_st_scrolling()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2022/01/14
//--------------------------------------------------------------------
// Usage: w_gobang.wf_switch_st_scrolling ( )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

If il_First = 1 Then
	st_scrolling.BackColor = is_white_color
	st_scrolling.Text = 'White Pick'
Else
	st_scrolling.BackColor = is_black_color
	st_scrolling.Text = 'Black Pick'
End If

end subroutine

public subroutine wf_button_enabled (boolean as_bool);//====================================================================
// Function: w_gobang.wf_button_enabled()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	boolean	as_bool	
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2022/01/14
//--------------------------------------------------------------------
// Usage: w_gobang.wf_button_enabled ( boolean as_bool )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

If as_bool Then
	cb_1.Enabled = False
	cb_3.Enabled = True
	cb_2.Enabled = True
	
	If Not rb_1.Checked Then rb_1.Enabled = False
	If Not rb_primary.Checked Then rb_primary.Enabled = False
	If Not rb_middlerank.Checked Then rb_middlerank.Enabled = False
Else
	cb_1.Enabled = True
	cb_3.Enabled = False
	cb_2.Enabled = False
	
	rb_1.Enabled = True
	rb_primary.Enabled = True
	rb_middlerank.Enabled = True
End If




end subroutine

public function integer wf_z_demo2 ();//====================================================================
// Function: w_gobang.wf_z_demo2()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2022/01/14
//--------------------------------------------------------------------
// Usage: w_gobang.wf_z_demo2 ( )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
//wf_z_evaluate

Long ll_for,ll_j,ll_i,ll_num = 0
String ls_con,ls_con_two,ls_pieces = ''
Long ll_number = 0,ll_max_number = 0
Long jmin,ll_value = 0,ll_value_tow = 0
String ls_con1,ls_con2,ls_con3,ls_con4,ls_con5,ls_con6,ls_con7,ls_con8
Long ll_x,ll_y,ll_x_two,ll_y_two
Long ll_k,ll_max,ll_INF = 1000000
il_x = 0
il_y = 0
ll_max = -ll_INF

For ll_i = 1 To il_size //Row
	For ll_j = 1 To il_size //vertical
		ls_con = dw_1.GetItemString(ll_i,ll_j)
		If IsNull(ls_con) Then ls_con = ''
		If ls_con = '' Then
			If ll_i -1 > 0 And ll_j+1 <= il_size Then ls_con1 = dw_1.GetItemString(ll_i -1,ll_j+1)
			If ll_i > 0 And ll_j+1 <= il_size Then ls_con2 = dw_1.GetItemString(ll_i,ll_j+1)
			If ll_i +1 <= il_size And ll_j+1 <= il_size Then ls_con3 = dw_1.GetItemString(ll_i+1,ll_j+1)
			If ll_i -1 > 0 And ll_j -1 > 0 Then ls_con4 = dw_1.GetItemString(ll_i -1,ll_j -1)
			If ll_i > 0 And ll_j -1 > 0 Then ls_con5 = dw_1.GetItemString(ll_i,ll_j -1)
			If ll_i +1 <= il_size And ll_j -1 > 0 Then ls_con6 = dw_1.GetItemString(ll_i +1,ll_j -1)
			If ll_i +1 <= il_size And ll_j > 0 Then ls_con7 = dw_1.GetItemString(ll_i +1,ll_j)
			If ll_i -1 > 0 And ll_j  <= il_size Then ls_con8 = dw_1.GetItemString(ll_i -1,ll_j)
			
			If IsNull(ls_con1) Then ls_con1 = ''
			If IsNull(ls_con2) Then ls_con2 = ''
			If IsNull(ls_con3) Then ls_con3 = ''
			If IsNull(ls_con4) Then ls_con4 = ''
			If IsNull(ls_con5) Then ls_con5 = ''
			If IsNull(ls_con6) Then ls_con6 = ''
			If IsNull(ls_con7) Then ls_con7 = ''
			If IsNull(ls_con8) Then ls_con8 = ''
			
			If ls_con1 = '' And ls_con2 = '' And ls_con3 = '' And ls_con4 = '' And ls_con5 = '' And +&
				ls_con6 = '' And ls_con7 = '' And ls_con8 = '' Then
				Continue;
			Else
				dw_1.SetItem(ll_i,ll_j,'1')
				//Recursion + Pruning
				ll_k = wf_z_alphabeta(1, -ll_INF, ll_INF, 1);
				MessageBox("",ll_k)
				dw_1.SetItem(ll_i,ll_j,'')
				If ll_k > ll_max Then
					ll_max = ll_k
					il_x = ll_i
					il_y = ll_j
				End If
			End If
		End If
	Next
Next
dw_1.SetItem( il_x,il_y, '○')
il_First = 2
Return  1

end function

public function long wf_z_alphabeta (long player, long alpha, long beta, long depth);//====================================================================
// Function: w_gobang.wf_z_alphabeta()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	long	player	
// 	long	alpha 	
// 	long	beta  	
// 	long	depth 	
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2022/01/14
//--------------------------------------------------------------------
// Usage: w_gobang.wf_z_alphabeta ( long player, long alpha, long beta, long depth )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Long ll_j,ll_i
String ls_con
String ls_con1,ls_con2,ls_con3,ls_con4,ls_con5,ls_con6,ls_con7,ls_con8
Int ll_v


If Depth = 2 Then
	Return wf_z_demo2_3('z') + wf_z_demo2_3('y') +wf_z_demo2_3('s')+	wf_z_demo2_3('x')+wf_z_demo2_3('zs')+ +&
		wf_z_demo2_3('zx')+wf_z_demo2_3('ys')+wf_z_demo2_3('yx')
End If

//mle_1.text =mle_1.text +'~r~n 333' + string(ll_i)+':'+string(ll_j)
For ll_i = 1 To il_size //Row
	For ll_j = 1 To il_size //vertical
		ls_con = dw_1.GetItemString(ll_i,ll_j)
		If IsNull(ls_con) Then ls_con = ''
		If ls_con = '' Then
			If ll_i -1 > 0 And ll_j+1 <= il_size Then ls_con1 = dw_1.GetItemString(ll_i -1,ll_j+1)
			If ll_i > 0 And ll_j+1 <= il_size Then ls_con2 = dw_1.GetItemString(ll_i,ll_j+1)
			If ll_i +1 <= il_size And ll_j+1 <= il_size Then ls_con3 = dw_1.GetItemString(ll_i+1,ll_j+1)
			If ll_i -1 > 0 And ll_j -1 > 0 Then ls_con4 = dw_1.GetItemString(ll_i -1,ll_j -1)
			If ll_i > 0 And ll_j -1 > 0 Then ls_con5 = dw_1.GetItemString(ll_i,ll_j -1)
			If ll_i +1 <= il_size And ll_j -1 > 0 Then ls_con6 = dw_1.GetItemString(ll_i +1,ll_j -1)
			If ll_i +1 <= il_size And ll_j > 0 Then ls_con7 = dw_1.GetItemString(ll_i +1,ll_j)
			If ll_i -1 > 0 And ll_j  <= il_size Then ls_con8 = dw_1.GetItemString(ll_i -1,ll_j)
			
			If IsNull(ls_con1) Then ls_con1 = ''
			If IsNull(ls_con2) Then ls_con2 = ''
			If IsNull(ls_con3) Then ls_con3 = ''
			If IsNull(ls_con4) Then ls_con4 = ''
			If IsNull(ls_con5) Then ls_con5 = ''
			If IsNull(ls_con6) Then ls_con6 = ''
			If IsNull(ls_con7) Then ls_con7 = ''
			If IsNull(ls_con8) Then ls_con8 = ''
			
			If ls_con1 = '' And ls_con2 = '' And ls_con3 = '' And ls_con4 = '' And ls_con5 = '' And +&
				ls_con6 = '' And ls_con7 = '' And ls_con8 = '' Then
				Continue;
			Else
				dw_1.SetItem(ll_i,ll_j,String(player))
				ll_v = wf_z_alphabeta(player * -1, alpha, beta, Depth + 1);
				dw_1.SetItem(ll_i,ll_j,'')
				If player = -1 Then
					alpha = Max(alpha, ll_v);
				Else
					beta = Min(beta, ll_v);
				End If
				If (beta <= alpha) Then //Pruning here I want to draw a tree for analysis, I have been thinking about it for a long time
					If (player = -1) Then
						Return alpha;
					Else
						Return beta;
					End If
				End If
			End If
		End If
	Next
Next

If player = -1 Then
	Return alpha;
End If

Return beta

end function

public function integer wf_z_demo2_3 (string as_bs);//====================================================================
// Function: w_gobang.wf_z_demo2_3()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	string	as_bs	
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2022/01/14
//--------------------------------------------------------------------
// Usage: w_gobang.wf_z_demo2_3 ( string as_bs )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

//wf_weighting_algorithm
Long ll_for,ll_num = 0,ll_j,ll_i
String ls_con,ls_con_two,ls_pieces = ''
Long ll_column,ll_row
Long ll_number,ll_max_number = 0
String ls_qzcon,ls_color

For ll_i = 1 To il_size //Row
	For ll_j = 1 To il_size //vertical
		ls_con = dw_1.GetItemString(ll_i,ll_j)
		If IsNull(ls_con) Then ls_con = ''
		If ls_con <> '' Then Continue;
		
		For ll_for = 1 To 5 //Row
			If as_bs = 'z' Then
				ll_row = ll_i
				ll_column = ll_j - ll_for
				If ll_column <= 0 Then Exit;
			ElseIf as_bs = 'y' Then
				ll_row = ll_i
				ll_column = ll_j + ll_for
				If ll_column > il_size Then Exit;
			ElseIf as_bs = 's' Then
				ll_row = ll_i - ll_for
				ll_column = ll_j
				If ll_row <= 0 Then Exit;
			ElseIf as_bs = 'x' Then
				ll_row = ll_i + ll_for
				ll_column = ll_j
				If ll_row > il_size Then Exit;
			ElseIf as_bs = 'zs' Then
				ll_row = ll_i - ll_for
				ll_column = ll_j - ll_for
				If ll_row <= 0 Then Exit;
				If ll_column <= 0 Then Exit;
			ElseIf as_bs = 'yx' Then
				ll_row = ll_i + ll_for
				ll_column = ll_j + ll_for
				If ll_row > il_size Then Exit;
				If ll_column > il_size Then Exit;
			ElseIf as_bs = 'ys' Then
				ll_row = ll_i - ll_for
				ll_column = ll_j + ll_for
				If ll_row <= 0 Then Exit;
				If ll_column > il_size Then Exit;
			ElseIf as_bs = 'zx' Then
				ll_row = ll_i + ll_for
				ll_column = ll_j - ll_for
				If ll_row > il_size Then Exit;
				If ll_column <= 0 Then Exit;
			End If
			
			
			ls_con_two = dw_1.GetItemString(ll_row,ll_column)
			If IsNull(ls_con_two) Then ls_con_two = '-1'
			If ls_color = ls_con_two Then Exit
			
			If ls_con_two = is_white Then
				ls_con_two = '1'
			ElseIf ls_con_two = is_black Then
				ls_con_two = '2'
			Else
				ls_con_two = '0'
				ls_color = '-1'
			End If
			ls_pieces = ls_pieces + ls_con_two
		Next
		
		//Weight table
		Choose Case ls_pieces
			Case '11110'
				ll_num = 11110
			Case '1111'
				ll_num = 15000
			Case '11112'
				ll_num = 16000
			Case '1110'
				ll_num = 5000
			Case '111'
				ll_num = 550
			Case '1112'
				ll_num = 600
			Case '110'
				ll_num = 500
			Case '11'
				ll_num = 200
			Case '112'
				ll_num = 220
			Case '10'
				ll_num = 100
			Case '12'
				ll_num = 40
			Case '1'
				ll_num = 25
			Case '22220'
				ll_num = 20000
			Case '2222'
				ll_num = 17000
			Case '22221'
				ll_num = 18000
			Case '2220'
				ll_num = 10000
			Case '2221'
				ll_num = 650
			Case '222'
				ll_num = 600
			Case '220'
				ll_num = 400
			Case '221'
				ll_num = 270
			Case '22'
				ll_num = 250
			Case '20'
				ll_num = 200
			Case '21'
				ll_num = 120
			Case '2'
				ll_num = 40
			Case '1'
				ll_num = 3
			Case Else
				ll_num = 0
		End Choose
		
		ll_number = Long(dw_weight.GetItemString(ll_i,ll_j))
		il_num_new = il_num_new + ll_num
		
		ls_pieces = ''
		ll_num = 0
		ls_color = ''
	Next
Next

Return il_num_new

end function

on w_gobang.create
this.mle_1=create mle_1
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.st_scrolling=create st_scrolling
this.rb_middlerank=create rb_middlerank
this.rb_primary=create rb_primary
this.rb_1=create rb_1
this.dw_weight=create dw_weight
this.cb_2=create cb_2
this.dw_coordinates=create dw_coordinates
this.sle_1=create sle_1
this.cb_1=create cb_1
this.st_1=create st_1
this.dw_1=create dw_1
this.Control[]={this.mle_1,&
this.cb_5,&
this.cb_4,&
this.cb_3,&
this.st_scrolling,&
this.rb_middlerank,&
this.rb_primary,&
this.rb_1,&
this.dw_weight,&
this.cb_2,&
this.dw_coordinates,&
this.sle_1,&
this.cb_1,&
this.st_1,&
this.dw_1}
end on

on w_gobang.destroy
destroy(this.mle_1)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.st_scrolling)
destroy(this.rb_middlerank)
destroy(this.rb_primary)
destroy(this.rb_1)
destroy(this.dw_weight)
destroy(this.cb_2)
destroy(this.dw_coordinates)
destroy(this.sle_1)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.dw_1)
end on

event open;//cb_1.triggerevent(clicked!) 
st_scrolling.Text = 'Please Start Game!'
//wf_draw_checkerboard()
wf_button_enabled(False)

end event

event timer;st_scrolling.TextColor = RGB(200,Integer(Right(String(Now(),'hhmmssf'),1))*200/10,0)


end event

type mle_1 from multilineedit within w_gobang
integer x = 2638
integer y = 76
integer width = 1285
integer height = 488
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type cb_5 from commandbutton within w_gobang
boolean visible = false
integer x = 165
integer y = 1400
integer width = 503
integer height = 112
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = gb2312charset!
fontpitch fontpitch = variable!
string facename = "Arial"
string text = "none"
end type

event clicked;boolean lbl_bool = false

do while not lbl_bool
	if il_First = 2 then
		rb_primary.checked = true
		wf_computer()
		dw_1.setitem(il_x,il_y,is_black)
		lbl_bool = wf_estimate_fiveeven(il_x,il_y,is_black)
		il_First = 1 
	else
		rb_middlerank.checked = true
		wf_computer()
		dw_1.setitem(il_x,il_y,is_white)
		lbl_bool = wf_estimate_fiveeven(il_x,il_y,is_white)
		il_First = 2
	end if
LOOP
messagebox("",il_First)




end event

type cb_4 from commandbutton within w_gobang
boolean visible = false
integer x = 146
integer y = 1556
integer width = 503
integer height = 112
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = gb2312charset!
fontpitch fontpitch = variable!
string facename = "Arial"
string text = "none"
end type

event clicked;wf_z_demo2()
end event

type cb_3 from commandbutton within w_gobang
integer x = 64
integer y = 816
integer width = 430
integer height = 128
integer taborder = 30
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Surrender"
end type

event clicked;String ls_text

ilb_start = False
If il_First = 1 Then
	ls_text = 'White Surrender'
Else
	ls_text = 'Black Surrender'
End If

If Not IsValid(tip) Then
	tip = Create uo_tip
End If

st_scrolling.Text = ls_text
tip.st_1.Text = ls_text
OpenUserObject(tip,(dw_1.Width / 2) - (tip.Width / 2) + dw_1.X,(dw_1.Height / 2) - (tip.Height / 2) + dw_1.Y)
wf_button_enabled(False)


end event

type st_scrolling from statictext within w_gobang
integer x = 713
integer y = 28
integer width = 1655
integer height = 140
integer textsize = -18
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
long backcolor = 0
alignment alignment = center!
boolean focusrectangle = false
end type

type rb_middlerank from radiobutton within w_gobang
boolean visible = false
integer x = 64
integer y = 436
integer width = 590
integer height = 92
integer textsize = -12
integer weight = 400
fontcharset fontcharset = gb2312charset!
fontpitch fontpitch = variable!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
string text = "human and machine"
end type

type rb_primary from radiobutton within w_gobang
integer x = 59
integer y = 316
integer width = 590
integer height = 92
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
string text = "Play Machine"
end type

type rb_1 from radiobutton within w_gobang
integer x = 59
integer y = 188
integer width = 590
integer height = 92
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
string text = "Play People"
boolean checked = true
end type

type dw_weight from datawindow within w_gobang
integer x = 2638
integer y = 792
integer width = 2272
integer height = 1632
integer taborder = 40
boolean titlebar = true
string title = "none"
boolean controlmenu = true
boolean border = false
boolean livescroll = true
end type

type cb_2 from commandbutton within w_gobang
integer x = 64
integer y = 992
integer width = 430
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

event clicked;//====================================================================
// Event: w_gobang.Properties -  cb_2  inherited  from  commandbutton()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2022/01/14
//--------------------------------------------------------------------
// Usage: w_gobang.
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

//regret
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

wf_switch_st_scrolling()

end event

type dw_coordinates from datawindow within w_gobang
boolean visible = false
integer x = 2423
integer y = 1764
integer width = 1417
integer height = 612
integer taborder = 30
string title = "none"
string dataobject = "d_coordinates"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type sle_1 from singlelineedit within w_gobang
integer x = 375
integer y = 52
integer width = 229
integer height = 96
integer taborder = 30
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean enabled = false
string text = "15"
end type

type cb_1 from commandbutton within w_gobang
integer x = 64
integer y = 584
integer width = 430
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
il_First = 2
il_x = 0
il_y = 0
il_num_new = 0
is_any_name = is_any_null
il_size = Long(sle_1.Text)

Parent.CloseUserObject(tip)
tip = Create uo_tip

wf_switch_st_scrolling()

wf_draw_checkerboard()

wf_button_enabled(True)
Timer(0.5)

end event

type st_1 from statictext within w_gobang
integer x = 59
integer y = 52
integer width = 283
integer height = 100
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "Size："
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_gobang
integer x = 713
integer y = 188
integer width = 1655
integer height = 1444
integer taborder = 20
string title = "none"
boolean livescroll = true
end type

event clicked;String ls_data
Boolean lbl_bool
String ls_text = ''
Long ll_insertrow,ll_for = 0
Long ll_column = 0,ll_row = 0

If Not ilb_start Then Return

This.AcceptText( )

If il_First = 1 And rb_1.Checked = False Then
	//Man-machine white chess
	wf_computer()
	ll_row = il_x
	ll_column = il_y
Else
	ll_column = wf_retrun_column(dwo.Name)
	ll_row = row
End If

If ll_column > 0 And ll_row > 0 Then
	ls_data = This.GetItemString(ll_row,ll_column)
	If IsNull(ls_data) Then ls_data = ''
	
	If ls_data <> is_white And ls_data <> is_black Then
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
			ls_text = 'White wins'
			This.SetItem(ll_row,ll_column,is_white)
			lbl_bool = wf_estimate_fiveeven(ll_row,ll_column,is_white)
			il_First = 2
		Else
			ls_text = 'Black wins'
			This.SetItem(ll_row,ll_column,is_black)
			lbl_bool = wf_estimate_fiveeven(ll_row,ll_column,is_black)
			il_First = 1
		End If
		
		//Finish
		If lbl_bool Then
			tip.st_1.Text = ls_text
			st_scrolling.Text = ls_text
			OpenUserObject(tip,(dw_1.Width / 2) - (tip.Width / 2) + dw_1.X,(dw_1.Height / 2) - (tip.Height / 2) + dw_1.Y)
			wf_button_enabled(False)
			ilb_start = False
			Return
		End If
		
		wf_switch_st_scrolling()
		If il_First = 1 And rb_1.Checked = False Then
			This.Event Clicked(1,1,1, dw_1.Object.a_1)
		End If
	End If
End If




end event

