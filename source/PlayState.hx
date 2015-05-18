package;

import flixel.addons.ui.FlxInputText;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.text.FlxTextField;
import flixel.tile.FlxTilemap;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxDestroyUtil;
using flixel.util.FlxSpriteUtil;


class PlayState extends FlxState
{
	
	private var _shipBack:FlxSprite;
	private var _ship:Ship;
	private var _bigShip:FlxTilemap;
	private var _txtSeed:FlxText;
	private var _txtColorSeed:FlxText;
	private var _seed:FlxInputText;
	private var _colorSeed:FlxInputText;
	private var _btnRandomize:FlxButton;
	
	override public function create():Void
	{
		bgColor = 0xff111111;
		
		_shipBack = new FlxSprite();
		_shipBack.makeGraphic(18,18,0xffffffff);
		_shipBack.drawRect(1, 1, 16, 16, 0xffcccccc);
		_shipBack.setPosition(FlxG.width - 24, 8);
		add(_shipBack);
		
		_btnRandomize = new FlxButton(0, 0, "Build", randomize);
		_btnRandomize.x = _shipBack.x - _btnRandomize.width - 8;
		_btnRandomize.y = 8;
		add(_btnRandomize);
		
		_txtSeed = new FlxText(8, 8, 0, "Ship:", 8);
		_txtSeed.color = 0xffffffff;
		add(_txtSeed);
		
		_seed = new FlxInputText(36, 8, 64, randomSeed(), 10, 0xff111111, 0xffffffff);
		_seed.fieldBorderThickness = 1;
		_seed.fieldBorderColor = 0xffcccccc;
		_seed.lines = 1;
		_seed.maxLength = 9;
		_seed.forceCase = FlxInputText.UPPER_CASE;
		_seed.customFilterPattern = ~/[^a-fA-F0-9]*/g;
		_seed.filterMode = FlxInputText.CUSTOM_FILTER;
		_seed.caretColor = 0xff111111;
		_seed.caretWidth = 2;
		add(_seed);
		
		_txtColorSeed = new FlxText(_seed.x + 66, 8, 0, "Color:", 8);
		_txtColorSeed.color = 0xffffffff;
		add(_txtColorSeed);
		
		_colorSeed = new FlxInputText(0, 8, 64, randomSeed(), 10, 0xff111111, 0xffffffff);
		_colorSeed.x = _btnRandomize.x - 64 - 8;
		_colorSeed.fieldBorderThickness = 1;
		_colorSeed.fieldBorderColor = 0xffcccccc;
		_colorSeed.lines = 1;
		_colorSeed.maxLength = 9;
		_colorSeed.forceCase = FlxInputText.UPPER_CASE;
		_colorSeed.customFilterPattern = ~/[^a-fA-F0-9]*/g;
		_colorSeed.filterMode = FlxInputText.CUSTOM_FILTER;
		_colorSeed.caretColor = 0xff111111;
		_colorSeed.caretWidth = 2;
		add(_colorSeed);
		
		_seed.hasFocus = true;
		
		
		randomize();
		
		super.create();
	}
	
	private function randomSeed():String
	{
		var s:String = '';
		for (i in 0...8)
		{
			s += StringTools.hex(FlxG.random.int(0, 15));
		}
		return s;
	}
	
	
	private function randomize():Void
	{
		if (_ship != null)
		{
			_ship.kill();
			members.remove(_ship);
			_ship = FlxDestroyUtil.destroy(_ship);
		}
		if (_bigShip != null)
		{
			_bigShip.kill();
			members.remove(_bigShip);
			_bigShip = FlxDestroyUtil.destroy(_bigShip);
		}
		_ship = new Ship();
		_ship.generate(Std.parseInt('0x' + _seed.text));
		_ship.setPosition(_shipBack.x + 3, _shipBack.y + 3);
		add(_ship);
		_bigShip = new FlxTilemap();
		_bigShip.loadMapFrom2DArray(_ship.definition, AssetPaths.ship_tiles__png, 16, 16);
		_bigShip.setPosition(8, _seed.y + _seed.height + 8);
		add(_bigShip);
	}
	
	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
