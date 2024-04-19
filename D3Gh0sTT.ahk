#Persistent
#SingleInstance force
#NoEnv
SetBatchLines, -1
SendMode, Input
SetWorkingDir %A_ScriptDir%
Loop %A_ScriptDir%\*.config
files .= (( files <> "" ) ? "|" : "" ) A_LoopFileName
SysGet, screenWidth, 0
SysGet, screenHeight, 1
centerX := (screenWidth // 2)

Gui 1: add, Text,, Charger un réglage existant:
Gui 1: add, ComboBox, Simple w320 r20 vScript, %files%
Gui 1: add, Button, h25 +Default gRunScript, Lancer
Gui 1: add, Button,yp h25 x+75 gCreateNewConfig, Créer un nouveau fichier de configuration

Gui 2: add, Tab2, w450 h200, Infos|Nom du réglage|Raccourcis|Cooldowns|Fin
Gui 2: add, Text, x20 y40 w435 h150, Bienvenue dans mon script pour Diablo III.`n`nCe script permet de lancer automatiquement les sorts de votre choix quand vous appuyez sur F1.`nPour mettre en pause, rappuyez sur F1.
Gui 2: Tab, Nom du réglage
Gui 2: add, Text, x20 y50 , Définir le nom de votre réglage:
Gui 2: add, Edit, x180 y47 w50 vSetting , 
Gui 2: add, Text, x20 y120 , Lancer automatiquement la compétence clic gauche lors de l'appui sur Shift Gauche :
Gui 2: add, Checkbox, x430 y120 vShiftClic ,
Gui 2: Tab, Raccourcis
Gui 2: add, Text, x20 y40 , Les touches en jeu de vos 4 compétences
Gui 2: add, Text, x30 y70 , Compétence 1:
Gui 2: add, Hotkey, x110 y67 w50 vKey1 , 
Gui 2: add, Text, x205 y70 , Compétence 2:
Gui 2: add, Hotkey, x285 y67 w50 vKey2 , 
Gui 2: add, Text, x30 y100 , Compétence 3:
Gui 2: add, Hotkey, x110 y97 w50 vKey3 , 
Gui 2: add, Text, x205 y100 , Compétence 4:
Gui 2: add, Hotkey, x285 y97 w50 vKey4 , 
Gui 2: Tab, Cooldowns
Gui 2: add, Text, x20 y40 , Les temps de recharge de vos compétences (en secondes).`nIl y a 30ms d'aléatoire sur les temps de recharge.`nExemple: si vous entrez 40, la compétence sera lancée toutes les 39,97-40 secondes.
Gui 2: add, Text, x30 y90 , Compétence 1:
Gui 2: add, Edit, x110 y87 w50 vTimer1 , 
Gui 2: add, Text, x205 y90 , Compétence 2:
Gui 2: add, Edit, x285 y87 w50 vTimer2 , 
Gui 2: add, Text, x30 y120 , Compétence 3:
Gui 2: add, Edit, x110 y117 w50 vTimer3 , 
Gui 2: add, Text, x205 y120 , Compétence 4:
Gui 2: add, Edit, x285 y117 w50 vTimer4 , 
Gui 2: add, Text, x20 y160 , SI VOUS NE VOULEZ PAS QU'UNE COMPÉTENCE SOIT LANCÉE`nAUTOMATIQUEMENT ENTREZ 0
Gui 2: Tab, Fin
Gui 2: add, Text, x20 y40 , Raccourci pour quitter le script
Gui 2: add, Hotkey, x205 y40 vExitKey , ^!Esc
Gui 2: add, Button, gButtonDone, Valider

IfNotExist, *.config
{
Gui 2: show, , Script Diablo III par Gh0sTT
}else{
    Gui 1: show,, Script Diablo III par Gh0sTT
}
return

RunScript:
	GuiControlGet, Script
    FileReadLine, ShiftC, %Script%, 1
	FileReadLine, Key1, %Script%, 2
    FileReadLine, Key2, %Script%, 3
    FileReadLine, Key3, %Script%, 4
    FileReadLine, Key4, %Script%, 5
    FileReadLine, Timer1min, %Script%, 6
    FileReadLine, Timer1, %Script%, 7
    FileReadLine, Timer2min, %Script%, 8
    FileReadLine, Timer2, %Script%, 9
    FileReadLine, Timer3min, %Script%, 10
    FileReadLine, Timer3, %Script%, 11
    FileReadLine, Timer4min, %Script%, 12
    FileReadLine, Timer4, %Script%, 13
    FileReadLine, ExitKey, %Script%, 14
    Hotkey, %ExitKey%, ExitSub
	Gui 1: destroy
return

CreateNewConfig:
    Gui 2: show, , Script Diablo III par Gh0sTT
	Gui 1: destroy
return

GuiClose:
ExitApp

2GuiClose:
ExitApp

ButtonDone:
Gui, submit
TimerVar := 30
if (Timer1 != 0) {
Timer1 := Timer1*1000
Timer1min := Timer1-TimerVar
} else {
Timer1min := 0
Timer1 := 0
}
if (Timer2 != 0) {
Timer2 := Timer2*1000
Timer2min := Timer2-TimerVar
} else {
Timer2min := 0
Timer2 := 0
}
if (Timer3 != 0) {
Timer3 := Timer3*1000
Timer3min := Timer3-TimerVar
} else {
Timer3min := 0
Timer3 := 0
}
if (Timer4 != 0) {
Timer4 := Timer4*1000
Timer4min := Timer4-TimerVar
} else {
Timer4min := 0
Timer4 := 0
}
if (ShiftClic) {
ShiftC := 1
} else {
ShiftC := 0
}
FileAppend, %ShiftC%`n, %Setting%.config
FileAppend, %Key1%`n, %Setting%.config
FileAppend, %Key2%`n, %Setting%.config
FileAppend, %Key3%`n, %Setting%.config
FileAppend, %Key4%`n, %Setting%.config
FileAppend, %Timer1min%`n, %Setting%.config
FileAppend, %Timer1%`n, %Setting%.config
FileAppend, %Timer2min%`n, %Setting%.config
FileAppend, %Timer2%`n, %Setting%.config
FileAppend, %Timer3min%`n, %Setting%.config
FileAppend, %Timer3%`n, %Setting%.config
FileAppend, %Timer4min%`n, %Setting%.config
FileAppend, %Timer4%`n, %Setting%.config
FileAppend, %ExitKey%, %Setting%.config
Hotkey, %ExitKey%, ExitSub
return

ToggleF1 := 0
F1::
ToggleF1 := !ToggleF1
if (ToggleF1 = 1) {
if (Timer1 != 0) {
Send, {%Key1% Down}
RandHold(10,30)
Send, {%Key1% Up}
RandHold(10,30)
Random, cooldown1, %Timer1min%, %Timer1%
SetTimer, spell1, %cooldown1%
}
if (Timer2 != 0) {
Send, {%Key2% Down}
RandHold(10,30)
Send, {%Key2% Up}
RandHold(10,30)
Random, cooldown2, %Timer2min%, %Timer2%
SetTimer, spell2, %cooldown2%
}
if (Timer3 != 0) {
Send, {%Key3% Down}
RandHold(10,30)
Send, {%Key3% Up}
RandHold(10,30)
Random, cooldown3, %Timer3min%, %Timer3%
SetTimer, spell3, %cooldown3%
}
if (Timer4 != 0) {
Send, {%Key4% Down}
RandHold(10,30)
Send, {%Key4% Up}
RandHold(10,30)
Random, cooldown4, %Timer4min%, %Timer4%
SetTimer, spell4, %cooldown4%
}
CoordMode, ToolTip, Screen
ToolTip, AutoCompétences: ON, %centerX%, 0
Sleep 5000
ToolTip
} else {
SetTimer, spell1, Off
SetTimer, spell2, Off
SetTimer, spell3, Off
SetTimer, spell4, Off
CoordMode, ToolTip, Screen
ToolTip, AutoCompétences: OFF, %centerX%, 0
Sleep 5000
ToolTip
}
return
~t::
if (ToggleF1 = 1) {
ToggleF1 := 0
SetTimer, spell1, Off
SetTimer, spell2, Off
SetTimer, spell3, Off
SetTimer, spell4, Off
CoordMode, ToolTip, Screen
ToolTip, Retour en ville AutoCompétences: OFF, %centerX%, 0
Sleep 5000
ToolTip
}
return
~LShift::
if (ToggleF1 = 1) {
if (ShiftC = 1) {
while GetKeyState("LShift", "P") {
Click
RandHold(10,30)
}
}
}
return

spell1:
Send, {%Key1% Down}
RandHold(10,30)
Send, {%Key1% Up}
return

spell2:
Send, {%Key2% Down}
RandHold(10,30)
Send, {%Key2% Up}
return

spell3:
Send, {%Key3% Down}
RandHold(10,30)
Send, {%Key3% Up}
return

spell4:
Send, {%Key4% Down}
RandHold(10,30)
Send, {%Key4% Up}
return

ExitSub:
ExitApp

return

RandHold(x,y) {
Random, hold, %x%, %y%
Sleep %hold%
}
return