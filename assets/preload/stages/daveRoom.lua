function onCreate()
	--makeLuaSprite('tint','tint',0, 0)
    	--addLuaSprite('tint',true)
   	--scaleObject('tint', 6, 6);
    	--setObjectCamera('tint', 'hud');
    	--setProperty('tint.antialiasing', false);
    	--doTweenAlpha('tint', 50)	

	-- background shit

	makeLuaSprite('floor', 'stages/dave/dave floor', -500, -100);
	scaleObject('floor', .8, .8);

	makeLuaSprite('jack', 'stages/dave/dave jack', -550, 0);
	setScrollFactor('jack', 0.9, 0.9);
	scaleObject('jack', .7, .7);

	makeLuaSprite('sword', 'stages/dave/dave sword', -400, -100);
	setScrollFactor('sword', 0.9, 0.9);
	scaleObject('sword', .7, .7);

	makeLuaSprite('closet', 'stages/dave/dave closet', -500, -100);
	setScrollFactor('closet', 0.9, 0.9);
	scaleObject('closet', .8, .8);

	makeLuaSprite('shelf', 'stages/dave/dave shelf', -500, -150);
	setScrollFactor('shelf', 0.9, 0.9);
	scaleObject('shelf', .8, .8);

	makeLuaSprite('wall', 'stages/rose/roseWall', -600, -600);
	setScrollFactor('shelf', 0.9, 0.9);
	scaleObject('wall', 10, 10);

	addLuaSprite('wall', false);
	addLuaSprite('closet', false);
	addLuaSprite('floor', false);
	addLuaSprite('shelf', false);
	addLuaSprite('jack', false);
	addLuaSprite('sword', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end