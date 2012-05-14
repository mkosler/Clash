package clash;

import com.haxepunk.HXP;
import com.haxepunk.graphics.Text;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

import nme.events.KeyboardEvent;

import clash.ClashWidget;
import clash.data.Clash;

/**
 * A rewritable text field widget
 */
class TextInput extends ClashWidget 
{
	/**
	 * The current text in the field
	 */
	public var text(get_text, set_text) : String;
	public function get_text() : String { return _text; }
	public function set_text(text : String) : String
	{
		_text = text;
		_textGraphic.text = text;

		setHitbox(_textGraphic.textWidth, _textGraphic.textHeight);

		return text;
	}

	/**
	 * Constructor. Must provide a position and a Clash data object
	 * @param x 		X coordinate of the widget
	 * @param y 		Y coordinate of the widget
	 * @param clash 	Clash data object
	 * @param style 	Specifies the style, found in the Clash data object, to use. If none provided, use the "Default" style
	 * @param multiline Allows for multiple lines to be input; initialized to false if not specified
 	 * @param text 		Text in the field when first initialized (Optional)
	 */
	public function new(x : Float = 0, y : Float = 0, clash : Clash, style : String = "Default", multiline : Bool = false, text : String = "")
	{
		super(x, y, clash, style);

		_textGraphic = new Text(text);
		_textGraphic.resizable = true;

		this.text = text;
		
		_multiline = multiline;
		
		graphic = _textGraphic;

		type = "textinput";
	}

	/**
	 * @private
	 */
	public override function added() : Void
	{
		super.added();

		HXP.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
	}

	/**
	 * @private
	 */
	public override function removed() : Void
	{
		super.removed();

		HXP.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
	}

	/**
	 * Updates the widget; if overridden, the super must be called; otherwise the widget will not work
	 */
	public override function update() : Void
	{
		super.update();

		if (TextInput.focus == this) {
			_textGraphic.color = 0xC4DCF4;
		} else {
			_textGraphic.color = 0xFFFFFF;
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

	private var _text : String;
	private var _textGraphic : Text;
	private var _multiline : Bool;	
	public static var focus : TextInput;
}