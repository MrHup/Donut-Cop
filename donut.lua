

Donut = Core.class(Sprite)
MY = application:getContentHeight()

function Sprite:setSize(newWidth, newHeight)
  self:setScale(1, 1)  -- to get original width and height without scaling
  local originalWidth = self:getWidth()
  local originalHeight = self:getHeight()
  self:setScale(newWidth / originalWidth, newHeight / originalHeight)
  parent:addChildAt(self, 25)
end

function Donut:init()
	self:addChild(Bitmap.new(Texture.new("Art/donut.png")))
	local rd = math.random(1,3)
		if rd == 1 then
			y=MY/4  -- banda 1
		elseif rd == 2 then
			y=MY/3 -- banda 2
		else
			y=MY/2 -- banda 3
		end
	y=y+25
	self:setPosition(540, y)
	
	self.speedy = 0
	self.speedx = 2.5
	
	---self.speedx = math.random(3000, 5000) / 1000
	
	self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)	
end

function Donut:onEnterFrame()
	local x,y = self:getPosition()
	x = x - self.speedx
	self:setPosition(x, y)
	self:setSize(310,155)
	local jj = self:getY()/100
	if jj < 0.7 then
		jj=0.3
	end
	if jj > 1.7 then
		jj=1
	end
	self:setScale(jj,jj)
	--self:setScale(jj,jj)
	
end
