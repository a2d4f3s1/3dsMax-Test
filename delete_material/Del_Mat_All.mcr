macroScript Del_Mat
	category:"scripts"
	toolTip:"Del_Mat_All"
(
	-- Delete materials in the scene
	for i in objects do (
		i.material = undefined
	)
)
