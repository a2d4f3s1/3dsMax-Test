clearListener()

fn setMakePreview = (
	local WindowHandle = DialogMonitorOPS.GetWindowHandle()
	local WIndowTitle =  (UIAccessor.GetWindowText WindowHandle)
	
	format "WindowHandle  = %\n" (WindowHandle as string)
	format "WindowTitle  = %\n" (WindowTitle as string)

	if WindowTitle == "Make Preview" then (
		for i in (windows.getChildrenHWND WindowHandle) do (format "%\n" i)
		UIAccessor.PressButtonByName WindowHandle "File..."
	)
	if WindowTitle == "Create Animated Sequence File..." then (
		for i in (windows.getChildrenHWND WindowHandle) do (format "%\n" i)

		local edits = for i in (windows.getChildrenHWND WindowHandle) where i[4] == "Edit" collect i[1]
		uiaccessor.setwindowtext edits[1] @"c:\temp\reallyanothertest_.jpg"	

		local comboboxes = for i in (windows.getChildrenHWND WindowHandle) where i[4] == "ComboBox" collect i[1]
		local filetypeHwnd = comboboxes[3] 
		
		local CB_SHOWDROPDOWN = 0x014F
		local CB_SETCURSEL = 0x014E 
		local WM_LBUTTONDOWN = 0x0201
		local WM_LBUTTONUP = 0x0202
		windows.sendMessage filetypeHwnd CB_SHOWDROPDOWN 1 0 -- Open combobox dropdown
		windows.sendMessage filetypeHwnd CB_SETCURSEL 7 0 -- Select 7th item
		windows.sendMessage filetypeHwnd WM_LBUTTONDOWN 0 -1  -- Press left mouse button	
		windows.sendMessage filetypeHwnd WM_LBUTTONUP 0 -1  -- Raise left mouse button
		windows.sendMessage filetypeHwnd CB_SHOWDROPDOWN 0 0    -- Close dropdown
		
		UIAccessor.PressButtonByName WindowHandle "&Save"
	)		
	True
)

DialogMonitorOPS.enabled = true
DialogMonitorOPS.RegisterNotification setMakePreview id:#setMakePreview 

max preview
	
DialogMonitorOPS.unRegisterNotification id:#setMakePreview 
DialogMonitorOPS.enabled = false 