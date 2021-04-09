macroScript NitrousLightOption_Toggle
	category:"script"
	toolTip:"NitrousLightOption_Toggle"
(
	currentLightSetting = (NitrousGraphicsManager.GetActiveViewportSetting()).LightOption
		
	if currentLightSetting == #SceneLight then 
	(
		(NitrousGraphicsManager.GetActiveViewportSetting()).LightOption = #DefaultLight
	)  else (
			(NitrousGraphicsManager.GetActiveViewportSetting()).LightOption = #SceneLight
	)
)
