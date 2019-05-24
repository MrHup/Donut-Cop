-- gestioneaza butonul de informatii
local MX = application:getContentWidth() -- retine latimea ecranului
local MY = application:getContentHeight()  -- retine inaltimea
bginfo = Bitmap.new(Texture.new("Art/shopBG.png"))
bginfo:setSize(5000,5000)

local font = Font.new("Textures/DonutCopFont.txt", "Textures/DonutCopFont.png")

local info1 = TextWrap.new("Proiect realizat de: Holerga Flavius\nClasa a XII-a Matematica-Informatica\nProfesor coordonator: Florea Gabriela\nLiceul Teoretic Axente Sever, Medias\n2017-2018", 500, "center") -- descrierea costumului selectat
info1:setLineSpacing(15) -- spatierea dintre linii
info1:setFont(font)
info1:setTextColor(0xffffff)
info1:setScale(.5)
info1:setPosition(110,130)

local mascota = Bitmap.new(Texture.new("Art/mascota.png"))
mascota:setScale(3.4)
mascota:setPosition(15,45)
local mascota2 = Bitmap.new(Texture.new("Art/mascota_op.png"))
mascota2:setScale(3.4)
mascota2:setPosition(295,45)

function retrageInfo()
	stage:removeChild(bginfo)
	stage:removeChild(info1)
	stage:removeChild(mascota)
	stage:removeChild(mascota2)
end

function showInfo()
	stage:addChild(bginfo)
	stage:addChild(info1)
	stage:addChild(mascota)
	stage:addChild(mascota2)
	Timer.delayedCall(5000, function() retrageInfo() end) 
end