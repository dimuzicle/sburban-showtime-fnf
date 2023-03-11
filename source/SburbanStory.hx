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

class SburbanStory extends MusicBeatState
{
    /* Holds the thing while I work
    	PlayState.storyPlaylist = ['Prankster','Gin-And-Needles','Record-Scratch','Sunshatter'];
		PlayState.isStoryMode = true;

		PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase(), PlayState.storyPlaylist[0].toLowerCase());
		PlayState.campaignScore = 0;
		PlayState.campaignMisses = 0;
    	LoadingState.loadAndSwitchState(new PlayState(), true);
		FreeplayState.destroyFreeplayVocals();
    */

    var curSelected:Int = 0;
    var goBack:FlxSprite;
    var start:FlxSprite;
    var bg:FlxSprite;
    var stageClosed:FlxSprite;
    var stageOpen:FlxSprite;
    var act1:FlxSprite;
    var act2:FlxSprite;
    var act3:FlxSprite;
    var secret:FlxSprite;
    var act1Cover:FlxSprite;
    var act2Cover:FlxSprite;
    var act3Cover:FlxSprite;
    var secretCover:FlxSprite;
    var selectedSomethin:Bool;
    var curWeek:WeekData;
    var songArray:Array<String> = [];
    var curWeekInt:Int;

    override function create(){
        
        WeekData.reloadWeekFiles(true);

        FlxG.mouse.visible = true;
		FlxG.mouse.useSystemCursor = true;

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

		var bg:FlxSprite = new FlxSprite(0).loadGraphic(Paths.image('week/actSky', "sburb"));
		//bg.setGraphicSize(Std.int(bg.width * 1.175));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

        act1Cover = new FlxSprite().loadGraphic(Paths.image('freeplay/cover-egbert', "sburb"));
        act1Cover.scale.set(.8, .8);
        act1Cover.updateHitbox();
        act1Cover.screenCenter();
        act1Cover.antialiasing = ClientPrefs.globalAntialiasing;
        act1Cover.y -= 120;
        act1Cover.x -= 175;
        act1Cover.alpha = 0;
        add(act1Cover);

        act2Cover = new FlxSprite().loadGraphic(Paths.image('freeplay/cover-dave', "sburb"));
        act2Cover.scale.set(.8, .8);
        act2Cover.updateHitbox();
        act2Cover.screenCenter();
        act2Cover.antialiasing = ClientPrefs.globalAntialiasing;
        act2Cover.y -= 120;
        act2Cover.x -= 175;
        act2Cover.alpha = 0;
        add(act2Cover);

        act3Cover = new FlxSprite().loadGraphic(Paths.image('freeplay/cover-rose', "sburb"));
        act3Cover.scale.set(.8, .8);
        act3Cover.updateHitbox();
        act3Cover.screenCenter();
        act3Cover.antialiasing = ClientPrefs.globalAntialiasing;
        act3Cover.y -= 120;
        act3Cover.x -= 175;
        act3Cover.alpha = 0;
        add(act3Cover);

        secretCover = new FlxSprite().loadGraphic(Paths.image('freeplay/cover-jade', "sburb"));
        secretCover.scale.set(.8, .8);
        secretCover.updateHitbox();
        secretCover.screenCenter();
        secretCover.antialiasing = ClientPrefs.globalAntialiasing;
        secretCover.y -= 120;
        secretCover.x -= 175;
        secretCover.alpha = 0;
        add(secretCover);

        stageClosed = new FlxSprite().loadGraphic(Paths.image('week/actCurtainClosed', "sburb"));
        stageClosed.updateHitbox();
        stageClosed.screenCenter();
        stageClosed.antialiasing = ClientPrefs.globalAntialiasing;
        stageClosed.y -= 100;
        stageClosed.alpha = 1;
        add(stageClosed);

        stageOpen = new FlxSprite().loadGraphic(Paths.image('week/actCurtainOpen', "sburb"));
        stageOpen.updateHitbox();
        stageOpen.screenCenter();
        stageOpen.antialiasing = ClientPrefs.globalAntialiasing;
        stageOpen.y -= 100;
        stageOpen.alpha = 0;
        add(stageOpen);

        act1 = new FlxSprite().loadGraphic(Paths.image('week/act1', "sburb"));
        act1.scale.set(.6, .6);
        act1.updateHitbox();
        act1.screenCenter();
        act1.antialiasing = ClientPrefs.globalAntialiasing;
        act1.y += 240;
        act1.x -= 390;
        add(act1);

        act2 = new FlxSprite().loadGraphic(Paths.image('week/act2', "sburb"));
        act2.scale.set(.6, .6);
        act2.updateHitbox();
        act2.screenCenter();
        act2.antialiasing = ClientPrefs.globalAntialiasing;
        act2.y += 230;
        act2.x -= 75;
        add(act2);

        act3 = new FlxSprite().loadGraphic(Paths.image('week/act3', "sburb"));
        act3.scale.set(.6, .6);
        act3.updateHitbox();
        act3.screenCenter();
        act3.antialiasing = ClientPrefs.globalAntialiasing;
        act3.y += 230;
        act3.x += 250;
        add(act3);

        secret = new FlxSprite().loadGraphic(Paths.image('menu/thing', "sburb"));
        secret.scale.set(3.4, 1.5);
        secret.updateHitbox();
        secret.screenCenter();
        secret.antialiasing = ClientPrefs.globalAntialiasing;
        secret.y += 225;
        secret.x += 525;
        secret.alpha = 0;
        add(secret);

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

        super.create();
    }

    override function update(elapsed:Float)
    {
        
        if (FlxG.sound.music.volume < 0.8)
        {
            FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
            if(FreeplayState.vocals != null) FreeplayState.vocals.volume += 0.5 * elapsed;
        }
    
        if (!selectedSomethin)
        {
            if (controls.BACK)
            {
                selectedSomethin = true;
                FlxG.sound.play(Paths.sound('cancelMenu'));
                MusicBeatState.switchState(new TitleState());
            }

            if(FlxG.mouse.overlaps(act1))
            {   
                stageClosed.alpha = 0;
                stageOpen.alpha = 1;
                act1Cover.alpha = 1;
                
                if(FlxG.mouse.justPressed){ 
                    FlxG.sound.play(Paths.sound("confirmMenu2"), .7);
					FlxFlicker.flicker(act1, 1, 0.05, false, false, function(flick:FlxFlicker)
					{
                        //PlayState.storyPlaylist = ['Prankster','Gin-And-Needles','Record-Scratch','Sunshatter'];
                        PlayState.storyWeek = 0;
                        curWeekInt = PlayState.storyWeek;

                        curWeek = WeekData.weeksLoaded.get(WeekData.weeksList[curWeekInt]);
                        trace(curWeekInt);
                        for (i in 0...curWeek.songs.length) {
                            songArray.push(curWeek.songs[i][0]);
                        }
                        
                        PlayState.storyPlaylist = songArray;
                        PlayState.isStoryMode = true;
        
                        PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase(), PlayState.storyPlaylist[0].toLowerCase());
                        PlayState.campaignScore = 0;
                        PlayState.campaignMisses = 0;
                        LoadingState.loadAndSwitchState(new PlayState(), true);
                        FreeplayState.destroyFreeplayVocals();
                    });
                }
            }
            else if(FlxG.mouse.overlaps(act2)){
                stageClosed.alpha = 0;
                stageOpen.alpha = 1;
                act2Cover.alpha = 1;
                
                if(FlxG.mouse.justPressed)
                {
                    if(StoryMenuState.weekCompleted.get(WeekData.weeksList[0]))
                    {
                        FlxG.sound.play(Paths.sound("confirmMenu2"), .7);
                        FlxFlicker.flicker(act2, 1, 0.05, false, false, function(flick:FlxFlicker)
                        {
                            PlayState.storyWeek = 1;
                            curWeekInt = PlayState.storyWeek;

                            curWeek = WeekData.weeksLoaded.get(WeekData.weeksList[curWeekInt]);
                            trace(curWeekInt);
                            for (i in 0...curWeek.songs.length) {
                                songArray.push(curWeek.songs[i][0]);
                            }
                            
                            PlayState.storyPlaylist = songArray;
                            PlayState.isStoryMode = true;
            
                            PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase(), PlayState.storyPlaylist[0].toLowerCase());
                            PlayState.campaignScore = 0;
                            PlayState.campaignMisses = 0;
                            LoadingState.loadAndSwitchState(new PlayState(), true);
                            FreeplayState.destroyFreeplayVocals();
                        });
                    }
                    else{ FlxG.sound.play(Paths.sound("nope"), .7); }
                }
            }
            else if(FlxG.mouse.overlaps(act3)){
                stageClosed.alpha = 0;
                stageOpen.alpha = 1;
                act3Cover.alpha = 1;

                if(FlxG.mouse.justPressed)
                {   
                    FlxG.sound.play(Paths.sound("confirmMenu2"), .7);
					FlxFlicker.flicker(act3, 1, 0.05, false, false, function(flick:FlxFlicker)
					{
                        PlayState.storyWeek = 2;
                        curWeekInt = PlayState.storyWeek;

                        curWeek = WeekData.weeksLoaded.get(WeekData.weeksList[curWeekInt]);
                        trace(curWeekInt);

                        for (i in 0...curWeek.songs.length) {
                            songArray.push(curWeek.songs[i][0]);
                        }
                        
                        PlayState.storyPlaylist = songArray;
                        PlayState.isStoryMode = true;
        
                        PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase(), PlayState.storyPlaylist[0].toLowerCase());
                        PlayState.campaignScore = 0;
                        PlayState.campaignMisses = 0;
                        LoadingState.loadAndSwitchState(new PlayState(), true);
                        FreeplayState.destroyFreeplayVocals();
                    });
                }
            }
            else if(FlxG.mouse.overlaps(secret)){
                stageClosed.alpha = 0;
                stageOpen.alpha = 1;
                secretCover.alpha = 1;

                if(FlxG.mouse.justPressed)
                {
                    FlxG.sound.play(Paths.sound("confirmMenu"), .7);
                    PlayState.storyPlaylist = ['Pouncegreet'];
                    PlayState.isStoryMode = true;
    
                    PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase(), PlayState.storyPlaylist[0].toLowerCase());
                    PlayState.campaignScore = 0;
                    PlayState.campaignMisses = 0;
                    LoadingState.loadAndSwitchState(new PlayState(), true);
                    FreeplayState.destroyFreeplayVocals();
                }
            }
            else{
                stageClosed.alpha = 1;
                stageOpen.alpha = 0;
                act1Cover.alpha = 0;
                act2Cover.alpha = 0;
                act3Cover.alpha = 0;
                secretCover.alpha = 0;
            }

            if(FlxG.mouse.overlaps(start) && FlxG.mouse.justPressed){
                FlxG.sound.play(Paths.sound("confirmMenu"), .7);
                MusicBeatState.switchState(new MainMenuState());
            }
            if(FlxG.mouse.overlaps(goBack) && FlxG.mouse.justPressed){
                FlxG.sound.play(Paths.sound("confirmMenu"), .7);
                MusicBeatState.switchState(new MainMenuState());
            }
        }
    }
}