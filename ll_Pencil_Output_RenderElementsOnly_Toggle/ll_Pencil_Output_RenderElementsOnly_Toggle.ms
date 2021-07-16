--Pencil OutputRenderElementsOnly_Toggle
--001_21.07.16

try DestroyDialog Line_RednerElementsOnly_Toggle catch ()

(
	--■Function
	--Fn エフェクトの「Pencil+4の数」と「RenderElementsOnlyの数」が一致するか
	fn fn_triState P4Num REONum = (
		TriState = false
		if (P4Num == REONum) then ( --状態判定
			TriState = true
		) else (
			TriState = false
		)
		TriState -- リターン値
	)
	--Fn ボタンテキスト更新
	fn fn_btnCaption Caption State = (
		if State == true then (
			Caption = "Now LINE REO  \"True\""
		) else (
			Caption = "Now LINE REO  \"False\""
		)
	)
	
	--■Variable
	--Pencil+ライン
	FxLineCount = 0 --Pencil_Line の数
	FxLineREOCount = 0 --Pencil_LineのRenderElementsOnlyの有効数
	FxLineTriState = false
	--ボタンテキスト
	btnCaption= "btnCaption"
	
	--■Calc
	--Pencilの現在の状態を確認
	for i = 1 to numEffects do (
		tempFX = getEffect i
		if (classof tempFX == Pencil__4_Line) do (
			FxLineCount +=1 --Pencil_Lineの数を更新
			if (tempFX.RenderElementOnly == true) do (FxLineREOCount +=1) --Pencil_LineのRenderElementsOnlyの有効数を更新
		)
	)
	--フラグ更新
	FxLineTriState = fn_triState FxLineCount FxLineREOCount --関数"fn_triState"
	btnCaption = fn_btnCaption btnCaption FxLineTriState
	
	--■Rollout
	rollout Line_RednerElementsOnly_Toggle "Line_RednerElementsOnly_Toggle" width:180 height:30 (
		button 'btn_LineElementOnly' btnCaption width:150 height:20 IsPressed:FxLineTriState
		
		--btn 'btn_LineElementOnly' pressed
		on btn_LineElementOnly pressed do (
			if (FxLineTriState == true) then ( --全部OFFにする
				for i = 1 to numEffects do (
					tempFX = getEffect i
					if (classof tempFX == Pencil__4_Line) do (
						tempFX.RenderElementOnly = false
					)
				)
				FxLineTriState = false --フラグOFF
			) else ( --全部OFFにする
				for i = 1 to numEffects do (
					tempFX = getEffect i
					if (classof tempFX == Pencil__4_Line) do (
						tempFX.RenderElementOnly = true
					)
				)
				FxLineTriState = true --フラグON
			)
			btn_LineElementOnly.text = btnCaption = fn_btnCaption btnCaption FxLineTriState
		)
	)
	CreateDialog Line_RednerElementsOnly_Toggle
)