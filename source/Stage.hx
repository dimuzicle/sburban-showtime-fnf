package;

import StageData;
import flixel.FlxBasic;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;

using StringTools;

class Stage extends FlxTypedGroup<FlxBasic>
{
    public var curStage = '';
    public var gfVersion:String = 'gf';

    public static var contents:Stage;

    public var songName:String = null;

    public var foregroundSprites:FlxTypedGroup<BGSprite>;
    
    public function new(curStage:String)
    {
        super();
        this.curStage = curStage;

        songName = Paths.formatToSongPath(PlayState.SONG.song);

        if(PlayState.SONG.stage == null || PlayState.SONG.stage.length < 1)
        {
			switch (songName)
			{
				default:
					curStage = 'stage';
			}
		}
		PlayState.SONG.stage = curStage;

        switch (curStage)
        {
            case 'stage': //Week 1 - FNF
                var bg:BGSprite = new BGSprite('stageback', -600, -200, 0.9, 0.9);
                add(bg);

                var stageFront:BGSprite = new BGSprite('stagefront', -650, 600, 0.9, 0.9);
                stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
                stageFront.updateHitbox();
                add(stageFront);

                if(!ClientPrefs.lowQuality)
                {
                    var stageLight:BGSprite = new BGSprite('stage_light', -125, -100, 0.9, 0.9);
                    stageLight.setGraphicSize(Std.int(stageLight.width * 1.1));
                    stageLight.updateHitbox();
                    add(stageLight);
                    
                    var stageLight:BGSprite = new BGSprite('stage_light', 1225, -100, 0.9, 0.9);
                    stageLight.setGraphicSize(Std.int(stageLight.width * 1.1));
                    stageLight.updateHitbox();
                    stageLight.flipX = true;
                    add(stageLight);

                    var stageCurtains:BGSprite = new BGSprite('stagecurtains', -500, -300, 1.3, 1.3);
                    stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
                    stageCurtains.updateHitbox();
                    add(stageCurtains);
                }
            case 'awesome':
                var blank:FlxSprite = new FlxSprite(-200, -575).makeGraphic(Std.int(FlxG.width * 5), Std.int(FlxG.height * 5), FlxColor.WHITE);
				blank.scrollFactor.set(0.9, 0.9);
				add(blank);

                var ground:BGSprite = new BGSprite('stages/dave/ground', -800, 0, 0.75, 0.75);
                ground.setGraphicSize(Std.int(ground.width * 0.7));
                add(ground);

                var stuff:BGSprite = new BGSprite('stages/dave/stuff', 0, 0, 0.75, 0.75);
                stuff.setGraphicSize(Std.int(stuff.width * 0.7));
                add(stuff);
            case 'balcony':
                var bg:BGSprite = new BGSprite('stages/john/4', 0, 0, 0.6, 0.6);
                bg.setGraphicSize(Std.int(bg.width * 1.34));
                add(bg);

                var sun:BGSprite = new BGSprite('stages/john/2', 0, 0, 0.75, 0.75);
                sun.setGraphicSize(Std.int(sun.width * 1.1));
                add(sun);

                var clouds:BGSprite = new BGSprite('stages/john/3', 0, 0, 0.86, 0.86);
                clouds.setGraphicSize(Std.int(clouds.width * 1.1));
                add(clouds);

                var ground:BGSprite = new BGSprite('stages/john/1', 0, 0, 1, 1);
                ground.setGraphicSize(Std.int(ground.width * 1.2));
                add(ground);
        }
    }

    public function returnGFtype(curStage)
    {
        gfVersion = PlayState.SONG.gfVersion;

        if(gfVersion == null || gfVersion.length < 1)
        {
            switch (curStage)
            {
                default:
                    gfVersion = 'gf';
            }
            PlayState.SONG.gfVersion = gfVersion; //Fix for the Chart Editor
        }

        return gfVersion;
    }

    public function stageUpdate(curBeat:Int, boyfriend:Boyfriend, gf:Character, dad:Character)
    {
        switch (curStage)
		{
			case 'blah':
                //
		}
    }

    public function stageUpdateConst(elapsed:Float, boyfriend:Boyfriend, gf:Character, dad:Character)
    {
        switch (curStage)
		{
			case 'blah':
                //
		}
    }
}