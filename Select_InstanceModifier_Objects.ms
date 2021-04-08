a = refs.dependents $.modifiers[1]

obj =#()

for o in a do
(
    if superclassof o == GeometryClass then append obj o
)

select obj