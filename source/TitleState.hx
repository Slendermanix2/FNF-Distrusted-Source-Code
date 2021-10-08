package;

import flixel.input.keyboard.FlxKeyList;
#if sys
import smTools.SMFile;
#end
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.system.ui.FlxSoundTray;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import io.newgrounds.NG;
import lime.app.Application;
import openfl.Assets;
import flixel.util.FlxGradient;
import flash.events.KeyboardEvent;
#if windows
import Discord.DiscordClient;
#end

#if cpp
import sys.thread.Thread;
#end

using StringTools;

class TitleState extends MusicBeatState
{
	static var initialized:Bool = false;

	var blackScreen:FlxSprite;
	var credGroup:FlxGroup;
	var credTextShit:Alphabet;
	var textGroup:FlxGroup;
	var ngSpr:FlxSprite;
	var gradientBar:FlxSprite;
	var txt3:FlxText;
	

	var curWacky:Array<String> = [];

	var wackyImage:FlxSprite;

	override public function create():Void
	{
		#if polymod
		polymod.Polymod.init({modRoot: "mods", dirs: ['introMod']});
		#end
		
		#if sys
		if (!sys.FileSystem.exists(Sys.getCwd() + "/assets/replays"))
			sys.FileSystem.createDirectory(Sys.getCwd() + "/assets/replays");
		#end

		@:privateAccess
		{
			trace("Loaded " + openfl.Assets.getLibrary("default").assetsLoaded + " assets (DEFAULT)");
		}
		
		#if !cpp

		FlxG.save.bind('funkin', 'ninjamuffin99');

		PlayerSettings.init();

		KadeEngineData.initSave();
		
		#end

				
		Highscore.load();

		  


		curWacky = FlxG.random.getObject(getIntroTextShit());

		trace('hello');

		// DEBUG BULLSHIT

		super.create();

		// NGio.noLogin(APIStuff.API);

		#if ng
		var ng:NGio = new NGio(APIStuff.API, APIStuff.EncKey);
		trace('NEWGROUNDS LOL');
		#end

		#if FREEPLAY
		FlxG.switchState(new FreeplayState());
		#elseif CHARTING
		FlxG.switchState(new ChartingState());
		#else
		#if !cpp
		new FlxTimer().start(1, function(tmr:FlxTimer)
		{
			startIntro();
		});
		#else
		startIntro();
		#end
		#end
	}

	var logoBl:FlxSprite;
	var gfDance:FlxSprite;
	var danceLeft:Bool = false;
	var titleText:FlxSprite;
	var bg:FlxSprite;

	function startIntro()
	{
		persistentUpdate = true;

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		// bg.antialiasing = true;
		// bg.setGraphicSize(Std.int(bg.width * 0.6));
		// bg.updateHitbox();
		add(bg);

		gradientBar = FlxGradient.createGradientFlxSprite(Math.round(FlxG.width), 512, [0xFF000000, 0xFF00FFFF, 0xFF0000FF, 0xFF800080], 1, 90, true); 
		gradientBar.y = 850;
		gradientBar.scale.y = 0;
		gradientBar.updateHitbox();
		add(gradientBar);

		if (Main.watermarks) {
			logoBl = new FlxSprite(100, -100);
			logoBl.frames = Paths.getSparrowAtlas('logoBumpin');
		} else {
			logoBl = new FlxSprite(-150, -100);
			logoBl.frames = Paths.getSparrowAtlas('logoBumpin');
		}
		if(FlxG.save.data.antialiasing)
			{
				logoBl.antialiasing = true;
			}
		logoBl.animation.addByPrefix('bump', 'logo bumpin', 24, false);
		logoBl.updateHitbox();
		// logoBl.screenCenter();
		// logoBl.color = FlxColor.BLACK;

		gfDance = new FlxSprite(800, 350);
		gfDance.frames = Paths.getSparrowAtlas('disttrustsans');
		gfDance.animation.addByPrefix('sansbump', 'image0', 14, true);
		gfDance.alpha = 0;
		gfDance.scale.x = 2;
		gfDance.scale.y = 2;
		gfDance.animation.play('sansbump', true);
		if(FlxG.save.data.antialiasing)
			{
				gfDance.antialiasing = true;
			}
		add(gfDance);
		add(logoBl);

		titleText = new FlxSprite(50, 1000);
		titleText.frames = Paths.getSparrowAtlas('titleEnter');
		titleText.animation.addByPrefix('idle', "Press Enter to Begin", 24);
		titleText.animation.addByPrefix('press', "ENTER PRESSED", 24);
		titleText.scale.x = 0.75;
		titleText.scale.y = 0.75;
		if(FlxG.save.data.antialiasing)
			{
				titleText.antialiasing = true;
			}
		titleText.animation.play('idle');
		titleText.updateHitbox();
		// titleText.screenCenter(X);
		add(titleText);

		txt3 = new FlxText(0, 500, FlxG.width, "Unlocked an Achievement!", 32);		
		txt3.setFormat("VCR OSD Mono", 32, FlxColor.fromRGB(200, 200, 200), CENTER);
		txt3.screenCenter();
		txt3.borderColor = FlxColor.BLACK;
		txt3.borderSize = 3;
		txt3.borderStyle = FlxTextBorderStyle.OUTLINE;
		txt3.alpha = 0;
		add(txt3);

		var logo:FlxSprite = new FlxSprite().loadGraphic(Paths.image('logo'));
		logo.screenCenter();
		if(FlxG.save.data.antialiasing)
			{
				logo.antialiasing = true;
			}
		// add(logo);

		// FlxTween.tween(logoBl, {y: logoBl.y + 50}, 0.6, {ease: FlxEase.quadInOut, type: PINGPONG});
		// FlxTween.tween(logo, {y: logoBl.y + 50}, 0.6, {ease: FlxEase.quadInOut, type: PINGPONG, startDelay: 0.1});

		credGroup = new FlxGroup();
		add(credGroup);
		textGroup = new FlxGroup();

		blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		credGroup.add(blackScreen);

		credTextShit = new Alphabet(0, 0, "ninjamuffin99\nPhantomArcade\nkawaisprite\nevilsk8er", true);
		credTextShit.screenCenter();

		// credTextShit.alignment = CENTER;

		credTextShit.visible = false;

		ngSpr = new FlxSprite(0, FlxG.height * 0.52).loadGraphic(Paths.image('newgrounds_logo'));
		add(ngSpr);
		ngSpr.visible = false;
		ngSpr.setGraphicSize(Std.int(ngSpr.width * 0.8));
		ngSpr.updateHitbox();
		ngSpr.screenCenter(X);
		if(FlxG.save.data.antialiasing)
			{
				ngSpr.antialiasing = true;
			}

		FlxTween.tween(credTextShit, {y: credTextShit.y + 20}, 2.9, {ease: FlxEase.quadInOut, type: PINGPONG});

		FlxG.mouse.visible = false;

		if (initialized)
			skipIntro();
		else {
			var diamond:FlxGraphic = FlxGraphic.fromClass(GraphicTransTileDiamond);
			diamond.persist = true;
			diamond.destroyOnNoUse = false;

			FlxTransitionableState.defaultTransIn = new TransitionData(FADE, FlxColor.BLACK, 1, new FlxPoint(0, -1), {asset: diamond, width: 32, height: 32},
				new FlxRect(-200, -200, FlxG.width * 1.4, FlxG.height * 1.4));
			FlxTransitionableState.defaultTransOut = new TransitionData(FADE, FlxColor.BLACK, 0.7, new FlxPoint(0, 1),
				{asset: diamond, width: 32, height: 32}, new FlxRect(-200, -200, FlxG.width * 1.4, FlxG.height * 1.4));

			transIn = FlxTransitionableState.defaultTransIn;
			transOut = FlxTransitionableState.defaultTransOut;

			// HAD TO MODIFY SOME BACKEND SHIT
			// IF THIS PR IS HERE IF ITS ACCEPTED UR GOOD TO GO
			// https://github.com/HaxeFlixel/flixel-addons/pull/348

			// var music:FlxSound = new FlxSound();
			// music.loadStream(Paths.music('freakyMenu'));
			// FlxG.sound.list.add(music);
			// music.play();
			FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);

			FlxG.sound.music.fadeIn(4, 0, 0.7);
			Conductor.changeBPM(75);
			initialized = true;
		}

		// credGroup.add(credTextShit);
	}

	function getIntroTextShit():Array<Array<String>>
	{
		var fullText:String = Assets.getText(Paths.txt('data/introText'));

		var firstArray:Array<String> = fullText.split('\n');
		var swagGoodArray:Array<Array<String>> = [];

		for (i in firstArray)
		{
			swagGoodArray.push(i.split('--'));
		}

		return swagGoodArray;
	}

	var transitioning:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;
		// FlxG.watch.addQuick('amp', FlxG.sound.music.amplitude);


		if (FlxG.keys.justPressed.UP)
		{
			trace('up');
			new FlxTimer().start(0.01, function(tmr:FlxTimer)
			{
				if (FlxG.keys.justPressed.DOWN)
				{
					trace('down');
					new FlxTimer().start(0.01, function(tmr:FlxTimer)
					{
						if (FlxG.keys.justPressed.LEFT)
						{
							trace('left');
							new FlxTimer().start(0.01, function(tmr:FlxTimer)
							{
								if (FlxG.keys.justPressed.LEFT)
								{
									trace('left');
									new FlxTimer().start(0.01, function(tmr:FlxTimer)
									{
										if (FlxG.keys.justPressed.DOWN)
										{
											trace('down');
											new FlxTimer().start(0.01, function(tmr:FlxTimer)
											{
												if (FlxG.keys.justPressed.RIGHT)
												{
													trace('right');
													new FlxTimer().start(0.01, function(tmr:FlxTimer)
													{
														if (FlxG.keys.justPressed.UP)
														{
															trace('up');
															new FlxTimer().start(0.01, function(tmr:FlxTimer)
															{
																if (FlxG.keys.justPressed.UP)
																{
																	trace('up');
																	new FlxTimer().start(0.01, function(tmr:FlxTimer)
																	{
																		if (FlxG.keys.justPressed.Z)
																		{
																			trace('z');
																			new FlxTimer().start(0.01, function(tmr:FlxTimer)
																			{
																				if (FlxG.keys.justPressed.X)
																				{
																					trace('x');
																					new FlxTimer().start(0.01, function(tmr:FlxTimer)
																					{
																						if (FlxG.keys.justPressed.C)
																						{
																							trace('c');
																							FlxG.save.data.secretAcheivement = true;
																							txt3.alpha = 1;
																						}
																					}, 500);
																				}
																			}, 500);
																		}
																	}, 500);
																}
															}, 500);
														}
													}, 500);
												}
											}, 500);
										}
									}, 500);
								}
							}, 500);
						}
					}, 500);
				}
			}, 500);
		}	

		if (FlxG.keys.justPressed.F)
		{
			FlxG.fullscreen = !FlxG.fullscreen;
		}

		var pressedEnter:Bool = controls.ACCEPT;

		#if mobile
		for (touch in FlxG.touches.list)
		{
			if (touch.justPressed)
			{
				pressedEnter = true;
			}
		}
		#end

		if (pressedEnter && !transitioning && skippedIntro)
		{
			#if !switch
			NGio.unlockMedal(60960);

			// If it's Friday according to da clock
			if (Date.now().getDay() == 5)
				NGio.unlockMedal(61034);
			#end

			if (FlxG.save.data.flashing)
				titleText.animation.play('press');

			FlxG.camera.flash(FlxColor.WHITE, 1);
			FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);

			transitioning = true;
			// FlxG.sound.music.stop();

			MainMenuState.firstStart = true;
			MainMenuState.finishedFunnyMove = false;

			new FlxTimer().start(2, function(tmr:FlxTimer)
			{
				// Get current version of Kade Engine
				
				var http = new haxe.Http("https://raw.githubusercontent.com/KadeDev/Kade-Engine/master/version.downloadMe");
				var returnedData:Array<String> = [];
				
				http.onData = function (data:String)
				{
					returnedData[0] = data.substring(0, data.indexOf(';'));
					returnedData[1] = data.substring(data.indexOf('-'), data.length);
				  	if (!MainMenuState.kadeEngineVer.contains(returnedData[0].trim()) && !OutdatedSubState.leftState)
					{
						FlxG.switchState(new InstructionsState());
					}
					else
					{
						FlxG.switchState(new InstructionsState());
					}
				}
				
				http.onError = function (error) {
				  trace('error: $error');
				  FlxG.switchState(new InstructionsState()); // fail but we go anyway
				}
				
				http.request();
			});
			// FlxG.sound.play(Paths.music('titleShoot'), 0.7);
		}

		if (pressedEnter && !skippedIntro && initialized)
		{
			skipIntro();
		}

		super.update(elapsed);
	}

	function createCoolText(textArray:Array<String>)
	{
		for (i in 0...textArray.length)
		{
			var money:Alphabet = new Alphabet(0, 0, textArray[i], true, false);
			money.screenCenter(X);
			money.y += (i * 60) + 800;
			credGroup.add(money);
			textGroup.add(money);
			FlxTween.tween(money,{y: 200 + (i * 60)},0.75 + (i * 0.25) ,{ease: FlxEase.expoInOut});
		}
	}

	function higherText(textArray:Array<String>)
	{
		for (i in 0...textArray.length)
		{
			var money:Alphabet = new Alphabet(0, 0, textArray[i], true, false);
			money.screenCenter(X);
			money.y += (i * 60) + 800;
			credGroup.add(money);
			textGroup.add(money);
			FlxTween.tween(money,{y: 100 + (i * 60)},0.75 + (i * 0.25) ,{ease: FlxEase.expoInOut});
		}
	}

	function addMoreText(text:String)
	{
		var coolText:Alphabet = new Alphabet(0, 0, text, true, false);
		coolText.screenCenter(X);
		coolText.y += (textGroup.length * 60) + 800;
		credGroup.add(coolText);
		textGroup.add(coolText);
		FlxTween.tween(coolText,{y:(textGroup.length * 60) + 150},0.75 ,{ease: FlxEase.expoInOut});
	}

	function addOtherText(text:String)
	{
		var coolText:Alphabet = new Alphabet(0, 0, text, true, false);
		coolText.screenCenter(X);
		coolText.y += (textGroup.length * 60) + 400;
		credGroup.add(coolText);
		textGroup.add(coolText);
		FlxTween.tween(coolText,{y:(textGroup.length * 60) + 50},0.75 ,{ease: FlxEase.expoInOut});
	}

	function deleteCoolText()
	{
		while (textGroup.members.length > 0)
		{
			credGroup.remove(textGroup.members[0], true);
			textGroup.remove(textGroup.members[0], true);
		}
	}

	override function beatHit()
	{
		super.beatHit();

		logoBl.animation.play('bump', true);
		danceLeft = !danceLeft;

		FlxG.log.add(curBeat);

		switch (curBeat)
		{
			case 0:
				deleteCoolText();
			case 1:
				higherText(['Yaro', 'Chris', 'kawaiiMochiORA', 'NeonAnimates', 'Slendermanix2', 'Gabe', 'Barooky', 'Sub X']);
			// credTextShit.visible = true;
			case 3:
				addOtherText('present');
			// credTextShit.text += '\npresent...';
			// credTextShit.addText();
			case 4:
				deleteCoolText();
			// credTextShit.visible = false;
			// credTextShit.text = 'In association \nwith';
			// credTextShit.screenCenter();
			case 5:
				if (Main.watermarks)
					createCoolText(['Kade Engine', 'by']);
				else
					createCoolText(['In Partnership', 'with']);
			case 7:
				if (Main.watermarks)
					addMoreText('KadeDeveloper as always');
				else
				{
					addMoreText('Newgrounds');
					ngSpr.visible = true;
				}
			// credTextShit.text += '\nNewgrounds';
			case 8:
				deleteCoolText();
				ngSpr.visible = false;
			// credTextShit.visible = false;

			// credTextShit.text = 'Shoutouts Tom Fulp';
			// credTextShit.screenCenter();
			case 9:
				createCoolText(['BenyiC03', 'is']);
			// credTextShit.visible = true;
			case 11:
				addMoreText('Awesome');
			// credTextShit.text += '\nlmao';
			case 12:
				deleteCoolText();
			// credTextShit.visible = false;
			// credTextShit.text = "Friday";
			// credTextShit.screenCenter();
			case 13:
				addMoreText('Another');
			// credTextShit.visible = true;
			case 14:
				addMoreText('Undertale');
			// credTextShit.text += '\nNight';
			case 15:
				addMoreText('Mod'); // credTextShit.text += '\nFunkin';
				addMoreText('lol'); // But seriously after this I'm not making another undertale mod(Slendermanix2)

			case 16: 
				skipIntro();
		}
	}

	var skippedIntro:Bool = false;

	function skipIntro():Void
	{
		if (!skippedIntro)
		{
			remove(ngSpr);

			FlxG.camera.flash(FlxColor.WHITE, 1);
			remove(credGroup);

			FlxTween.tween(logoBl,{'scale.x': 0.65, 'scale.y': 0.65, y: -150, x: -175}, 2.4, {ease: FlxEase.expoInOut});
			FlxTween.tween(gfDance,{alpha: 1}, 2, {ease: FlxEase.expoInOut, startDelay: 1});
			FlxTween.tween(titleText,{y: 600}, 2, {ease: FlxEase.expoInOut, startDelay: 0.75});

			FlxTween.tween(gradientBar, {'scale.y': 1.3}, 2, {ease: FlxEase.quadInOut, startDelay: 1});

			new FlxTimer().start(0.01, function(tmr:FlxTimer)
			{
				if(gradientBar.scale.y == 1.3) 
					FlxTween.tween(gradientBar, {'scale.y': 1}, 2, {ease: FlxEase.quadInOut});
				if (gradientBar.scale.y == 1) 
					FlxTween.tween(gradientBar, {'scale.y': 1.3}, 2, {ease: FlxEase.quadInOut});
			}, 0);

			skippedIntro = true;
		}
	}
}
