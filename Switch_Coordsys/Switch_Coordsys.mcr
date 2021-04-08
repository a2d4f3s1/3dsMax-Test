macroScript switch_coordsys
	category:"script"
	toolTip:"Switch_Coordsys"
(
	case getRefCoordSys() of
	(
		#hybrid : toolMode.coordsys #screen
		#screen : toolMode.coordsys #world
		#world : toolMode.coordsys #parent
		#parent : toolMode.coordsys #local
		#local : toolMode.coordsys #grid
		#object : toolMode.coordsys #working_pivot
		#working_pivot : toolMode.coordsys #local_aligned
		#local_aligned : toolMode.coordsys #view
	)
)
