package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSubState;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class GameOverSubstate extends MusicBeatSubstate
{
	var bf:Boyfriend;
	var boneAttackStart:Character;
	var boneAttackLoop:Character;
	var boneAttackEnd:Character;
	var camFollow:FlxObject;
	var startSong:Bool = false;

	var stageSuffix:String = "";

	public function new(x:Float, y:Float)
	{
		var daStage = PlayState.curStage;
		var daBf:Array<String> = [''];
		switch (PlayState.SONG.player1)
		{
			case 'bf-pixel':
				stageSuffix = '-pixel';
			default:
				daBf = ['boneAttackLoop', 'boneAttackStart', 'boneAttackEnd'];
		}

		super();

		Conductor.songPosition = 0;

		bf = new Boyfriend(x, y, 'bf');

		boneAttackStart = new Character(x, y, 'boneAttackStart');
		add(boneAttackStart);

		boneAttackLoop = new Character(x, y, 'boneAttackLoop');
		boneAttackLoop.alpha = 0;
		add(boneAttackLoop);

		boneAttackEnd = new Character(x, y, 'boneAttackEnd');

		new FlxTimer().start(2.75, function(tmr:FlxTimer)
		{
			FlxG.sound.playMusic(Paths.music('gameOver'));
		});

		camFollow = new FlxObject(bf.getGraphicMidpoint().x, bf.getGraphicMidpoint().y, 1, 1);
		add(camFollow);

		FlxG.sound.play(Paths.sound('fnf_loss_sfx' + stageSuffix));
		Conductor.changeBPM(102);

		// FlxG.camera.followLerp = 1;
		// FlxG.camera.focusOn(FlxPoint.get(FlxG.width / 2, FlxG.height / 2));
		FlxG.camera.scroll.set();
		FlxG.camera.target = null;	

		boneAttackStart.playAnim('deathStart');
	}

	var startVibin:Bool = false;

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.ACCEPT)
		{
			endBullshit();
		}

		if (controls.BACK)
		{
			FlxG.sound.music.stop();

			if (PlayState.isStoryMode)
				FlxG.switchState(new StoryMenuState());
			else
				FlxG.switchState(new FreeplayState());
			PlayState.loadRep = false;
		}

		if (boneAttackStart.animation.curAnim.name == 'firstDeath' && boneAttackStart.animation.curAnim.curFrame == 12)
		{
			FlxG.camera.follow(camFollow, LOCKON, 0.01);
		}

		if (boneAttackStart.animation.curAnim.name == 'firstDeath' && boneAttackStart.animation.curAnim.finished)
		{
			startVibin = true;
			boneAttackStart.alpha = 0;
			boneAttackLoop.alpha = 1;
		}

		if (FlxG.sound.music.playing)
		{
			Conductor.songPosition = FlxG.sound.music.time;
		}
	}

	override function beatHit()
	{
		super.beatHit();

		if (startVibin && !isEnding)
		{
			boneAttackLoop.playAnim('deathLoop', true);
		}
		FlxG.log.add('beat');
	}

	var isEnding:Bool = false;

	function endBullshit():Void
	{
		if (!isEnding)
		{
			boneAttackStart.alpha = 0;
			boneAttackLoop.alpha = 0;
			PlayState.startTime = 0;
			isEnding = true;
			boneAttackEnd.playAnim('deathConfirm', true);
			add(boneAttackEnd);
			remove(boneAttackLoop);
			FlxG.sound.music.stop();
			FlxG.sound.play(Paths.music('gameOverEnd' + stageSuffix));
			new FlxTimer().start(0.7, function(tmr:FlxTimer)
			{
				FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
			});
			new FlxTimer().start(0.01, function(tmr:FlxTimer)
			{
				FlxG.sound.music.stop();
			}, 750);
		}
	}
}
