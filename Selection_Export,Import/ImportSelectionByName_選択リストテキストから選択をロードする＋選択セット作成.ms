--テキストファイルから選択をロードする
(
	Array_Selection = #()
	
	--ロードファイル
	LoadedFile = getOpenFileName() 
	
	if LoadedFile != undefined then (
		LoadContents = openFile LoadedFile
		seek LoadContents 0 --頭出し
		
		while eof LoadContents == false do (
			obj = Execute ("$'"+ (readLine LoadContents) + "'")
			append Array_Selection obj
			)
		
		--色々開放
		close LoadContents
		free LoadContents
		free LoadedFile
		)
	
	--選択する
	select Array_Selection
		
		
	--選択セットの名前を試す
		NewName = getFilenameFile LoadedFile
		for i = 1 to 1000 do (
			if selectionSets[NewName] != undefined  do NewName = (NewName + i as string)
			)
			
	--選択セット保存する？
	rollout Dialog_CreateSelectionSet "CreateSelectionSet" (
		edittext SelectionSetName  "SelectionSet Name :" text:NewName fieldWidth:200 labelOnTop:true
		button btn_run "Create" across:2
		button btn_ext "Cancel"
		
		on btn_run pressed do (
			print (SelectionSetName.text)
			selectionSets[SelectionSetName.text] = Selection
			DestroyDialog Dialog_CreateSelectionSet
			)
		on btn_ext pressed do (
			DestroyDialog Dialog_CreateSelectionSet
			)
		)

createDialog Dialog_CreateSelectionSet Width:225
)
