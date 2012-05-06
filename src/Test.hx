package;

import com.haxepunk.World;
import com.haxepunk.HXP;

import clash.Button;

class Test extends World 
{
	public function new()
	{
		super();
	}

	public override function begin() : Void
	{
		add(new Button(HXP.halfWidth, HXP.halfHeight, "Test", ButtonCallback));
	}

	private function ButtonCallback() : Void
	{
		trace("In button callback");
	}
}