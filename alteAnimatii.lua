local packX = TexturePack.new("Textures/dedanim.txt", "Textures/dedanim.png")
copanim0 = Bitmap.new(packX:getTextureRegion("copanim_00.png"))
copanim1 = Bitmap.new(packX:getTextureRegion("copanim_01.png"))
copanim2 = Bitmap.new(packX:getTextureRegion("copanim_02.png"))
copanim3 = Bitmap.new(packX:getTextureRegion("copanim_03.png"))
copanim4 = Bitmap.new(packX:getTextureRegion("copanim_04.png"))
copanim5 = Bitmap.new(packX:getTextureRegion("copanim_05.png"))
copanim6 = Bitmap.new(packX:getTextureRegion("copanim_06.png"))
copanim7 = Bitmap.new(packX:getTextureRegion("copanim_07.png"))
copanim8 = Bitmap.new(packX:getTextureRegion("copanim_08.png"))
copanim9 = Bitmap.new(packX:getTextureRegion("copanim_09.png"))
copanim10 = Bitmap.new(packX:getTextureRegion("copanim_10.png"))

copanim = MovieClip.new{ --animatia politistului cand e lovit de masina
	{1, 6, copanim0},	
	{7, 12, copanim1},
	{13, 18, copanim2},
	{19, 24, copanim3},
	{25, 30, copanim4},
	{31, 36, copanim5},
	{37, 42, copanim6},
	{43, 48, copanim7},
	{49, 54, copanim8},
	{55, 60, copanim9},
	{61, 66, copanim10}
}
copanim:setScale(1.4,1.4)
copanim:setGotoAction(67,1)
copanim:setPosition(-570,-600)

local pack3 = TexturePack.new("Textures/masinadistrusa.txt", "Textures/masinadistrusa.png")
masinadistrusa1 = Bitmap.new(pack3:getTextureRegion("bum_0.png"))
masinadistrusa2 = Bitmap.new(pack3:getTextureRegion("bum_1.png"))
masinadistrusa3 = Bitmap.new(pack3:getTextureRegion("bum_2.png"))
masinadistrusa4 = Bitmap.new(pack3:getTextureRegion("bum_3.png"))

bum = MovieClip.new{
	{1, 5, masinadistrusa1},
	{6, 11, masinadistrusa2},
	{12, 17, masinadistrusa3},
	{18, 23, masinadistrusa4}
}
bum:setPosition(-1000,0)

local pack4 = TexturePack.new("Textures/DonutCar.txt","Textures/DonutCar.png")
dcar1 = Bitmap.new(pack4:getTextureRegion("donutcar_0.png"))
dcar2 = Bitmap.new(pack4:getTextureRegion("donutcar_1.png"))
dcar3 = Bitmap.new(pack4:getTextureRegion("donutcar_2.png"))
dcar4 = Bitmap.new(pack4:getTextureRegion("donutcar_3.png"))
dcar5 = Bitmap.new(pack4:getTextureRegion("donutcar_4.png"))
dcar6 = Bitmap.new(pack4:getTextureRegion("donutcar_5.png"))

donutcar = MovieClip.new{
	{1,5, dcar1},
	{6,11, dcar2},
	{12,17, dcar3},
	{18,23, dcar4},
	{24,29, dcar5}
}
donutcar:setPosition(-500,0)
donutcar:setScale(1.6,1.6)
donutcar:setGotoAction(29, 1)

local pack2 = TexturePack.new("Textures/texturaExplozie.txt", "Textures/texturaExplozie.png")
explozie1 = Bitmap.new(pack2:getTextureRegion("explozie_1.png"))
explozie2 = Bitmap.new(pack2:getTextureRegion("explozie_2.png"))
explozie3 = Bitmap.new(pack2:getTextureRegion("explozie_3.png"))
explozie4 = Bitmap.new(pack2:getTextureRegion("explozie_4.png"))
explozie5 = Bitmap.new(pack2:getTextureRegion("explozie_5.png"))
explozie6 = Bitmap.new(pack2:getTextureRegion("explozie_6.png"))
explozie7 = Bitmap.new(pack2:getTextureRegion("explozie_7.png"))

explozie = MovieClip.new{
	{1, 5, explozie1},	
	{6, 11, explozie2},
	{12, 17, explozie3},
	{18, 23, explozie4},
	{24, 29, explozie5},
	{30, 35, explozie6},
	{36, 41, explozie7}
}

explozie:setScale(1.7,1.7)

explozie:setPosition(-1000,-1000)

frames1 = {
	"Textures/CarO/caro0.png",
	"Textures/CarO/caro1.png",
	"Textures/CarO/caro2.png",
	"Textures/CarO/caro3.png",
	"Textures/CarO/caro4.png"
	}
	
frames2 = {
	"Textures/Car1/car1_0.png",
	"Textures/Car1/car1_1.png",
	"Textures/Car1/car1_2.png",
	"Textures/Car1/car1_3.png",
	"Textures/Car1/car1_4.png",
	"Textures/Car1/car1_5.png"
	}	
	
car1 = Car.new(frames1,factor)
car1:setScale(0.6,0.6)

