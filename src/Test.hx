package;

import com.haxepunk.World;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import clash.data.Clash;
import clash.data.ClashParser;
import clash.Button;
import clash.Checkbox;
import clash.RadioButton;
// import clash.TextInput;
import clash.Handle;

class Test extends World 
{
	private var _currentClash : Clash;

	public function new()
	{
		super();

		_currentClash = ClashParser.parse("clash/singleslice.clash");
	}

	public override function begin() : Void
	{
		add(new Button(10, 50, _currentClash, "Default", "Press me!", ButtonCallback));

		add(new Checkbox(10, 100, _currentClash, "Default", "Check me!", CheckboxCallback));

		var group1 : RadioGroup = new RadioGroup(RadioCallback);
		add(new RadioButton(10, 150, group1, _currentClash, "Default", "Number 1!"));
		add(new RadioButton(10, 175, group1, _currentClash, "Default", "Number 2!"));
		add(new RadioButton(10, 200, group1, _currentClash, "Default", "Number 3!"));

		// add(new TextInput(HXP.halfWidth, 100, false, "Single line!"));
		// add(new TextInput(HXP.halfWidth, 200, true, "Multiline!"));

		add(new Handle(10, 300, 100, _currentClash));
	}

	public override function update() : Void
	{
		super.update();

		if (Input.pressed(Key.DIGIT_1)) {
			// trace("Switching to Default");
			_currentClash.setCurrentImage("Default");
		} else if (Input.pressed(Key.DIGIT_2)) {
			// trace("Switching to Monochromatic");
			_currentClash.setCurrentImage("Monochromatic");
		} else if (Input.pressed(Key.DIGIT_3)) {
			// trace("Switching to Wooden");
			_currentClash.setCurrentImage("Wooden");
		}
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