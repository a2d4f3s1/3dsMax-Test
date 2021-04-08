macroScript Add_MeshSmooth
	category:"script"
	toolTip:"Add MeshSmooth"
(
	--Add MeshSmooth

	try DestroyDialog Dig_AddMeshSmooth catch()

	rollout Dig_AddMeshSmooth "Add MeshSmooth" width:200 height:320
	(
		spinner 'spn_iteration' "Iteration:" pos:[60,10] width:128 height:16 align:#right type:#integer range:[0,6,1]
		spinner 'spn_smoothness' "Smoothness:" pos:[60,30] width:128 height:16 align:#right type:#float range:[0.0,1.0,1.0]
		
		label 'lbl_render values:' "Render Values:" pos:[10,50] width:106 height:16 align:#left
		checkbox 'chk_ren_itaration' "" pos:[35,67] width:26 height:21 align:#left checked:true
		spinner 'spn_ren_iteration' "Iteration:" pos:[60,70] width:128 height:16 align:#right type:#integer range:[0,6,2]
		checkbox 'chk_ren_smooth' "" pos:[30,87] width:26 height:21 align:#left
		spinner 'spn_ren_smoothness' "Smoothness:" pos:[60,90] width:128 height:16 align:#right range:[0.0,1.0,1.0]
		
		checkbox 'chk_isoDisplay' "ISO Line Display" pos:[30,110] width:127 height:27 align:#left
		
		label 'lbl_surface parameters' "Surface Parameters" pos:[10,145] width:128 height:21 align:#left
		checkbox 'chk_smooth_result' "Smooth Result" pos:[30,160] width:128 height:18 align:#left
		label 'lbl_separate_by' "Separate by:" pos:[30,180] width:100 height:19 align:#left
		checkbox 'chk_materilas' "Materials" pos:[60,190] width:127 height:27 align:#left
		checkbox 'chk_smoothingGroups' "Smoothing Groups" pos:[60,210] width:114 height:27 align:#left checked:true
		
		edittext 'txt_modifierName' "Name:" pos:[10,248] width:178 height:16 align:#left text:"MeshSmooth_"
		
		button 'btn_addMeshSmooth' "Add MeshSmooth" pos:[15,278] width:170 height:32 align:#left
		
		--action
		on btn_addMeshSmooth pressed  do
		(
			addMeshSmooth = meshSmooth()
			
			addMeshSmooth.iterations = spn_iteration.value
			addMeshSmooth.smoothness = spn_smoothness.value
			
			addMeshSmooth.useRenderIterations = chk_ren_itaration.state
			addMeshSmooth.renderIterations = spn_ren_iteration.value
			addMeshSmooth.useRenderSmoothness = chk_ren_smooth.state
			addMeshSmooth.renderSmoothness = spn_ren_smoothness.value
			
			addMeshSmooth.isolineDisplay = chk_isoDisplay.state
			
			addMeshSmooth.smoothResult = chk_smooth_result.state
			addMeshSmooth.sepByMats = chk_materilas.state
			addMeshSmooth.sepBySmGroups = chk_smoothingGroups.state
			
			addMeshSmooth.name = txt_modifierName.text
			
			try addModifier $ (addMeshSmooth) catch()
		)
	)
	CreateDialog Dig_AddMeshSmooth
)
