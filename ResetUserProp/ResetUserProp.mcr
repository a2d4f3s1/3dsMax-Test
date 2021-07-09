macroScript ResetUserProp
	category:"Scripts"
	buttonText:"ResetUP"
	toolTip:"ResetUserProp"
(
	for i in selection do
	(
		setUserPropBuffer i ""
		)
	messageBox "Reset \"User Defined\""
)
