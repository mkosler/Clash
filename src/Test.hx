package;

import com.haxepunk.World;
import com.haxepunk.HXP;

import clash.Button;
import clash.Checkbox;

class Test extends World 
{
	public function new()
	{
		super();
	}

	public override function begin() : Void
	{
		add(new Button(10, 50, "Press me!", ButtonCallback));
		add(new Checkbox(10, 100, "Check me!", CheckboxCallback));
	}

	private function ButtonCallback() : Void
	{
		trace("In ButtonCallback");
	}

	private function CheckboxCallback() : Void
	{
		trace("In CheckboxCallback");
	}
}