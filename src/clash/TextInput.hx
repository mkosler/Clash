package clash;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Text;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import nme.events.KeyboardEvent;
import clash.ClashElement;

class TextInput extends ClashElement 
{
	public var text(get_text, set_text) : String;
	private var _text : String;
	public function get_text() : String { return _text; }
	public function set_text(text : String) : String
	{
		_text = text;
		textGraphic.text = text;

		setHitbox(textGraphic.textWidth, textGraphic.textHeight);

		return text;
	}

	private var textGraphic : Text;
	private var _multiline : Bool;
	public static var focus : TextInput;

	public function new(x : Float = 0, y : Float = 0, clash : Clash, multiline : Bool = false, text : String = "")
	{
		super(x, y, clash);

		textGraphic = new Text(text);
		textGraphic.resizable = true;
		this.text = text;
		_multiline = multiline;
		graphic = textGraphic;

		type = "textinput";
	}

	public override function update() : Void
	{
		super.update();

		if (TextInput.focus == this) {
			textGraphic.color = 0xC4DCF4;
		} else {
			textGraphic.color = 0xFFFFFF;
		}

		if (Input.mousePressed) {
			if (collidePoint(x, y, world.mouseX, world.mouseY)) {
				TextInput.focus = this;
				Input.keyString = "";
			} else if (world.collidePoint("textinput", world.mouseX, world.mouseY) == null) {
				TextInput.focus = null;
			}
		}

		if (TextInput.focus == this && Input.keyString != "") {
			this.text += Input.keyString;
			Input.keyString = "";
		}
	}

	public override function added() : Void
	{
		super.added();

		HXP.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
	}

	private function onKeyDown(e : KeyboardEvent) : Void
	{
		if (world != HXP.world) return;
		if (TextInput.focus != this) return;
		
		switch (e.keyCode) {
			case Key.BACKSPACE:
				text = _text.substr(0, _text.length - 1);
			case Key.ENTER:
				if (_multiline) text += '\n';
		}
	}

	public override function removed() : Void
	{
		super.removed();

		HXP.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
	}
}