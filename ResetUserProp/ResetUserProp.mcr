/*
Discription "Reset User Properties"
ver 002
*/
macroScript ResetUserProp
	category:"Scripts"
	buttonText:"ResetUP"
	toolTip:"Reset User Properties v002"
(
	if selection.count then
	(
			for i in selection do
		(
			setUserPropBuffer i ""
			)
		messageBox "Reset \"User Defined\""
	) else (
		messageBox "Please select targets."
	)
)
