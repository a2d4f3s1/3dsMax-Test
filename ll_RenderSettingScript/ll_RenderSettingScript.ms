/*
--レンダーセッティング
--v000 21.07.16
--テスト中
*/


--名前による選択
tgtCha = "KNN"
tgtMatName = "sOPA"
tgtType = "geo"

execute ("select $"+tgtCha+"_"+tgtMatName+"_"+"*"+"_"+tgtType)--名前で選択	


--名前によるマテリアルの選択
--※マテリアルには一定のルールがある
--※
matNameList = #("col","mask_eye","mask_hairA","mask_hi","mask_skin")
tgtTypeM="M"
--matNameList[2]--テスト：配列から中身を取得

--sceneMaterials[1].name--テスト：マテリアルを番号でシーンマテリアルから取得
--sceneMaterials["KNN_sOPA_msk_skin_M"].name--テスト：マテリアルを名前でシーンマテリアルから取得
--sceneMaterials["KNN_sOPA_msk_hairA_M"].name--テスト：マテリアルを名前でシーンマテリアルから取得


tgtMat=(
	execute ("sceneMaterials[\""+tgtCha+"_"+tgtMatName+"_"+matNameList[1]+"_"+tgtTypeM+"\"]")--名前で選択
)
tgtMat.name--テスト：取得したマテリアルの名前
	
$.material = tgtMat--テスト：マテリアルの変更
	
--■レンダリングパスの設定
basePath=@"D:\Sublimation\Github\3dsMax-ll_RenderSettingScript\testRend"
dirName=tgtCha+"_"+matNameList[1]
newDir = basePath + "\\" + dirName
newFileFullPath=newDir+ "\\" +dirName+"_.png"
makeDir newDir --ディレクトリの作成

--■レンダリングの設定
(
	renderSceneDialog.close()
	rendOutputFilename = ""
	current_type = pngio.gettype() -- {#paletted|#true24|#true48|#gray8|#gray16}
	current_alpha =  pngio.getAlpha()
	current_interlaced = pngio.getInterlaced()
	
	newPngioType = #gray16
	/*case current_type of--※設定トグル
	(
		#paletted : pngio.settype #true24
		#true24   : pngio.settype #true48
		#true48   : pngio.settype #gray8
		#gray8    : pngio.settype #gray16 
		#gray16   : pngio.settype #paletted
		default:    pngio.settype #paletted	
	)*/
	
	renderSceneDialog.close()
	
	pngio.settype  #paletted
	pngio.setAlpha false
	
	current_type = pngio.gettype()
	current_alpha =  pngio.getAlpha()
	
	rendOutputFilename = newFileFullPath--この行がないと、設定が書き換わらないぽい
	rendSaveFile = true
	renderSceneDialog.update()
	renderSceneDialog.open()
)