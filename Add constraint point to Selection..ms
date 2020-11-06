for i in selection do (
	targetObj = i
	new = point()
	new.size = 1
	new.name = i.name + "_point"
	if i.children.count == 1 do hide new
	
	PositionConstraint = Position_Constraint ()
	new.pos.controller = PositionConstraint
	PositionConstraint.appendTarget targetObj 50.0
	
	OrientationConstraint = Orientation_Constraint ()
	new.rotation.controller = OrientationConstraint
	OrientationConstraint.appendTarget targetObj 50.0
	
	if i.children.count == 1 do hide new
	)

