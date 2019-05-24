function Sprite:setSize(newWidth, newHeight) -- functie de redimensionare pe o dimensiune exacta in pixeli
  self:setScale(1, 1) 
  local originalWidth = self:getWidth()
  local originalHeight = self:getHeight()
  self:setScale(newWidth / originalWidth, newHeight / originalHeight)
end

function shakeScreen()
    stage:setPosition(-10, -10)
   GTween.new(stage, 0.25, {x = 0,y = 0}, {delay = 0, ease = easing.outBounce })
end
 
function Sprite:setIndex(index) -- pentru a pune un obiect in fata altuia
	local parent=self:getParent()
	if index<parent:getChildIndex(self) then
		index=index-1
	end
	parent:addChildAt(self, index)
end

function Sprite:collision(sprite2) --functie de detectare a coliziunii
 	local myX = self:getX()
 	local myY = self:getY()
 	local myWidth = self:getWidth()
 	local myHeight = self:getHeight()
 	local otherX = sprite2:getX()
 	local otherY = sprite2:getY()
 	local otherWidth = sprite2:getWidth()
 	local otherHeight = sprite2:getHeight()
	-- cea mai joasa parte a primei imagini mai sus de cat cea mai inalta parte a celeilate
	if myY + myHeight < otherY or myY > otherY + otherHeight then
		return false
	end
	-- partea stanga a primei img > partea dreapta a celei de-a doua imagini si viceversa
	if myX > otherX + otherWidth or myX  + myWidth < otherX then
		return false
	end
 
	return true
end

function reSizeCop(dimX,dimY)
	copp1:setSize(dimX,dimY)
	copp2:setSize(dimX,dimY)
	copp3:setSize(dimX,dimY)
	copp4:setSize(dimX,dimY)
	copp5:setSize(dimX,dimY)
	copp6:setSize(dimX,dimY)
	copp7:setSize(dimX,dimY)
	copp8:setSize(dimX,dimY)
end

function reScaleCop(dimX,dimY)
	copp1:setScale(dimX,dimY)
	copp2:setScale(dimX,dimY)
	copp3:setScale(dimX,dimY)
	copp4:setScale(dimX,dimY)
	copp5:setScale(dimX,dimY)
	copp6:setScale(dimX,dimY)
	copp7:setScale(dimX,dimY)
	copp8:setScale(dimX,dimY)
end