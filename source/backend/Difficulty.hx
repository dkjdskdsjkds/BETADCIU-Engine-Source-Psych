package backend;

class Difficulty
{
	public static final defaultList:Array<String> = [
		'Easy',
		'Normal',
		'Hard'
	];
	public static var guestList:Array<String> = [
		'Snow The Fox', 
		"spres", 
		'AjTheFunky', 
		"LiterallyNoOne", 
		'Lylace', 
		'Tactical Cupcakes', 
		'Chxwy', 
		'Mewrk'
	];

	private static final defaultDifficulty:String = 'Normal'; //The chart that has no postfix and starting difficulty on Freeplay/Story Mode

	public static var list:Array<String> = [];

	inline public static function getFilePath(num:Null<Int> = null)
	{
		if(num == null) num = PlayState.storyDifficulty;

		var filePostfix:String = list[num];
		if(filePostfix != null && Paths.formatToSongPath(filePostfix) != Paths.formatToSongPath(defaultDifficulty))
			filePostfix = '-' + filePostfix;
		else
			filePostfix = '';
		return Paths.formatToSongPath(filePostfix);
	}

	public static function difficultyString():String
	{
		var guestNumber:Int = 0;

		if (PlayState.storyDifficulty == 5)
		{
			switch (PlayState.SONG.song.toLowerCase())
			{
				case 'epiphany' | 'bonedoggle': guestNumber = 0;
				case "rabbit's-luck": guestNumber = 1;
				case "arch": guestNumber = 2;
				case 'ghost-vip': guestNumber = 3;
				case 'you-cant-run': guestNumber = 4;
				case "its-complicated": guestNumber = 5;
				case "buildstroll": guestNumber = 6;
				case 'ballistic': guestNumber = 7;
			}

			return guestList[guestNumber];
		}
		else
			return defaultList[PlayState.storyDifficulty];
	}

	inline public static function loadFromWeek(week:WeekData = null)
	{
		if(week == null) week = WeekData.getCurrentWeek();

		var diffStr:String = week.difficulties;
		if(diffStr != null && diffStr.length > 0)
		{
			var diffs:Array<String> = diffStr.trim().split(',');
			var i:Int = diffs.length - 1;
			while (i > 0)
			{
				if(diffs[i] != null)
				{
					diffs[i] = diffs[i].trim();
					if(diffs[i].length < 1) diffs.remove(diffs[i]);
				}
				--i;
			}

			if(diffs.length > 0 && diffs[0].length > 0)
				list = diffs;
		}
		else resetList();
	}

	inline public static function resetList()
	{
		list = defaultList.copy();
	}

	inline public static function copyFrom(diffs:Array<String>)
	{
		list = diffs.copy();
	}

	inline public static function getString(?num:Null<Int> = null, ?canTranslate:Bool = true):String
	{
		var diffName:String = list[num == null ? PlayState.storyDifficulty : num];
		if(diffName == null) diffName = defaultDifficulty;
		return canTranslate ? Language.getPhrase('difficulty_$diffName', diffName) : diffName;
	}

	inline public static function getDefault():String
	{
		return defaultDifficulty;
	}
}