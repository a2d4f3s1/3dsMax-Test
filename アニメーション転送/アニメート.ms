rangeSratTicks = animationRange.start
rangeEndTicks = animationRange.end
animate on
for t in rangeSratTicks to rangeEndTicks by 1f do (
	at time t animate on $'Point001'.transform = $'ensui'.transform
)
