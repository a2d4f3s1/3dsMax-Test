-- Simple hWnd Viewer
-- by Pixamoon
-- www.pixamoon.com
-- pixamoon@gmail.com
-- edited by Swordslayer

try destroyDialog ::hWndInspector catch()

rollout hWndInspector " Simple hWnd Viewer " width:500 height:385
(
	local GWL_STYLE = -16
	local WS_POPUP = 0x80000000L
	local ctypes = python.import "ctypes"
	local wintypes = python.import "ctypes.wintypes"
	local user32 = ctypes.windll.user32
	local getProcessByID = (dotNetClass "System.Diagnostics.Process").GetProcessById
	local lastTxt1 = "", lastTxt2 = ""

	editText edt1 "" width:(hWndInspector.width - 8) height:350 align:#left offset:[-12,0]

	label lbl "[Esc] to Stop:" pos:[10, hWndInspector.height - 22] align:#left across:7
	checkButton chbStopped " Running "  align:#left offset:[0,-1]
	hyperLink Pixamoon "by Pixamoon" align:#right address:"http://www.pixamoon.com" \
		pos:[hWndInspector.width - 70, hWndInspector.height - 22] color:[0,150,200] visitedColor:[0,150,200]
	timer tm1 interval:100 active:on

	fn getProcessPath hWnd =
	(
		local processID = ctypes.c_ulong()
		user32.GetWindowThreadProcessId hWnd (ctypes.byref processID)
		(getProcessByID processID.value).MainModule.FileName
	)

	fn getFirstLine str =
		if str == undefined or str.count == 0 then "\"\""
		else (filterString (trimLeft str) "\n\r")[1]

	fn isPopup hWnd =
		bit.and (user32.GetWindowLongPtrW hWnd GWL_STYLE) WS_POPUP == WS_POPUP

	on chbStopped changed state do
	(
		tm1.active = not state
		chbStopped.text = if state then "Stopped" else "Running"
	)

	on tm1 tick do
	(
		local txt = "", txt2 = ""

		try (
			local mPos = mouse.screenPos
			local hWnd = user32.WindowFromPoint (wintypes.POINT (int mPos.x) (int mPos.y))
			local hWndData = windows.getHWndData hWnd
			local pHWnd = UIAccessor.getParentWindow hWnd
			local ppHWnd = UIAccessor.getParentWindow pHWnd

			txt += "Mouse pos:\t[" + mPos.X as string + ", " + mPos.Y as string + "]\n\n"

			txt += "hWnd:\t\t" + hWnd as string + "\n"
			txt += "Text:\t\t" + getFirstLine (UIAccessor.getWindowText hWnd) + "\n"
			txt += "Class:\t\t" + getFirstLine (UIAccessor.getWindowClassName hWnd) + "\n"
			txt += "Is Window:\t" + UIAccessor.isWindow hWnd as string + "\n"
			txt += "Is Pop-up:\t" + isPopup hWnd as string + "\n"
			txt += "Resource ID:\t" + UIAccessor.getWindowResourceID hWnd as string + "\n"
			txt += "Ancestor hWnd:\t" + hWndData[2] as string + "\n"
			txt += "Parent hWnd:\t" + hWndData[3] as string + "\n"
			txt += "Owner hWnd:\t" + hWndData[6] as string + "\n"
			txt += "Root hWnd:\t" + hWndData[7] as string + "\n"
			txt += "Owned hWnd:\t" + hWndData[8] as string + "\n"
			txt += "Prev Sibling hWnd:\t" + UIAccessor.getPrevWindow hWnd as string + "\n"
			txt += "Next Sibling hWnd:\t" + UIAccessor.getNextWindow hWnd as string + "\n"
			txt += "DLL Filename:\t" + getFirstLine (UIAccessor.getWindowDllFileName hWnd) + "\n"
			txt += "Process Filename:\t" + getProcessPath hWnd + "\n\n"

			txt += "Parent1 hWnd:\t" + pHWnd as string + "\n"
			txt += "Parent1 text:\t" + getFirstLine (UIAccessor.getWindowText pHWnd) + "\n"
			txt += "Parent1 class:\t" + getFirstLine (UIAccessor.getWindowClassName pHWnd) + "\n\n"

			txt += "Parent2 hWnd:\t" + ppHWnd as string + "\n"
			txt += "Parent2 text:\t" + getFirstLine (UIAccessor.getWindowText ppHWnd) + "\n"
			txt += "Parent2 class:\t" + getFirstLine (UIAccessor.getWindowClassName ppHWnd) + "\n"
		)
		catch txt = (getCurrentException()) as string

		-- protection against text flickering
		if txt != lastTxt1 then edt1.text = txt
		lastTxt1 = txt

		if txt2 != lastTxt2 then edt2.text = txt2
		lastTxt2 = txt2

		if keyboard.escPressed do
		(
			chbStopped.checked = not (tm1.active = off)
			chbStopped.text = "Stopped"
		)
	)
)
createDialog ::hWndInspector