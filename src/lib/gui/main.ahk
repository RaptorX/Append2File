#Requires Autohotkey v1.1.33+
Gui, Main:New
Gui, Add, GroupBox, w300 Section, % "Path to Search"
Gui, Add, Edit, xp+5 yp+20 w210 vwDir
Gui, Add, Button, x+5 yp-1 w75, % "Browse"

Gui, Add, GroupBox, xs w300 r6 Section, % "Options"
Gui, Add, Text, xp+5 yp+25, % "Skip files containing:"
Gui, Add, Edit, xp y+m w290 vFindText, % "#Requires"
Gui, Add, Text, xp y+m, % "Append:"
Gui, Add, Checkbox, x+5 Checked vbof, % "at the beginning"
Gui, Add, Edit, xs+5 y+m w290 vAppendText, % "#Requires Autohotkey v1.1.33+"
Gui, Add, Button, xm w75, % "OK"

MainButtonBrowse(CtrlHwnd, GuiEvent, EventInfo, ErrLevel:="")
{
	FileSelectFolder, sDir, *%A_ScriptDir%
	if !sDir
		return
	
	GuiControl,, wDir, %sDir%
	GuiControl, Focus, wDir
	Send, {end}
}

MainButtonOK(CtrlHwnd, GuiEvent, EventInfo, ErrLevel:="")
{
	global

	Gui, Main:Submit, NoHide

	if (!wDir || !FindText || !AppendText)
	{
		MsgBox, % "Missing required information"
		return
	}

	Gui, Main:Submit
	
	Gui Progress:New, -Caption
	Gui Add, Progress, vwProgress -Smooth 0x8 w350 h5 ; PBS_MARQUEE = 0x8
	Gui Add, Text, w350 Center vpTitle, Working
	Gui Show
	
	fixCount := skipCount := 0
	Loop, Files, %wDir%\*.ahk, FR
	{
		FileRead, wFile, %A_LoopFileFullPath%
		
		if !Mod(A_Index, 5)
			GuiControl,, wProgress, 1
		
		GuiControl,, pTitle, % A_Index " files checked"
		if RegExMatch(wFile, "im`a)^" FindText)   ; match when file uses `n`r or `n
		{
			skipCount++
			Continue
		}
		
		fixCount++
		hFile := FileOpen(A_LoopFileFullPath, "w-")
		
		switch bof
		{
		case true:
			hFile.Write(AppendText "`n" wFile)
		case false:
			hFile.Write(wFile "`n" AppendText)
		}
		hFile.Close()
	}
	
	Gui Progress:Destroy

	MsgBox, % fixCount " files fixed.`n"
	      .   skipCount " files skipped."
	ExitApp
}

MainGuiClose()
{
	ExitApp
}