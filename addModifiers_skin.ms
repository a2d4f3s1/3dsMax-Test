for i in selection do
(
	a = Skin()
	addModifier i a
	print a
	a.filter_vertices = on
	a.showNoEnvelopes = on
	a.clearZeroLimit = 0.001
)