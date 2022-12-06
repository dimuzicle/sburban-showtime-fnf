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

class FreeplaySelectorTheSecond extends MusicBeatState
{
    var vol1:FlxSprite;
    var misc:FlxSprite;
    var cover:FlxSprite;
    var candyCorn1:FlxSprite;
    var candyCorn2:FlxSprite;
    var candyCorn3:FlxSprite;
    var candyCorn4:FlxSprite;
    var mspaFace:FlxSprite;
    var homestuck:FlxSprite;
    var help:FlxSprite;
    var goBack:FlxSprite;
    var start:FlxSprite;
    var settings:FlxSprite;
    var credits:FlxSprite;

    override function create()
    {
        FlxG.mouse.visible = true;
		FlxG.mouse.useSystemCursor = true; //make the mouse visible and the default cursor instead of the fnf one

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
        #end

        //background
        var bg:FlxSprite = new FlxSprite(0).loadGraphic(Paths.image('freeplaySel/bg', "sburb"));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

        // volume covers
        vol1 = new FlxSprite(0).loadGraphic(Paths.image('freeplaySel/one', "sburb"));
		vol1.updateHitbox();
		vol1.screenCenter();
        vol1.x -= 360;
		vol1.antialiasing = ClientPrefs.globalAntialiasing;
		add(vol1);

        misc = new FlxSprite(0).loadGraphic(Paths.image('freeplaySel/two', "sburb"));
		misc.updateHitbox();
		misc.screenCenter();
		misc.antialiasing = ClientPrefs.globalAntialiasing;
		add(misc);

        cover = new FlxSprite(0).loadGraphic(Paths.image('freeplaySel/three', "sburb"));
		cover.updateHitbox();
		cover.screenCenter();
        cover.x += 400;
		cover.antialiasing = ClientPrefs.globalAntialiasing;
		add(cover);

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

        super.create();
    }
    var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
        if (!selectedSomethin) {
            if (controls.BACK)
            {
                selectedSomethin = true;
                FlxG.sound.play(Paths.sound('cancelMenu'));
                MusicBeatState.switchState(new MainMenuState());
            }

            if(FlxG.mouse.overlaps(vol1)){
                if(FlxG.mouse.justPressed){
                    selectedSomethin = true;
                    FlxG.sound.play(Paths.sound("confirmMenu"), 1.5);
                    //FlxG.camera.fade(FlxColor.WHITE,1);
                    FlxFlicker.flicker(vol1, .5, 0.06, false, false, function(flick:FlxFlicker)
                    {
                        selectSmth('Vol1');
                    });
                }
            }

            if(FlxG.mouse.overlaps(misc)){
                if(FlxG.mouse.justPressed){
                    selectedSomethin = true;
                    FlxG.sound.play(Paths.sound("confirmMenu"), 1.5);
                    //FlxG.camera.fade(FlxColor.WHITE,1);
                    FlxFlicker.flicker(misc, .5, 0.06, false, false, function(flick:FlxFlicker)
                    {
                        selectSmth('Misc');
                    });
                }
            }

            if(FlxG.mouse.overlaps(cover)){
                if(FlxG.mouse.justPressed){
                    selectedSomethin = true;
                    FlxG.sound.play(Paths.sound("confirmMenu"), 1.5);
                    //FlxG.camera.fade(FlxColor.WHITE,1);
                    FlxFlicker.flicker(cover, .5, 0.06, false, false, function(flick:FlxFlicker)
                    {
                        selectSmth('Covers');
                    });
                }
            }
        }

        //:33 < Some more fun secret stuff, please don't tell!!
		if(FlxG.mouse.overlaps(candyCorn1) || FlxG.mouse.overlaps(candyCorn2) || FlxG.mouse.overlaps(candyCorn3) || FlxG.mouse.overlaps(candyCorn4)){
            if(FlxG.mouse.justPressed){
				FlxG.sound.play(Paths.sound("crunch"), 1);
    		}
        }

        if(FlxG.mouse.overlaps(help) && FlxG.mouse.justPressed){
			FlxG.sound.play(Paths.sound("horn"), 1);
			ClientPrefs.secret1 = true;
		}

        if(FlxG.mouse.overlaps(mspaFace) && FlxG.mouse.justPressed){
            FlxG.sound.play(Paths.sound("alert"), 1);
            mspaFace.alpha = 1;
        }

        if(FlxG.mouse.overlaps(homestuck) && FlxG.mouse.justPressed){
            CoolUtil.browserLoad("https://bambosh.dev/unofficial-homestuck-collection/");
        }

        if(FlxG.mouse.overlaps(goBack) && FlxG.mouse.justPressed){
			FlxG.sound.play(Paths.sound('confirmMenu'));
			MusicBeatState.switchState(new MainMenuState());
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

    function selectSmth(category:String)
    {
        FreeplaySburb.curCategory = category;
        MusicBeatState.switchState(new FreeplaySburb());
    }
}