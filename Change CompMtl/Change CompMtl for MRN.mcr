macroScript Change_CompMtl_ForImarin
	category:"script"
	toolTip:"CCMM"
(
	--Change_CompMtl_ForImarin
	--ver.210421.01
	--合成マテリアルの切り替え
	(
		try DestroyDialog Change_CompMtl_ForMRN catch ()
		rollout Change_CompMtl_ForMRN "Change CompMtl for MRN" width:220  height:220
		(
			radioButtons 'rdo1' "Change Composite Material" pos:[20,10] labels:#("(00) Standard / Mask Charactor","(01) P4Mlt + Line","(02) Mask Parts","(03) Mask Emission","(04) Mask Eye","(05) Normal","(06) Falloff","(07) Wepon Mask","(08) ","(09) ") default:2 align:#left
			button 'btn_change' "Change" pos:[60,190] width:100  align:#center
			
			on btn_change pressed do (
				rboState = rdo1.state as integer -1
				print ("select Map = "+ rboState as string)
				
				for i in (getClassInstances CompositeMaterial) do (
					print i.name
					for j = 1 to 9 do (
						if j== rboState then (
							i.mapEnables[j] = on
						) else (
							i.mapEnables[j] = off
						)
					)
				)
			)
		) CreateDialog Change_CompMtl_ForMRN
	)
)
