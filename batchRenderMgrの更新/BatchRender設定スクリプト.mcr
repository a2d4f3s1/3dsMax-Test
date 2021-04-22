macroScript BatchRenderSet
	category:"Script"
	toolTip:"BRS_MRN"
(
	/*
	--BatchRender設定スクリプト
	ver 210414.001

	※1 ①の書き出し先のフォルダを設定します
	※2 ②既存のバッチをクリアする場合はONにして下さい
	※3 独自のパスを追加する場合は③に追加して下さい

	※ ライン用のバッチも一緒に作られちゃう作りなので捨てて下さい
	※ たまにエラーでMax落ちるので保存してから実行がおすすめ
	*/
	(
		clearListener()--リスナーのクリア
		--書き出し要素設定
		local setNames = #("CHA_col","CHA_line","CHA_maskParts","CHA_maskEmission","CHA_maskEye","CHA_Normal","CHA_wxp","WPN_col","WPN_line","WPN_mask")
		local setPath = @"X:\imarine\05_mv#3\10_Model\imarine3\test_Rendering\210421"--初期値
		local StartTime, EndTime, FrameWidth, FrameHeight, PixelAspect, PickCamera --その他パラメーター
		format "setNames = %\n" setNames
		format "setPath = %\n" setPath
		--pngの設定
		pngio.setType #true48
		pngio.setAlpha false
		pngio.setInterlaced true
		--バッチあたり関連
		local loopCount=0, k=0
		
		--■関数(テスト)
		fn Fn_test = (format "fn_test\n") --引数無し
		--■関数(バッチの作成)
		fn Fn_CreateBatch setNames setPath StartTime EndTime FrameWidth FrameHeight PixelAspect PickCamera = (
			format "Run fn_CreateBatch\n"
			for i = 1 to setNames.count do (
				newBatch = batchRenderMgr.CreateView PickCamera --新しいバッチの作成(PickCameraを使って)
				newBatch.overridePreset = True --上書き"ON"
				newBatch.startFrame = StartTime --その開始フレーム
				newBatch.endFrame = EndTime --その終了フレーム
				newBatch.width = FrameWidth --その画面幅
				newBatch.height = FrameHeight --その画面高
				newBatch.pixelAspect =　PixelAspect --そのピクセルアスペクト
				newName = setNames[i]--その名前、、、の重複回避
				format "newName = %\n" newName
				if batchRenderMgr.FindView newName != 0 do (
					newNameB = newName
					for j = 1 to 10 while (batchRenderMgr.FindView newNameB != 0) do (
						newNameB = newName + "_" +  (j as string)
					)
					newName = newNameB
				)
				format "newName = %\n" newName
				newBatch.name = newName --その名前
				newBatch.outputFilename= setPath + "/" + setNames[i] + "/" + setNames[i] + "_"--そのパス
			)
		)
		--■関数(カメラピックボタンのフィルター) Camera_filt <parm1>obj
		fn Fn_Camera_filt obj = (superClassOf obj == Camera)
		--■関数(batchRenderMgrを閉じる)
		fn Fn_Close_BatchRender = (
			format "Run Fn_Close_BatchRender\n"
			local hwnd
			if (hwnd = windows.getchildhwnd 0 "Batch Render") != undefined do
			(
				uiaccessor.closedialog hwnd[1]
			)
		)
		--■関数(batchRenderMgrのクリア)
		fn Fn_batchCLR flag = (
			format "Run Fn_batchCLR\n"
			format "flag = %\n" flag
			if flag == true do (
				for h = 1 to batchRenderMgr.numViews do batchRenderMgr.DeleteView 1
			)
		)
		--■関数(ディレクトリの作成)
		fn Fn_newDir DirNames BasePath = (
			format "Run Fn_newDir\n"
			format "DirNames = %\n" DirNames
			format "BasePath = %\n" BasePath
			for i = 1 to DirNames.count do (
				newDir = BasePath + "/" + DirNames[i] 
				makeDir newDir
			)
		)
		
		--ロールアウト
		try (DestroyDialog 'CreateBatchRender') catch ()
		rollout 'CreateBatchRender' "Create Batch Render" width:880 height:160
		(
			editText 'edt_Path' "Output Path: " pos:[10,15] width:850 height:20 multiLine:false align:#left text:setPath
			spinner 'spn_Fr_Start' "Frame Start: " type:#integer range:[0,100000,0] scale:1 pos:[100,50] width:80 height:20 align:#right
			spinner 'spn_Fr_End' "Frame End: " type:#integer range:[0,100000,100] scale:1 pos:[250,50] width:80 height:20 align:#right
			spinner 'spn_Width' "Width: " type:#integer range:[0,32000,1920] scale:1 pos:[100,80] width:80 height:20 align:#right
			spinner 'spn_Height' "Height: " type:#integer range:[0,32000,1080] scale:1 pos:[250,80] width:80 height:20 align:#right
			spinner 'spn_PxAspect' "Pixel Axpect: " type:#float scale:0.1 range:[0.001,1000,1] pos:[100,110] width:80 height:20 align:#right
			pickbutton 'pbtn_Camera' "Pick Camera" pos:[420,48] width:400 height:20 align:#left filter:Fn_Camera_filt 
			checkbox 'chk_Old_Clear' "Old Batch Clear" pos:[240,120] width:100 height:20 align:#left
			button 'btn_Run' "Run ! !" pos:[630,110] width:220 height:35 align:#left
			
			--editText 'edt_Path'
			on edt_Path entered txt do (
				setPath = txt
				--format "setPath = %\n" setPath--確認用
				if (doesFileExist txt) then (
					edt_Path.bold = false
				) else (
					edt_Path.bold = true
				)
			)
			--pickbutton 'pbtn_Camera'
			on pbtn_Camera picked obj do (
				if obj != undefined do (
					pbtn_Camera.text = obj.name
					print pbtn_Camera.object
				)
			)
			--button 'btn_Run'
			on btn_Run pressed do (
				if pbtn_Camera.object != undefined then (
					clearListener()--リスナーのクリア
					Fn_Close_BatchRender() --batchRenderMgrを閉じる
					print "btn_Run pressed"
					
					--ロールアウトのパラメーターを上位の変数に
					setNames = setNames
					setPath = setPath
					StartTime = spn_Fr_Start.value
					EndTime = spn_Fr_End.value
					FrameWidth = spn_Width.value
					FrameHeight = spn_Height.value
					PixelAspect = spn_PxAspect.value
					PickCamera = pbtn_Camera.object
					--の確認
					format "setNames = %\n" setNames
					format "setPath = %\n" setPath
					format "StartTime = %\n" StartTime
					format "EndTime = %\n" EndTime
					format "FrameWidth = %\n" FrameWidth
					format "FrameHeight = %\n" FrameHeight
					format "PixelAspect = %\n" PixelAspect
					format "PickCamera = %\n" PickCamera
					
					Fn_batchCLR chk_Old_Clear.state --バッチのクリア
					Fn_newDir setNames setPath --ディレクトリの作成
					Fn_CreateBatch setNames setPath StartTime EndTime FrameWidth FrameHeight PixelAspect PickCamera--Batchビュー登録
					
					actionMan.executeAction -43434444 "4096" --batchRenderMgrを開く
					messageBox "Create finished"
					try (DestroyDialog 'CreateBatchRender') catch ()
				) else (
					messageBox "カメラを選択して下さい"
				)
			)
		) CreateDialog 'CreateBatchRender'
	)


)
