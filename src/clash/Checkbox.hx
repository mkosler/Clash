package clash;

import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;
import nme.geom.Rectangle;
import clash.Button;
import clash.data.Clash;
import clash.data.ClashImage;
import clash.data.ClashStyle;

class Checkbox extends Button
{
	private static inline var CHECKED : Int = 1;

	private var _normalChecked : Image;
	private var _normalCheckedRect : Rectangle;
	private var _hoverChecked : Image;
	private var _hoverCheckedRect : Rectangle;
	private var _downChecked : Image;
	private var _downCheckedRect : Rectangle;

	public var checked : Bool;

	public function new(x : Float, y : Float, clash : Clash, style : String = "Default", text : String = "", calling : Void -> Void = null)
	{
		super(x, y, clash, style, text, calling);

		var currentStyle : ClashStyle = clash.getElement("Checkbox").getStyle(style);
		_normalRect = makeSliceRectangle(currentStyle.getSlice("Normal"));
		_normalCheckedRect = makeSliceRectangle(currentStyle.getSlice("Normal", true));

		_hoverRect = makeSliceRectangle(currentStyle.getSlice("Hover"));
		_hoverCheckedRect = makeSliceRectangle(currentStyle.getSlice("Hover", true));
		
		_downRect = makeSliceRectangle(currentStyle.getSlice("Down"));
		_downCheckedRect = makeSliceRectangle(currentStyle.getSlice("Down", true));

		reskin(clash.getCurrentImage());

		graphic = _normal;

		_label.x = _normal.width + 5;
		_label.y = 0;

		setHitbox(_normal.width + _label.width, _normal.height);

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

	public override function reskin(image : ClashImage) : Void
	{
		_normalChecked = new Image(image.path, _normalCheckedRect);
		_hoverChecked = new Image(image.path, _hoverCheckedRect);
		_downChecked = new Image(image.path, _downCheckedRect);

		super.reskin(image);
	}
}