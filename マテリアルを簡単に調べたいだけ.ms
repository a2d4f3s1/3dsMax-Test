--マテリアルを簡単に調べたいだけ
(
	--関数：マテリアル名
	function Fn_MatName = (
		if (selection.count) == 1 then  (
			return selection [1].material.name as string
			) else (
			return "selected any object"
			)
		)
	--関数：文字数
	function Fn_updateWidth charCount = return (charCount.count*8)
		
	MaterialName = Fn_MatName()
	
	try(Destroydialog test) catch()
	rollout test "test"
	(
		edittext ET_materialName "Material Name :" text:MaterialName readOnly:true
		button btnMat "Update" across:2
		button btnOpenProperty "Open Property"
		
		on btnMat pressed do (
			MaterialName = Fn_MatName()
			ET_materialName.text = MaterialName
			test.width = (100+Fn_updateWidth(MaterialName))
			)
		)
		on btnMat btnOpenProperty do (
			actionMan.executeAction 0 "40022"
			)
	
	createDialog test width:(100+Fn_updateWidth(MaterialName))
)