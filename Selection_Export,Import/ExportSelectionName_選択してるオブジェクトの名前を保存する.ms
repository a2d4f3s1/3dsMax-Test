--選択してるオブジェクトの名前を保存する
(
	SS_TargetNames = StringStream ""
	for i in selection do (
		TargetName = i.name
		format "%\n" TargetName to:SS_TargetNames
		)
	
	--セーブファイル
	SaveFileName = "TargetNames.txt"
	SavedFile = getSaveFileName caption:"txt" filename: SaveFileName types: "TXT(*.txt)|*.txt"
	deletefile SavedFile --一度消す
	
	SaveFileName = (getFilenameFile SavedFile) + (getFilenameType SavedFile) --名前の再取得
	
	CreateFilePath = createFile SaveFileName encoding:#utf8 -- utf8で保存
	seek SS_TargetNames 0
	while eof SS_TargetNames == false do (
		format (readLine SS_TargetNames  + "\n") to:CreateFilePath
		)
		
	close CreateFilePath --閉じる(ちゃんと閉じないと自分で掴んでる状態)
	free CreateFilePath --ついでにガベージコレクション開放
	)
