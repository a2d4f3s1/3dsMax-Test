macroScript SceneSwitchForMRN
	category:"script"
	toolTip:"SwMRN"
(
	--Scene Switch forMRN
	--210415.01

	(
		--Fn 数を比較してフラグを返す
		fn fn_triState mainNum slaveNum =
		(
			TriState = 0
			if slaveNum == 0 then --状態判定
			(
				TriState = 0
			) else if (slaveNum == mainNum) then (
				TriState = 1
			) else (
				TriState = 2
			)
			TriState -- 結果
		)

		--エフェクトのP4ラインの現在の状態
		FxLineCount = 0 --Pencil__4_Line の数
		FxLineCheckCount = 0 --Pencil__4_Line の有効数
		FxLineElementCount = 0 --Pencil__4_Line のRenderElementsOnlyの有効数
		ExLineTriState = 0 --フラグ（アクティブ）
		ExLineElementTriState = 0 --フラグ（レンダーエレメントのみ）

		for i = 1 to numEffects do
		(
			tempFX = getEffect i
			if (classof tempFX == Pencil__4_Line) do (
				FxLineCount +=1
				if (IsActive tempFX == true) do ( FxLineCheckCount +=1)
				if (tempFX.RenderElementOnly == true) do  ( FxLineElementCount +=1)
			)
		)

		ExLineTriState = fn_triState FxLineCount FxLineCheckCount --関数"fn_triState"
		ExLineElementTriState = fn_triState FxLineCount FxLineElementCount --関数"fn_triState"

		--レンダーエレメントの全体の状態
		re = maxOps.GetCurRenderElementMgr() -- get the current render element manager
		reActive = re.GetElementsActive() as integer --フラグ


		--特定パーツの表示/非表示
		TgtObjNames = #("MRN_mesh_NoseLine_Generator","marin_mesh_hand_line","ICK_mesh_NoseLine_Generator","ICK_mesh_hand_line")
		TgtObjs = #()
		TbtObjHideCount = 0 --非表示数
		TgtObjsTriState = 0 --フラグ
		--特定パーツの取得
		for TmpGeo in geometry do
		(
			for i = 1 to TgtObjNames.count do
			(
				if TmpGeo.name == TgtObjNames[i] do (append TgtObjs TmpGeo)
			)
		)
		--特定パーツの非表示状態を比較
		for i = 1 to TgtObjs.count do
		(
			if TgtObjs[i].isHiddenInVpt do TbtObjHideCount +=1
		)

		TgtObjsTriState = fn_triState TgtObjs.count TbtObjHideCount --関数"fn_triState"


		--ロールアウト
		try DestroyDialog Scene_Switch catch ()
		rollout Scene_Switch "Scene Switch forMRN" width:239 height:134
		(
			checkbox 'chk_LineActive' "Effects P4Line Active" pos:[10,10] width:200 height:20 align:#left triState:ExLineTriState
			checkbox 'chk_LineElementOnly' "Effects P4Line RenderElemnt only" pos:[30,40] width:200 height:20 align:#left triState:ExLineElementTriState
			checkbox 'chk_REActive' "RenderElements Active" pos:[10,70] width:200 height:20 align:#left triState:reActive
			checkbox 'chk_NoseLineHide' "LineObj Hide" pos:[10,100] width:120 height:20 align:#left triState:TgtObjsTriState
			button 'btn_BatchRenderDialog' "Batch Render" pos:[150,105]
			--Effects Line Active
			on chk_LineActive changed state do
			(
				for i = 1 to numEffects do
				(
					tempFX = getEffect i
					if (classof tempFX == Pencil__4_Line) do (
						setActive tempFX state
					)
				)
			)
			--Effects Line Render Elements Only
			on chk_LineElementOnly changed state do
			(
				aniState = animButtonState

				for i = 1 to numEffects do
				(
					tempFX = getEffect i
					if (classof tempFX == Pencil__4_Line) do (
						tempFX.RenderElementOnly = state
					)
				)
				if state == false then (
					if aniState == true do (animButtonState = false)
					backgroundColor = color 64 64 64
					if aniState == true do (animButtonState = true)
				) else (
					if aniState == true do (animButtonState = false)
					backgroundColor = color 0 0 0
					if aniState == true do (animButtonState = true)
				)
			)
			--Render Elements Active
			on chk_REActive changed state do
			(
				re.SetElementsActive state
				renderSceneDialog.update()
			)
			--NoseLineObj Hide
			on chk_NoseLineHide changed state do
			(
				for i = 1 to TgtObjs.count do
				(
					TgtObjs[i].isHidden = state
				)
			)
			on btn_BatchRenderDialog pressed do
			(
				actionMan.executeAction -43434444 "4096"
			)
		)
		CreateDialog Scene_Switch
	)
)
