try (
		local hwnd
		if (hwnd = windows.getchildhwnd 0 "Batch Render") != undefined do
		(
			uiaccessor.closedialog hwnd[1]
		)
	) catch ()

ForceCompleteRedraw() true

clearListener()
flag =false

fn setMakePreview = (
	format "------------------------------\n"
	format "fn setMakePreview\n"
	local WindowHandle = DialogMonitorOPS.GetWindowHandle()
	--format "WindowHandle  = %\n" (WindowHandle as string)
	local WindowTitle =  (UIAccessor.GetWindowText WindowHandle)
	--format "WindowTitle  = %\n" (WindowTitle as string)
	
	if WindowTitle == "Batch Render" then (
		--for i in (windows.getChildrenHWND WindowHandle) do (format "%\n" i)
		UIAccessor.PressButtonByName WindowHandle "&Add..."
		UIAccessor.PressButtonByName WindowHandle "..."
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

DialogMonitorOPS.enabled = true
DialogMonitorOPS.RegisterNotification setMakePreview id:#setMakePreview  

pngio.setType #true48
pngio.setAlpha false
pngio.setInterlaced true

actionMan.executeAction -43434444 "4096"

ForceCompleteRedraw() true
--hwnd
--if (hwnd = windows.getchildhwnd 0 "Batch Render") != undefined  do ()

if (messageBox "You shouldn't have done that") == OK  do (
	format " End\n"
	DialogMonitorOPS.unRegisterNotification id:#setMakePreview 
	DialogMonitorOPS.enabled = false 
)