package clash;

import com.haxepunk.Entity;
import clash.data.Clash;
import clash.data.ClashImage;

class ClashWidget extends Entity 
{
	public var clash : Clash;
	private var _style : String;
	private var _clashIndex : Int;

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
}