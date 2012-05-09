package clash;

import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;
import nme.geom.Rectangle;
import clash.Button;
import clash.Checkbox;

class RadioButton extends Checkbox 
{
	public var group : RadioGroup;
	public var index : Int;
	public var id : String;

	public function new(x : Float, y : Float, group : RadioGroup, text : String = "", id : String = null)
	{
		super(x, y, text);

		if (id == null) {
			this.id = text;
		} else {
			this.id = id;
		}

		this.group = group;
		this.group.add(this);

		var clipWidth : Int = 20;
		var clipHeight : Int = 20;
		_normal = new Image("gfx/testing/radiobutton.png",
			new Rectangle(clipWidth * Button.NORMAL, clipHeight * Button.NORMAL, clipWidth, clipHeight));
		_hover = new Image("gfx/testing/radiobutton.png",
			new Rectangle(clipWidth * Button.NORMAL, clipHeight * Button.HOVER, clipWidth, clipHeight));
		_down = new Image("gfx/testing/radiobutton.png",
			new Rectangle(clipWidth * Button.NORMAL, clipHeight * Button.DOWN, clipWidth, clipHeight));
		_normalChecked = new Image("gfx/testing/radiobutton.png",
			new Rectangle(clipWidth * Checkbox.CHECKED, clipHeight * Button.NORMAL, clipWidth, clipHeight));
		_hoverChecked = new Image("gfx/testing/radiobutton.png",
			new Rectangle(clipWidth * Checkbox.CHECKED, clipHeight * Button.HOVER, clipWidth, clipHeight));
		_downChecked = new Image("gfx/testing/radiobutton.png",
			new Rectangle(clipWidth * Checkbox.CHECKED, clipHeight * Button.DOWN, clipWidth, clipHeight));

		graphic = _normal;
		setHitbox(_normal.width + _label.width, _normal.height);
	}

	private override function click() : Void
	{
		trace("In RadioButton.Click");
		
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