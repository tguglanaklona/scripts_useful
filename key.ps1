add-type -AssemblyName microsoft.VisualBasic
add-type -AssemblyName System.Windows.Forms
Terminal
start-sleep -Milliseconds 1500
[Microsoft.VisualBasic.Interaction]::AppActivate("Calc");
[System.Windows.Forms.SendKeys]::SendWait("1{ADD}1=");
