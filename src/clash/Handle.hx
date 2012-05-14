package clash;

import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.TiledImage;

import nme.geom.Rectangle;

import clash.Button;
import clash.data.Clash;
import clash.data.ClashImage;
import clash.data.ClashStyle;

class Handle extends Button
{
	public function new(x : Float, y : Float, length : Int, clash : Clash, style : String = "Default", vertical : Bool = false, text : String = "", calling : Int -> Int = null)
	{
		// Since I need to figure out _length for reskin(), I need to find it before I call super(), since super() calls reskin()
		var currentStyle : ClashStyle = clash.getElement("Handle").getStyle(style);
		_leftEndRect = makeSliceRectangle(currentStyle.getSlice("Left"));
		_rightEndRect = makeSliceRectangle(currentStyle.getSlice("Right"));
		_middleRect = makeSliceRectangle(currentStyle.getSlice("Middle"));

		_length = length - Std.int(_leftEndRect.width + _rightEndRect.width);

		super(x, y, clash, style, text);

		_normalRect = makeSliceRectangle(currentStyle.getSlice("Normal"));
		_hoverRect = makeSliceRectangle(currentStyle.getSlice("Hover"));
		_downRect = makeSliceRectangle(currentStyle.getSlice("Down"));

		reskin(clash.getCurrentImage());

		graphic = _normal;
		setHitbox(length, _normal.height);
	}

	public override function render() : Void
	{
		super.renderGraphic(_leftEnd);
		super.renderGraphic(_middle);
		super.renderGraphic(_rightEnd);

		super.render();
	}

	public override function reskin(image : ClashImage) : Void
	{
		super.reskin(image);

		_leftEnd = new Image(image.path, _leftEndRect);
		_middle = new TiledImage(image.path, _length, Std.int(_middleRect.height), _middleRect);
		_rightEnd = new Image(image.path, _rightEndRect);
		_middle.x = _leftEnd.width;
		_rightEnd.x = _leftEnd.width + _middle.width;
	}

	public override function update() : Void
	{
		super.update();

		if (_clicked) {
			shift(clamp(world.mouseX - x, _leftEnd.x, _leftEnd.x + (width - _rightEnd.width)));
		}
	}

	private override function changeState(state : Int = 0) : Void
	{
		switch (state) {
			case Button.NORMAL:
				graphic = _normal;
			case Button.HOVER:
				graphic = _hover;
			case Button.DOWN:
				graphic = _down;
		}
	}

	private function shift(value : Float) : Void
	{
		_normal.x = value;
		_hover.x = value;
		_down.x = value;
	}

	private var _length : Int;
	private var _leftEnd : Image;
	private var _leftEndRect : Rectangle;
	private var _middle : TiledImage;
	private var _middleRect : Rectangle;
	private var _rightEnd : Image;
	private var _rightEndRect : Rectangle;
	private var _follow : Bool;
}