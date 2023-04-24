#Persistent
Gui, Font, s10, Arial
Gui, Add, Text, Center h20 w300 vStatusLabel,  Me = ?    Now = ?    Next = ? 
Gui, Font, s16, Arial
Gui, Add, Text, Center cGreen h30 w300 vActionLabel, good luck       
Gui, Font, s10, Arial            
Gui, Add, DropDownList, Center w300 vPosSelect, LR|LOO|AP|SC
Gui, Add, Button, Center w300 gInit, Apply Position
Gui, Show
return

GuiClose:
    Exitapp
return

global positions := []
global counter := 0
global mPos := ""

Init()
{
    positions := ["LR", "LOO", "SC_ZONE", "AP", "SC", "NAN", "LR_ZONE", "LR", "NAN", "LOO", "NAN", "AP_ZONE", "AP", "SC", "NAN", "LOO_ZONE", "LR", "NAN", "LOO", "NAN"]
    counter := 0

    GuiControlGet, PosSelect
    if(PosSelect = "LR")
        mPos := "LR"
    if(PosSelect = "LOO")
        mPos := "LOO"
    if(PosSelect = "AP")
        mPos := "AP"
    if(PosSelect = "SC")
        mPos := "SC"

    firstAction := positions[1]
    GuiControl,, StatusLabel, Me = %mPos%    Now = ?    Next = %firstAction%
    GuiControl, +cGreen, Static2, ahk_class AutoHotkeyGUI  
    GuiControl,, ActionLabel, good luck !
}

*q::
    counter := Mod(counter + 1, positions.Length() + 1)
    if(counter = 0)
        counter := 1
    action := positions[counter]

    if(action = mPos)
    {     
        GuiControl, +cRed, Static2, ahk_class AutoHotkeyGUI  
        GuiControl,, ActionLabel, TAUNT!
    }
    Else if(action = mPos "_ZONE")
    {
        GuiControl, +cRed, Static2, ahk_class AutoHotkeyGUI
        GuiControl,, ActionLabel, ZONE!
    }
    Else
    {
        GuiControl, +cBlack, Static2, ahk_class AutoHotkeyGUI
        GuiControl,, ActionLabel, Nan
    }   
    nextAction := positions[Mod(counter, positions.Length()) + 1]
    GuiControl,, StatusLabel, Me = %mPos%    Now = %action%    Next = %nextAction%
    return