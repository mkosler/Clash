package clash;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.HXP;
import nme.geom.Point;
import nme.geom.Rectangle;
import clash.data.Clash;
import clash.data.ClashImage;
import clash.data.ClashSlice;

class ClashWidget extends Entity 
{
	public var clash : Clash;
	private var _style : String;
	private var _clashIndex : Int;

	private var _myPoint : Point;
	private var _myCamera : Point;

	public function new(x : Float, y : Float, clash : Clash, style : String = "Default")
	{
		super(x, y);

		_style = style;
		_clashIndex = clash.addWidget(this);
		this.clash = clash;
	}

	public override function removed() : Void
	{
		super.removed();

		clash.removeWidget(_clashIndex);
	}

	public function reskin(image : ClashImage) : Void
	{
		
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

	private function makeSliceRectangle(slice : ClashSlice) : Rectangle
	{
		return new Rectangle(slice.x, slice.y, slice.width, slice.height);
	}
}