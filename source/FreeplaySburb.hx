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

class FreeplaySburb extends MusicBeatState
{
	public static var curCategory:String = 'Vol1'; //This is also used for Discord RPC
	var curSelected:Int = -1;

	var menuItems:FlxTypedGroup<FlxSprite>;
	var covers:FlxTypedGroup<FlxSprite>;
	var cakeNote:FlxSprite;
	var candyCorn1:FlxSprite;
	var candyCorn2:FlxSprite;
	var candyCorn3:FlxSprite;
	var candyCorn4:FlxSprite;
	var mspaFace:FlxSprite;
	var homestuck:FlxSprite;
	var magnet:FlxSprite;
	var goBack:FlxSprite;
	var start:FlxSprite;
	var settings:FlxSprite;
	var credits:FlxSprite;
	var help:FlxSprite;
	
	var songs:Map<String, Array<Dynamic>> = [
		'Vol1' => [
			['Prankster', 'egbert'],
			['Gin-And-Needles', 'rose'],
			['Record-Scratch', 'dave'],            // - :33 < Alright so the way this works is you put in your song's name
			['Sunshatter', 'jade'],                // - :33 < then you put in the name of the cofurr art for your song.
		],                                         // - :33 < Then, if you would like to, you can make a whole new ~~Cat-egory~~!!
		'Misc' => [                                // - :33 < The code for other cat-egories will be added latepurr on by the 
			['Abjure', 'misc'],				       // - :33 < Haxe Master themselves, Teles :))
		],
		'Covers' => [
			['Showtime', 'covers'],
		],
	];

	var debugKeys:Array<FlxKey>;

	override function create()
	{
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

		var bg:FlxSprite = new FlxSprite(0).loadGraphic(Paths.image('freeplaySel/bg', "sburb"));
		//bg.setGraphicSize(Std.int(bg.width * 1.175));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

		// :33 < This loads in the dadbert note!!

		cakeNote = new FlxSprite().loadGraphic(Paths.image('freeplay/note', "sburb"));
		cakeNote.updateHitbox();
		cakeNote.screenCenter();
		cakeNote.x -= 300;
		cakeNote.y += 150;
		cakeNote.scale.set(.7, .7);
		cakeNote.antialiasing = ClientPrefs.globalAntialiasing;
		cakeNote.alpha = 0;
		add(cakeNote);
		
		// This adds in the base covers for each category of songs in freeplay
		var baseCover:FlxSprite = new FlxSprite(0).loadGraphic(Paths.image('freeplay/cover-' + curCategory.toLowerCase(), "sburb"));
		//bg.setGraphicSize(Std.int(bg.width * 1.175));
		baseCover.updateHitbox();
		baseCover.screenCenter();
		baseCover.antialiasing = ClientPrefs.globalAntialiasing;
		add(baseCover);

		// magenta.scrollFactor.set();

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		covers = new FlxTypedGroup<FlxSprite>();
		add(covers);

		var scale:Float = 1;
		/*if(optionShit.length > 6) {
			scale = 6 / optionShit.length;
		}*/

		for (i in 0...songs.get(curCategory).length)
		{
			//This loads in all of the buttons for the freeplay menu
			var menuItem:FlxSprite = new FlxSprite(-200, 300 + (i * 43));
			menuItem.loadGraphic(Paths.image('freeplay/' + songs.get(curCategory)[i][0].toLowerCase(), "sburb"));
			menuItem.ID = i;
			menuItem.screenCenter(X);
			menuItem.x -= 290;
			menuItems.add(menuItem);
			menuItem.scrollFactor.set();
			menuItem.antialiasing = true;
			menuItem.updateHitbox();

			//This loads in all of the cover art for the freeplay menu, save for the base category images
			var coverArt:FlxSprite = new FlxSprite(0).loadGraphic(Paths.image('freeplay/cover-' + songs.get(curCategory)[i][1].toLowerCase(), "sburb"));
			//bg.setGraphicSize(Std.int(bg.width * 1.175));
			coverArt.alpha = 0;
			coverArt.updateHitbox();
			coverArt.screenCenter();
			coverArt.antialiasing = ClientPrefs.globalAntialiasing;
			coverArt.ID = i;
			covers.add(coverArt);
		}


		//Everything here is the clickables in the bars

		candyCorn1 = new FlxSprite().loadGraphic(Paths.image('menu/thing', "sburb"));
        candyCorn1.scale.set(.25, .3);
        candyCorn1.updateHitbox();
		candyCorn1.screenCenter();
		candyCorn1.y -= 323;
		candyCorn1.x += 47;
		candyCorn1.alpha = 0;
		add(candyCorn1);

		candyCorn2 = new FlxSprite().loadGraphic(Paths.image('menu/thing', "sburb"));
        candyCorn2.scale.set(.25, .3);
        candyCorn2.updateHitbox();
		candyCorn2.screenCenter();
		candyCorn2.y -= 323;
		candyCorn2.x += 168;
		candyCorn2.alpha = 0;
		add(candyCorn2);

		candyCorn3 = new FlxSprite().loadGraphic(Paths.image('menu/thing', "sburb"));
        candyCorn3.scale.set(.25, .3);
        candyCorn3.updateHitbox();
		candyCorn3.screenCenter();
		candyCorn3.y -= 323;
		candyCorn3.x -= 112;
		candyCorn3.alpha = 0;
		add(candyCorn3);

		candyCorn4 = new FlxSprite().loadGraphic(Paths.image('menu/thing', "sburb"));
        candyCorn4.scale.set(.25, .3);
        candyCorn4.updateHitbox();
		candyCorn4.screenCenter();
		candyCorn4.y -= 323;
		candyCorn4.x -= 180;
		candyCorn4.alpha = 0;
		add(candyCorn4);

		mspaFace = new FlxSprite().loadGraphic(Paths.image('freeplay/suprised', "sburb"));
		mspaFace.scale.set(1, 1);
        mspaFace.updateHitbox();
		mspaFace.screenCenter();
		mspaFace.y -= 294;
		mspaFace.x += 481;
		mspaFace.alpha = 0;
		add(mspaFace);

        homestuck = new FlxSprite().loadGraphic(Paths.image('menu/thing', "sburb"));
        homestuck.scale.set(3.2, .3);
		homestuck.updateHitbox();
		homestuck.screenCenter();
		homestuck.y -= 323;
		homestuck.x -= 278;
		homestuck.alpha = 0;
		add(homestuck);

		help = new FlxSprite().loadGraphic(Paths.image('menu/thing', "sburb"));
		help.scale.set(.6, .3);
		help.updateHitbox();
		help.screenCenter();
		help.y -= 323;
		help.x -= 146;
		help.alpha = 0;
		add(help);

		magnet = new FlxSprite().loadGraphic(Paths.image('freeplay/magnet', "sburb"));
		magnet.updateHitbox();
		magnet.screenCenter();
		magnet.y -= 68;
		magnet.x += 314;
		magnet.alpha = 0;
		add(magnet);

		goBack = new FlxSprite().loadGraphic(Paths.image('freeplay/back', "sburb"));
        goBack.scale.set(.8, .8);
        goBack.updateHitbox();
        goBack.screenCenter();
        goBack.antialiasing = ClientPrefs.globalAntialiasing;
        goBack.y += 320;
        goBack.x -= 450;
        add(goBack);

        start = new FlxSprite().loadGraphic(Paths.image('freeplay/start', "sburb"));
        start.scale.set(.8, .8);
        start.updateHitbox();
        start.screenCenter();
        start.antialiasing = ClientPrefs.globalAntialiasing;
        start.y += 320;
        start.x -= 530;
        add(start);

		settings = new FlxSprite().loadGraphic(Paths.image('menu/thing', "sburb"));
		settings.scale.set(1.2, .3);
		settings.updateHitbox();
		settings.screenCenter();
		settings.alpha = 0;
		settings.y -= 323;
		settings.x += 260;
		add(settings);

		credits = new FlxSprite().loadGraphic(Paths.image('menu/thing', "sburb"));
		credits.scale.set(1.1, .3);
		credits.updateHitbox();
		credits.screenCenter();
		credits.alpha = 0;
		credits.y -= 323;
		credits.x += 325;
		add(credits);

		// End of things

		
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
				MusicBeatState.switchState(new FreeplaySelectorTheSecond());
			}

			// This is the start of the mouse clicking code.
			menuItems.forEach(function(spr:FlxSprite)
			{
				if(FlxG.mouse.overlaps((spr:FlxSprite))){
					curSelected = spr.ID;
					if(FlxG.mouse.justPressed){
						selectedSomethin = true;
						var songLowercase:String = Paths.formatToSongPath(songs.get(curCategory)[spr.ID][0].toLowerCase());
						var poop:String = Highscore.formatSong(songLowercase, 1);
						trace(poop);
						
						// :33 < this checks to see if the player has found the cake secret or not, h33h33
						if(songLowercase == 'abjure' && ClientPrefs.cakeSecret == false){
							FlxG.sound.play(Paths.sound("nope"), .7);
							selectedSomethin = false;
							cakeNote.alpha = 1;
						}

						else{
							FlxG.sound.play(Paths.sound("confirmMenu"), 1.5);
							//FlxG.camera.fade(FlxColor.WHITE,1);
							FlxFlicker.flicker(spr, .5, 0.06, false, false, function(flick:FlxFlicker)
							{
								PlayState.SONG = Song.loadFromJson(poop, songLowercase);
								PlayState.isStoryMode = false;
								PlayState.storyDifficulty = 1;
								LoadingState.loadAndSwitchState(new PlayState());
							});
						}
					}
					covers.forEach(function(spr:FlxSprite):Void
					{
						if(spr.ID == curSelected){
							spr.alpha = 1;
						}
						else{
							spr.alpha = 0;
						}
					});
				}
			});

			//This is INCREDIBLY Jank, and should be re-written to be better interlaced with the rest of the code 1000000%, but it works. Anyways...
			var mouseHover:Bool = false;
			if(FlxG.mouse.overlaps(menuItems)){
				mouseHover = true;                 // - This checks to see if the mouse is hovering over ANY menu item, and sets hover to true if so
			}
			else{
				mouseHover = false;                // - This does the opposite.
			}

			if(mouseHover == false){         // - This was the kicker, actually :33
				curSelected = -1;            // - The way it was working before was that it thought the mouse was not on the menu at all, because it was only on one part of it.
			}                                // - This code fixes that issue, but is entirely dependant on the above mouseHover code

			if(curSelected == -1){          
				covers.forEach(function(spr:FlxSprite):Void      // - This code just turns off all the sprites if the mouse isn't on a menu
				{                                                // - 
					spr.alpha = 0;                               // - Because if mouseHover isn't true, curSelected is -1 :33 
				});
			}
		}

		// :33 < Some secret stuff, please don't tell!!
		if(FlxG.mouse.overlaps(candyCorn1) || FlxG.mouse.overlaps(candyCorn2) || FlxG.mouse.overlaps(candyCorn3) || FlxG.mouse.overlaps(candyCorn4)){
            if(FlxG.mouse.justPressed){
				FlxG.sound.play(Paths.sound("crunch"), 1);
    		}
        }

		if(FlxG.mouse.overlaps(magnet) && FlxG.mouse.justPressed && ClientPrefs.secret1){
			FlxG.sound.play(Paths.sound("horn"), 1);
			ClientPrefs.secret2 = true;
			magnet.alpha = 1;
		}

		if(FlxG.mouse.overlaps(homestuck) && FlxG.mouse.justPressed){CoolUtil.browserLoad("https://bambosh.dev/unofficial-homestuck-collection/");}

		if(FlxG.mouse.overlaps(mspaFace) && FlxG.mouse.justPressed){FlxG.sound.play(Paths.sound('alert')); mspaFace.alpha = 1;}
		
		if(FlxG.mouse.overlaps(help) && FlxG.mouse.justPressed){FlxG.sound.play(Paths.sound('horn')); ClientPrefs.secret1 = true;}
		
		if(FlxG.mouse.overlaps(goBack) && FlxG.mouse.justPressed){
			FlxG.sound.play(Paths.sound('confirmMenu'));
			MusicBeatState.switchState(new FreeplaySelectorTheSecond());
		}
		if(FlxG.mouse.overlaps(start) && FlxG.mouse.justPressed){
			FlxG.sound.play(Paths.sound('confirmMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}

		if(FlxG.mouse.overlaps(settings) && FlxG.mouse.justPressed){
			FlxG.sound.play(Paths.sound('confirmMenu'));
			MusicBeatState.switchState(new options.OptionsState());
		}
		if(FlxG.mouse.overlaps(credits) && FlxG.mouse.justPressed){
			FlxG.sound.play(Paths.sound('confirmMenu'));
			MusicBeatState.switchState(new CreditsState());
		}

		super.update(elapsed);
	}
}
