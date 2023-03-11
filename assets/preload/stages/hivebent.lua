function onCreate()
	-- background shit
	makeLuaSprite('wall', 'stages/karkat/karkatWall', -450, -150);
	setScrollFactor('wall', 0.9, 0.9);
	scaleObject('wall', .8, .8);

	makeLuaSprite('floor', 'stages/karkat/karkatFloor', -500, -350);
	setScrollFactor('floor', 0.9, 0.9);
	scaleObject('floor', 1, 1);

	makeLuaSprite('bed', 'stages/karkat/karkatBed', -350, -70);
	setScrollFactor('bed', 0.9, 0.9);
	scaleObject('bed', .7, .7);

	makeLuaSprite('door', 'stages/karkat/karkatDoor', -400, -50);
	setScrollFactor('door', 0.9, 0.9);
	scaleObject('door', .6, .7);

	makeLuaSprite('desk', 'stages/karkat/karkatDesk', -425, -95);
	setScrollFactor('desk', 0.9, 0.9);
	scaleObject('desk', .7, .7);

	addLuaSprite('wall', false);
	addLuaSprite('door', false);
	addLuaSprite('floor', false);
	addLuaSprite('bed', false);
	addLuaSprite('desk', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end