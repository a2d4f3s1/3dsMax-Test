--??????????
WeightBone = $
WeightBoneName = WeightBone.name

ParentPt = WeightBone.parent
ParentPtName = ParentPt.name
ParentPtNewName = ParentPtName+ "__" + WeightBoneName
ParentPt.name = ParentPtNewName

--??????
TargetName = "$'" + "*" + "__" + WeightBoneName
TargetNullExecute = execute(TargetName)
select TargetNullExecute
TargetNull = selection[1]

--??????
WeightBone.parent = TargetNull