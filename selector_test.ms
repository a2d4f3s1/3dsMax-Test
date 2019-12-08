----------------------------------------------------------
----------------------------------------------------------
--load_skinBones_of_SelectedObjects
--Version 1_001
--Moteki Kunio
--Last change 191113
--
-- Skinに含まれる Bones をテキスト(txt)からロードする
--1_001 テスト中
--1_004 ファイル名からmaxファイル名を除去
----------------------------------------------------------
----------------------------------------------------------

try (DestroyDialog selector_test) catch ()
(

	fn Fn_toggleSelection targets =
	(
		target = targets
		if (superclassof targets != GeometryClass) do (target = targets[1])
		CurrentSelect = getCurrentSelection()
		if (findItem CurrentSelect target == 0) do (selectmore targets)
		if (findItem CurrentSelect target != 0) do (deselect targets)
	)

	script_Path = getSourceFileName() --自身のフルパス
	script_Dir = getFilenamePath script_Path --自身のディレクトリ

	--オブジェクト選択用配列
	arrTgt = #();arrClmRA = #();arrClmRB = #();arrClmRC = #();arrClmRD = #();arrClmRE = #();arrClmRF = #();arrClmRG = #();arrClmRH = #()
	arrClmB = #();arrClmLA = #();arrClmLB = #();arrClmLC = #();arrClmLD = #();arrClmLE = #();arrClmLF = #();arrClmLG = #();arrClmLH = #()
	arrLine01 = #();arrLine02 = #();arrLine03 = #();arrLine04 = #();arrLine05 = #();arrLine06 = #();arrLine07 = #();arrLine08 = #();arrLine09 = #();arrLine10 = #()

	fn Fn_loadList listFileName arrTgt arrClmRA arrClmRB arrClmRC arrClmRD arrClmRE arrClmRF arrClmRG arrClmRH arrClmB arrClmLA arrClmLB arrClmLC arrClmLD arrClmLE arrClmLF arrClmLG arrClmLH arrLine01 arrLine02 arrLine03 arrLine04 arrLine05 arrLine06 arrLine07 arrLine08 arrLine09 arrLine10 =
	(
		print listFileName
		--リスト開放
		free arrTgt;free arrClmRA;free arrClmRB;free arrClmRC;free arrClmRD;free arrClmRE;free arrClmRF;free arrClmRG;free arrClmRH
		free arrClmB;free arrClmLA;free arrClmLB;free arrClmLC;free arrClmLD;free arrClmLE;free arrClmLF;free arrClmLG;free arrClmLH
		free arrLine01;free arrLine02;free arrLine03;free arrLine04;free arrLine05;free arrLine06;free arrLine07;free arrLine08;free arrLine09;free arrLine10

		--リスト化
		loadContents = openFile listFileName
		seek LoadContents 0
		while eof LoadContents == false do (
			tgtBone = execute ("$'" + (readLine loadContents) + "'" )
			--print (tgtBone.name)
			if findString (tgtBone.name) "_00" == undefined do (appendIfUnique arrTgt tgtBone)
			if findString (tgtBone.name) "_RA_" != undefined do (appendIfUnique arrClmRA tgtBone)
			if findString (tgtBone.name) "_RB_" != undefined do (appendIfUnique arrClmRB tgtBone)
			if findString (tgtBone.name) "_RC_" != undefined do (appendIfUnique arrClmRC tgtBone)
			if findString (tgtBone.name) "_RD_" != undefined do (appendIfUnique arrClmRD tgtBone)
			if findString (tgtBone.name) "_RE_" != undefined do (appendIfUnique arrClmRE tgtBone)
			if findString (tgtBone.name) "_RF_" != undefined do (appendIfUnique arrClmRF tgtBone)
			if findString (tgtBone.name) "_RG_" != undefined do (appendIfUnique arrClmRG tgtBone)
			if findString (tgtBone.name) "_RH_" != undefined do (appendIfUnique arrClmRH tgtBone)
			if findString (tgtBone.name) "_B_" != undefined do (appendIfUnique arrClmB tgtBone)
			if findString (tgtBone.name) "_LH_" != undefined do (appendIfUnique arrClmLH tgtBone)
			if findString (tgtBone.name) "_LG_" != undefined do (appendIfUnique arrClmLG tgtBone)
			if findString (tgtBone.name) "_LF_" != undefined do (appendIfUnique arrClmLF tgtBone)
			if findString (tgtBone.name) "_LE_" != undefined do (appendIfUnique arrClmLE tgtBone)
			if findString (tgtBone.name) "_LD_" != undefined do (appendIfUnique arrClmLD tgtBone)
			if findString (tgtBone.name) "_LC_" != undefined do (appendIfUnique arrClmLC tgtBone)
			if findString (tgtBone.name) "_LB_" != undefined do (appendIfUnique arrClmLB tgtBone)
			if findString (tgtBone.name) "_LA_" != undefined do (appendIfUnique arrClmLA tgtBone)
			if findString (tgtBone.name) "_01" != undefined do (appendIfUnique arrLine01 tgtBone)
			if findString (tgtBone.name) "_02" != undefined do (appendIfUnique arrLine02 tgtBone)
			if findString (tgtBone.name) "_03" != undefined do (appendIfUnique arrLine03 tgtBone)
			if findString (tgtBone.name) "_04" != undefined do (appendIfUnique arrLine04 tgtBone)
			if findString (tgtBone.name) "_05" != undefined do (appendIfUnique arrLine05 tgtBone)
			if findString (tgtBone.name) "_06" != undefined do (appendIfUnique arrLine06 tgtBone)
			if findString (tgtBone.name) "_07" != undefined do (appendIfUnique arrLine07 tgtBone)
			if findString (tgtBone.name) "_08" != undefined do (appendIfUnique arrLine08 tgtBone)
			if findString (tgtBone.name) "_09" != undefined do (appendIfUnique arrLine09 tgtBone)
			if findString (tgtBone.name) "_10" != undefined do (appendIfUnique arrLine10 tgtBone)
		)
		close LoadContents
	)

	--確認
-- 	print "arrTgt"
-- 	print arrTgt
-- 	print"arrClmRA"
-- 	print arrClmRA
-- 	print"arrClmRB"
-- 	print arrClmRB
-- 	print"arrClmRD"
-- 	print arrClmRD
-- 	print"arrClmRE"
-- 	print arrClmRE
-- 	print"arrClmRF"
-- 	print arrClmRF
-- 	print"arrClmRG"
-- 	print arrClmRG
-- 	print"arrClmRH"
-- 	print arrClmRH
-- 	print"arrClmB"
-- 	print arrClmB

	Fn_loadList (script_Dir+ "selector_test_list.txt") arrTgt arrClmRA arrClmRB arrClmRC arrClmRD arrClmRE arrClmRF arrClmRG arrClmRH arrClmB arrClmLA arrClmLB arrClmLC arrClmLD arrClmLE arrClmLF arrClmLG arrClmLH arrLine01 arrLine02 arrLine03 arrLine04 arrLine05 arrLine06 arrLine07 arrLine08 arrLine09 arrLine10

	local btnPos = [0,10]
	local addColum = [20,0]
	local addRow = [0,22]
	local iSize = 20 --ボタンワイド
	local iSizeB = [8,8] --ボタンワイド
	local iconPos = [2,4]

	rollout selector_test "Select Bones"
	(
		--切り替え
		button btn_bonePtToggle "Select Pt" pos:[355,0]
		--ヘッド
		button btn_ALL "ALL" acos:11 pos:(addRow+[5,0])

		button btn_RA "RA" width:iSize pos:(addRow+addColum*3)
		button btn_RB "RB" width:iSize pos:(addRow+addColum*4)
		button btn_RC "RC" width:iSize pos:(addRow+addColum*5)
		button btn_RD "RD" width:iSize pos:(addRow+addColum*6)
		button btn_RE "RE" width:iSize pos:(addRow+addColum*7)
		button btn_RF "RF" width:iSize pos:(addRow+addColum*8)
		button btn_RG "RG" width:iSize pos:(addRow+addColum*9)
		button btn_RH "RH" width:iSize pos:(addRow+addColum*10)
		button btn_B "B" width:iSize pos:(addRow+addColum*11)
		button btn_LH "LH" width:iSize pos:(addRow+addColum*12)
		button btn_LG "LG" width:iSize pos:(addRow+addColum*13)
		button btn_LF "LF" width:iSize pos:(addRow+addColum*14)
		button btn_LE "LE" width:iSize pos:(addRow+addColum*15)
		button btn_LD "LD" width:iSize pos:(addRow+addColum*16)
		button btn_LC "LC" width:iSize pos:(addRow+addColum*17)
		button btn_LB "LB" width:iSize pos:(addRow+addColum*18)
		button btn_LA "LA" width:iSize pos:(addRow+addColum*19)
		--01行目
		local mlt1 = 2.2
		button btn_clm1 "col1" acos:11 pos:(addRow*mlt1+[5,0])
		button btn_RA01 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt1+addColum*3)
		button btn_RB01 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt1+addColum*4)
		button btn_RC01 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt1+addColum*5)
		button btn_RD01 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt1+addColum*6)
		button btn_RE01 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt1+addColum*7)
		button btn_RF01 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt1+addColum*8)
		button btn_RG01 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt1+addColum*9)
		button btn_RH01 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt1+addColum*10)
		button btn_B01 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt1+addColum*11)
		button btn_LH01 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt1+addColum*12)
		button btn_LG01 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt1+addColum*13)
		button btn_LF01 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt1+addColum*14)
		button btn_LE01 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt1+addColum*15)
		button btn_LD01 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt1+addColum*16)
		button btn_LC01 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt1+addColum*17)
		button btn_LB01 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt1+addColum*18)
		button btn_LA01 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt1+addColum*19)
				--02行目
		local mlt2 = 3.2
		button btn_clm2 "col2" acos:11 pos:(addRow*mlt2+[5,0])
		button btn_RA02 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt2+addColum*3)
		button btn_RB02 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt2+addColum*4)
		button btn_RC02 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt2+addColum*5)
		button btn_RD02 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt2+addColum*6)
		button btn_RE02 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt2+addColum*7)
		button btn_RF02 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt2+addColum*8)
		button btn_RG02 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt2+addColum*9)
		button btn_RH02 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt2+addColum*10)
		button btn_B02 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt2+addColum*11)
		button btn_LH02 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt2+addColum*12)
		button btn_LG02 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt2+addColum*13)
		button btn_LF02 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt2+addColum*14)
		button btn_LE02 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt2+addColum*15)
		button btn_LD02 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt2+addColum*16)
		button btn_LC02 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt2+addColum*17)
		button btn_LB02 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt2+addColum*18)
		button btn_LA02 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt2+addColum*19)
		--03行目
		local mlt3 = 4.2
		button btn_clm3 "col3" acos:11 pos:(addRow*mlt3+[5,0])
		button btn_RA03 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt3+addColum*3)
		button btn_RB03 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt3+addColum*4)
		button btn_RC03 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt3+addColum*5)
		button btn_RD03 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt3+addColum*6)
		button btn_RE03 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt3+addColum*7)
		button btn_RF03 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt3+addColum*8)
		button btn_RG03 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt3+addColum*9)
		button btn_RH03 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt3+addColum*10)
		button btn_B03 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt3+addColum*11)
		button btn_LH03 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt3+addColum*12)
		button btn_LG03 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt3+addColum*13)
		button btn_LF03 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt3+addColum*14)
		button btn_LE03 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt3+addColum*15)
		button btn_LD03 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt3+addColum*16)
		button btn_LC03 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt3+addColum*17)
		button btn_LB03 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt3+addColum*18)
		button btn_LA03 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt3+addColum*19)
		--04行目
		local mlt4 = 5.2
		button btn_clm4 "col4" acos:11 pos:(addRow*mlt4+[5,0])
		button btn_RA04 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt4+addColum*3)
		button btn_RB04 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt4+addColum*4)
		button btn_RC04 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt4+addColum*5)
		button btn_RD04 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt4+addColum*6)
		button btn_RE04 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt4+addColum*7)
		button btn_RF04 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt4+addColum*8)
		button btn_RG04 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt4+addColum*9)
		button btn_RH04 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt4+addColum*10)
		button btn_B04 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt4+addColum*11)
		button btn_LH04 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt4+addColum*12)
		button btn_LG04 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt4+addColum*13)
		button btn_LF04 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt4+addColum*14)
		button btn_LE04 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt4+addColum*15)
		button btn_LD04 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt4+addColum*16)
		button btn_LC04 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt4+addColum*17)
		button btn_LB04 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt4+addColum*18)
		button btn_LA04 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt4+addColum*19)
		--05行目
		local mlt5 = 6.2
		button btn_clm5 "col5" acos:11 pos:(addRow*mlt5+[5,0])
		button btn_RA05 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt5+addColum*3)
		button btn_RB05 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt5+addColum*4)
		button btn_RC05 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt5+addColum*5)
		button btn_RD05 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt5+addColum*6)
		button btn_RE05 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt5+addColum*7)
		button btn_RF05 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt5+addColum*8)
		button btn_RG05 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt5+addColum*9)
		button btn_RH05 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt5+addColum*10)
		button btn_B05 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt5+addColum*11)
		button btn_LH05 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt5+addColum*12)
		button btn_LG05 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt5+addColum*13)
		button btn_LF05 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt5+addColum*14)
		button btn_LE05 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt5+addColum*15)
		button btn_LD05 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt5+addColum*16)
		button btn_LC05 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt5+addColum*17)
		button btn_LB05 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt5+addColum*18)
		button btn_LA05 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt5+addColum*19)
		--06行目
		local mlt6 = 7.2
		button btn_clm6 "col6" acos:11 pos:(addRow*mlt6+[5,0])
		button btn_RA06 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt6+addColum*3)
		button btn_RB06 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt6+addColum*4)
		button btn_RC06 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt6+addColum*5)
		button btn_RD06 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt6+addColum*6)
		button btn_RE06 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt6+addColum*7)
		button btn_RF06 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt6+addColum*8)
		button btn_RG06 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt6+addColum*9)
		button btn_RH06 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt6+addColum*10)
		button btn_B06 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt6+addColum*11)
		button btn_LH06 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt6+addColum*12)
		button btn_LG06 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt6+addColum*13)
		button btn_LF06 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt6+addColum*14)
		button btn_LE06 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt6+addColum*15)
		button btn_LD06 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt6+addColum*16)
		button btn_LC06 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt6+addColum*17)
		button btn_LB06 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt6+addColum*18)
		button btn_LA06 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt6+addColum*19)
		--07行目
		local mlt7 = 8.2
		button btn_clm7 "col7" acos:11 pos:(addRow*mlt7+[5,0])
		button btn_RA07 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt7+addColum*3)
		button btn_RB07 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt7+addColum*4)
		button btn_RC07 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt7+addColum*5)
		button btn_RD07 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt7+addColum*6)
		button btn_RE07 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt7+addColum*7)
		button btn_RF07 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt7+addColum*8)
		button btn_RG07 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt7+addColum*9)
		button btn_RH07 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt7+addColum*10)
		button btn_B07 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt7+addColum*11)
		button btn_LH07 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt7+addColum*12)
		button btn_LG07 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt7+addColum*13)
		button btn_LF07 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt7+addColum*14)
		button btn_LE07 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt7+addColum*15)
		button btn_LD07 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt7+addColum*16)
		button btn_LC07 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt7+addColum*17)
		button btn_LB07 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt7+addColum*18)
		button btn_LA07 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt7+addColum*19)
		--08行目
		local mlt8 = 9.2
		button btn_clm8 "col8" acos:11 pos:(addRow*mlt8+[5,0])
		button btn_RA08 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt8+addColum*3)
		button btn_RB08 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt8+addColum*4)
		button btn_RC08 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt8+addColum*5)
		button btn_RD08 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt8+addColum*6)
		button btn_RE08 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt8+addColum*7)
		button btn_RF08 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt8+addColum*8)
		button btn_RG08 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt8+addColum*9)
		button btn_RH08 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt8+addColum*10)
		button btn_B08 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt8+addColum*11)
		button btn_LH08 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt8+addColum*12)
		button btn_LG08 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt8+addColum*13)
		button btn_LF08 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt8+addColum*14)
		button btn_LE08 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt8+addColum*15)
		button btn_LD08 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt8+addColum*16)
		button btn_LC08 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt8+addColum*17)
		button btn_LB08 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt8+addColum*18)
		button btn_LA08 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt8+addColum*19)
		--09行目
		local mlt9 = 10.2
		button btn_clm9 "co9" acos:11 pos:(addRow*mlt9+[5,0])
		button btn_RA09 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt9+addColum*3)
		button btn_RB09 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt9+addColum*4)
		button btn_RC09 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt9+addColum*5)
		button btn_RD09 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt9+addColum*6)
		button btn_RE09 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt9+addColum*7)
		button btn_RF09 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt9+addColum*8)
		button btn_RG09 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt9+addColum*9)
		button btn_RH09 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt9+addColum*10)
		button btn_B09 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt9+addColum*11)
		button btn_LH09 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt9+addColum*12)
		button btn_LG09 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt9+addColum*13)
		button btn_LF09 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt9+addColum*14)
		button btn_LE09 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt9+addColum*15)
		button btn_LD09 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt9+addColum*16)
		button btn_LC09 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt9+addColum*17)
		button btn_LB09 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt9+addColum*18)
		button btn_LA09 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt9+addColum*19)
		--10行目
		local mlt10 = 11.2
		button btn_clm10 "col10" acos:11 pos:(addRow*mlt10+[5,0])
		button btn_RA10 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt10+addColum*3)
		button btn_RB10 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt10+addColum*4)
		button btn_RC10 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt10+addColum*5)
		button btn_RD10 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt10+addColum*6)
		button btn_RE10 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt10+addColum*7)
		button btn_RF10 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt10+addColum*8)
		button btn_RG10 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt10+addColum*9)
		button btn_RH10 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt10+addColum*10)
		button btn_B10 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt10+addColum*11)
		button btn_LH10 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt10+addColum*12)
		button btn_LG10 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt10+addColum*13)
		button btn_LF10 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt10+addColum*14)
		button btn_LE10 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt10+addColum*15)
		button btn_LD10 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt10+addColum*16)
		button btn_LC10 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt10+addColum*17)
		button btn_LB10 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt10+addColum*18)
		button btn_LA10 iconName:" " iconSize:iSizeB pos:(iconPos+addRow*mlt10+addColum*19)

		--切り替え
		on btn_bonePtToggle pressed do
		(
			if (btn_bonePtToggle.caption == "Select Pt") then (
				Fn_loadList (script_Dir+ "selector_test_list_Pt.txt") arrTgt arrClmRA arrClmRB arrClmRC arrClmRD arrClmRE arrClmRF arrClmRG arrClmRH arrClmB arrClmLA arrClmLB arrClmLC arrClmLD arrClmLE arrClmLF arrClmLG arrClmLH arrLine01 arrLine02 arrLine03 arrLine04 arrLine05 arrLine06 arrLine07 arrLine08 arrLine09 arrLine10
				btn_bonePtToggle.caption = "Select Bone"
				selector_test.title =  "Select Points"
			) else (
				Fn_loadList (script_Dir+ "selector_test_list.txt") arrTgt arrClmRA arrClmRB arrClmRC arrClmRD arrClmRE arrClmRF arrClmRG arrClmRH arrClmB arrClmLA arrClmLB arrClmLC arrClmLD arrClmLE arrClmLF arrClmLG arrClmLH arrLine01 arrLine02 arrLine03 arrLine04 arrLine05 arrLine06 arrLine07 arrLine08 arrLine09 arrLine10
				btn_bonePtToggle.caption = "Select Pt"
				selector_test.title =  "Select Bones"
			)
		)
		--オール
		on btn_ALL pressed do Fn_toggleSelection arrTgt
		--縦のグループ
		on btn_RA pressed do Fn_toggleSelection arrClmRA
		on btn_RB pressed do Fn_toggleSelection arrClmRB
		on btn_RC pressed do Fn_toggleSelection arrClmRC
		on btn_RD pressed do Fn_toggleSelection arrClmRD
		on btn_RE pressed do Fn_toggleSelection arrClmRE
		on btn_RF pressed do Fn_toggleSelection arrClmRF
		on btn_RG pressed do Fn_toggleSelection arrClmRG
		on btn_RH pressed do Fn_toggleSelection arrClmRH
		on btn_B pressed do Fn_toggleSelection arrClmB
		on btn_LH pressed do Fn_toggleSelection arrClmLH
		on btn_LG pressed do Fn_toggleSelection arrClmLG
		on btn_LF pressed do Fn_toggleSelection arrClmLF
		on btn_LE pressed do Fn_toggleSelection arrClmLE
		on btn_LD pressed do Fn_toggleSelection arrClmLD
		on btn_LC pressed do Fn_toggleSelection arrClmLC
		on btn_LB pressed do Fn_toggleSelection arrClmLB
		on btn_LA pressed do Fn_toggleSelection arrClmLA
		--横のグループ
		on btn_clm1 pressed do Fn_toggleSelection arrLine01
		on btn_clm2 pressed do Fn_toggleSelection arrLine02
		on btn_clm3 pressed do Fn_toggleSelection arrLine03
		on btn_clm4 pressed do Fn_toggleSelection arrLine04
		on btn_clm5 pressed do Fn_toggleSelection arrLine05
		on btn_clm6 pressed do Fn_toggleSelection arrLine06
		on btn_clm7 pressed do Fn_toggleSelection arrLine07
		on btn_clm8 pressed do Fn_toggleSelection arrLine08
		on btn_clm9 pressed do Fn_toggleSelection arrLine09
		on btn_clm10 pressed do Fn_toggleSelection arrLine10
		--個別 RA
		on btn_RA01 pressed do Fn_toggleSelection arrClmRA[1]
		on btn_RA02 pressed do Fn_toggleSelection arrClmRA[2]
		on btn_RA03 pressed do Fn_toggleSelection arrClmRA[3]
		on btn_RA04 pressed do Fn_toggleSelection arrClmRA[4]
		on btn_RA05 pressed do Fn_toggleSelection arrClmRA[5]
		on btn_RA06 pressed do Fn_toggleSelection arrClmRA[6]
		on btn_RA07 pressed do Fn_toggleSelection arrClmRA[7]
		on btn_RA08 pressed do Fn_toggleSelection arrClmRA[8]
		on btn_RA09 pressed do Fn_toggleSelection arrClmRA[9]
		on btn_RA10 pressed do Fn_toggleSelection arrClmRA[10]
		--個別 RB
		on btn_RB01 pressed do Fn_toggleSelection arrClmRB[1]
		on btn_RB02 pressed do Fn_toggleSelection arrClmRB[2]
		on btn_RB03 pressed do Fn_toggleSelection arrClmRB[3]
		on btn_RB04 pressed do Fn_toggleSelection arrClmRB[4]
		on btn_RB05 pressed do Fn_toggleSelection arrClmRB[5]
		on btn_RB06 pressed do Fn_toggleSelection arrClmRB[6]
		on btn_RB07 pressed do Fn_toggleSelection arrClmRB[7]
		on btn_RB08 pressed do Fn_toggleSelection arrClmRB[8]
		on btn_RB09 pressed do Fn_toggleSelection arrClmRB[9]
		on btn_RB10 pressed do Fn_toggleSelection arrClmRB[10]
		--個別 RC
		on btn_RC01 pressed do Fn_toggleSelection arrClmRC[1]
		on btn_RC02 pressed do Fn_toggleSelection arrClmRC[2]
		on btn_RC03 pressed do Fn_toggleSelection arrClmRC[3]
		on btn_RC04 pressed do Fn_toggleSelection arrClmRC[4]
		on btn_RC05 pressed do Fn_toggleSelection arrClmRC[5]
		on btn_RC06 pressed do Fn_toggleSelection arrClmRC[6]
		on btn_RC07 pressed do Fn_toggleSelection arrClmRC[7]
		on btn_RC08 pressed do Fn_toggleSelection arrClmRC[8]
		on btn_RC09 pressed do Fn_toggleSelection arrClmRC[9]
		on btn_RC10 pressed do Fn_toggleSelection arrClmRC[10]
		--個別 RD
		on btn_RD01 pressed do Fn_toggleSelection arrClmRD[1]
		on btn_RD02 pressed do Fn_toggleSelection arrClmRD[2]
		on btn_RD03 pressed do Fn_toggleSelection arrClmRD[3]
		on btn_RD04 pressed do Fn_toggleSelection arrClmRD[4]
		on btn_RD05 pressed do Fn_toggleSelection arrClmRD[5]
		on btn_RD06 pressed do Fn_toggleSelection arrClmRD[6]
		on btn_RD07 pressed do Fn_toggleSelection arrClmRD[7]
		on btn_RD08 pressed do Fn_toggleSelection arrClmRD[8]
		on btn_RD09 pressed do Fn_toggleSelection arrClmRD[9]
		on btn_RD10 pressed do Fn_toggleSelection arrClmRD[10]
		--個別 RE
		on btn_RE01 pressed do Fn_toggleSelection arrClmRE[1]
		on btn_RE02 pressed do Fn_toggleSelection arrClmRE[2]
		on btn_RE03 pressed do Fn_toggleSelection arrClmRE[3]
		on btn_RE04 pressed do Fn_toggleSelection arrClmRE[4]
		on btn_RE05 pressed do Fn_toggleSelection arrClmRE[5]
		on btn_RE06 pressed do Fn_toggleSelection arrClmRE[6]
		on btn_RE07 pressed do Fn_toggleSelection arrClmRE[7]
		on btn_RE08 pressed do Fn_toggleSelection arrClmRE[8]
		on btn_RE09 pressed do Fn_toggleSelection arrClmRE[9]
		on btn_RE10 pressed do Fn_toggleSelection arrClmRE[10]
		--個別 RF
		on btn_RF01 pressed do Fn_toggleSelection arrClmRF[1]
		on btn_RF02 pressed do Fn_toggleSelection arrClmRF[2]
		on btn_RF03 pressed do Fn_toggleSelection arrClmRF[3]
		on btn_RF04 pressed do Fn_toggleSelection arrClmRF[4]
		on btn_RF05 pressed do Fn_toggleSelection arrClmRF[5]
		on btn_RF06 pressed do Fn_toggleSelection arrClmRF[6]
		on btn_RF07 pressed do Fn_toggleSelection arrClmRF[7]
		on btn_RF08 pressed do Fn_toggleSelection arrClmRF[8]
		on btn_RF09 pressed do Fn_toggleSelection arrClmRF[9]
		on btn_RF10 pressed do Fn_toggleSelection arrClmRF[10]
		--個別 RG
		on btn_RG01 pressed do Fn_toggleSelection arrClmRG[1]
		on btn_RG02 pressed do Fn_toggleSelection arrClmRG[2]
		on btn_RG03 pressed do Fn_toggleSelection arrClmRG[3]
		on btn_RG04 pressed do Fn_toggleSelection arrClmRG[4]
		on btn_RG05 pressed do Fn_toggleSelection arrClmRG[5]
		on btn_RG06 pressed do Fn_toggleSelection arrClmRG[6]
		on btn_RG07 pressed do Fn_toggleSelection arrClmRG[7]
		on btn_RG08 pressed do Fn_toggleSelection arrClmRG[8]
		on btn_RG09 pressed do Fn_toggleSelection arrClmRG[9]
		on btn_RG10 pressed do Fn_toggleSelection arrClmRG[10]
		--個別 RH
		on btn_RH01 pressed do Fn_toggleSelection arrClmRH[1]
		on btn_RH02 pressed do Fn_toggleSelection arrClmRH[2]
		on btn_RH03 pressed do Fn_toggleSelection arrClmRH[3]
		on btn_RH04 pressed do Fn_toggleSelection arrClmRH[4]
		on btn_RH05 pressed do Fn_toggleSelection arrClmRH[5]
		on btn_RH06 pressed do Fn_toggleSelection arrClmRH[6]
		on btn_RH07 pressed do Fn_toggleSelection arrClmRH[7]
		on btn_RH08 pressed do Fn_toggleSelection arrClmRH[8]
		on btn_RH09 pressed do Fn_toggleSelection arrClmRH[9]
		on btn_RH10 pressed do Fn_toggleSelection arrClmRH[10]
		--個別 B
		on btn_B01 pressed do Fn_toggleSelection arrClmB[1]
		on btn_B02 pressed do Fn_toggleSelection arrClmB[2]
		on btn_B03 pressed do Fn_toggleSelection arrClmB[3]
		on btn_B04 pressed do Fn_toggleSelection arrClmB[4]
		on btn_B05 pressed do Fn_toggleSelection arrClmB[5]
		on btn_B06 pressed do Fn_toggleSelection arrClmB[6]
		on btn_B07 pressed do Fn_toggleSelection arrClmB[7]
		on btn_B08 pressed do Fn_toggleSelection arrClmB[8]
		on btn_B09 pressed do Fn_toggleSelection arrClmB[9]
		on btn_B10 pressed do Fn_toggleSelection arrClmB[10]
		--個別 LA
		on btn_LA01 pressed do Fn_toggleSelection arrClmLA[1]
		on btn_LA02 pressed do Fn_toggleSelection arrClmLA[2]
		on btn_LA03 pressed do Fn_toggleSelection arrClmLA[3]
		on btn_LA04 pressed do Fn_toggleSelection arrClmLA[4]
		on btn_LA05 pressed do Fn_toggleSelection arrClmLA[5]
		on btn_LA06 pressed do Fn_toggleSelection arrClmLA[6]
		on btn_LA07 pressed do Fn_toggleSelection arrClmLA[7]
		on btn_LA08 pressed do Fn_toggleSelection arrClmLA[8]
		on btn_LA09 pressed do Fn_toggleSelection arrClmLA[9]
		on btn_LA10 pressed do Fn_toggleSelection arrClmLA[10]
		--個別 LB
		on btn_LB01 pressed do Fn_toggleSelection arrClmLB[1]
		on btn_LB02 pressed do Fn_toggleSelection arrClmLB[2]
		on btn_LB03 pressed do Fn_toggleSelection arrClmLB[3]
		on btn_LB04 pressed do Fn_toggleSelection arrClmLB[4]
		on btn_LB05 pressed do Fn_toggleSelection arrClmLB[5]
		on btn_LB06 pressed do Fn_toggleSelection arrClmLB[6]
		on btn_LB07 pressed do Fn_toggleSelection arrClmLB[7]
		on btn_LB08 pressed do Fn_toggleSelection arrClmLB[8]
		on btn_LB09 pressed do Fn_toggleSelection arrClmLB[9]
		on btn_LB10 pressed do Fn_toggleSelection arrClmLB[10]
		--個別 LC
		on btn_LC01 pressed do Fn_toggleSelection arrClmLC[1]
		on btn_LC02 pressed do Fn_toggleSelection arrClmLC[2]
		on btn_LC03 pressed do Fn_toggleSelection arrClmLC[3]
		on btn_LC04 pressed do Fn_toggleSelection arrClmLC[4]
		on btn_LC05 pressed do Fn_toggleSelection arrClmLC[5]
		on btn_LC06 pressed do Fn_toggleSelection arrClmLC[6]
		on btn_LC07 pressed do Fn_toggleSelection arrClmLC[7]
		on btn_LC08 pressed do Fn_toggleSelection arrClmLC[8]
		on btn_LC09 pressed do Fn_toggleSelection arrClmLC[9]
		on btn_LC10 pressed do Fn_toggleSelection arrClmLC[10]
		--個別 LD
		on btn_LD01 pressed do Fn_toggleSelection arrClmLD[1]
		on btn_LD02 pressed do Fn_toggleSelection arrClmLD[2]
		on btn_LD03 pressed do Fn_toggleSelection arrClmLD[3]
		on btn_LD04 pressed do Fn_toggleSelection arrClmLD[4]
		on btn_LD05 pressed do Fn_toggleSelection arrClmLD[5]
		on btn_LD06 pressed do Fn_toggleSelection arrClmLD[6]
		on btn_LD07 pressed do Fn_toggleSelection arrClmLD[7]
		on btn_LD08 pressed do Fn_toggleSelection arrClmLD[8]
		on btn_LD09 pressed do Fn_toggleSelection arrClmLD[9]
		on btn_LD10 pressed do Fn_toggleSelection arrClmLD[10]
		--個別 LE
		on btn_LE01 pressed do Fn_toggleSelection arrClmLE[1]
		on btn_LE02 pressed do Fn_toggleSelection arrClmLE[2]
		on btn_LE03 pressed do Fn_toggleSelection arrClmLE[3]
		on btn_LE04 pressed do Fn_toggleSelection arrClmLE[4]
		on btn_LE05 pressed do Fn_toggleSelection arrClmLE[5]
		on btn_LE06 pressed do Fn_toggleSelection arrClmLE[6]
		on btn_LE07 pressed do Fn_toggleSelection arrClmLE[7]
		on btn_LE08 pressed do Fn_toggleSelection arrClmLE[8]
		on btn_LE09 pressed do Fn_toggleSelection arrClmLE[9]
		on btn_LE10 pressed do Fn_toggleSelection arrClmLE[10]
		--個別 LF
		on btn_LF01 pressed do Fn_toggleSelection arrClmLF[1]
		on btn_LF02 pressed do Fn_toggleSelection arrClmLF[2]
		on btn_LF03 pressed do Fn_toggleSelection arrClmLF[3]
		on btn_LF04 pressed do Fn_toggleSelection arrClmLF[4]
		on btn_LF05 pressed do Fn_toggleSelection arrClmLF[5]
		on btn_LF06 pressed do Fn_toggleSelection arrClmLF[6]
		on btn_LF07 pressed do Fn_toggleSelection arrClmLF[7]
		on btn_LF08 pressed do Fn_toggleSelection arrClmLF[8]
		on btn_LF09 pressed do Fn_toggleSelection arrClmLF[9]
		on btn_LF10 pressed do Fn_toggleSelection arrClmLF[10]
		--個別 LG
		on btn_LG01 pressed do Fn_toggleSelection arrClmLG[1]
		on btn_LG02 pressed do Fn_toggleSelection arrClmLG[2]
		on btn_LG03 pressed do Fn_toggleSelection arrClmLG[3]
		on btn_LG04 pressed do Fn_toggleSelection arrClmLG[4]
		on btn_LG05 pressed do Fn_toggleSelection arrClmLG[5]
		on btn_LG06 pressed do Fn_toggleSelection arrClmLG[6]
		on btn_LG07 pressed do Fn_toggleSelection arrClmLG[7]
		on btn_LG08 pressed do Fn_toggleSelection arrClmLG[8]
		on btn_LG09 pressed do Fn_toggleSelection arrClmLG[9]
		on btn_LG10 pressed do Fn_toggleSelection arrClmLG[10]
		--個別 LH
		on btn_LH01 pressed do Fn_toggleSelection arrClmLH[1]
		on btn_LH02 pressed do Fn_toggleSelection arrClmLH[2]
		on btn_LH03 pressed do Fn_toggleSelection arrClmLH[3]
		on btn_LH04 pressed do Fn_toggleSelection arrClmLH[4]
		on btn_LH05 pressed do Fn_toggleSelection arrClmLH[5]
		on btn_LH06 pressed do Fn_toggleSelection arrClmLH[6]
		on btn_LH07 pressed do Fn_toggleSelection arrClmLH[7]
		on btn_LH08 pressed do Fn_toggleSelection arrClmLH[8]
		on btn_LH09 pressed do Fn_toggleSelection arrClmLH[9]
		on btn_LH10 pressed do Fn_toggleSelection arrClmLH[10]




	)
	createDialog selector_test width:420 height:280
)