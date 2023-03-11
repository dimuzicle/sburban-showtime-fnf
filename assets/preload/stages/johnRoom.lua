function onCreate()
	-- background shit
	makeLuaSprite('wall', 'stages/john/johnWall', -1300, -100);
	setScrollFactor('wall', .9, .9);
	scaleObject('wall', 2, 2);

	makeLuaSprite('floor', 'stages/john/johnFloor', -750, -10);
	setScrollFactor('floor', 0.9, .9);
	scaleObject('floor', .8, .9);

	makeLuaSprite('bed', 'stages/john/johnBed', -1250, 90);
	setScrollFactor('bed', 0.9, 0.9);
	scaleObject('bed', 1.2, .8);

	makeLuaSprite('desk', 'stages/john/johnCake', -800, 160);
	setScrollFactor('desk', 0.9, 0.9);
	scaleObject('desk', .7, .7);

	addLuaSprite('wall', false);
	addLuaSprite('floor', false);
	addLuaSprite('desk', false);
	addLuaSprite('bed', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end