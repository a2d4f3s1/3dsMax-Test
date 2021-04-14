--batchRenderMgrの更新
(
	local hwnd
	if (hwnd = windows.getchildhwnd 0 "Batch Render") != undefined do
	(
		uiaccessor.closedialog hwnd[1]
		actionMan.executeAction -43434444 "4096"
	)
)