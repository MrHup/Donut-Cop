Sky = Core.class(Sprite) -- create your own player class
 
function Sky:init()
-- do the initialization of Player instance

self.speedx = math.random(-500, 500) / 1000
end
 
function Sky:onEnterFrame()
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
	
	-- get the current position
	local x,y = self:getPosition()
		
	-- change the position according to the speed
	x = x - self.speedx

	-- if the bird is out of the screen, set new speed and position
	if x < -100 then 
		self.speedx = math.random(2000, 4000) / 1000
		x = 540
		y = 0
	end

	-- set the new position
	self:setPosition(x, y)
end
 

 
