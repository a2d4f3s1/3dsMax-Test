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
	--①書き出し先ルートフォルダパスの指定
	setPath = @"H:\test\CHA"
	--②バッチをクリアする場合は"ON"クリアしないなら"OFF"
	batchCLR = OFF
	--③書き出し要素設定
	setNames = #("CHA_col","CHA_line","CHA_maskParts","CHA_maskEmission","CHA_maskEye","CHA_Normal","CHA_wxp","WPN_col","WPN_line","WPN_mask")
	
	--batchRenderMgrを閉じる
	(
		local hwnd
		if (hwnd = windows.getchildhwnd 0 "Batch Render") != undefined do
		(
			uiaccessor.closedialog hwnd[1]
		)
	)

	--仮カメラの作成
	tempCamera = freecamera()
	tempCamera.name = "batchRenderMgrTempCamera"
	
	--バッチのクリア
	if batchCLR then
	(
		for h = 1 to batchRenderMgr.numViews do batchRenderMgr.DeleteView 1
		--Print ("batch Cleared")
	)

	--新規バッチの作成（ディレクトリの作成）
	for i = 1 to setNames.count do
	(
		--ディレクトリの作成
		newFolder = setPath + "/" + setNames[i] 
		makeDir newFolder
		
		newBatch = batchRenderMgr.CreateView batchRenderMgrTempCamera
		newName = setNames[i]
		if batchRenderMgr.FindView newName != 0 do
		(
			for j = 1 to 10 while (batchRenderMgr.FindView newNameB != 0) do
			(
				newNameB = newName + "_" +  (j as string)
			) 
			newName = newNameB
		)
		newBatch.name = newName
		newBatch.outputFilename= newFolder + "/" + setNames[i]+"_.png"
	)
	
	--仮カメラの消去
	delete tempCamera
	
	actionMan.executeAction -43434444 "4096" --batchRenderMgrを開く
)