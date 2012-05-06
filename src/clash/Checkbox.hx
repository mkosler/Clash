package clash;

import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;
import nme.geom.Rectangle;
import clash.Button;

class Checkbox extends Button
{
	private static inline var CHECKED : Int = 1;

	private var _normalChecked : Image;
	private var _hoverChecked : Image;
	private var _downChecked : Image;

	public var checked : Bool;

	public function new(x : Float, y : Float, text : String = "", calling : Void -> Void = null)
	{
		super(x, y, text, calling);

		var clipWidth : Int = 20;
		var clipHeight : Int = 20;
		_normal = new Image("gfx/testing/checkbox.png",
			new Rectangle(clipWidth * Button.NORMAL, clipHeight * Button.NORMAL, clipWidth, clipHeight));
		_hover = new Image("gfx/testing/checkbox.png",
			new Rectangle(clipWidth * Button.NORMAL, clipHeight * Button.HOVER, clipWidth, clipHeight));
		_down = new Image("gfx/testing/checkbox.png",
			new Rectangle(clipWidth * Button.NORMAL, clipHeight * Button.DOWN, clipWidth, clipHeight));
		_normalChecked = new Image("gfx/testing/checkbox.png",
			new Rectangle(clipWidth * CHECKED, clipHeight * Button.NORMAL, clipWidth, clipHeight));
		_hoverChecked = new Image("gfx/testing/checkbox.png",
			new Rectangle(clipWidth * CHECKED, clipHeight * Button.HOVER, clipWidth, clipHeight));
		_downChecked = new Image("gfx/testing/checkbox.png",
			new Rectangle(clipWidth * CHECKED, clipHeight * Button.DOWN, clipWidth, clipHeight));

		graphic = _normal;

		label.x = _normal.width + 5;
		label.y = 0;

		setHitbox(_normal.width + label.width, _normal.height);

		checked = false;
	}

	private override function click() : Void
	{
		checked = !checked;

		super.click();
	}

	private override function changeState(state : Int = 0) : Void
	{
		if (checked) {
			switch (state) {
				case Button.NORMAL:
					graphic = _normalChecked;
				case Button.HOVER:
					graphic = _hoverChecked;
				case Button.DOWN:
					graphic = _downChecked;
			}
		} else {
			super.changeState(state);
		}
	}
}