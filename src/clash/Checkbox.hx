package clash;

import com.haxepunk.graphics.Image;

import nme.geom.Rectangle;

import clash.Button;
import clash.data.Clash;
import clash.data.ClashImage;
import clash.data.ClashStyle;

/**
 * A toggleable Checkbox widget
 */
class Checkbox extends Button
{
	/**
	 * The checked state of the widget
	 */
	public var checked : Bool;

	/**
	 * Constructor. Must provide a position and a Clash data object
	 * @param x 		X coordinate of the widget
	 * @param y 		Y coordinate of the widget
	 * @param clash 	Clash data object
	 * @param style 	Specifies the style, found in the Clash data object, to use. If none provided, use the "Default" style
	 * @param text 		Label of the button (Optional)
	 * @param calling 	Callback function for the widget, which is activated when the widget is changed from unchecked to checked
	 */
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

	/**
	 * Applies a new skin to the widget; called automatically when clash.setCurrentImage() is called
	 * @param 			image The new ClashImage to reskin the widget to
	 */
	public override function reskin(image : ClashImage) : Void
	{
		_normalChecked = new Image(image.path, _normalCheckedRect);
		_hoverChecked = new Image(image.path, _hoverCheckedRect);
		_downChecked = new Image(image.path, _downCheckedRect);

		super.reskin(image);
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

	private var _normalChecked : Image;
	private var _normalCheckedRect : Rectangle;
	private var _hoverChecked : Image;
	private var _hoverCheckedRect : Rectangle;
	private var _downChecked : Image;
	private var _downCheckedRect : Rectangle;
}