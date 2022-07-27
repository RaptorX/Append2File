#SingleInstance
#Requires Autohotkey v1.1.33+
;--
;@Ahk2Exe-SetVersion 1.0.0-alpha.1
;@Ahk2Exe-SetProductName Append2File
;@Ahk2Exe-SetDescription Allows you to append arbitraty strings at the beginning or end of ahk files in a selected folder
/**
 * ============================================================================ *
 * @Author           : RaptorX                                                  *
 * @Homepage         :                                                          *
 *                                                                              *
 * @Created          : July 26, 2022                                            *
 * @Modified         : July 27, 2022                                            *
 * ============================================================================ *
 * License:                                                                     *
 * Copyright ©2022 RaptorX <GPLv3>                                              *
 *                                                                              *
 * This program is free software: you can redistribute it and/or modify         *
 * it under the terms of the **GNU General Public License** as published by     *
 * the Free Software Foundation, either version 3 of the License, or            *
 * (at your option) any later version.                                          *
 *                                                                              *
 * This program is distributed in the hope that it will be useful,              *
 * but **WITHOUT ANY WARRANTY**; without even the implied warranty of           *
 * **MERCHANTABILITY** or **FITNESS FOR A PARTICULAR PURPOSE**.  See the        *
 * **GNU General Public License** for more details.                             *
 *                                                                              *
 * You should have received a copy of the **GNU General Public License**        *
 * along with this program. If not, see:                                        *
 * <http://www.gnu.org/licenses/gpl-3.0.txt>                                    *
 * ============================================================================ *
 */

;{#Includes
 #Include <gui\main>
 #Include <ScriptObject\ScriptObject>

 global script := {base         : script
                 ,name          : regexreplace(A_ScriptName, "\.\w+")
                 ,version      : "1.0.0-alpha.1"
                 ,author       : "RaptorX"
                 ,email        : ""
                 ,crtdate      : "July 26, 2022"
                 ,moddate      : "July 27, 2022"
                 ,homepagetext : ""
                 ,homepagelink : ""
                 ,donateLink   : "https://www.paypal.com/donate?hosted_button_id=MBT5HSD9G94N6"
                 ,resfolder    : A_ScriptDir "\res"
                 ,iconfile     : A_ScriptDir "\res\sct.ico"
                 ,configfile   : A_ScriptDir "\settings.ini"
                 ,configfolder : A_ScriptDir ""}
;}
;{#Directives
;}--
;{#Settings
;}

try script.Update("https://raw.githubusercontent.com/RaptorX/Append2File/master/ver"
                 ,"https://github.com/RaptorX/Append2File/releases/download/latest/Append2File.zip")
Catch err
	if err.code != 6
		MsgBox err.msg

Gui, Show
return