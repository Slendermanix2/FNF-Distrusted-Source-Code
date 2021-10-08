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

class InstructionsState extends MusicBeatState
{
	public static var leftState:Bool = false;
	public static var boyfriend:Boyfriend;
	public static var boyfriendTwo:Boyfriend;
	public static var boneBottaHit:FlxSprite;
	public static var boneBottaHitBlue:FlxSprite;
	public static var instructionFood:FlxSprite;
	public static var hitbox:FlxSprite;

	public static var needVer:String = "IDFK LOL";
	public static var currChanges:String = "dk";
	
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

		boneBottaHit = new FlxSprite(0, 175);
		boneBottaHit.frames = Paths.getSparrowAtlas('le_Boner', 'shared');
		boneBottaHit.animation.addByPrefix('boneHit', 'BoneHit', 24, true);
		boneBottaHit.updateHitbox();
		boneBottaHit.scale.x = 0.5;
		boneBottaHit.scale.y = 0.5;
		boneBottaHit.animation.play('boneHit');

		instructionFood = new FlxSprite(850, 200).loadGraphic(Paths.image('instruction_Food'));
		instructionFood.scale.x = 2;
		instructionFood.scale.y = 2;
		add(instructionFood);

		boneBottaHitBlue = new FlxSprite(0, -25);
		boneBottaHitBlue.frames = Paths.getSparrowAtlas('le_Boner_Blue', 'shared');
		boneBottaHitBlue.animation.addByPrefix('boneHit', 'BoneHit', 24, true);
		boneBottaHitBlue.updateHitbox();
		boneBottaHitBlue.scale.x = 0.5;
		boneBottaHitBlue.scale.y = 0.5;
		boneBottaHitBlue.animation.play('boneHit');

		hitbox = new FlxSprite(0,200).makeGraphic(50, 125, FlxColor.WHITE);
		hitbox.alpha = 0;

		boyfriendTwo = new Boyfriend(100, -25, 'bf');
		boyfriendTwo.playAnim('idleShit');
		boyfriendTwo.scale.x = 0.5;
		boyfriendTwo.scale.y = 0.5;

		boyfriend = new Boyfriend(100, 175, 'bf');
		boyfriend.playAnim('idleShit');
		boyfriend.scale.x = 0.5;
		boyfriend.scale.y = 0.5;
		add(boyfriend);
		add(boyfriendTwo);
		add(boneBottaHit);
		add(boneBottaHitBlue);
		add(hitbox);

		var txt:FlxText = new FlxText(0, 500, Std.int(FlxG.width * 0.4),
			"if you see a warning sign and a bone press space to dodge or you will die"
			+ "\nif the bone is blue then don't press space or you will die",
			24);

		if (MainMenuState.nightly != "")
			txt.text = 
			"You are on\n"
			+ MainMenuState.kadeEngineVer
			+ "\nWhich is a PRE-RELEASE BUILD!"
			+ "\n\nReport all bugs to the author of the pre-release.\nSpace/Escape ignores this.";
		
		txt.setFormat("VCR OSD Mono", 32, FlxColor.fromRGB(200, 200, 200));
		txt.borderColor = FlxColor.BLACK;
		txt.borderSize = 3;
		txt.borderStyle = FlxTextBorderStyle.OUTLINE;
		add(txt);

		var txt2:FlxText = new FlxText(750, 500, Std.int(FlxG.width * 0.4),
			"you will have 6 items, 1 butterscotch pie, 2 instant noodles, and 3 legendary heros,"
			+ "\nbutterscotch pie does max health, instant noodles do 3/4 health, and the legendary hero does 1/4 health"
			+ "\nif you run out of items you can't heal extra so use them wisely",
			24);

		if (MainMenuState.nightly != "")
			txt.text = 
			"You are on\n"
			+ MainMenuState.kadeEngineVer
			+ "\nWhich is a PRE-RELEASE BUILD!"
			+ "\n\nReport all bugs to the author of the pre-release.\nSpace/Escape ignores this.";
		
		txt2.setFormat("VCR OSD Mono", 24, FlxColor.fromRGB(200, 200, 200));
		txt2.borderColor = FlxColor.BLACK;
		txt2.borderSize = 3;
		txt2.borderStyle = FlxTextBorderStyle.OUTLINE;
		add(txt2);

		Conductor.changeBPM(75);
		
	}

	override function update(elapsed:Float)
	{
		new FlxTimer().start(0.01, function(tmr:FlxTimer)
		{
			if(instructionFood.y == 200) 
				FlxTween.tween(instructionFood, {y: 215}, 4, {ease: FlxEase.quadInOut});
			if(instructionFood.y == 215) 
				FlxTween.tween(instructionFood, {y: 200}, 4, {ease: FlxEase.quadInOut});
		}, 0);
		FlxTween.tween(hitbox, {x: 100}, 0.4, {ease: FlxEase.quadInOut, startDelay: 0.5});
		if (hitbox.overlaps(boyfriend))
		{
			boyfriend.playAnim("ayoWatchOut");	
		}
		if (controls.ACCEPT && MainMenuState.nightly == "")
		{
			leftState = true;
			FlxG.switchState(new MainMenuState());
		}
		else if (controls.ACCEPT)
		{
			leftState = true;
			FlxG.switchState(new MainMenuState());
		}
		super.update(elapsed);
	}
}
