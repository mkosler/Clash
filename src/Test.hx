package;

import com.haxepunk.World;
import com.haxepunk.HXP;

import clash.Button;
import clash.Checkbox;
import clash.RadioButton;
import clash.TextInput;

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

		var group1 : RadioGroup = new RadioGroup(RadioCallback);
		add(new RadioButton(10, 150, group1, "Number 1!"));
		add(new RadioButton(10, 175, group1, "Number 2!"));
		add(new RadioButton(10, 200, group1, "Number 3!"));

		add(new TextInput(HXP.halfWidth, 100, false, "Single line!"));
		add(new TextInput(HXP.halfWidth, 200, true, "Multiline!"));
	}

	private function ButtonCallback() : Void
	{
		trace("In ButtonCallback");
	}

	private function CheckboxCallback() : Void
	{
		trace("In CheckboxCallback");
	}

	private function RadioCallback(id : String) : Void
	{
		trace(Std.format("In RadioCallback: ${id}"));
	}
}