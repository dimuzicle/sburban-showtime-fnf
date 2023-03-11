function onCreate()
	makeLuaSprite('daveRoof', 'stages/MSStages/daveRoof', -1000, -300)
	addLuaSprite('daveRoof', false)
	scaleObject('daveRoof', 2.8, 2.8);
	setProperty('daveRoof.antialiasing', false);
end