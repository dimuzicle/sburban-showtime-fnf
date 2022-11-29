function onCreate()
	-- the below code makes a tint, un-comment to use it :33
	--makeLuaSprite('tint','tint',0, 0)
    	--addLuaSprite('tint',true)
   	--scaleObject('tint', 6, 6);
    	--setObjectCamera('tint', 'hud');
    	--setProperty('tint.antialiasing', false);
    	--doTweenAlpha('tint', 50)	

	-- background shit
	makeLuaSprite('sky', 'stages/jade/jadeSky', -450, -150);
	setScrollFactor('sky', 0.9, 0.9);
	scaleObject('sky', 1, 1);

	makeLuaSprite('cloud', 'stages/jade/jadeClouds', -200, -100);
	setScrollFactor('cloud', 0.9, 0.9);
	scaleObject('cloud', .6, .6);

	makeLuaSprite('wall', 'stages/jade/jadeWall', -350, -150);
	setScrollFactor('wall', 0.9, 0.9);
	scaleObject('wall', .9, .9);

	makeLuaSprite('pots', 'stages/jade/pots', -400, -175);
	setScrollFactor('pots', 0.9, 0.9);
	scaleObject('pots', .9, .9);

	addLuaSprite('sky', false);
	addLuaSprite('cloud', false);
	addLuaSprite('wall', false);
	addLuaSprite('pots', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end