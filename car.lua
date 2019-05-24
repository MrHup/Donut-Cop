

Car = Core.class(Sprite)
MY = application:getContentHeight()

function Sprite:setSize(newWidth, newHeight)
  self:setScale(1, 1)  -- to get original width and height without scaling
  local originalWidth = self:getWidth()
  local originalHeight = self:getHeight()
  self:setScale(newWidth / originalWidth, newHeight / originalHeight)
end

function Car:init(frameList, factor)
	self.frames = {}
	for i = 1, #frameList do
		self.frames[i] = Bitmap.new(Texture.new(frameList[i]))
	end
	
	self.nframes = #frameList
	
	self.frame = 1
	self:addChild(self.frames[1])
	
	
	self.subframe = 0

	local rd = math.random(1,3)
		if rd == 1 then
			y=MY/6
		elseif rd == 2 then
			y=MY/4.5
		else
			y=MY/3
		end
	self:setPosition(540, y)
	
	self.speedy = math.random(-500, 500) / 1000
	self.speedx = (math.random(5000, 8000)+factor*30) / 1000
	
	---self.speedx = math.random(3000, 5000) / 1000
	
	self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)	
end

function Car:onEnterFrame()
	self.subframe = self.subframe + 1
	
	-- for every 10 frames, we remove the old frame and add the new frame as a child
	if self.subframe > 10 then
		self:removeChild(self.frames[self.frame])

		self.frame = self.frame + 1
		if self.frame > self.nframes then
			self.frame = 1
		end
		
		self:addChild(self.frames[self.frame])
		
		self.subframe = 0
	end
	
	
	local x,y = self:getPosition()
		
	
	x = x - self.speedx
	--y = y + self.speedy

	--resetare viteza si pozitie
	if x < -400 then 
		if self.subframe > 10 then
		self:removeChild(self.frames[self.frame])
		end
	end

	-- set the new position
	self:setPosition(x, y)
	
	self:setSize(135,180)
	self:setSize(307,153.6)
	local jj = self:getY()/100
	if jj < 0.7 then
		jj=0.7
	end
	if jj > 1.7 then
		jj=1.7
	end
	self:setScale(jj,jj)
	self:setScale(jj,jj)
	
end
