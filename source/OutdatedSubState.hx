package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;
import flixel.addons.ui.FlxInputText;
import flixel.addons.ui.FlxUIInputText;


class OutdatedSubState extends MusicBeatState
{
	public static var leftState:Bool = false;

	public static var needVer:String = "IDFK LOL";
	public static var currChanges:String = "dk";
	var typingShit:FlxInputText;
	var UI_songTitle:FlxUIInputText;
	var txt3:FlxText;
	
	private var bgColors:Array<String> = [
		'#314d7f',
		'#4e7093',
		'#70526e',
		'#594465'
	];
	private var colorRotation:Int = 1;

	override function create()
	{
		super.create();
	
		
		var txt:FlxText = new FlxText(0, 0, FlxG.width, "Enter Password", 32);		
		txt.setFormat("VCR OSD Mono", 32, FlxColor.fromRGB(200, 200, 200), CENTER);
		txt.borderColor = FlxColor.BLACK;
		txt.borderSize = 3;
		txt.borderStyle = FlxTextBorderStyle.OUTLINE;
		txt.screenCenter();
		add(txt);

		var txt2:FlxText = new FlxText(0, 0, FlxG.width, "Press ESC to exit", 32);		
		txt2.setFormat("VCR OSD Mono", 32, FlxColor.fromRGB(200, 200, 200));
		txt2.borderColor = FlxColor.BLACK;
		txt2.borderSize = 3;
		txt2.borderStyle = FlxTextBorderStyle.OUTLINE;
		add(txt2);
		
		txt3 = new FlxText(0, 500, FlxG.width, "Incorrect password", 32);		
		txt3.setFormat("VCR OSD Mono", 32, FlxColor.fromRGB(200, 200, 200), CENTER);
		txt3.borderColor = FlxColor.BLACK;
		txt3.borderSize = 3;
		txt3.borderStyle = FlxTextBorderStyle.OUTLINE;
		txt3.alpha = 0;
		add(txt3);


		UI_songTitle = new FlxUIInputText(500, 400, 300, "password", 36);
		add(UI_songTitle);
		typingShit = UI_songTitle;
	}

	override function update(elapsed:Float)
	{
		FlxG.save.data.playedOnce = true;
		if(UI_songTitle.text == 'Dissus' || UI_songTitle.text == 'dissus')
		{
			if(FlxG.keys.justPressed.ENTER)
			{
				PlayState.SONG = Song.loadFromJson("a-sansational-battle-hard", "a-sansational-battle");
				PlayState.isStoryMode = true;
				PlayState.storyDifficulty = 2;
				PlayState.storyWeek = 1;
				LoadingState.loadAndSwitchState(new PlayState());
			}	 
		}	
		else if(UI_songTitle.text == 'Gaster' || UI_songTitle.text == 'gaster')
		{
			if(FlxG.keys.justPressed.ENTER)
			{
				FlxG.resetGame();
			}	 
		}	
		else if(UI_songTitle.text == 'Sus' || UI_songTitle.text == 'sus')
		{
			if(FlxG.keys.justPressed.ENTER)
			{
				fancyOpenURL("https://sites.google.com/view/sussysussysussysussysussysussy/sussy");
				FlxG.save.data.susCode = true;
			}	 
		}
		else if(UI_songTitle.text == 'DyingIsGay' || UI_songTitle.text == 'dyingisgay' || UI_songTitle.text == 'Dying is gay')
		{
			if(FlxG.keys.justPressed.ENTER)
			{
				var video:MP4Handler = new MP4Handler();
				video.playMP4(Paths.video('dyingIsGay'), new MainMenuState()); 
				FlxG.save.data.dyingIsGay = true;
			}	 
		}	
	    else if(UI_songTitle.text == '307543')
		{
			if(FlxG.keys.justPressed.ENTER)
			{
				txt3.alpha = 1;
				if(FlxG.save.data.staticCode)
					txt3.text = 'Already have this acheivement!';
				else
					txt3.text = 'Unlocked an acheivement!';
				new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					if(txt3.alpha == 1)
					  FlxTween.tween(txt3, {alpha: 0}, 1, {ease: FlxEase.quadInOut});
				}, 0);
				FlxG.save.data.staticCode = true;
			}	 
		}
	    else if(UI_songTitle.text == 'BigShot' || UI_songTitle.text == 'bigshot')
		{
			if(FlxG.keys.justPressed.ENTER)
			{
				var videoTwo:MP4Handler = new MP4Handler();
				if(FlxG.save.data.playedOnce = true)
				{
				    videoTwo.playMP4(Paths.video('bigShot'), new MainMenuState());
				}	
				else
				{
					FlxG.switchState(new MainMenuState());	
				}		
				FlxG.save.data.playedOnce = false;
				FlxG.save.data.bigShotCode = true;
			}	 
		}
		else if(UI_songTitle.text == 'StarValley' || UI_songTitle.text == 'starvalley')
		{
			if(FlxG.keys.justPressed.ENTER)
			{
				txt3.alpha = 1;
				if(FlxG.save.data.starValleyCode)
					txt3.text = 'Already have this acheivement!';
				else
					txt3.text = 'Unlocked an acheivement!';
				new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					if(txt3.alpha == 1)
					  FlxTween.tween(txt3, {alpha: 0}, 1, {ease: FlxEase.quadInOut});
				}, 0);
				FlxG.save.data.starValleyCode = true;
			}	 
		}
		else if(FlxG.keys.justPressed.ENTER)
		{
			txt3.alpha = 1;
			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				if(txt3.alpha == 1)
			      FlxTween.tween(txt3, {alpha: 0}, 1, {ease: FlxEase.quadInOut});
			}, 0);
		}	
		if(FlxG.keys.justPressed.ESCAPE)
		{
			FlxG.switchState(new StoryMenuState());
		}	
		super.update(elapsed);
	}
}
