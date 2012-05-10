package clash;

import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;
import nme.geom.Rectangle;
import clash.Button;
import clash.Checkbox;
import clash.data.Clash;
import clash.data.ClashStyle;

class RadioButton extends Checkbox 
{
	public var group : RadioGroup;
	public var index : Int;
	public var id : String;

	public function new(x : Float, y : Float, group : RadioGroup, clash : Clash, style : String = "Default", text : String = "", id : String = null)
	{
		super(x, y, clash, style, text);

		if (id == null) {
			this.id = text;
		} else {
			this.id = id;
		}

		this.group = group;
		this.group.add(this);

		var currentStyle : ClashStyle = clash.getElement("Radio").getStyle(style);
		_normalRect = makeSliceRectangle(currentStyle.getSlice("Normal"));
		_normalCheckedRect = makeSliceRectangle(currentStyle.getSlice("Normal", true));

		_hoverRect = makeSliceRectangle(currentStyle.getSlice("Hover"));
		_hoverCheckedRect = makeSliceRectangle(currentStyle.getSlice("Hover", true));

		_downRect = makeSliceRectangle(currentStyle.getSlice("Down"));
		_downCheckedRect = makeSliceRectangle(currentStyle.getSlice("Down", true));

		reskin(clash.getCurrentImage());

		graphic = _normal;
		setHitbox(_normal.width + _label.width, _normal.height);
	}

	private override function click() : Void
	{
		group.click(this, id);
	}

	public override function removed() : Void
	{
		super.removed();

		group.remove(this);
	}
}

class RadioGroup 
{
	private var _buttons : Array<RadioButton>;
	public var calling : String -> Void;

	public function new(buttons : Array<RadioButton> = null, calling : String -> Void = null)
	{
		if (buttons != null) {
			_buttons = buttons;
		} else {
			_buttons = new Array<RadioButton>();
		}

		this.calling = calling;
	}

	public function add(button : RadioButton) : RadioButton
	{
		button.group = this;
		button.index = _buttons.push(button);
		return button;
	}

	public function addArray(buttons : Array<RadioButton>) : Void
	{
		for (button in buttons) {
			add(button);
		}
	}

	public function remove(button : RadioButton) : RadioButton
	{
		for (i in button.index..._buttons.length) {
			_buttons[i].index -= 1;
		}
		_buttons.splice(button.index, 1);
		button.group = null;
		button.index = -1;
		return button;
	}

	public function removeArray(buttons : Array<RadioButton>) : Void
	{
		for (button in buttons) {
			remove(button);
		}
	}

	public function removeAll() : Void
	{
		removeArray(_buttons);
	}

	public function getAt(index : Int) : RadioButton
	{
		return _buttons[index];
	}

	public function click(target : RadioButton, id : String) : Void
	{
		for (button in _buttons) {
			button.checked = false;
		}
		target.checked = true;

		if (calling != null) {
			calling(id);
		}
	}
}