package clash;

import com.haxepunk.Entity;
import clash.Clash;

class ClashElement extends Entity 
{
	public var clash : Clash;
	private var clashIndex : Int;

	public function new(x : Float, y : Float, clash : Clash)
	{
		super(x, y);

		clashIndex = clash.clashElements.push(this);
		this.clash = clash;
	}

	public override function removed() : Void
	{
		super.removed();

		clash.clashElements.splice(clashIndex, 1);
	}

	public function reskin(image : Hash<Dynamic>) : Void
	{
		
	}
}