local pack = TexturePack.new("Textures/copText.txt", "Textures/copText.png")
copp1 = Bitmap.new(pack:getTextureRegion("cop_0.png"))
copp1:setScale(1.4,1.4)
copp2 = Bitmap.new(pack:getTextureRegion("cop_1.png"))
copp2:setScale(1.4,1.4)
pack = TexturePack.new("Textures/CopFarma.txt", "Textures/CopFarma.png")
copp3 = Bitmap.new(pack:getTextureRegion("sprite_0.png"))
copp3:setSize(copp1:getWidth(),copp1:getHeight())
copp3:setPosition(copp1:getPosition())
copp4 = Bitmap.new(pack:getTextureRegion("sprite_1.png"))
copp4:setSize(copp1:getWidth(),copp1:getHeight())
copp4:setPosition(copp1:getPosition())
pack = TexturePack.new("Textures/CopWorker.txt", "Textures/CopWorker.png")
copp5 = Bitmap.new(pack:getTextureRegion("sprite_0.png"))
copp5:setSize(copp1:getWidth(),copp1:getHeight())
copp5:setPosition(copp1:getPosition())
copp6 = Bitmap.new(pack:getTextureRegion("sprite_1.png"))
copp6:setSize(copp1:getWidth(),copp1:getHeight())
copp6:setPosition(copp1:getPosition())
pack = TexturePack.new("Textures/CopSanta.txt", "Textures/CopSanta.png")
copp7 = Bitmap.new(pack:getTextureRegion("sprite_0.png"))
copp7:setSize(copp1:getWidth(),copp1:getHeight())
copp7:setPosition(copp1:getPosition())
copp8 = Bitmap.new(pack:getTextureRegion("sprite_1.png"))
copp8:setSize(copp1:getWidth(),copp1:getHeight())
copp8:setPosition(copp1:getPosition())

mc_creat = MovieClip.new{
	{1, 10, copp1},	
	{11, 20, copp2},
	{21, 30, copp3},
	{31, 40, copp4},
	{41, 50, copp5},
	{51, 60, copp6},
	{61, 70, copp7},
	{71, 80, copp8}
}
