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
                    FlxG.sound.play(Paths.sound("confirmMenu"), 0.7);
                    //FlxG.camera.fade(FlxColor.WHITE,1);
                    FlxFlicker.flicker(vol1, 1, 0.06, false, false, function(flick:FlxFlicker)
                    {
                        selectSmth('Vol1');
                    });
                }
            }

            if(FlxG.mouse.overlaps(misc)){
                if(FlxG.mouse.justPressed){
                    selectedSomethin = true;
                    FlxG.sound.play(Paths.sound("confirmMenu"), 0.7);
                    //FlxG.camera.fade(FlxColor.WHITE,1);
                    FlxFlicker.flicker(misc, 1, 0.06, false, false, function(flick:FlxFlicker)
                    {
                        selectSmth('Misc');
                    });
                }
            }

            if(FlxG.mouse.overlaps(cover)){
                if(FlxG.mouse.justPressed){
                    selectedSomethin = true;
                    FlxG.sound.play(Paths.sound("confirmMenu"), 0.7);
                    //FlxG.camera.fade(FlxColor.WHITE,1);
                    FlxFlicker.flicker(cover, 1, 0.06, false, false, function(flick:FlxFlicker)
                    {
                        selectSmth('Covers');
                    });
                }
            }
        }
        super.update(elapsed);
    }

    function selectSmth(category:String)
    {
        FreeplaySburb.curCategory = category;
        MusicBeatState.switchState(new FreeplaySburb());
    }
}