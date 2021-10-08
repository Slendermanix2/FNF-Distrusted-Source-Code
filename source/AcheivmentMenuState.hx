package;

import flixel.input.gamepad.FlxGamepad;
import Controls.KeyboardScheme;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import io.newgrounds.NG;
import lime.app.Application;
import flixel.util.FlxGradient;

#if windows
import Discord.DiscordClient;
#end

using StringTools;

class AcheivmentMenuState extends MusicBeatState
{
	var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;

	#if !switch
	var optionShit:Array<String> = ['pageOne', 'pageTwo', 'pageThree'];
	#else
	var optionShit:Array<String> = ['pageOne', 'pageTwo', 'pageThree'];
	#end

	var newGaming:FlxText;
	var newGaming2:FlxText;
	public static var firstStart:Bool = true;

	public static var nightly:String = "";

	public static var kadeEngineVer:String = "1.6" + nightly;
	public static var gameVer:String = "0.2.7.1";

	var acheivment0:FlxSprite;
	var acheivment1:FlxSprite;
	var acheivment2:FlxSprite;
	var acheivment3:FlxSprite;
	var acheivment4:FlxSprite;
	var acheivment5:FlxSprite;
	var acheivment6:FlxSprite;
	var acheivment7:FlxSprite;
	var acheivment8:FlxSprite;
	var acheivment9:FlxSprite;
	var square0:FlxSprite;
	var square1:FlxSprite;
	var square2:FlxSprite;
	var square3:FlxSprite;
	var text0:FlxText;
	var text1:FlxText;
	var text2:FlxText;
	var text3:FlxText;
	var camFollow:FlxObject;
	public static var finishedFunnyMove:Bool = false;

	override function create()
	{
		#if windows
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		if (!FlxG.sound.music.playing)
		{
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}

		persistentUpdate = persistentDraw = true;

		var bg:FlxSprite = new FlxSprite(-100).loadGraphic(Paths.image('stageback', 'shared'));
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0.10;
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = FlxG.save.data.antialiasing;
		add(bg);

		acheivment0 = new FlxSprite(250, 150).loadGraphic(Paths.image('Acheivment0'));
		acheivment0.scrollFactor.set();
		acheivment0.alpha = 0;
		acheivment0.antialiasing = FlxG.save.data.antialiasing;
		
		acheivment1 = new FlxSprite(750, 150).loadGraphic(Paths.image('Acheivment1'));
		acheivment1.scrollFactor.set();
		acheivment1.alpha = 0;
		acheivment1.antialiasing = FlxG.save.data.antialiasing;
		
		acheivment2 = new FlxSprite(250, 450).loadGraphic(Paths.image('Acheivment2'));
		acheivment2.scrollFactor.set();
		acheivment2.alpha = 0;
		acheivment2.antialiasing = FlxG.save.data.antialiasing;
		
		acheivment3 = new FlxSprite(750, 450).loadGraphic(Paths.image('Acheivment3'));
		acheivment3.scrollFactor.set();
		acheivment3.alpha = 0;
		acheivment3.antialiasing = FlxG.save.data.antialiasing;

		acheivment4 = new FlxSprite(250, 150).loadGraphic(Paths.image('Acheivment4'));
		acheivment4.scrollFactor.set();
		acheivment4.alpha = 0;
		acheivment4.antialiasing = FlxG.save.data.antialiasing;
		
		acheivment5 = new FlxSprite(750, 150).loadGraphic(Paths.image('Acheivment5'));
		acheivment5.scrollFactor.set();
		acheivment5.alpha = 0;
		acheivment5.antialiasing = FlxG.save.data.antialiasing;
		
		acheivment6 = new FlxSprite(250, 450).loadGraphic(Paths.image('Acheivment6'));
		acheivment6.scrollFactor.set();
		acheivment6.alpha = 0;
		acheivment6.antialiasing = FlxG.save.data.antialiasing;
		
		acheivment7 = new FlxSprite(750, 450).loadGraphic(Paths.image('Acheivment7'));
		acheivment7.scrollFactor.set();
		acheivment7.alpha = 0;
		acheivment7.antialiasing = FlxG.save.data.antialiasing;

		acheivment8 = new FlxSprite(250, 150).loadGraphic(Paths.image('Acheivment8'));
		acheivment8.scrollFactor.set();
		acheivment8.alpha = 0;
		acheivment8.antialiasing = FlxG.save.data.antialiasing;

		acheivment9 = new FlxSprite(750, 150).loadGraphic(Paths.image('Acheivment9'));
		acheivment9.scrollFactor.set();
		acheivment9.alpha = 0;
		acheivment9.antialiasing = FlxG.save.data.antialiasing;

		text0 = new FlxText(250, 130, 0, '', 12);
		text0.scrollFactor.set();
		text0.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);

		text1 = new FlxText(750, 130, 0, '', 12);
		text1.scrollFactor.set();
		text1.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);

		text2 = new FlxText(250, 430, 0, '', 12);
		text2.scrollFactor.set();
		text2.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);

		text3 = new FlxText(750, 430, 0, '', 12);
		text3.scrollFactor.set();
		text3.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);

		square0 = new FlxSprite(250,150).makeGraphic(250,250, FlxColor.BLACK);
		square0.scrollFactor.set();

		square1 = new FlxSprite(750,150).makeGraphic(250,250, FlxColor.BLACK);
		square1.scrollFactor.set();

		square2 = new FlxSprite(250,450).makeGraphic(250,250, FlxColor.BLACK);
		square2.scrollFactor.set();

		square3 = new FlxSprite(750,450).makeGraphic(250,250, FlxColor.BLACK);
		square3.scrollFactor.set();
		add(square0);
		add(square1);
		add(square2);
		add(square3);
		add(acheivment9);
		add(acheivment8);
		add(acheivment7);
		add(acheivment6);
        add(acheivment5);
        add(acheivment4);
		add(acheivment3);
		add(acheivment2);
        add(acheivment1);
        add(acheivment0);
		add(text0);
		add(text1);
		add(text2);
		add(text3);

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var tex = Paths.getSparrowAtlas('pages');

		for (i in 0...optionShit.length)
		{
			var menuItem:FlxSprite = new FlxSprite(0, FlxG.height * 1.6);
			menuItem.frames = tex;
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			menuItem.x = 200 + (i * 260);
			menuItem.y = 60;
			menuItems.add(menuItem);
			menuItem.scrollFactor.set();
			if(FlxG.save.data.antialiasing)
			{
				menuItem.antialiasing = true;
			}
			changeItem();
			finishedFunnyMove = true;
		}

		firstStart = false;

		FlxG.camera.follow(camFollow, null, 0.60 * (60 / FlxG.save.data.fpsCap));

		// NG.core.calls.event.logEvent('swag').send();


		if (FlxG.save.data.dfjk)
			controls.setKeyboardScheme(KeyboardScheme.Solo, true);
		else
			controls.setKeyboardScheme(KeyboardScheme.Duo(true), true);

		changeItem();

		super.create();
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if (!selectedSomethin)
		{
			var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

			if (gamepad != null)
			{
				if (gamepad.justPressed.DPAD_UP)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'));
					changeItem(-1);
				}
				if (gamepad.justPressed.DPAD_DOWN)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'));
					changeItem(1);
				}
			}

			if (FlxG.keys.justPressed.LEFT)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}

			if (FlxG.keys.justPressed.RIGHT)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}

			if (controls.BACK)
			{
				FlxG.switchState(new MainMenuState());
			}

		}

		super.update(elapsed);
	}

	function changeItem(huh:Int = 0)
	{
		if (finishedFunnyMove)
		{
			curSelected += huh;

			if (curSelected >= menuItems.length)
				curSelected = 0;
			if (curSelected < 0)
				curSelected = menuItems.length - 1;
		}
		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');

			if (spr.ID == curSelected && finishedFunnyMove)
			{
				spr.animation.play('selected');
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y);
			}

			spr.updateHitbox();
		});

		if (optionShit[curSelected] == 'pageOne')
		{
			if(FlxG.save.data.noHunger)
				acheivment0.alpha = 1;
			if(FlxG.save.data.fcFDY)
				acheivment1.alpha = 1;
			if(FlxG.save.data.die69Times)
				acheivment2.alpha = 1;
			if(FlxG.save.data.dissus)
				acheivment3.alpha = 1;
			acheivment4.alpha = 0;
			acheivment5.alpha = 0;
			acheivment6.alpha = 0;
			acheivment7.alpha = 0;
			acheivment8.alpha = 0;
			acheivment9.alpha = 0;
			square2.alpha = 1;
			square3.alpha = 1;
			text0.text = 'Not hungry at all!' + '\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nComplete Humerus without using items';
			text1.text = 'Unbeatable!' + '\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nFC Humerus on FDY difficulty';
			text2.text = 'Smh Skill issue' + '\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nDie 69 times';
			text3.text = 'Dissus ' + '\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n???';
			text2.alpha = 1;
			text3.alpha = 1;
		}
		else if (optionShit[curSelected] == 'pageTwo')
		{
			acheivment0.alpha = 0;
			acheivment1.alpha = 0;
			acheivment2.alpha = 0;
			acheivment3.alpha = 0;
			acheivment8.alpha = 0;
			acheivment9.alpha = 0;
			square2.alpha = 1;
			square3.alpha = 1;
			if(FlxG.save.data.dyingIsGay)
				acheivment4.alpha = 1;
			if(FlxG.save.data.susCode)
				acheivment5.alpha = 1;
			if(FlxG.save.data.staticCode)
				acheivment6.alpha = 1;
			if(FlxG.save.data.secretAcheivement)
				acheivment7.alpha = 1;
			text0.text = 'Dying is gay' + '\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n???';
			text1.text = 'Sus' + '\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n???';
			text2.text = '???' + '\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n???';
			text3.text = 'The super secret acheivment' + '\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n???';
			text2.alpha = 1;
			text3.alpha = 1;
		}
		else if (optionShit[curSelected] == 'pageThree')
		{
			acheivment0.alpha = 0;
			acheivment1.alpha = 0;
			acheivment2.alpha = 0;
			acheivment3.alpha = 0;
			acheivment4.alpha = 0;
			acheivment5.alpha = 0;
			acheivment6.alpha = 0;
			acheivment7.alpha = 0;
			square2.alpha = 0;
			square3.alpha = 0;
			if(FlxG.save.data.bigShotCode)
				acheivment8.alpha = 1;
			if(FlxG.save.data.starValleyCode)
				acheivment9.alpha = 1;
			text0.text = 'Big Shot??' + '\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n???';
			text1.text = 'Star Valley Star' + '\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n???';
			text2.alpha = 0;
			text3.alpha = 0;
		}

	}
}
