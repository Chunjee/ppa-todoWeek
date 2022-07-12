; ################################# ################################# #################################
;                           				  N  o  t  e  s
; Make GUI appear on Screen one. Maybe top-right corner. Under everything, but above desktop.
; After x time, make GUI on top of everything until clicked.
; ################################# ################################# #################################
#SingleInstance, force
SetBatchLines, -1

#Include %A_ScriptDir%\node_modules
#Include biga.ahk\export.ahk
A := new biga() ; requires https://github.com/biga-ahk/biga.ahk


OutputDebug, Script Start
Global selectedDay := 0
Global burdy := 0
FormatTime, selectedDay ,,yyyyMMdd
burdy := selectedDay
;FormatTime, TimeString, 20050423220133, dddd MMMM d, yyyy hh:mm:ss tt
;MsgBox %selectedDay%
;msgbox YYYYMMDDHH24MISS = %YYYYMMDDHH24MISS%
Global weekdayname := 0
Global dayName := 0
Global dayNumber := 0
Global tstv1 := 20220706000000
Global tstv2 := 20220712
Global tstv3 := 20220700
Global matchingEntry := 0
Global fridaysVar := 0
; #################################
;           A r r a y s
; #################################

; Now to figure out how to efficiently push the objects/elements to each 'next' node, if there is something already in the first.
tasksVar :={1: "Do the dishes", 2: "Clean the fishtank", 3: "Sleep longer", 4: "Do some coding", 5: "Start the working week", 6: "Gaming day, every Saturday.", 7: "Play the violin"}

daysVar := [{"day": 20220708, "name": "Friday", "tasks": "This is past-tense for data."}
		, {"day": 20220709, "name": "Saturday", "tasks": "This is also past-tense for data."}
		, {"day": 20220710, "name": "Sunday", "tasks": tasksVar[2]}
		, {"day": 20220711, "name": "Monday", "tasks": "Start of the working week."}
		, {"day": 20220712, "name": "Tuesday", "tasks": "nah"}
		, {"day": 20220713, "name": "Wednesday", "tasks": "cope|no|touch a computer"}
		, {"day": 20220714, "name": "Thursday", "tasks": "no"}
		, {"day": 20220715, "name": "Friday", "tasks": "Grab paycheck"}]



; Fill days with things I do every week
daysVar := fn_fillDays(daysVar, "Friday", "End of the week!")

; sort days
daysVar := A.sortBy(daysVar, "day")

; remove days that have past
currentDays := fn_filterOldDaysFunc(daysVar)

; user adds activity to exact day
; userInput := "20220715"
; activity := "visit bank"
; modifiableItem := A.find(daysVar, {"day": userInput})
; if (modifiableItem != false) {
; 	; remember the items location for later replacement
; 	index := A.indexOf(daysVar, modifiableItem)
; 	modifiableItem.tasks .=  "|" activity
; 	; show the modified item before replacing in data storage
; 	A.print(modifiableItem)
; 	; replace in data
; 	daysVar[index] := modifiableItem
; }

; #################################
;           G l o b a l s
; #################################

#SingleInstance,Force
#Persistent
CoordMode, Pixel, Screen
Global b := 0
Global Satdy := 0
Global Sundy := 0
Global Mondy := 0
Global Tuedy := 0
Global Weddy := 0
Global Thudy := 0
Global Fridy := 0
Global daynum := 0
Global dayday := 0
Global NewDY := -1
Global ND := 0
Global Loo := 1
Global k := 0
Global tstv4 := 0
;Global
Global index := 1
Global tstv5 := daysVar[5].tasks
Global Taday := NDY0
Setdaynum()
Namedaynum()

; #################################
;              G U I
; #################################

WinGet, active_id, ID, A
Menu, Tray, Tip, % "Memberry, 'member?"
Gui, MemGUI:+LastFound +ToolWindow -Caption +AlwaysOnTop ; Added
Gui, MemGUI:Color, 10191A
WinSet, TransColor, 10191A 221 ; Added
Gui, MemGUI:Margin, 5, 5
Gui, MemGUI:Add, Picture, x0 y%NewDY% w200 h150 Disabled hwnd%ND%BGHwnd v%ND%BG g%ND%BG, Icons\Today.png
Gui, MemGUI:Add, Picture, x0 yp+150 w200 h10 hwndMinus%ND%Hwnd vMinus%ND% gMinus%ND%, Icons\Remove.png
GuiControl, MemGUI:, Minus%ND%,
Gui, MemGUI:Add, Picture, x0 yp w200 h10 hwndPlus%ND%Hwnd vPlus%ND% gPlus%ND%, Icons\Add.png
Gui, MemGUI:Font, S14, Tahoma
Gui, MemGUI:Add, Text, x7 yp-146 h25 BackgroundTrans hwndText%ND%1Hwnd vText%ND%1 gText%ND%1, %dayday%
Gui, MemGUI:Font, S10, Tahoma
Gui, MemGUI:Add, Text, x+3 yp+7 h20 BackgroundTrans hwndText%ND%2Hwnd vText%ND%2 gText%ND%2, (Today)

Gui, MemGUI:Font, S12, Tahoma
Gui, MemGUI:Add, Picture, x7 yp+23 w19 h19 hwndChckbx%ND%1Hwnd vChckbx%ND%1 gChckbx%ND%1, Icons\ChckbxN.png
Gui, MemGUI:Add, Text, x30 yp w180 h20 BackgroundTrans hwndTxt%ND%1Hwnd vTxt%ND%1 gTxt%ND%1, No Results Found.
Gui, MemGUI:Add, Picture, x7 yp+23 w19 h19 hwndChckbx%ND%2Hwnd vChckbx%ND%2 gChckbx%ND%2, Icons\ChckbxN.png
Gui, MemGUI:Add, Text, x30 yp w180 h20 BackgroundTrans hwndTxt%ND%2Hwnd vTxt%ND%2 gTxt%ND%2, No Results Found.
Gui, MemGUI:Add, Picture, x7 yp+23 w19 h19 hwndChckbx%ND%3Hwnd vChckbx%ND%3 gChckbx%ND%3, Icons\ChckbxN.png
Gui, MemGUI:Add, Text, x30 yp w180 h20 BackgroundTrans hwndTxt%ND%3Hwnd vTxt%ND%3 gTxt%ND%3, No Results Found.
Gui, MemGUI:Add, Picture, x7 yp+23 w19 h19 hwndChckbx%ND%4Hwnd vChckbx%ND%4 gChckbx%ND%4, Icons\ChckbxN.png
Gui, MemGUI:Add, Text, x30 yp w180 h20 BackgroundTrans hwndTxt%ND%4Hwnd vTxt%ND%4 gTxt%ND%4, No Results Found.
Gui, MemGUI:Add, Picture, x7 yp+23 w19 h19 hwndChckbx%ND%5Hwnd vChckbx%ND%5 gChckbx%ND%5, Icons\ChckbxN.png
Gui, MemGUI:Add, Text, x30 yp w180 h20 BackgroundTrans hwndTxt%ND%5Hwnd vTxt%ND%5 gTxt%ND%5, No Results Found.
ND++
Gui, MemGUI:Show, x1721 y0 w200 h1080
return


; ################
; Functions
; ################

fn_fillDays(inputArr, weekdayname, activity)
{
	index := 1

	; get the first item in the array
	dayNumber := inputArr[index].day
	loop, 30 {
		dayNumber += 1, days
		; make newest encountered day an object so we can add data
		if (!isObject(inputArr[index])) {
			inputArr[index] := {}
		}
		; set the day number back to YYYYMMDD format
		dayNumber := subStr(dayNumber, 1, 8)
		inputArr[index].day := dayNumber
		; set the day human readable name
		FormatTime, dayName, % dayNumber, dddd
		inputArr[index].name := dayName
		; add activity if matches input
		if (weekdayname = dayName) {
			if (inputArr[index].tasks = "") {
				inputArr[index].tasks := activity
			} else {
				inputArr[index].tasks .= "|" activity
			}
		}
		index++
	}
	return inputArr
}

;################
;An example of use
;################
^E::
msgbox J = %tstv4%
	arrayVar := {1: "Monday", 9: "Friday", 16: "Saturday", 23: "Saturday"}
	;msgbox, % arrayVar[16]
	; => "Saturday"

	;msgbox, % arrayVar.16
	; => "Saturday"

	Concat := ""
	;For Each, Element In tasksVar {
	For Each, Element In arrayVar {
		if (Concat <> "")  ; Concat is not empty, so add a line feed
			Concat .= "`n" ; Add something at the end of every element. In this case, a new line.
			Concat .= Element

	}
	if (Element in arrayVar = "Monday"){
		msgbox Monday
	}
	MsgBox, %Concat%
return



	return

	fn_filterOldDaysFunc(inputVar)
	{
		while (inputVar[1].day < A_YYYY A_MM A_DD "000000") {
			inputVar.removeAt(1)
		}
		return inputVar
	}

; #################################
;           L a b e l s           ;
; #################################
; P l u s  B u t t o n ;
; ######################

Plus0:
Plus1:
Plus2:
Plus3:
Plus4:
Plus5:
if (Loo = 1) {
		DayCheckYear()
	Loop{
		if (Loo = 6){
			ND:=ND-5
			break
		}
		NewDY:=NewDY+160
		Gui, MemGUI:Add, Picture, x0 y%NewDY% w200 h150 Disabled hwnd%ND%BGHwnd v%ND%BG g%ND%BG,
		Gui, MemGUI:Add, Picture, x0 yp+149 w200 h10 hwndMinus%ND%Hwnd vMinus%ND% gMinus%ND%,
		Gui, MemGUI:Add, Picture, x0 yp w200 h10 hwndPlus%ND%Hwnd vPlus%ND% gPlus%ND%,
		Gui, MemGUI:Font, S14, Tahoma

		if (Loo = 1){
		;Below code replace the next 1-line code. Determines the day after today. Used for alligning "(Tomorrow)" to the end of the day name.
		;Gui, MemGUI:Add, Text, x7 yp-145 h25 BackgroundTrans hwndText%ND%1Hwnd vText%ND%1 gText%ND%1, %dayday%
			if (A_WDay = 1) {
				Gui, MemGUI:Add, Text, x7 yp-145 h25 BackgroundTrans hwndText%ND%1Hwnd vText%ND%1 gText%ND%1, Monday
			}
			else if (A_WDay = 2) {
				Gui, MemGUI:Add, Text, x7 yp-145 h25 BackgroundTrans hwndText%ND%1Hwnd vText%ND%1 gText%ND%1, Tuesday
			}
			else if (A_WDay = 3) {
				Gui, MemGUI:Add, Text, x7 yp-145 h25 BackgroundTrans hwndText%ND%1Hwnd vText%ND%1 gText%ND%1, Wednesday
			}
			else if (A_WDay = 4) {
				Gui, MemGUI:Add, Text, x7 yp-145 h25 BackgroundTrans hwndText%ND%1Hwnd vText%ND%1 gText%ND%1, Thursday
			}
			else if (A_WDay = 5) {
				Gui, MemGUI:Add, Text, x7 yp-145 h25 BackgroundTrans hwndText%ND%1Hwnd vText%ND%1 gText%ND%1, Friday
			}
			else if (A_WDay = 6) {
				Gui, MemGUI:Add, Text, x7 yp-145 h25 BackgroundTrans hwndText%ND%1Hwnd vText%ND%1 gText%ND%1, Saturday
			}
			else if (A_WDay = 7) {
				Gui, MemGUI:Add, Text, x7 yp-145 h25 BackgroundTrans hwndText%ND%1Hwnd vText%ND%1 gText%ND%1, Sunday
			}

			Gui, MemGUI:Font, S10, Tahoma
			Gui, MemGUI:Add, Text, x+3 yp+7 h20 BackgroundTrans hwndText%ND%2Hwnd vText%ND%2 gText%ND%2, (Tomorrow)
			Gui, MemGUI:Font, S12, Tahoma
			Gui, MemGUI:Add, Picture, x7 yp+24 w19 h19 hwndChckbx%ND%1Hwnd vChckbx%ND%1 gChckbx%ND%1,
			Gui, MemGUI:Add, Text, x30 yp w180 h20 BackgroundTrans hwndTxt%ND%1Hwnd vTxt%ND%1 gTxt%ND%1,
		}

		if (Loo > 1) {
		Gui, MemGUI:Add, Text, x7 yp-145 w110 h25 BackgroundTrans hwndText%ND%1Hwnd vText%ND%1 gText%ND%1, %NDY0%
		;Gui, MemGUI:Add, Text, x7 yp-145 w110 h25 BackgroundTrans hwndText%ND%1Hwnd vText%ND%1 gText%ND%1, %dayday%
		Gui, MemGUI:Font, S12, Tahoma
		Gui, MemGUI:Add, Picture, x7 yp+29 w19 h19 hwndChckbx%ND%1Hwnd vChckbx%ND%1 gChckbx%ND%1,
		Gui, MemGUI:Add, Text, x30 yp w180 h20 BackgroundTrans hwndTxt%ND%1Hwnd vTxt%ND%1 gTxt%ND%1,
		}

		Gui, MemGUI:Add, Picture, x7 yp+23 w19 h19 hwndChckbx%ND%2Hwnd vChckbx%ND%2 gChckbx%ND%2,
		Gui, MemGUI:Add, Text, x30 yp w180 h20 BackgroundTrans hwndTxt%ND%2Hwnd vTxt%ND%2 gTxt%ND%2,
		Gui, MemGUI:Add, Picture, x7 yp+23 w19 h19 hwndChckbx%ND%3Hwnd vChckbx%ND%3 gChckbx%ND%3,
		Gui, MemGUI:Add, Text, x30 yp w180 h20 BackgroundTrans hwndTxt%ND%3Hwnd vTxt%ND%3 gTxt%ND%3,
		Gui, MemGUI:Add, Picture, x7 yp+23 w19 h19 hwndChckbx%ND%4Hwnd vChckbx%ND%4 gChckbx%ND%4,
		Gui, MemGUI:Add, Text, x30 yp w180 h20 BackgroundTrans hwndTxt%ND%4Hwnd vTxt%ND%4 gTxt%ND%4,
		Gui, MemGUI:Add, Picture, x7 yp+23 w19 h19 hwndChckbx%ND%5Hwnd vChckbx%ND%5 gChckbx%ND%5,
		Gui, MemGUI:Add, Text, x30 yp w180 h20 BackgroundTrans hwndTxt%ND%5Hwnd vTxt%ND%5 gTxt%ND%5,

		ND++
		Loo++
	}
}

; After creating next day, this modifies the new plus and minus buttons.
NextDay()
selectedDay += 1, days
selectedDay := subStr(selectedDay, 1, 8)
; FormatTime, daynum, selectedDay, WDay

dayElement := A.find(daysVar, {"day": selectedDay})
	ND--
	GuiControl, MemGUI:, Plus%ND%
	GuiControl, Disable, Plus%ND%
	GuiControl, Enable, Minus%ND%
	GuiControl, MemGUI:, Minus%ND%, Icons\Remove.png
	ND++
	GuiControl, MemGUI:, %ND%BG, Icons\Today.png
	GuiControl, MemGUI:, Text%ND%1, %dayday%
	if (ND = 1) {
		GuiControl, MemGUI:, Text%ND%2, (Tomorrow)
	}
	GuiControl, MemGUI:, Minus%ND%
	GuiControl, Disable, Minus%ND%
	GuiControl, Enable, Plus%ND%

	; add all the icons and checkboxes
	GuiControl, MemGUI:, Plus%ND%, Icons\Add.png
	for key, value in (strSplit(dayElement.tasks, "|")) {
		GuiControl, MemGUI:, Chckbx%ND%%key%, Icons\ChckbxN.png

		; add task text
		GuiControl, MemGUI:, Txt%ND%%A_Index%, % value
	}



	ND++
	k++
return

; ########################
; M i n u s  B u t t o n ;
; ########################

Minus0:
Minus1:
Minus2:
Minus3:
Minus4:
Minus5:
ND--
ND--
	PrevDay()
	selectedDay += -1, days
ND--
	GuiControl, MemGUI:, Plus%ND%,
	GuiControl, Disable, Plus%ND%
	GuiControl, Enable, Minus%ND%
	GuiControl, MemGUI:, Minus%ND%, Icons\Remove.png
ND++
	GuiControl, MemGUI:, Minus%ND%,
	GuiControl, Disable, Minus%ND%
	GuiControl, Enable, Plus%ND%
	GuiControl, MemGUI:, Plus%ND%, Icons\Add.png
ND++
	GuiControl, MemGUI:, %ND%BG,
	GuiControl, MemGUI:, Text%ND%1,
	GuiControl, MemGUI:, Text%ND%2,
	GuiControl, MemGUI:, Plus%ND%,
	GuiControl, MemGUI:, Chckbx%ND%1,
	GuiControl, MemGUI:, Chckbx%ND%2,
	GuiControl, MemGUI:, Chckbx%ND%3,
	GuiControl, MemGUI:, Chckbx%ND%4,
	GuiControl, MemGUI:, Chckbx%ND%5,
	GuiControl, MemGUI:, Txt%ND%1,
	GuiControl, MemGUI:, Txt%ND%2,
	GuiControl, MemGUI:, Txt%ND%3,
	GuiControl, MemGUI:, Txt%ND%4,
	GuiControl, MemGUI:, Txt%ND%5,
	DayCheckYear()
	k--
return

; ####################
; E m p t y  T e x t ;
; ####################

Text01:
Text02:
Text11:
Text12:
Text21:
Text31:
Text41:
Text51:
Txt01:
Txt02:
Txt03:
Txt04:
Txt05:
Txt11:
Txt12:
Txt13:
Txt14:
Txt15:
Txt21:
Txt22:
Txt23:
Txt24:
Txt25:
Txt31:
Txt32:
Txt33:
Txt34:
Txt35:
Txt41:
Txt42:
Txt43:
Txt44:
Txt45:
Txt51:
Txt52:
Txt53:
Txt54:
Txt55:
return

; #####################
; C h e c k b o x e s ;
; #####################
; ###########
;    O n e  ;
; ###########

0BG:
	;WinSet, Bottom,,
return

Chckbx01:
	;msgbox % A_WDay
	DayCheckYear()
	GuiControl, MemGUI:, %A_GuiControl%, % (%ND%1 := !%ND%1) ? "Icons\ChckbxY.png" : "Icons\ChckbxN.png"
return
Chckbx02:
selectedDay:=selectedDay-3000000
	GuiControl, MemGUI:, %A_GuiControl%, % (%ND%2 := !%ND%2) ? "Icons\ChckbxY.png" : "Icons\ChckbxN.png"
return
Chckbx03:
	GuiControl, MemGUI:, %A_GuiControl%, % (%ND%3 := !%ND%3) ? "Icons\ChckbxY.png" : "Icons\ChckbxN.png"
return
Chckbx04:
	GuiControl, MemGUI:, %A_GuiControl%, % (%ND%4 := !%ND%4) ? "Icons\ChckbxY.png" : "Icons\ChckbxN.png"
return
Chckbx05:
	GuiControl, MemGUI:, %A_GuiControl%, % (%ND%5 := !%ND%5) ? "Icons\ChckbxY.png" : "Icons\ChckbxN.png"
return

; ###########
;    T w o  ;
; ###########

1BG:
	;WinSet, Bottom,,
return

Chckbx11:
	DayCheckTom()
	GuiControl, MemGUI:, %A_GuiControl%, % (%ND%1 := !%ND%1) ? "Icons\ChckbxY.png" : "Icons\ChckbxN.png"
return
Chckbx12:
	GuiControl, MemGUI:, %A_GuiControl%, % (%ND%2 := !%ND%2) ? "Icons\ChckbxY.png" : "Icons\ChckbxN.png"
return
Chckbx13:
	GuiControl, MemGUI:, %A_GuiControl%, % (%ND%3 := !%ND%3) ? "Icons\ChckbxY.png" : "Icons\ChckbxN.png"
return
Chckbx14:
	GuiControl, MemGUI:, %A_GuiControl%, % (%ND%4 := !%ND%4) ? "Icons\ChckbxY.png" : "Icons\ChckbxN.png"
return
Chckbx15:
	GuiControl, MemGUI:, %A_GuiControl%, % (%ND%5 := !%ND%5) ? "Icons\ChckbxY.png" : "Icons\ChckbxN.png"
return

; ###########
; T h r e e ;
; ###########

2BG:
	;WinSet, Bottom,,
return

Chckbx21:
	DayCheckTT()
	GuiControl, MemGUI:, %A_GuiControl%, % (%ND%1 := !%ND%1) ? "Icons\ChckbxY.png" : "Icons\ChckbxN.png"
return
Chckbx22:
	GuiControl, MemGUI:, %A_GuiControl%, % (%ND%2 := !%ND%2) ? "Icons\ChckbxY.png" : "Icons\ChckbxN.png"
return
Chckbx23:
	GuiControl, MemGUI:, %A_GuiControl%, % (%ND%3 := !%ND%3) ? "Icons\ChckbxY.png" : "Icons\ChckbxN.png"
return
Chckbx24:
	GuiControl, MemGUI:, %A_GuiControl%, % (%ND%4 := !%ND%4) ? "Icons\ChckbxY.png" : "Icons\ChckbxN.png"
return
Chckbx25:
	GuiControl, MemGUI:, %A_GuiControl%, % (%ND%5 := !%ND%5) ? "Icons\ChckbxY.png" : "Icons\ChckbxN.png"
return

; ###########
;   F o u r ;
; ###########

3BG:
	;WinSet, Bottom,,
return

Chckbx31:
	DayCheckTT()
	GuiControl, MemGUI:, %A_GuiControl%, % (%ND%1 := !%ND%1) ? "Icons\ChckbxY.png" : "Icons\ChckbxN.png"
return
Chckbx32:
	GuiControl, MemGUI:, %A_GuiControl%, % (%ND%2 := !%ND%2) ? "Icons\ChckbxY.png" : "Icons\ChckbxN.png"
return
Chckbx33:
	GuiControl, MemGUI:, %A_GuiControl%, % (%ND%3 := !%ND%3) ? "Icons\ChckbxY.png" : "Icons\ChckbxN.png"
return
Chckbx34:
	GuiControl, MemGUI:, %A_GuiControl%, % (%ND%4 := !%ND%4) ? "Icons\ChckbxY.png" : "Icons\ChckbxN.png"
return
Chckbx35:
	GuiControl, MemGUI:, %A_GuiControl%, % (%ND%5 := !%ND%5) ? "Icons\ChckbxY.png" : "Icons\ChckbxN.png"
return

; ###########
;   F i v e ;
; ###########

4BG:
	;WinSet, Bottom,,
return

Chckbx41:
	DayCheckTT()
	GuiControl, MemGUI:, %A_GuiControl%, % (%ND%1 := !%ND%1) ? "Icons\ChckbxY.png" : "Icons\ChckbxN.png"
return
Chckbx42:
	GuiControl, MemGUI:, %A_GuiControl%, % (%ND%2 := !%ND%2) ? "Icons\ChckbxY.png" : "Icons\ChckbxN.png"
return
Chckbx43:
	GuiControl, MemGUI:, %A_GuiControl%, % (%ND%3 := !%ND%3) ? "Icons\ChckbxY.png" : "Icons\ChckbxN.png"
return
Chckbx44:
	GuiControl, MemGUI:, %A_GuiControl%, % (%ND%4 := !%ND%4) ? "Icons\ChckbxY.png" : "Icons\ChckbxN.png"
return
Chckbx45:
	GuiControl, MemGUI:, %A_GuiControl%, % (%ND%5 := !%ND%5) ? "Icons\ChckbxY.png" : "Icons\ChckbxN.png"
return

; ###########
;    S i x  ;
; ###########

5BG:
	;WinSet, Bottom,,
return

Chckbx51:
	DayCheckTT()
	GuiControl, MemGUI:, %A_GuiControl%, % (%ND%1 := !%ND%1) ? "Icons\ChckbxY.png" : "Icons\ChckbxN.png"
return
Chckbx52:
	GuiControl, MemGUI:, %A_GuiControl%, % (%ND%2 := !%ND%2) ? "Icons\ChckbxY.png" : "Icons\ChckbxN.png"
return
Chckbx53:
	GuiControl, MemGUI:, %A_GuiControl%, % (%ND%3 := !%ND%3) ? "Icons\ChckbxY.png" : "Icons\ChckbxN.png"
return
Chckbx54:
	GuiControl, MemGUI:, %A_GuiControl%, % (%ND%4 := !%ND%4) ? "Icons\ChckbxY.png" : "Icons\ChckbxN.png"
return
Chckbx55:
	GuiControl, MemGUI:, %A_GuiControl%, % (%ND%5 := !%ND%5) ? "Icons\ChckbxY.png" : "Icons\ChckbxN.png"
return

; #################################
;        V a r i a b l e s
; #################################
;Day of the year check (accurate in 2022).
DayCheckYear(){
	OutputDebug, Day/Month %A_DD%/%A_MM%
	OutputDebug, Day of Year %A_YDay%
	OutputDebug, %A_WDay%

	dayday:=A_WDay
	OutputDebug, %dayday%
	dayday:=A_WDay+1
	OutputDebug, %dayday%

	loop{
		c:=b
		b:=b+7

		Satdy:=1+c
		Sundy:=2+c
		Mondy:=3+c
		Tuedy:=4+c
		Weddy:=5+c
		Thudy:=6+c
		Fridy:=7+c

		if (A_YDay = 1 + c){
			NDY0 = Saturday
			NDY1 = Sunday
			NDY2 = Monday
			NDY3 = Tuesday
			NDY4 = Wednesday
			NDY5 = Thursday
			NDY6 = Friday
			OutputDebug, %b%
			OutputDebug, dy Saturday
			break
		}
		if (A_YDay = 2 + c){
			NDY0 = Sunday
			NDY1 = Monday
			NDY2 = Tuesday
			NDY3 = Wednesday
			NDY4 = Thursday
			NDY5 = Friday
			NDY6 = Saturday
			OutputDebug, %b%
			OutputDebug, dy Sunday
			break
		}
		if (A_YDay = 3 + c){
			NDY0 = Monday
			NDY1 = Tuesday
			NDY2 = Wednesday
			NDY3 = Thursday
			NDY4 = Friday
			NDY5 = Saturday
			NDY6 = Sunday
			OutputDebug, %b%
			OutputDebug, dy Monday
			;msgbox hello
			break
			;msgbox bye
		}
		if (A_YDay = 4 + c){
			NDY0 = Tuesday
			NDY1 = Wednesday
			NDY2 = Thursday
			NDY3 = Friday
			NDY4 = Saturday
			NDY5 = Sunday
			NDY6 = Monday
			OutputDebug, %b%
			OutputDebug, dy Tuesday
			break
		}
		if (A_YDay = 5 + c){
			NDY0 = Wednesday
			NDY1 = Thursday
			NDY2 = Friday
			NDY3 = Saturday
			NDY4 = Sunday
			NDY5 = Monday
			NDY6 = Tuesday
			OutputDebug, %b%
			OutputDebug, dy Wednesday
			break
		}
		if (A_YDay = 6 + c){
			NDY0 = Thursday
			NDY1 = Friday
			NDY2 = Saturday
			NDY3 = Sunday
			NDY4 = Monday
			NDY5 = Tuesday
			NDY6 = Wednesday
			OutputDebug, %b%
			OutputDebug, dy Thursday
			break
		}
		if (A_YDay = 7 + c){
			NDY0 = Friday
			NDY1 = Saturday
			NDY2 = Sunday
			NDY3 = Monday
			NDY4 = Tuesday
			NDY5 = Wednesday
			NDY6 = Thursday
			OutputDebug, %b%
			OutputDebug, dy Friday
			break
		}
			;OutputDebug, Checking #%c% to #%b%
			;OutputDebug, Saturday: %Satdy%
			;OutputDebug, Sunday: %Sundy%
			;OutputDebug, Monday: %Mondy%
			;OutputDebug, Tuesday: %Tuedy%
			;OutputDebug, Wednesday: %Weddy%
			;OutputDebug, Thursday: %Thudy%
			;OutputDebug, Friday: %Fridy%
			;sleep 500
		AYDAY0 := A_YDay
	}

;Example of use.
			;msgbox NDY0 = %NDY0%
	if (A_YDay = Satdy){
		OutputDebug It's Saturday
	}
	if (A_YDay = Fridy){
		OutputDebug It's Friday
	}
}

(DayCheckYear)
if (A_YDay = Satdy){

}

Setdaynum(){
	;%i% +7 = nw
	if (A_WDay = 1){
		daynum=1
		OutputDebug, dw Sunday
	}
	if (A_WDay = 2){
		daynum=2
		OutputDebug, dw Monday
	}
	if (A_WDay = 3){
		daynum=3
		OutputDebug, dw Tuesday
	}
	if (A_WDay = 4){
		daynum=4
		OutputDebug, dw Wednesday
	}
	if (A_WDay = 5){
		daynum=5
		OutputDebug, dw Thursday
	}
	if (A_WDay = 6){
		daynum=6
		OutputDebug, dw Friday
	}
	if (A_WDay = 7){
		daynum=7
		OutputDebug, dw Saturday
	}
}
Namedaynum(){
	if (daynum = 1){
		dayday=Sunday
		OutputDebug, dw Sunday
	}
	if (daynum = 2){
		dayday=Monday
		OutputDebug, dw Monday
	}
	if (daynum = 3){
		dayday=Tuesday
		OutputDebug, dw Tuesday
	}
	if (daynum = 4){
		dayday=Wednesday
		OutputDebug, dw Wednesday
	}
	if (daynum = 5){
		dayday=Thursday
		OutputDebug, dw Thursday
	}
	if (daynum = 6){
		dayday=Friday
		OutputDebug, dw Friday
	}
	if (daynum = 7){
		dayday=Saturday
		OutputDebug, dw Saturday
	}
}

NextDay(){
	if (daynum=7){
		daynum=1
	}
	else{
		daynum++
	}
	Namedaynum()
}
PrevDay(){
	if (daynum=0){
		daynum=6
	}
	else{
		daynum--
	}
	Namedaynum()
}

DayCheckTom(){
	if (A_WDay = 1 + 6){
		OutputDebug, Sunday
	}
	if (A_WDay = 2 - 1){
		OutputDebug, Monday
	}
	if (A_WDay = 3 - 1){
		OutputDebug, Tuesday
	}
	if (A_WDay = 4 - 1){
		OutputDebug, Wednesday
	}
	if (A_WDay = 5 - 1){
		OutputDebug, Thursday
	}
	if (A_WDay = 6 - 1){
		OutputDebug, Friday
	}
	if (A_WDay = 7 - 1){
		OutputDebug, Saturday
	}
}

DayCheckTT(){
	if (A_WDay = 1 + 6){
		OutputDebug, Sunday
	}
	if (A_WDay = 2 - 1){
		OutputDebug, Monday
	}
	if (A_WDay = 3 - 1){
		OutputDebug, Tuesday
	}
	if (A_WDay = 4 - 1){
		OutputDebug, Wednesday
	}
	if (A_WDay = 5 - 1){
		OutputDebug, Thursday
	}
	if (A_WDay = 6 - 1){
		OutputDebug, Friday
	}
	if (A_WDay = 7 - 1){
		OutputDebug, Saturday
	}
}

; ################
;      O n e
; ################


; ################
;      T w o
; ################


; ################
;     T h r e e
; ################


; ################
;    E x c e l
; ################

;The code to output data from AHK to XLS
Excel_Get(WinTitle:="ahk_class XLMAIN", Excel7#:=1) {
	static h := DllCall("LoadLibrary", "Str", "oleacc", "Ptr")
	WinGetClass, WinClass, %WinTitle%
	if !(WinClass == "XLMAIN")
		return "Window class mismatch."
	ControlGet, hwnd, hwnd,, Excel7%Excel7#%, %WinTitle%
	if (ErrorLevel)
		return "Error accessing the control hWnd."
	VarSetCapacity(IID_IDispatch, 16)
	NumPut(0x46000000000000C0, NumPut(0x0000000000020400, IID_IDispatch, "Int64"), "Int64")
	if DllCall("oleacc\AccessibleObjectFromWindow", "Ptr", hWnd, "UInt", -16, "Ptr", &IID_IDispatch, "Ptr*", pacc) != 0
		return "Error calling AccessibleObjectFromWindow."
	window := ComObject(9, pacc, 1)
	if ComObjType(window) != 9
		return "Error wrapping the window object."
	Loop
		try return window.Application
	catch e
		if SubStr(e.message, 1, 10) = "0x80010001"
		ControlSend, Excel7%Excel7#%, {Esc}, %WinTitle%
	else
		return "Error accessing the application object."
}

; #################################
;         I n c l u d e s
; #################################

; #include Dates.ahk
