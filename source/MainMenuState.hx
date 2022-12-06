package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;
import Achievements;
import editors.MasterEditorMenu;
import flixel.input.keyboard.FlxKey;
import openfl.ui.Mouse;
import openfl.ui.MouseCursor;

using StringTools;

class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '0.6.3'; //This is also used for Discord RPC
	public static var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;

	var cake:FlxSprite;
	var abjureMenu:FlxSprite;
	var paper:FlxSprite;
	var square:FlxSprite;
	var sburb:FlxSprite;
	
	var optionShit:Array<String> = [
		'story_mode',
		'freeplay',
		'options',
		'credits'
	];

	var debugKeys:Array<FlxKey>;

	override function create()
	{
		#if MODS_ALLOWED
		Paths.pushGlobalMods();
		#end
		WeekData.loadTheFirstEnabledMod();

		FlxG.mouse.visible = true;
		FlxG.mouse.useSystemCursor = true;

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end
		debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

		var yScroll:Float = Math.max(0.25 - (0.05 * (optionShit.length - 4)), 0.1);
		var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('menu/back', "sburb"));
		bg.scrollFactor.set(0, yScroll);
		//bg.setGraphicSize(Std.int(bg.width * 1.175));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

		
		// :33 < h33h33 secret cake
		
		cake = new FlxSprite(0).loadGraphic(Paths.image('menu/cake', "sburb"));
		cake.updateHitbox();
		cake.x = 305;
		cake.y = 145;
		cake.antialiasing = ClientPrefs.globalAntialiasing;
		add(cake);

		// :33 < This loads in the abjure!!! paper! :))

		abjureMenu = new FlxSprite(0).loadGraphic(Paths.image('menu/abjureMenu', "sburb"));
		abjureMenu.updateHitbox();
		abjureMenu.x = 315;
		abjureMenu.y = 125;
		abjureMenu.scale.set(.7, .7);
		abjureMenu.antialiasing = ClientPrefs.globalAntialiasing;
		abjureMenu.alpha = 0;
		add(abjureMenu);

		paper = new FlxSprite().loadGraphic(Paths.image('menu/thing', "sburb"));
		paper.scale.set(1, .5);
		paper.updateHitbox();
		paper.x = 415;
		paper.y = 247;
		paper.alpha = 0;
		add(paper);

		sburb = new FlxSprite().loadGraphic(Paths.image('menu/sburb', "sburb"));
		sburb.updateHitbox();
		sburb.screenCenter();
		sburb.y -= 234;
		sburb.x += 40;
		sburb.alpha = 1;
		add(sburb);

		square = new FlxSprite().loadGraphic(Paths.image('menu/thing', "sburb"));
		square.scale.set(.27, .27);
		square.updateHitbox();
		square.screenCenter();
		square.y -= 234;
		square.x += 40;
		square.alpha = 0;
		add(square);
		
		// magenta.scrollFactor.set();

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var scale:Float = 1;
		/*if(optionShit.length > 6) {
			scale = 6 / optionShit.length;
		}*/

		for (i in 0...optionShit.length)
		{
			var menuItem:FlxSprite = new FlxSprite(0, 515 + (i * 43));
			menuItem.loadGraphic(Paths.image('menu/' + optionShit[i].toLowerCase(), "sburb"));
			menuItem.ID = i;
			menuItem.screenCenter(X);
			menuItem.x -= 190;
			menuItems.add(menuItem);
			menuItem.scrollFactor.set();
			menuItem.antialiasing = true;
			menuItem.updateHitbox();

			/*
				FlxTween.tween(menuItem, {alpha: 1, x: ((FlxG.width / 2) - (menuItem.width / 2))}, 0.35, {
					ease: FlxEase.smootherStepInOut,
					onComplete: function(tween:FlxTween)
					{
						canSnap[i] = 0;
					}
			});*/
		}

		/*
		var versionShit:FlxText = new FlxText(12, FlxG.height - 44, 0, "Psych Engine v" + psychEngineVersion, 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);
		var versionShit:FlxText = new FlxText(12, FlxG.height - 24, 0, "Friday Night Funkin' v" + Application.current.meta.get('version'), 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);
		*/
		
		// :33 < hi teles!! so we can reuse the above code for our own style of version stuff, but I commented it out so it doesn't show up on the menu.

		// NG.core.calls.event.logEvent('swag').send();

		changeItem();


		super.create();
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
			if(FreeplayState.vocals != null) FreeplayState.vocals.volume += 0.5 * elapsed;
		}

		var lerpVal:Float = CoolUtil.boundTo(elapsed * 7.5, 0, 1);

		if (!selectedSomethin)
		{
			if (controls.BACK)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new TitleState());
			}



			menuItems.forEach(function(spr:FlxSprite)
			{
				if(FlxG.mouse.overlaps(spr)){
					if(FlxG.mouse.justPressed){
						selectedSomethin = true;
						FlxG.sound.play(Paths.sound("confirmMenu"), 1.5);
						//FlxG.camera.fade(FlxColor.WHITE,1);
						FlxFlicker.flicker(spr, .5, 0.06, false, false, function(flick:FlxFlicker)
							{
								var daChoice:String = optionShit[spr.ID];

								switch (daChoice)
								{
									case 'story_mode':
										MusicBeatState.switchState(new StoryMenuState());
									case 'freeplay':
										MusicBeatState.switchState(new FreeplaySelectorTheSecond());
									case 'credits':
										MusicBeatState.switchState(new CreditsState());
									case 'options':
										LoadingState.loadAndSwitchState(new options.OptionsState());
								}
							});
					}
				}
			});

			// :00 < ABJURE!!!!
			
			if(FlxG.mouse.overlaps(cake)){
				if(FlxG.mouse.justPressed){
					if(ClientPrefs.cakeSecret == false){
						abjureMenu.alpha = 1;
						FlxFlicker.flicker(abjureMenu, 1, 0.05, true, false);
						ClientPrefs.cakeSecret = true;
						selectedSomethin = true;
						FlxG.sound.play(Paths.sound("cakeSplat"), 0.7);
						FlxFlicker.flicker(cake, 1, 0.05, false, false, function(flick:FlxFlicker)
						{
							var poop:String = Highscore.formatSong('abjure', 1);
							trace(poop);
	
							PlayState.SONG = Song.loadFromJson(poop, 'abjure');
							PlayState.isStoryMode = false;
							PlayState.storyDifficulty = 1;
	
							LoadingState.loadAndSwitchState(new PlayState());
						});
					}
					else{
						FlxG.sound.play(Paths.sound("cakeSplat"), 0.7);
					}
				}
			}

			/*
			if (controls.ACCEPT)
			{
				if (optionShit[curSelected] == 'donate')
				{
					CoolUtil.browserLoad('https://ninja-muffin24.itch.io/funkin');
				}
				else
				{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
							FlxTween.tween(spr, {alpha: 0}, 0.4, {
								ease: FlxEase.quadOut,
								onComplete: function(twn:FlxTween)
								{
									spr.kill();
								}
							});
						}
						else
						{
							FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
							{
								var daChoice:String = optionShit[curSelected];

								switch (daChoice)
								{
									case 'story_mode':
										MusicBeatState.switchState(new StoryMenuState());
									case 'freeplay':
										MusicBeatState.switchState(new FreeplayState());
									#if MODS_ALLOWED
									case 'mods':
										MusicBeatState.switchState(new ModsMenuState());
									#end
									case 'awards':
										MusicBeatState.switchState(new AchievementsMenuState());
									case 'credits':
										MusicBeatState.switchState(new CreditsState());
									case 'options':
										LoadingState.loadAndSwitchState(new options.OptionsState());
								}
							});
						}
					});
				}
			}
			*/
		}

		if(FlxG.mouse.overlaps(paper)){
			if(FlxG.mouse.justPressed){
				if(ClientPrefs.secret1 && ClientPrefs.secret2 == true){
					FlxG.sound.play(Paths.sound("horn"), 3.0);
					ClientPrefs.secret3 = true;
				}
			}
		}

		if(FlxG.mouse.overlaps(square)){
			if(FlxG.mouse.justPressed){
				if(ClientPrefs.secret1 == true && ClientPrefs.secret2 == true && ClientPrefs.secret3 == true){
					FlxG.sound.play(Paths.sound("confirmMenu2"), .7);
					FlxFlicker.flicker(sburb, 1, 0.06, false, false, function(flick:FlxFlicker){
						MusicBeatState.switchState(new FreeplayState());
					});
				}

			}
		}
		super.update(elapsed);

		/*
		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.screenCenter(X);
		});
		*/
	}

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;
	}
}
