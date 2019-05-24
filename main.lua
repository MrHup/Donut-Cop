--[[ 
	Cuprins
	12 ......... initializari si altele
	161 ........ salvare load
	216 ........ adaugare obiecte
	276 ........ gestionarea magazinului de caractere
	366 ........ functii butoane
	589 ........ gestionarea aplicatiei inainte si dupa un inceperea unui joc
	801 ........ setare evenimente
]]--

------------------------------------[[[[[[[     INITIALIZARI SI ALTELE      ]]]]]]]]]] --------------------------------
application:setKeepAwake(true) -- face ca telefonul sa nu intre in sleep
application:setScaleMode("stretch") -- redimensioneaza jocul in functie de device
application:setOrientation(Application.LANDSCAPE_LEFT) -- seteaza orientarea ecranului
application:setFps(60)
--Var principale
local MX = application:getContentWidth() -- retine latimea ecranului
local MY = application:getContentHeight()  -- retine inaltimea
local force = 0
local ingame = false -- indica daca exista o runda in progres
--Debounceri
local deb_b_play = false
local deb_b_shop = false
local deb_b_back = false
function undebug(x)
	deb_b_back = false
	deb_b_shop = false
end
--Fonturi
local font = Font.new("Textures/DonutCopFont.txt", "Textures/DonutCopFont.png")
--Pornire muzica background / sunete
local song =  Sound.new("Sounds/DonutCopThemeSong.wav")
local canal_song = song:play(1, true, false) -- porneste muzica si o repeta in continuu
canal_song:setVolume(0.1) -- setare volum melodie
local bang =  Sound.new("Sounds/bang.wav")
local ding2 =  Sound.new("Sounds/ding.wav")
local ding = ding2:play()
ding:setVolume(0)
--Imagine background-uri & efect de miscare a acestuia
local background = Bitmap.new(Texture.new("Art/Background.png"))
background:setScale(0.65,0.67)
local c_background = Bitmap.new(Texture.new("Art/Background.png")) -- copia backgroundului
c_background:setScale(0.65,0.67)
c_background:setPosition(MX,0)
local bg2 = Bitmap.new(Texture.new("Art/Sky.png"))  -- cerul din spatele cladirilor (static)
bg2:setScale(0.65,0.67)
--Titluri si alte textLabel-uri
local shopBG = Bitmap.new(Texture.new("Art/shopBG.png"))
shopBG:setPosition(0,MY)
shopBG:setScale(0.65,0.67)
local T_Shop = Bitmap.new(Texture.new("Art/T_Shop.png"))
T_Shop:setScale(0.3,0.3)
T_Shop:setPosition(MX/4 - T_Shop:getWidth()/2,MY+15)
local border = Bitmap.new(Texture.new("Art/border.png")) -- chenarul albastru folosit la shop
border:setScale(1.4,1.4)
border:setPosition(MX,MY)
local catAi = TextField.new(font, "0") -- TextLabel pentru numarul de gogosi
catAi:setTextColor(0xffffff)
catAi:setScale(1.5,1.5)
catAi:setPosition(15,2*MY-15-catAi:getHeight())
local donutText2 = Bitmap.new(Texture.new("Art/donut.png"))
donutText2:setScale(1.6,1.6)
donutText2:setPosition(catAi:getWidth() + 25, 2*MY- donutText2:getHeight() - 10)
--Informatii si obiecte din Shop
local info_titlu = TextField.new(font, "Classic Donut") -- titlul costumului selectat
info_titlu:setTextColor(0xffffff)
info_titlu:setPosition(MX-info_titlu:getWidth()-const,MY+45)
local info_desc = TextWrap.new("Classic Donut\nOH BOY", 250, "center") -- descrierea costumului selectat
info_desc:setLineSpacing(15) -- spatierea dintre linii
info_desc:setFont(font)
info_desc:setTextColor(0xffffff)
info_desc:setScale(.5)
info_desc:setPosition(MX-info_titlu:getWidth()-const,MY+85)
local pret = TextField.new(font, "Price: 0") -- pretul costumului
pret:setTextColor(0xffffff)
pret:setScale(.5)
pret:setPosition(MX-pret:getWidth()/2-info_titlu:getWidth()/2-const, info_desc:getY()+info_desc:getHeight()+5 )
--Butoane din SHOP
b1 = Bitmap.new(Texture.new("Art/b_buy.png"))
b2 = Bitmap.new(Texture.new("Art/b_buy.png"))
b2:setScale(1.1,1.1)
b_buy = Button.new(b1, b2) -- buton cumparare
b_buy:setPosition(MX-b_buy:getWidth()-const-5,pret:getY()+pret:getHeight()+5)

b1 = Bitmap.new(Texture.new("Art/b_back.png"))
b2 = Bitmap.new(Texture.new("Art/b_back.png"))
b2:setScale(1.1,1.1)
b_back = Button.new(b1, b2) -- buton de intoarcere
b_back:setPosition(MX-b_back:getWidth()-const-5,b_buy:getY()+b_buy:getHeight()+5)

b1 = Bitmap.new(Texture.new("Art/b_wear.png"))
b2 = Bitmap.new(Texture.new("Art/b_wear.png"))
b2:setScale(1.1,1.1)
b_wear = Button.new(b1, b2) -- buton de echipare a costumului
b_wear:setPosition(MX-b_buy:getWidth()-const-5,pret:getY()+pret:getHeight()+5+MY)

b1 = Bitmap.new(Texture.new("Art/b_have.png"))
b2 = Bitmap.new(Texture.new("Art/b_have.png"))
b2:setScale(1.1,1.1)
b_have = Button.new(b1, b2) -- buton de semnalizare
b_have:setPosition(MX-b_buy:getWidth()-const-5,pret:getY()+pret:getHeight()+5+MY)
--buton play
b1 = Bitmap.new(Texture.new("Art/b_play.png"))
b2 = Bitmap.new(Texture.new("Art/b_play.png"))
b2:setScale(1.1,1.1)
b_play = Button.new(b1, b2)
b_play:setScale(6,6)
b_play:setPosition(MX/2-b_play:getWidth()/2,MY/2-b_play:getHeight()/2)
--buton informatii
b1 = Bitmap.new(Texture.new("Art/b_info.png"))
b2 = Bitmap.new(Texture.new("Art/b_info.png"))
b2:setScale(1.1,1.1)
local b_info = Button.new(b1,b2)
b_info:setScale(2,2)
b_info:setPosition(MX-70,MY-70)
--buton shop
b1 = Bitmap.new(Texture.new("Art/b_shop.png"))
b2 = Bitmap.new(Texture.new("Art/b_shop.png"))
b2:setScale(1.1,1.1)
local b_shop = Button.new(b1,b2)
b_shop:setScale(2,2)
b_shop:setPosition(5,MY-70)
--TextLabel-uri pentru scor, record si alte informatii de pe meniul principal
local textfield1 = TextField.new(font, "Score: 0")
textfield1:setTextColor(0xffffff)
textfield1:setPosition(MX/2-textfield1:getWidth()-10,5)
local text_best = TextField.new(font, "Best: 0")
text_best:setTextColor(0xff0000)
text_best:setPosition(MX/2+10,5)
local realizatDe = TextField.new(font, minidesc)
realizatDe:setTextColor(0xffffff)
realizatDe:setScale(.5)
realizatDe:setPosition(MX/2-realizatDe:getWidth()/2,MY-realizatDe:getHeight()-5)
local donut = Bitmap.new(Texture.new("Art/donut.png"))
donut:setScale(1.6,1.6)
donut:setPosition(MX+500,math.random(75)+150)
local textfield2 = TextField.new(font, "0")
textfield2:setTextColor(0xffffff)
textfield2:setScale(1.5,1.5)
textfield2:setPosition(15,16)
local donutText = Bitmap.new(Texture.new("Art/donut.png"))
donutText:setScale(1.6,1.6)
donutText:setPosition(textfield2:getWidth() + 25, 5)

title = Bitmap.new(Texture.new("Art/Titlu.png")) 
title:setPosition(65,0) -- pozitionare titlu
--joystick
joystick = Button.new(Bitmap.new(Texture.new("Art/Joystick.png")),Bitmap.new(Texture.new("Art/Joystick.png")))
joystick:setPosition(20,MY/2-MY/8)
joystick:setScale(1.9,1.9)
joystick:setAlpha(0)

--Declarara caracter principal
local mc = mc_creat
local tag1 = 20
local tag2 = 1
mc:setGotoAction(tag1,tag2) --40;21 - 60;41 - 80;61
mc:setPosition(70,100) 

---------------------------- [[[[[[[[[[       SALVARE  /  LOAD       ]]]]]]]]]]]]]]] ---------------------------------------------------

function loadHighscore() --- da load la stats
	local file = io.open("|D|data.txt", "r")
	if file then
		best = tonumber(file:read())
		bani = tonumber(file:read())
		for i, v in pairs(costume) do
			costume[i] = tonumber(file:read())
		end
		io.close(file)
	else
		best = 0
		for i, v in pairs(costume) do
			costume[i] = 1
		end
		costume[1]=3
	end
	
end
 
function saveHighscore()
	local file = io.open("|D|data.txt", "w+")
	if file then
		file:write(best .. "\n")
		file:write(bani .. "\n")
		for i, v in pairs(costume) do
			file:write(costume[i] .. "\n")
		end
	end
	io.close(file)
end
function loadStuffUp() -- actualizeaza elementele vizuale pe baza diferitor valori
	text_best:setText("Best: " .. best)
	textfield2:setText(bani)
	catAi:setText(bani)
	donutText:setPosition(textfield2:getWidth() + 25, 5)
	
	for i,v in pairs(costume) do
		if v==3 then
			tag1 = i*20
			tag2 = 1+(i-1)*20
		end
	end
end
loadHighscore()
loadStuffUp()
---
for i,v in pairs(costume) do
	if v==3 then
		mc:setGotoAction(tag1,tag2)
		mc:gotoAndPlay(tag2)
	end
end

----------------------------------- [[[[[[[[[      ADAUGARE OBIECTE       ]]]]]]]]----------------------------
stage:addChild(bg2)
stage:addChild(background)
stage:addChild(c_background)
stage:addChild(b_play)
stage:addChild(b_info)
stage:addChild(b_shop)
stage:addChild(donutText)
stage:addChild(mc)
stage:addChild(bum)
stage:addChild(donut)
stage:addChild(textfield1)
stage:addChild(text_best)
stage:addChild(textfield2)
stage:addChild(realizatDe)
stage:addChild(title)
stage:addChild(donutcar)
stage:addChild(copanim)
stage:addChild(explozie)
stage:addChild(joystick)
stage:addChild(shopBG)
stage:addChild(T_Shop)
stage:addChild(border)
stage:addChild(info_titlu)
stage:addChild(info_desc)
stage:addChild(b_buy)
stage:addChild(b_back)
stage:addChild(b_wear)
stage:addChild(b_have)
stage:addChild(pret)
stage:addChild(catAi)
stage:addChild(donutText2)

function play_g(target,event)  -- buton de play
	if target:hitTestPoint(event.x, event.y) and deb_b_play==false then
		deb_b_play = true
		retreatstuff()
		GTween.new(joystick,1,{x=20},{ease = easing.inSine})
		GTween.new(donutcar,3,{x=MX},{ease = easing.inSine})
		joystick:setAlpha(0.5)
		Timer.delayedCall(2600, function() incepe_pe_bune() end) 
		GTween.new(mc,1,{x=70,y=mc:getY()},{ease = easing.inSine}) --adaugare politist de pe ecran
		canal_song:setVolume(0.25)
	end
end

function info_g(target,event)  -- buton de informatii
	if target:hitTestPoint(event.x, event.y) then
		--GTween.new(donutcar,1,{x=-500},{ease = easing.outSine})
		--GTween.new(mc,1,{x=-500},{ease = easing.outSine})
		--retreatstuff()
		--[[costume[1] = 3
		costume[2] = 1
		costume[3] = 1
		costume[4] = 1
		bani = bani+ 50]]
		showInfo()
		--saveHighscore()
	end
end

-----------------------[[[[[[[[[[[     SHOP      ]]]]]]]]]]]]]]-------------------------

local grup_shop = {}
local tabel_afisare = Sprite.new()
local extract = 0
local stg1, stg2
local despre = 1
local select_tag1 = 20 
local select_tag2 = 1


function set_but(x) -- setare aspect buton in functie de avabilitatea costumului selectat
	if x == 1 then
		b_buy:setPosition(MX-b_buy:getWidth()-const-5,pret:getY()+pret:getHeight()+5)
		b_have:setPosition(MX-b_buy:getWidth()-const-5,pret:getY()+pret:getHeight()+5+MY)
		b_wear:setPosition(MX-b_buy:getWidth()-const-5,pret:getY()+pret:getHeight()+5+MY)
	elseif x ==2 then
		b_buy:setPosition(MX-b_buy:getWidth()-const-5,pret:getY()+pret:getHeight()+5+MY)
		b_have:setPosition(MX-b_buy:getWidth()-const-5,pret:getY()+pret:getHeight()+5+MY)
		b_wear:setPosition(MX-b_buy:getWidth()-const-5,pret:getY()+pret:getHeight()+5)
	elseif x==3 then
		b_buy:setPosition(MX-b_buy:getWidth()-const-5,pret:getY()+pret:getHeight()+5+MY)
		b_have:setPosition(MX-b_buy:getWidth()-const-5,pret:getY()+pret:getHeight()+5)
		b_wear:setPosition(MX-b_buy:getWidth()-const-5,pret:getY()+pret:getHeight()+5+MY)
	end
end
if costume[1] == 3 then  set_but(3) else set_but(2) end

function gr_b(target,event)
	if target:hitTestPoint(event.x, event.y) then
		GTween.new(border,.75,{x=target:getX()-7,y=target:getY()},{ease = easing.outSine})
		if target == grup_shop[1] then
			extract = 0
			info_titlu:setText("   Classic Cop")
			info_desc:setText("Classy for the donut")
			pret:setText(" ")
			despre = 1
			select_tag1= 20
			select_tag2 =1
		elseif target == grup_shop[2] then
			extract = 25
			info_titlu:setText("   Doctor Cop")
			info_desc:setText("Gonna heal those donuts I tell ya")
			pret:setText("Price: " .. extract)
			despre = 2
			select_tag1 = 40
			select_tag2 = 21
		elseif target == grup_shop[3] then
			extract = 50
			info_titlu:setText("   Worker Cop")
			info_desc:setText("If you have to work for donuts, you work for them")
			pret:setText("Price: " .. extract)
			despre = 3
			select_tag1 = 60
			select_tag2 = 41
		elseif target == grup_shop[4] then
			extract = 100
			info_titlu:setText("    Santa Cop")
			info_desc:setText("My gift for you is a donut")
			pret:setText("Price: " .. extract)
			despre = 4
			select_tag1 = 80
			select_tag2 = 61
		end
		set_but(costume[despre])
	end
end

--Pregatire shop
local spack = TexturePack.new("Textures/copText.txt", "Textures/copText.png")
grup_shop[1] = Button.new(Bitmap.new(spack:getTextureRegion("cop_0.png")),Bitmap.new(spack:getTextureRegion("cop_0.png")))
grup_shop[1]:setScale(1.4,1.4)
spack = TexturePack.new("Textures/CopFarma.txt", "Textures/CopFarma.png")
grup_shop[2] = Button.new(Bitmap.new(spack:getTextureRegion("sprite_0.png")),Bitmap.new(spack:getTextureRegion("sprite_0.png")))
grup_shop[2]:setScale(1.4,1.4)
spack = TexturePack.new("Textures/CopWorker.txt", "Textures/CopWorker.png")
grup_shop[3] = Button.new(Bitmap.new(spack:getTextureRegion("sprite_0.png")),Bitmap.new(spack:getTextureRegion("sprite_0.png")))
grup_shop[3]:setScale(1.4,1.4)
spack = TexturePack.new("Textures/CopSanta.txt", "Textures/CopSanta.png")
grup_shop[4] = Button.new(Bitmap.new(spack:getTextureRegion("sprite_0.png")),Bitmap.new(spack:getTextureRegion("sprite_0.png")))
grup_shop[4]:setScale(1.4,1.4)
for g, v in pairs(grup_shop) do
	v:setPosition(v:getWidth()*(g-1) + 5,MY/2-v:getHeight()/2)
end
for g, v in pairs(grup_shop) do
	tabel_afisare:addChild(v)
end
tabel_afisare:setPosition(0,MY)
stage:addChild(tabel_afisare)

---------- [[[[[[[[[[[[[[[[           FUNCTII BUTOANE               ]]]]]]]]]]]]]] ---------

function shop_g(target,event) -- buton de shop
	if target:hitTestPoint(event.x, event.y) and deb_b_shop == false and deb_b_back==false then
		deb_b_shop = true
		deb_b_back = true
		loadStuffUp()
		
		--totul in sus 
		--b_info, b_play, b_shop, title, realizatDe
		GTween.new(donutcar,2,{y=donutcar:getY() - MY},{ease = easing.outSine})
		GTween.new(mc,2,{y=mc:getY() - MY},{ease = easing.outSine})
		GTween.new(b_info,2,{y=b_info:getY()- MY},{ease = easing.outSine})
		GTween.new(b_play,2,{y=b_play:getY()- MY},{ease = easing.outSine})
		GTween.new(b_shop,2,{y=b_shop:getY()- MY},{ease = easing.outSine})
		GTween.new(title,2,{y=title:getY()- MY},{ease = easing.outSine})
		GTween.new(realizatDe,2,{y=realizatDe:getY()- MY},{ease = easing.outSine})
		GTween.new(bg2,2,{y=bg2:getY()- MY},{ease = easing.outSine})
		GTween.new(background,2,{y=background:getY()- MY},{ease = easing.outSine})
		GTween.new(c_background,2,{y=c_background:getY()- MY},{ease = easing.outSine})
		GTween.new(textfield2,2,{y=textfield2:getY()- MY},{ease = easing.outSine})
		GTween.new(donutText,2,{x=textfield2:getWidth()+5,y=donutText:getY()- MY},{ease = easing.outSine})
		GTween.new(donutcar,2,{y=donutcar:getY()- MY},{ease = easing.outSine})
		GTween.new(text_best,2,{y=text_best:getY()- MY},{ease = easing.outSine})
		GTween.new(textfield1,2,{y=textfield1:getY()- MY},{ease = easing.outSine})
		
		
		GTween.new(shopBG,2,{y=shopBG:getY()- MY},{ease = easing.outSine})
		GTween.new(T_Shop,2,{y=T_Shop:getY()- MY},{ease = easing.outSine})
		GTween.new(tabel_afisare,2,{y=tabel_afisare:getY() - MY},{ease = easing.outSine})
		--
		GTween.new(border,2,{x=grup_shop[despre]:getX()-7,y=grup_shop[1]:getY()},{ease = easing.outSine})
		GTween.new(info_titlu,2,{y=info_titlu:getY()- MY},{ease = easing.outSine})
		GTween.new(info_desc,2,{y=info_desc:getY()- MY},{ease = easing.outSine})
		GTween.new(b_buy,2,{y=b_buy:getY()- MY},{ease = easing.outSine})
		GTween.new(b_have,2,{y=b_have:getY()- MY},{ease = easing.outSine})
		GTween.new(b_wear,2,{y=b_wear:getY()- MY},{ease = easing.outSine})
		GTween.new(b_back,2,{y=b_back:getY()- MY},{ease = easing.outSine})
		GTween.new(pret,2,{y=pret:getY()- MY},{ease = easing.outSine})
		GTween.new(catAi,2,{y=catAi:getY()- MY},{ease = easing.outSine})
		GTween.new(donutText2,2,{x=catAi:getWidth()+15,y=donutText2:getY()- MY},{ease = easing.outSine})
		
		Timer.delayedCall(2500, function() undebug() end)  
	end
end

function back_g(target,event) -- buton de mers inapoi
if target:hitTestPoint(event.x, event.y) and deb_b_back == false and deb_b_play==false then
			deb_b_back = true
			deb_b_shop = true
			GTween.new(donutcar,2,{y=donutcar:getY() + MY},{ease = easing.outSine})
			GTween.new(mc,2,{y=mc:getY() + MY},{ease = easing.outSine})
			GTween.new(b_info,2,{y=b_info:getY()+ MY},{ease = easing.outSine})
			GTween.new(b_play,2,{y=b_play:getY()+ MY},{ease = easing.outSine})
			GTween.new(b_shop,2,{y=b_shop:getY()+ MY},{ease = easing.outSine})
			GTween.new(title,2,{y=title:getY()+ MY},{ease = easing.outSine})
			GTween.new(realizatDe,2,{y=realizatDe:getY()+ MY},{ease = easing.outSine})
			GTween.new(bg2,2,{y=bg2:getY()+ MY},{ease = easing.outSine})
			GTween.new(background,2,{y=background:getY()+ MY},{ease = easing.outSine})
			GTween.new(c_background,2,{y=c_background:getY()+ MY},{ease = easing.outSine})
			GTween.new(textfield2,2,{y=textfield2:getY()+ MY},{ease = easing.outSine})
			GTween.new(donutText,2,{x=textfield2:getWidth()+15,y=donutText:getY()+ MY},{ease = easing.outSine})
			GTween.new(donutcar,2,{y=donutcar:getY()+ MY},{ease = easing.outSine})
			GTween.new(text_best,2,{y=text_best:getY()+ MY},{ease = easing.outSine})
			GTween.new(textfield1,2,{y=textfield1:getY()+ MY},{ease = easing.outSine})
			
			GTween.new(shopBG,2,{y=shopBG:getY()+ MY},{ease = easing.outSine})
			GTween.new(T_Shop,2,{y=T_Shop:getY()+ MY},{ease = easing.outSine})
			GTween.new(tabel_afisare,2,{y=tabel_afisare:getY() + MY},{ease = easing.outSine})
			
			GTween.new(border,2,{x=grup_shop[despre]:getX()-7,y=grup_shop[1]:getY()+MY},{ease = easing.outSine})
			GTween.new(info_titlu,2,{y=info_titlu:getY()+ MY},{ease = easing.outSine})
			GTween.new(info_desc,2,{y=info_desc:getY()+ MY},{ease = easing.outSine})
			GTween.new(b_buy,2,{y=b_buy:getY()+ MY},{ease = easing.outSine})
			GTween.new(b_wear,2,{y=b_wear:getY()+ MY},{ease = easing.outSine})
			GTween.new(b_have,2,{y=b_have:getY()+ MY},{ease = easing.outSine})
			GTween.new(b_back,2,{y=b_back:getY()+ MY},{ease = easing.outSine})
			GTween.new(pret,2,{y=pret:getY()+ MY},{ease = easing.outSine})
			GTween.new(catAi,2,{y=catAi:getY()+ MY},{ease = easing.outSine})
			GTween.new(donutText2,2,{y=donutText2:getY()+ MY},{ease = easing.outSine})
			
			Timer.delayedCall(2500, function() undebug() end) 	-- deblocare butoane
		end
end

function buy_g(target,event)
	if target:hitTestPoint(event.x, event.y) and deb_b_back == false and deb_b_play==false then
	if bani >= extract then
		bani = bani - extract
		for i, v in pairs(costume) do
			if costume[i]==3 then costume[i] = 2 end
		end
		costume[despre] = 3
		tag1= select_tag1
		tag2= select_tag2
		mc:setGotoAction(tag1,tag2)
		mc:gotoAndPlay(tag1-1) --40;21 - 60;41 - 80;61
		saveHighscore()
		loadStuffUp()
		set_but(3)
		
		GTween.new(donutcar,2,{y=donutcar:getY() + MY},{ease = easing.outSine})
		GTween.new(mc,2,{y=mc:getY() + MY},{ease = easing.outSine})
		GTween.new(b_info,2,{y=b_info:getY()+ MY},{ease = easing.outSine})
		GTween.new(b_play,2,{y=b_play:getY()+ MY},{ease = easing.outSine})
		GTween.new(b_shop,2,{y=b_shop:getY()+ MY},{ease = easing.outSine})
		GTween.new(title,2,{y=title:getY()+ MY},{ease = easing.outSine})
		GTween.new(realizatDe,2,{y=realizatDe:getY()+ MY},{ease = easing.outSine})
		GTween.new(bg2,2,{y=bg2:getY()+ MY},{ease = easing.outSine})
		GTween.new(background,2,{y=background:getY()+ MY},{ease = easing.outSine})
		GTween.new(c_background,2,{y=c_background:getY()+ MY},{ease = easing.outSine})
		GTween.new(textfield2,2,{y=textfield2:getY()+ MY},{ease = easing.outSine})
		GTween.new(donutText,2,{x=textfield2:getWidth() + 25,y=5},{ease = easing.outSine})
		
		GTween.new(donutcar,2,{y=donutcar:getY()+ MY},{ease = easing.outSine})
		GTween.new(text_best,2,{y=text_best:getY()+ MY},{ease = easing.outSine})
		GTween.new(textfield1,2,{y=textfield1:getY()+ MY},{ease = easing.outSine})
		
		GTween.new(shopBG,2,{y=shopBG:getY()+ MY},{ease = easing.outSine})
		GTween.new(T_Shop,2,{y=T_Shop:getY()+ MY},{ease = easing.outSine})
		GTween.new(tabel_afisare,2,{y=tabel_afisare:getY() + MY},{ease = easing.outSine})
		
		GTween.new(border,2,{x=grup_shop[despre]:getX()-7,y=grup_shop[1]:getY()+MY},{ease = easing.outSine})
		GTween.new(info_titlu,2,{y=info_titlu:getY()+ MY},{ease = easing.outSine})
		GTween.new(info_desc,2,{y=info_desc:getY()+ MY},{ease = easing.outSine})
		GTween.new(b_buy,2,{y=b_buy:getY()+ MY},{ease = easing.outSine})
		GTween.new(b_wear,2,{y=b_wear:getY()+ MY},{ease = easing.outSine})
		GTween.new(b_have,2,{y=b_have:getY()+ MY},{ease = easing.outSine})
		GTween.new(b_back,2,{y=b_back:getY()+ MY},{ease = easing.outSine})
		GTween.new(pret,2,{y=pret:getY()+ MY},{ease = easing.outSine})
		GTween.new(catAi,2,{y=catAi:getY()+ MY},{ease = easing.outSine})
		GTween.new(donutText2,2,{y=donutText2:getY()+ MY},{ease = easing.outSine})
		GTween.new(catAi,2,{y=catAi:getY()+ MY},{ease = easing.outSine})
		GTween.new(donutText2,2,{y=donutText2:getY()+ MY},{ease = easing.outSine})
		
	else
		shakeScreen() -- scutura ecranul daca costumul nu poate fi achizitonat
	end
	end
end

function wear_g(target,event)
	if target:hitTestPoint(event.x, event.y) then
		print("WEAR")
		print(costume[1],costume[2],costume[3],costume[4])
		b_wear:setPosition(b_wear:getX() + 5, b_wear:getY())
		for i,v in pairs(costume) do
			if costume[i]==3 then costume[i] = 2 end
		end
		costume[despre] = 3
		tag1= select_tag1
		tag2= select_tag2
		mc:setGotoAction(tag1,tag2)
		mc:gotoAndPlay(tag1-1) --40;21 - 60;41 - 80;61
		saveHighscore()
		loadStuffUp()
		donutText:setPosition(textfield2:getWidth() + 25, 5)
		set_but(3)
		print(costume[1],costume[2],costume[3],costume[4])
		-----
		GTween.new(donutcar,2,{y=donutcar:getY() + MY},{ease = easing.outSine})
		GTween.new(mc,2,{y=mc:getY() + MY},{ease = easing.outSine})
		GTween.new(b_info,2,{y=b_info:getY()+ MY},{ease = easing.outSine})
		GTween.new(b_play,2,{y=b_play:getY()+ MY},{ease = easing.outSine})
		GTween.new(b_shop,2,{y=b_shop:getY()+ MY},{ease = easing.outSine})
		GTween.new(title,2,{y=title:getY()+ MY},{ease = easing.outSine})
		GTween.new(realizatDe,2,{y=realizatDe:getY()+ MY},{ease = easing.outSine})
		GTween.new(bg2,2,{y=bg2:getY()+ MY},{ease = easing.outSine})
		GTween.new(background,2,{y=background:getY()+ MY},{ease = easing.outSine})
		GTween.new(c_background,2,{y=c_background:getY()+ MY},{ease = easing.outSine})
		GTween.new(textfield2,2,{y=textfield2:getY()+ MY},{ease = easing.outSine})
		GTween.new(donutText,2,{y=donutText:getY()+ MY},{ease = easing.outSine})
		GTween.new(donutcar,2,{y=donutcar:getY()+ MY},{ease = easing.outSine})
		GTween.new(text_best,2,{y=text_best:getY()+ MY},{ease = easing.outSine})
		GTween.new(textfield1,2,{y=textfield1:getY()+ MY},{ease = easing.outSine})
		
		GTween.new(shopBG,2,{y=shopBG:getY()+ MY},{ease = easing.outSine})
		GTween.new(T_Shop,2,{y=T_Shop:getY()+ MY},{ease = easing.outSine})
		GTween.new(tabel_afisare,2,{y=tabel_afisare:getY() + MY},{ease = easing.outSine})
		GTween.new(border,2,{x=grup_shop[despre]:getX()-7,y=grup_shop[1]:getY()+MY},{ease = easing.outSine})
		GTween.new(info_titlu,2,{y=info_titlu:getY()+ MY},{ease = easing.outSine})
		GTween.new(info_desc,2,{y=info_desc:getY()+ MY},{ease = easing.outSine})
		GTween.new(b_buy,2,{y=b_buy:getY()+ MY},{ease = easing.outSine})
		GTween.new(b_wear,2,{y=b_wear:getY()+ MY},{ease = easing.outSine})
		GTween.new(b_have,2,{y=b_have:getY()+ MY},{ease = easing.outSine})
		GTween.new(b_back,2,{y=b_back:getY()+ MY},{ease = easing.outSine})
		GTween.new(pret,2,{y=pret:getY()+ MY},{ease = easing.outSine})
		GTween.new(catAi,2,{y=catAi:getY()+ MY},{ease = easing.outSine})
		GTween.new(donutText2,2,{y=donutText2:getY()+ MY},{ease = easing.outSine})
		GTween.new(catAi,2,{y=catAi:getY()+ MY},{ease = easing.outSine})
		GTween.new(donutText2,2,{y=donutText2:getY()+ MY},{ease = easing.outSine})
	end
end

onJoy = false -- este true daca joystick-ul este atins, iar false daca nu este
local function JoyStickMove(event) -- executata in momentul miscarii joystick-ului
	if onJoy == true and ingame == true then
		local ty = event.y -- pozitia mouse-ului pe axa Y
		if ty>20 and ty< MY-70 then
			joystick:setPosition(20,event.y-20)
			force = MY-ty - (MY/2) --forta influeteaza viteza de miscare a politistului
		end
		joystick:setAlpha(1) --seteaza transparenta joystickului ca fiind opaca in momentul atingerii
	end
end
local function JoyStickAllow(target,event) --daca joystick-ul e folosit corespunzator, acest lucru este semnalat prin intermediul semaforului onJoy
	if target:hitTestPoint(event.x, event.y) then --verifica daca degetul jucatorului se afla in pozitia corecta
		onJoy = true
	end
end

function NoJoyStick() -- se apeleaza cand jucatorul ridica degetul de pe ecran
	if ingame == true then
		GTween.new(joystick,0.2,{x=20,y=MY/2-MY/8},{ease = easing.outSine}) -- misca butonul la pozitia initiala
		onJoy = false
		--GTween.new(joystick,0.2,{x=20,y=MY/2-MY/8},{ease = easing.outSine})
		force = 0 -- opreste politistul din miscare "laterala"
		joystick:setAlpha(0.5) -- face joystickul relativ transparent
	end
end



-------------------  [[[[[[[[[[[[[[[   GESTIONARE ELEMENTE JOC INAINTE SI DUPA INCEPEREA JOCULUI  ]]]]]]]]]]]]]]]]]----



function incepe_pe_bune() --- inceperea jocului dupa terminarea animatiei
	mc:gotoAndPlay(tag1-1)
	adaugaMasina()
	ingame = true
	NoJoyStick()
	deb_b_play = false
end

function retreatstuff() --animatie + eliberarea ecranului
	GTween.new(b_play,1,{x=1222},{ease = easing.outSine})
	GTween.new(b_info,1,{x=1222},{ease = easing.outSine})
	GTween.new(b_shop,1,{x=-500},{ease = easing.outSine})
	GTween.new(title,1,{y=-400},{ease = easing.outSine})
	GTween.new(realizatDe,1,{y=MY+400},{ease = easing.outSine})
end

function again() -- reintrarea butoanelor pe ecran
	GTween.new(b_play,1,{x=MX/2-b_play:getWidth()/2,y=MY/2-b_play:getHeight()/2},{ease = easing.inSine})
	GTween.new(b_info,1,{x=MX-70,y=MY-70},{ease = easing.inSine})
	GTween.new(b_shop,1,{x=5,y=MY-70},{ease = easing.inSine})
	GTween.new(title,1,{x=65,y=0},{ease = easing.outSine})
	GTween.new(realizatDe,1,{x=MX/2-realizatDe:getWidth()/2,y=MY-realizatDe:getHeight()-5},{ease = easing.outSine})
	GTween.new(joystick,1,{x=-400},{ease = easing.outSine})
end
-----------------------------------------adaugare/eliminare masina && donut
local car2  -- pentru stergerea obiectelor deoarece la un moment dat sunt mai multe obiecte pe ecran
function stergere_intarziata()
	if car2 ~= nil then
		stage:removeChild(car2)
		print("Totul e ok cu stergerea")
	end
end
local kk = 0 -- nu sterge prima masina :)
function adaugaMasina()
	if car1 ~= nil and kk==1 then
		car2 = car1
		Timer.delayedCall(600, function() stergere_intarziata() end) 
	end
	kk=1
local rand = math.random(1,2)  --generare masina cu textura diversificata
if rand == 1 then
	car1 = Car.new(frames1,factor) --textura cu animatia1
else
	car1 = Car.new(frames2,factor) --textura cu animatia2
end
stage:addChild(car1)
factor = factor + 2
end
--------------------------------------------------------------------------------------------
local function delayAnimatieMoarte() --???
	copanim:setPosition(-599,999)
end

local function onEnterFrame()
	if ingame==true then
	local speed = 2
	reSizeCop(135,180)
	local jj = mc:getY()/100 -- nu permite trecerea de 90 pe axa Y
	if jj < 0.9 then
		jj=0.9
	end
	reScaleCop(jj,jj)
	--misca backgroundul
	x=background:getX() -speed
	y=0
	background:setPosition(x,y)
	if x<=0-background:getWidth() then
		background:setPosition(MX,0)
	end
	x=c_background:getX() - speed
	c_background:setPosition(x,y)
	if x<=0-c_background:getWidth() then
		c_background:setPosition(MX,0)
	end
	-----------------------
	local aditie = 0  ---viteza politistului pe axa Y // $
	if force>100 then
		aditie = -2
	elseif force > 50 then
		aditie = -1
	elseif force > 0 and force <=50 then
		aditie = -0.5
	elseif force < -70 then
		aditie = 2
	elseif force < -40 then
		aditie = 1
	elseif force < 0 then
		aditie = 0.5
	end
	
	if mc:getY() >= MY/4 and mc:getY() <= MY/2 then --- misca politistul in zonele permise cu viteza "aditie"
		mc:setPosition(70,mc:getY()+(aditie))
	end
	if mc:getY() < MY/4 and aditie>0 then
		mc:setPosition(70,mc:getY()+aditie)
	end
	if mc:getY() > MY/2 and aditie<0 then
		mc:setPosition(70,mc:getY()+aditie)
	end
	--///////////  afla pe ce banda se afla politistul (mcy)
	local mcy = mc:getY()
	if  mcy<=MY/4  then
		mcy=1
	elseif mcy > MY/4 and mcy<=MY/3 + 8 then
		mcy=2
	elseif mcy > MY/3 + 8 then
		mcy=3
	end
	local ccy = car1:getY()  --banda pe care se afla masina (ccy)
	if ccy ==80 then
		ccy = 1
	elseif ccy ==160 then
		ccy=3 
	elseif ccy > MY/3 -1 and ccy<MY/3 +1 then
		ccy=2
	end
	--daca banda coincide si se lovesc => coliziune
	local car_y = car1:getY()
	if car_y == 80 then
		car_y=1
	elseif car_y == 107 then
		car_y=2
	elseif car_y == 160 then
		car_y=3
	end
	donut:setPosition(donut:getX() - 3, donut:getY())
	print(donut:getX(),donut:getY())
	if donut:getX() < -25 then
		donut:setPosition(MX+500,math.random(75)+150)
	end
	--jucatorul atinge gogoasa
	if mc:collision(donut) == true and donut:getY()>mc:getY()+mc:getHeight()/4 and donut:getY()<mc:getY()+mc:getHeight() then
		donut:setPosition(donut:getX() + 2000, math.random(75)+150)
		bani = bani + 1
		textfield2:setText(bani)
		ding= ding2:play(0,false,false)
		ding:setVolume(.2)
		donutText:setPosition(textfield2:getWidth() + 25, 5)
	end
	textfield2:setText(bani)
	if mc:collision(car1) == true and mcy==car_y then
		print("KABOOOM")
		if scor > best then
			best = scor
			text_best:setText("Best: " .. best)
		end
		scor = 0
		factor = 0
		textfield1:setText("Score: " .. scor)
		bang:play()
		donut:setPosition(MX+500,donut:getY())
		shakeScreen()
		explozie:setPosition(mc:getX(),mc:getY())
		ingame = false
		bum:setPosition(car1:getX(),car1:getY())
		bum:setSize(car1:getWidth(),car1:getHeight())
		bum:gotoAndPlay(1)
		explozie:gotoAndPlay(1)
		copanim:setPosition(mc:getX()+200-copanim:getWidth(),mc:getY())
		copanim:setSize(mc:getWidth()*4,mc:getHeight())
		copanim:gotoAndPlay(1)
		mc:setPosition(-500,mc:getY())
		car1:setPosition(car1:getX(),-2000)
		canal_song:setVolume(0.1)
		donutcar:setPosition(-MX,donutcar:getY())
		
		donutcar:setIndex(6)
		copanim:setIndex(5)
		GTween.new(donutcar,2,{x=-185},{ease = easing.outSine})
		Timer.delayedCall(2200, function() delayAnimatieMoarte() end) 
		saveHighscore()
		again()
		else
			explozie:setPosition(-1000,-1000)
			
		end
		
		y=car1:getY()
		if y>mc:getY() then
			car1:setIndex(7)
			mc:setIndex(6)
			donut:setIndex(5)
		else
			car1:setIndex(6)
			mc:setIndex(7)
			donut:setIndex(5)
		end
		
		local x,y = car1:getPosition()
	if x < -150 then 
		print("Merge?")
		scor = scor+1
		textfield1:setText("Score: " .. scor)
		adaugaMasina()
	end
		
	end
end
explozie:addEventListener(Event.COMPLETE, function()
	explozie:setPosition(-1000,-1000)
end)
copanim:addEventListener(Event.COMPLETE, function()
	--copanim:setPosition(-1000,-1000)
end)
bum:addEventListener(Event.COMPLETE, function()
	bum:setPosition(-1000,-1000)
end)

------------------------- [[[[[[[[[   SETARE EVENIMENTE   ]]]]]]] ------------------

stage:addEventListener(Event.ENTER_FRAME, onEnterFrame) -- a se executa functia onEnterFrame la fiecare frame parcurs
joystick:addEventListener(Event.MOUSE_UP, NoJoyStick) -- a se executa functia noJoyStick cand se ridica degetul de pe ecran 
b_play:addEventListener(Event.MOUSE_DOWN,play_g,b_play) -- a se executa functia play_g cand degetul e pus pe ecran
b_info:addEventListener(Event.MOUSE_DOWN,info_g,b_info)
b_shop:addEventListener(Event.MOUSE_DOWN,shop_g,b_shop)
joystick:addEventListener(Event.MOUSE_DOWN,JoyStickAllow,joystick) -- a se executa functia noJoyStick cand se pune degetul pe joystick 
joystick:addEventListener(Event.MOUSE_MOVE,JoyStickMove) -- a se executa cand joystick-ul e miscat
----eventuri cumparare--------
b_back:addEventListener(Event.MOUSE_DOWN,back_g,b_back)
b_buy:addEventListener(Event.MOUSE_DOWN,buy_g,b_buy)
b_wear:addEventListener(Event.MOUSE_DOWN,wear_g,b_wear)
grup_shop[1]:addEventListener(Event.MOUSE_DOWN,gr_b,grup_shop[1])
grup_shop[2]:addEventListener(Event.MOUSE_DOWN,gr_b,grup_shop[2])
grup_shop[3]:addEventListener(Event.MOUSE_DOWN,gr_b,grup_shop[3])
grup_shop[4]:addEventListener(Event.MOUSE_DOWN,gr_b,grup_shop[4])
