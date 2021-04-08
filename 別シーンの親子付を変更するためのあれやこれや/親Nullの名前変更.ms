Array_WeightBone = Selection as array

for i = 1 to Array_WeightBone.count do (
	WeightBone = Array_WeightBone[i]
	WeightBoneName = WeightBone.name
	
	--??????????
	ParentPt = WeightBone.parent
	ParentPtName = ParentPt.name
	ParentPtNewName = ParentPtName+ "__" + WeightBoneName
	ParentPt.name = ParentPtNewName
	)
	
globalVars.remove "Array_WeightBone"