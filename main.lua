local fonts = TTFont.new("fonts/OpenSans-Regular.ttf", 30)


local aboutText = TextWrap.new("asdasdasd", 150, "justify", 5, nil)


local elementSprite = Bitmap.new(Texture.new("images/The plashka.png"))
local textfield = TextField.new(nil, "some text")
local textfieldTop = TextField.new(nil, "TOP")
local textfieldBottom = TextField.new(nil, "BOTTOM")
local arr = {textfield, }

local textfield1 = TextField.new(nil, "1")
local textfield2 = TextField.new(nil, "2")
local textfield3 = TextField.new(nil, "3")
local textfield4 = TextField.new(nil, "4")
local textfield5 = TextField.new(nil, "5")
local textfield6 = TextField.new(nil, "6")
local textfield7 = TextField.new(nil, "7")
local textfield8 = TextField.new(nil, "8")
local textfield9 = TextField.new(nil, "9")
local textfield10 = TextField.new(nil, "10")
local textfield11 = TextField.new(nil, "11")
local textfield12 = TextField.new(nil, "12")
local textfield13 = TextField.new(nil, "13")
local textfield14 = TextField.new(nil, "14")

local sp = Sprite.new()
--elementSprite:addChild(textfield)
--sp:addChild(elementSprite)
elementSprite:setPosition(120, 45)
elementSprite:setScale(200/elementSprite:getWidth(), 200/elementSprite:getHeight())
textfield:setPosition(elementSprite:getX() +20,elementSprite:getY() + 20)

--sp:addChild(elementSprite)
--sp:addChild(textfield)
--sp:addChild(textfield)
local shapkaBmp = Bitmap.new(Texture.new("images/The shapka.png"))
local list = ListView.new(elementSprite:getWidth(), 300, 20, 20,{textfield1,textfield2,textfield3,textfield4,textfield5,textfield6,textfield7,textfield8,textfield9,
textfield10,textfield11,textfield12,textfield13,textfield14,})

stage:addChild(shapkaBmp)
stage:addChildAt(list,1)
