--Select Crease Edges

(
	theObj = modPanel.getCurrentObject()
	if theobj  != undefined do
	(
		subobjectLevel = 2
		
		edgeArray = #{}
		EdgeCount = polyop.getNumEdges theObj
		
		for i = 1 to EdgeCount do
		(
			polyop.setEdgeSelection theObj #{i}
			if 0.1 < (theObj.EditablePoly.getEdgeData 1 1 false) do
			(
				append edgeArray i
			)
		)
		
		theObj.EditablePoly.SetSelection #Edge edgeArray
	)
)