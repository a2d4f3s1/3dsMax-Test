obj = modPanel.getCurrentObject()
if obj != undefined then
(
case (classof obj) of
	(
		Edit_Poly:obj.setoperation #SelectHardEdges 
		Editable_Poly:obj.selectHardEdges()
		)
	)
