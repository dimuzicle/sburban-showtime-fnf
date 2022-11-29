function onCreate()
	makeLuaSprite('tint','stages/rose/tint',0, 0)
    	addLuaSprite('tint',true)
   	scaleObject('tint', 6, 6);
    	setObjectCamera('tint', 'hud');
    	setProperty('tint.antialiasing', false);
    	doTweenAlpha('tint', 50)	

	-- background shit
	makeLuaSprite('wall', 'stages/rose/roseWall', -450, -150);
	setScrollFactor('wall', 0.9, 0.9);
	scaleObject('wall', .8, .8);

	makeLuaSprite('floor', 'stages/rose/roseFloor', -450, 50);
	setScrollFactor('floor', 0.9, 0.9);
	scaleObject('floor', .6, .6);

	makeLuaSprite('bed', 'stages/rose/roseBed', -350, 0);
	setScrollFactor('bed', 0.9, 0.9);
	scaleObject('bed', .7, .7);

	makeLuaSprite('fenestratedWall', 'stages/rose/fenestratedWall', -100, -100);
	setScrollFactor('fenestratedWall', 0.9, 0.9);
	scaleObject('fenestratedWall', .7, .7);

	addLuaSprite('wall', false);
	addLuaSprite('floor', false);
	addLuaSprite('fenestratedWall', false);
	addLuaSprite('bed', false);
	addLuaSprite('tint', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end