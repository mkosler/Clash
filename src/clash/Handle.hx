package clash;

import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.TiledImage;
import com.haxepunk.utils.Input;

import nme.geom.Rectangle;

import clash.Button;
import clash.data.Clash;

class Handle extends Button
{
	// private var _currentHandle : Image;
	private var _length : Int;
	private var _leftEnd : Image;
	private var _middle : TiledImage;
	private var _rightEnd : Image;

	public function new(x : Float, y : Float, length : Int, clash : Clash, vertical : Bool = false, text : String = "", calling : Int -> Int = null)
	{
		super(x, y, clash, text);

		var clipWidth : Int = 10;
		var clipHeight : Int = 20;
		_normal = new Image("gfx/testing/handle.png",
			new Rectangle(clipWidth * (3 + Button.NORMAL), 0, clipWidth, clipHeight));
		_hover = new Image("gfx/testing/handle.png",
			new Rectangle(clipWidth * (3 + Button.HOVER), 0, clipWidth, clipHeight));
		_down = new Image("gfx/testing/handle.png",
			new Rectangle(clipWidth * (3 + Button.DOWN), 0, clipWidth, clipHeight));

		_length = length - (clipWidth * 2);

		_leftEnd = new Image("gfx/testing/handle.png",
			new Rectangle(0, 0, clipWidth, clipHeight));

		_rightEnd = new Image("gfx/testing/handle.png",
			new Rectangle(20, 0, clipWidth, clipHeight));
		_rightEnd.x = _length + clipWidth;

		_middle = new TiledImage("gfx/testing/handle.png", _length, clipHeight,
			new Rectangle(10, 0, clipWidth, clipHeight));
		_middle.x = clipWidth;

		// FIXME: Figure out how to flip vertically
		// if (vertical) {
		// 	_normal.angle = _hover.angle = _down.angle = leftEnd.angle = middle.angle = 90;
		// 	rightEnd.angle = 270;
		// 	rightEnd.y = length - clipHeight;
		// 	middle.y = clipWidth;
		// } else {
		// 	rightEnd.x = length - clipWidth;
		// 	middle.x = clipWidth;
		// }

		// FIXME: Figure out better callback
		// if (calling != null) this.calling = calling;

		graphic = _normal;
		setHitbox(length, clipHeight);
	}

	public override function update() : Void
	{
		super.update();

		var mX : Float = world.mouseX;
		if (Input.mouseDown && collidePoint(x, y, mX, Input.mouseY)) {
			trace(Std.format("mouseX: ${mX}, x: ${graphic.x}"));
			shift(mX);
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

	public override function render() : Void
	{
		super.renderGraphic(_leftEnd);
		super.renderGraphic(_middle);
		super.renderGraphic(_rightEnd);

		super.render();
	}

	private function shift(value : Float) : Void
	{
		_normal.x = value;
		_hover.x = value;
		_down.x = value;
	}
}