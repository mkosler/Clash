package clash;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.HXP;

import nme.geom.Point;
import nme.geom.Rectangle;

import clash.data.Clash;
import clash.data.ClashImage;
import clash.data.ClashSlice;

/**
 * The Clash UI widget superclass
 */
class ClashWidget extends Entity 
{
	/**
	 * The currently associated Clash data object
	 */
	public var clash : Clash;

	/**
	 * Constructor. You do not call this directly; rather individual widgets will call this in their constructors
	 * @param x 		X coordinate of the widget
	 * @param y 		Y coordinate of the widget
	 * @param clash 	Clash data object
	 * @param style 	Specifies the style, found in the Clash data object, to use. If none provided, use the "Default" style
	 */
	public function new(x : Float, y : Float, clash : Clash, style : String = "Default")
	{
		super(x, y);

		_style = style;
		_clashIndex = clash.addWidget(this);
		this.clash = clash;

		_myPoint = HXP.point;
		_myCamera = HXP.point2;
	}

	public override function removed() : Void
	{
		super.removed();

		clash.removeWidget(_clashIndex);
	}

	/**
	 * Applies a new skin to the widget; called automatically when clash.setCurrentImage() is called
	 * @param 			image The new ClashImage to reskin the widget to
	 */
	public function reskin(image : ClashImage) : Void
	{
		
	}

	private function clamp(value : Float, lower : Float, upper : Float) : Float
	{
		return Math.min(Math.max(value, lower), upper);
	}

	private function makeSliceRectangle(slice : ClashSlice) : Rectangle
	{
		return new Rectangle(slice.x, slice.y, slice.width, slice.height);
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

	private var _style : String;
	private var _clashIndex : Int;
	private var _myPoint : Point;	
	private var _myCamera : Point;
}