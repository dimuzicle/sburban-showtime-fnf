function onCreate()
	-- background shit
	makeLuaSprite('wall', 'stages/lowas/lowasWall', -550, -150);
	setScrollFactor('wall', 0.9, 0.9);
	scaleObject('wall', .7, .5);

	makeLuaSprite('floor', 'stages/lowas/lowasFloor', -600, -125);
	setScrollFactor('floor', 0.9, 0.9);
	scaleObject('floor', .7, .5);

	makeLuaSprite('houses', 'stages/lowas/lowasHouses', -550, -125);
	setScrollFactor('houses', 0.9, 0.9);
	scaleObject('houses', .5, .5);

	makeLuaSprite('pillar', 'stages/lowas/lowasPillar', -560, -100);
	setScrollFactor('pillar', 0.9, 0.9);
	scaleObject('pillar', .5, .5);

	makeLuaSprite('rocks', 'stages/lowas/lowasRock', -225, -95);
	setScrollFactor('rocks', 0.9, 0.9);
	scaleObject('rocks', .5, .5);

	addLuaSprite('wall', false);
	addLuaSprite('floor', false);
	addLuaSprite('pillar', false);
	addLuaSprite('houses', false);
	addLuaSprite('rocks', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end