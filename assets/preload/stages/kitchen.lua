function onCreate()
	makeLuaSprite('kitchen', 'stages/kitchen', -1000, -500)
	addLuaSprite('kitchen', false)
	scaleObject('kitchen', 2, 2);
	setProperty('kitchen.antialiasing', false);
end