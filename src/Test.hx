package;

import com.haxepunk.World;
import com.haxepunk.HXP;

import clash.Clash;
import clash.ClashParser;
import clash.Button;
import clash.Checkbox;
import clash.RadioButton;
import clash.TextInput;
import clash.Handle;

class Test extends World 
{
	private var currentClash : Clash;

	public function new()
	{
		super();

		currentClash = ClashParser.parse("assets/gfx/skins/default.clash");
	}

	public override function begin() : Void
	{
		add(new Button(10, 50, currentClash, "Press me!", ButtonCallback));
		add(new Checkbox(10, 100, currentClash, "Check me!", CheckboxCallback));

		var group1 : RadioGroup = new RadioGroup(RadioCallback);
		add(new RadioButton(10, 150, group1, currentClash, "Number 1!"));
		add(new RadioButton(10, 175, group1, currentClash, "Number 2!"));
		add(new RadioButton(10, 200, group1, currentClash, "Number 3!"));

		// add(new TextInput(HXP.halfWidth, 100, false, "Single line!"));
		// add(new TextInput(HXP.halfWidth, 200, true, "Multiline!"));

		// add(new Handle(10, 300, 100, true));
	}

	private function ButtonCallback()
	{
		trace("In ButtonCallback");
	}

	private function CheckboxCallback()
	{
		trace("In CheckboxCallback");
	}

	private function RadioCallback(id)
	{
		trace(Std.format("In RadioCallback: ${id}"));
	}
}