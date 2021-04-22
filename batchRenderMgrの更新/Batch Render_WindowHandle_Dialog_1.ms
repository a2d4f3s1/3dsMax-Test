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
	setNames = #("CHA_col","CHA_line","CHA_maskParts","CHA_maskEmission","CHA_maskEye","CHA_Normal","CHA_wxp","WPN_col","WPN_line","WPN_mask")
	setPath = @"X:\imarine\05_mv#3\10_Model\imarine3\test_Rendering\210421"--初期値
	format "setPath = %\n" setPath
	--pngの設定三種
	pngio.setType #true48
	pngio.setAlpha false
	pngio.setInterlaced true
	--ロールアウト関連
	local setName, setPath, StartTime, EndTime, FrameWidth, FrameHeight, PixelAspect, PickCamera
	--バッチあたり関連
	local k = 0

	--■関数(バッチの作成)
	fn setCreateBatch = (
		format "'setNames = %\n" setNames
		format "'setPath = %\n" setPath
		format "'StartTime = %\n" StartTime
		format "'EndTime = %\n" EndTime
		format "'FrameWidth = %\n" FrameWidth
		format "'FrameHeight = %\n" FrameHeight
		format "'PixelAspect = %\n" PixelAspect
		format "'PickCamera = %\n" PickCamera
		format "------------------------------\n"
		--WindowHandleを呼び出してごにょごにょするところ
		local WindowHandle = DialogMonitorOPS.GetWindowHandle()
		format "WindowHandle  = %\n" (WindowHandle as string)--テスト
		local WindowTitle =  (UIAccessor.GetWindowText WindowHandle)
		format "WindowTitle  = %\n" (WindowTitle as string)--テスト
		
		--WindowTitleが"Batch Render"だったら
		if WindowTitle == "Batch Render" then (
			for i in (windows.getChildrenHWND WindowHandle) do (format "%\n" i)--UI要素の種類を確認し、各UI要素にアクセスする方法を見つける方法
			
			for j = 1 to 10 do (
				k += 1
				format "k = %\n" k
				UIAccessor.PressButtonByName WindowHandle "&Add..."
				UIAccessor.PressButtonByName WindowHandle "..."
			)
		)
		if WindowTitle == "Render Output File" then (
			--for i in (windows.getChildrenHWND WindowHandle) do (format "%\n" i)
			local edits = for i in (windows.getChildrenHWND WindowHandle) where i[4] == "Edit" collect i[1]
			uiaccessor.setwindowtext edits[1] @"c:\temp\reallyanothertest_.png"
			local comboboxes = for i in (windows.getChildrenHWND WindowHandle) where i[4] == "ComboBox" collect i[1]
			local filetypeHwnd = comboboxes[3]
			local CB_SHOWDROPDOWN = 0x014F
			local CB_SETCURSEL = 0x014E
			local WM_LBUTTONDOWN = 0x0201
			local WM_LBUTTONUP = 0x0202
			windows.sendMessage filetypeHwnd CB_SHOWDROPDOWN 1 0 -- Open combobox dropdown
			windows.sendMessage filetypeHwnd CB_SETCURSEL 8 0 -- Select 7th item
			windows.sendMessage filetypeHwnd WM_LBUTTONDOWN 0 -1  -- Press left mouse button
			windows.sendMessage filetypeHwnd WM_LBUTTONUP 0 -1  -- Raise left mouse button
			windows.sendMessage filetypeHwnd CB_SHOWDROPDOWN 0 0    -- Close dropdown
			UIAccessor.PressButtonByName WindowHandle "&Save"
		)
		if WindowTitle == "PNG Configuration" then (
			--for i in (windows.getChildrenHWND WindowHandle) do (format "%\n" i)
			UIAccessor.PressButtonByName WindowHandle "OK"
		)
		flag =true
		True
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
			clearListener()--リスナーのクリア
			print "btn_Run pressed"
			Fn_Close_BatchRender() --batchRenderMgrを閉じる
			Fn_batchCLR chk_Old_Clear.state --バッチのクリア
			Fn_newDir setNames setPath --ディレクトリの作成
			--
			setNames = setNames
			setPath = setPath
			StartTime = spn_Fr_Start.value
			EndTime = spn_Fr_End.value
			FrameWidth = spn_Width.value
			FrameHeight = spn_Height.value
			PixelAspect = spn_PxAspect.value
			PickCamera = pbtn_Camera.object
			--バッチの作成
			DialogMonitorOPS.enabled = true
			DialogMonitorOPS.RegisterNotification setCreateBatch id:#setCreateBatch --※
			
			actionMan.executeAction -43434444 "4096"
			
			sleep 1
			if (messageBox "Create finished") == OK  do (
				format " finish!!\n"
				DialogMonitorOPS.unRegisterNotification id:#setCreateBatch
				DialogMonitorOPS.enabled = false
			)
			
		)
	) CreateDialog 'CreateBatchRender'
)
