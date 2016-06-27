ListView = Core.class(Sprite)

function ListView:init(width, height, posX, posY, ...)
	sprite = Sprite.new()
	self.width = width
	self.height = height
	self.texts = ...
	self.MAX_PATH_LENGTH = 20
	self.posY = posY
	self.posX = posX
	self:setPosition(posX, posY)
	print("Start SELF TOP Y "..self.posY)
	--self.background = Bitmap.new(Texture.new("images/The plashka.png"))
	self.DISTANCE_FROM_TEXT = 40
	self.nRemovedTopSprites = 0
	self.passedPath = 0
	local iter = 1
	self.spritesHeight = 0
	
	for key, value in ipairs(self.texts) do
		if self.spritesHeight >= self.height then
			break
		end
		local textfield = TextField.new(nil, value:getText())
		sprite:addChild(self:_makeSprite(key, value, iter))
		if key == 1 then
			self.topSpriteHeight = sprite:getChildAt(key):getHeight()
			textfield:setPosition(sprite:getChildAt(key):getX() + 10, sprite:getChildAt(key):getY()+10)
			self.spritesHeight = self.spritesHeight + sprite:getChildAt(key):getHeight()
		else 
			textfield:setPosition(sprite:getChildAt(iter):getX() + 10, sprite:getChildAt(iter):getY()+10)
			self.spritesHeight = self.spritesHeight + sprite:getChildAt(iter):getHeight()
		end
		sprite:addChild(textfield)
		self:addChild(sprite,1)
		iter = iter + 2
	end
	
	self:addEventListener(Event.MOUSE_DOWN, self.onMouseDown, self)
	self:addEventListener(Event.MOUSE_MOVE, self.onMouseMove, self)
	self:addEventListener(Event.MOUSE_UP, self.onMouseUp, self)
end

--SPRITES CREATION
function ListView:_makeSprite(key, value, iter)
	local elementSprite = Bitmap.new(Texture.new("images/The plashka.png"))
	elementSprite:setScale(self.width/elementSprite:getWidth(), 
		(value:getHeight() 
		+ self.DISTANCE_FROM_TEXT)/elementSprite:getHeight())
	if key == 1 then 
		elementSprite:setPosition(self:getX() - self.posX, self:getY() - self.posY)
	else 
		elementSprite:setPosition(sprite:getChildAt(iter - 2):getX(), sprite:getChildAt(iter - 2):getY() + sprite:getChildAt(iter - 2):getHeight())
	end
	
	return elementSprite
	
end


--COSMETICS
function ListView:_setSpriteSize(newWidth, newHeight)
	self:setScale(1,1)
	self:setScale(newWidth/self:getWidth(), newHeight/self:getHeight())
end

function ListView:_checkTextLength()
end


--EVENTS
function ListView:onMouseDown(event)
--print("DOWN")
	if self:hitTestPoint(event.x, event.y) then
		event:stopPropagation()
		self.startY = event.y
		self.topY = self:getY()
	end
end

function ListView:onMouseUp(event)
--print("UP")
	if self:hitTestPoint(event.x, event.y) then
	self.passedPath = 0
		event:stopPropagation()
	end
end

function ListView:onMouseMove(event)
	if self:hitTestPoint(event.x, event.y) then
		event:stopPropagation()
		self.endY = event.y
		local pathY = self.endY - self.startY
		local newY = self:getY() - pathY
		
		if math.abs(pathY) > self.MAX_PATH_LENGTH then
			pathY = (pathY > 0 and self.MAX_PATH_LENGTH or -self.MAX_PATH_LENGTH)
		end
		
		if math.abs(self.startY - event.y) > 10 then
			if pathY < 0  then
				if self.passedPath - pathY < self.passedPath then 
					--self.passedPath = 0
				end 
				
				if self.spritesHeight - pathY >= self.height and 
				self.nRemovedTopSprites + sprite:getNumChildren()/2  == table.getn(self.texts) then
					self:setPosition(self:getX(), -self.spritesHeight + pathY)
					--self.passedPath = 0
					do return end
				else 
					self:_makeNewList(pathY)
					self:setPosition(self:getX(), self:getY() + pathY)
				end
			elseif pathY > 0 then
				if self.passedPath + pathY < self.passedPath then 
					--self.passedPath = 0
				end
				if self.spritesHeight + pathY >= self.height and 
				self.nRemovedTopSprites == 0 then
					--print("SELF TOP Y "..self.posY)
					self:setPosition(self:getX(), self.posY )
					--self.passedPath = 0
					do return end
				else 
					self:_makeNewList(pathY)
					self:setPosition(self:getX(), self:getY() + pathY)
				end
			end
		end
	end
end

function ListView:_makeNewList(pathY)
	if pathY < 0 then 
		self.passedPath = self.passedPath - pathY 
		--print("SP UP"..self.passedPath)
		if self.passedPath > self.topSpriteHeight then
			--[[if self.spritesHeight - self.topSpriteHeight*2 < self.height 
			and self.nRemovedTopSprites + sprite:getNumChildren()/2 == table.getn(self.texts) then 
				do return end 
			end ]]--
			self.passedPath = self.passedPath - self.topSpriteHeight
			self.spritesHeight = self.spritesHeight - self.topSpriteHeight
			sprite:removeChildAt(1)
			sprite:removeChildAt(1)
			self.nRemovedTopSprites = self.nRemovedTopSprites + 1
			self.topSpriteHeight = sprite:getChildAt(1):getHeight()
			--print(self.nRemovedTopSprites)
		end
		if self.spritesHeight <= self.height then 
			local heightDiff = self.height - self.spritesHeight
			local textKey = self.nRemovedTopSprites + sprite:getNumChildren()/2 + 1
			local key = sprite:getNumChildren() + 1
			local iter = key 
			while(heightDiff > 0) do
				if textKey > table.getn(self.texts) then 
					break 
				end
				
				local textfield = TextField.new(nil, self.texts[textKey]:getText())
				sprite:addChild(self:_makeSprite(key, textfield, iter))
				--print(self.texts[textKey]:getText()) 
				
				textfield:setPosition(sprite:getChildAt(key):getX() + 10, sprite:getChildAt(key):getY()+10)
				self.spritesHeight = self.spritesHeight + sprite:getChildAt(key):getHeight()
				sprite:addChild(textfield)
				iter = iter + 2
				textKey = textKey + 1
				heightDiff = heightDiff - sprite:getChildAt(key):getHeight()
				key = key + 1
				
			end
		end
	else
		self.passedPath = self.passedPath + pathY 
		local spriteBottomHeight = sprite:getChildAt(sprite:getNumChildren()-1):getHeight()
		if self.spritesHeight < self.height  then 
			local heightDiff = self.height - self.spritesHeight
			local textKey = self.nRemovedTopSprites 
			while(heightDiff > 0) do
				
				if textKey < 1 then 
					break 
				end
				
				local textfield = TextField.new(nil, self.texts[textKey]:getText())
				--sprite:addChild(self:_makeSprite(key, textfield, iter))
				local elementSprite = Bitmap.new(Texture.new("images/The plashka.png"))
				elementSprite:setScale(self.width/elementSprite:getWidth(), 
				(textfield:getHeight() 
				+ self.DISTANCE_FROM_TEXT)/elementSprite:getHeight())
				elementSprite:setPosition(sprite:getChildAt(1):getX(), sprite:getChildAt(1):getY() - elementSprite:getHeight())
				
				textfield:setPosition(elementSprite:getX() + 10, elementSprite:getY()+10)
				self.spritesHeight = self.spritesHeight + elementSprite:getHeight()
				
				sprite:addChildAt(textfield,1)
				sprite:addChildAt(elementSprite,1)
				textKey = textKey - 1
				self.nRemovedTopSprites = self.nRemovedTopSprites - 1
				heightDiff = heightDiff - elementSprite:getHeight()
				self.topSpriteHeight = elementSprite:getHeight()
			end
		end
		--print("SELF PASSED "..self.passedPath)
		if self.passedPath > spriteBottomHeight then
			self.passedPath = self.passedPath - spriteBottomHeight
			self.spritesHeight = self.spritesHeight - spriteBottomHeight
			sprite:removeChildAt(sprite:getNumChildren())
			sprite:removeChildAt(sprite:getNumChildren())

		end
		
	end
end
