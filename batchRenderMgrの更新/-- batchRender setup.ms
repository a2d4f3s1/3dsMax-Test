-- batchRender setup
fn batchRender camArr path: imagename: ext: =
(
	local batch = batchRenderMgr, appendPath = pathConfig.appendPath
	batch.netRender = on
	for c in camArr do
	(
		imagename = imagename + "_" + c.name + "view" + ext
		view = batch.CreateView c
		view.overridePreset = on
		view.outputFilename = appendPath path imagename
		view.name = c.name
	)
)
--create four cameras
fn createFourOrthoCameras camType:#target origin:[0,0,0] distanceFromOrigin:100 height:0 =
(
	local camNames = #("Front", "Back", "Left", "Right"), camWire = #(red,green,blue,yellow)
	local camTM = #(
		(matrix3 x_axis z_axis (-y_axis) [origin.x, (origin.y - distanceFromOrigin), height]), \ -- front
		(matrix3 (-x_axis) z_axis y_axis [origin.x, (origin.y + distanceFromOrigin), height]), \ -- back
		(matrix3 (-y_axis) z_axis (-x_axis) [(origin.x - distanceFromOrigin), origin.y, height]), \ -- left
		(matrix3 y_axis z_axis x_axis [(origin.x + distanceFromOrigin), origin.y, height]) -- right
	)
	for i = 1 to camNames.count do
	(
		camera = Freecamera name:camNames[i] wirecolor:camWire[i] transform:camTM[i] orthoProjection:on
		if camType == #target do 
		(
			camera.type = camType
			camera.target.pos = [origin.x,origin.y,height]
			camera.target.wirecolor = camWire[i]
		)
	)
)
 
-- EXAMPLE
tea = Teapot radius:50
createFourOrthoCameras camType:#free origin:tea.pos distanceFromOrigin:300 height:50
batchRender #($Front, $Back, $Left, $Right) path:@"\\Server\outputs" imagename:"teapot" ext:".tif"