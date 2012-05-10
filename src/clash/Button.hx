package clash;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;
import com.haxepunk.utils.Input;

import nme.geom.Rectangle;

import clash.ClashWidget;
import clash.data.Clash;
import clash.data.ClashParser;
import clash.data.ClashImage;
import clash.data.ClashSlice;
import clash.data.ClashStyle;

class Button extends ClashWidget 
{
	public var calling : Void -> Void;

	public function new(x : Float, y : Float, clash : Clash, style : String = "Default", text : String = "", calling : Void -> Void = null)
	{
		super(x, y, clash, style);

		var currentStyle : ClashStyle = clash.getElement("Button").getStyle(style);
		_normalRect = makeSliceRectangle(currentStyle.getSlice("Normal"));
		_hoverRect  = makeSliceRectangle(currentStyle.getSlice("Hover"));
		_downRect   = makeSliceRectangle(currentStyle.getSlice("Down"));

		reskin(clash.getCurrentImage());

		graphic = _normal;
		setHitboxTo(graphic);

		_label = new Text(text);
		_label.x = (width - _label.width) / 2;
		_label.y = (height - _label.height) / 2;

		this.calling = calling;
		
		_clicked = false;
	}

	public override function render() : Void
	{
		super.render();

		renderGraphic(_label);
	}

	public override function reskin(image : ClashImage) : Void 
	{
		_normal = new Image(image.path, _normalRect);
		_hover = new Image(image.path, _hoverRect);
		_down = new Image(image.path, _downRect);
	}

	public override function update() : Void
	{
		super.update();

		if (collidePoint(x, y, world.mouseX, world.mouseY)) {
			if (Input.mousePressed) {
				_clicked = true;
			}

			if (_clicked) {
				changeState(DOWN);
			} else {
				changeState(HOVER);
			}

			if (_clicked && Input.mouseReleased) {
				click();
			}
		} else {
			if (_clicked) {
				changeState(HOVER);
			} else {
				changeState(NORMAL);
			}
		}

		if (Input.mouseReleased) {
			_clicked = false;
		}
	}

	private function changeState(state : Int = 0)
	{
		switch (state) {
			case NORMAL:
				graphic = _normal;
			case HOVER:
				graphic = _hover;
			case DOWN:
				graphic = _down;
		}

	}

	private function click() : Void 
	{
		if (calling != null) {
			calling();
		}
	}
	
	private static inline var NORMAL : Int = 0;
	private var _normal : Image;
	private var _normalRect : Rectangle;
	private static inline var HOVER : Int = 1;
	private var _hover : Image;
	private var _hoverRect : Rectangle;
	private static inline var DOWN : Int = 2;
	private var _down : Image;
	private var _downRect : Rectangle;
	private var _label : Text;
	private var _clicked : Bool;
}