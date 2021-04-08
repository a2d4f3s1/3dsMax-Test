Array_WeightBone = Selection as array

for i = 1 to Array_WeightBone.count do (
	WeightBone = Array_WeightBone[i]
	WeightBoneName = WeightBone.name
	
	--??????
	TargetName = "$'" + "*" + "__" + WeightBoneName
	TargetNullExecute = execute(TargetName)
	select TargetNullExecute
	TargetNull = selection[1]
	
	--??????
	WeightBone.parent = selection[1]
	)
	
globalVars.remove "Array_WeightBone"