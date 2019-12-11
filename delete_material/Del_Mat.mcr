macroScript Del_Mat
	category:"scripts"
	toolTip:"Del_Mat"
(
	-- Delete materials in the selection
	for i in selection do i.material=undefined
)
