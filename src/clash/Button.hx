package clash;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;
import com.haxepunk.utils.Input;
import nme.geom.Point;
import nme.geom.Rectangle;

class Button extends Entity 
{
	private static inline var NORMAL : Int = 0;
	private var _normal : Image;

	private static inline var HOVER : Int = 1;
	private var _hover : Image;

	private static inline var DOWN : Int = 2;
	private var _down : Image;

	private var label : Text;

	public var calling : Void -> Void;

	private var _clicked : Bool;

	private var _myPoint : Point;
	private var _myCamera : Point;

	public function new(x : Float, y : Float, text : String = "", calling : Void -> Void = null)
	{
		super(x, y);

		// At the moment, much of this is hardcoded for testing purposes
		// TODO: grab the slicing information from the most recently added Skin class
		var clipWidth : Int = 75;
		var clipHeight : Int = 30;
		_normal = new Image("gfx/testing/button.png", new Rectangle(0, clipHeight * NORMAL, clipWidth, clipHeight));
		_hover = new Image("gfx/testing/button.png", new Rectangle(0, clipHeight * HOVER, clipWidth, clipHeight));
		_down = new Image("gfx/testing/button.png", new Rectangle(0, clipHeight * DOWN, clipWidth, clipHeight));

		graphic = _normal;
		setHitboxTo(graphic);

		label = new Text(text);
		label.x = (width - label.width) / 2;
		label.y = (height - label.height) / 2;

		this.calling = calling;
		_clicked = false;
		_myPoint = HXP.point;
		_myCamera = HXP.point2;
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

	private function click() : Void 
	{
		if (calling != null) {
			calling();
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

	public override function render() : Void
	{
		super.render();

		renderGraphic(label);
	}

	private function renderGraphic(graphic : Graphic) : Void
	{
		if (graphic != null && graphic.visible) {
			if (graphic.relative) {
				_myPoint.x = x;
				_myPoint.y = y;
			} else {
				_myPoint.x = _myPoint.y = 0;
			}
			_myCamera.x = world != null ? world.camera.x : HXP.camera.x;
			_myCamera.y = world != null ? world.camera.y : HXP.camera.y;
			graphic.render(renderTarget != null ? renderTarget : HXP.buffer, _myPoint, _myCamera);
		}
	}
}