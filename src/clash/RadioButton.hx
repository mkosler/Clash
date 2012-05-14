package clash;

import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;

import nme.geom.Rectangle;

import clash.Checkbox;
import clash.data.Clash;
import clash.data.ClashStyle;

/**
 * An individual radio button widget; works in concert with other radio buttons through a RadioGroup
 */
class RadioButton extends Checkbox 
{
	/**
	 * The group this widget belongs to
	 */
	public var group : RadioGroup;
	/**
	 * @private
	 */
	public var index : Int;
	/**
	 * The ID of the widget within the RadioGroup
	 */
	public var id : String;

	/**
	 * Constructor. Must provide a position, an associated RadioGroup, and a Clash data object
	 * @param x 		X coordinate of the widget
	 * @param y 		Y coordinate of the widget
	 * @param clash 	Clash data object
	 * @param style 	Specifies the style, found in the Clash data object, to use. If none provided, use the "Default" style
 	 * @param text 		Label of the button (Optional)
 	 * @param id 		The ID of the widget within the RadioGroup
	 */
	public function new(x : Float, y : Float, group : RadioGroup, clash : Clash, style : String = "Default", text : String = "", id : String = null)
	{
		super(x, y, clash, style, text);

		this.id = (id != null ? id : text);

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

	/**
	 * @private
	 */
	public override function removed() : Void
	{
		super.removed();

		group.remove(this);
	}

	private override function click() : Void
	{
		group.click(this, id);
	}
}

/**
 * A group of RadioButtons that act together to provide a value
 */
class RadioGroup 
{
	/**
	 * Function to be called when a new RadioButton is chosen
	 * @todo 			Provide more generic callback support
	 */
	public var calling : String -> Void;

	/**
	 * Constructor. Can either be initialized empty, or by giving an array of RadioButtons to associate to
	 * @param calling 	Callback function for the widget, which is activated when a new RadioButton is chosen
	 * @param buttons 	Buttons to group together using this object
	 */
	public function new(calling : String -> Void = null, buttons : Array<RadioButton> = null)
	{
		_buttons = (buttons != null ? buttons : new Array<RadioButton>());

		this.calling = calling;
	}

	/**
	 * Add an individual RadioButton to this group
	 * @param button 	A RadioButton to be added
	 * @return 			The added button
	 */
	public function add(button : RadioButton) : RadioButton
	{
		button.group = this;
		button.index = _buttons.push(button);
		return button;
	}

	/**
	 * Add an array of RadioButtons to this group
	 * @param buttons 	The array of RadioButtons to be added
	 */
	public function addArray(buttons : Array<RadioButton>) : Void
	{
		for (button in buttons) {
			add(button);
		}
	}

	/**
	 * @private
	 */
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

	/**
	 * Gets the RadioButton at a specified index
	 * @param index 	The specified index
	 * @return 			The RadioButton at this index
	 */
	public function getAt(index : Int) : RadioButton
	{
		return _buttons[index];
	}

	/**
	 * Removes a particular RadioButton from this group
	 * @param button 	The RadioButton to remove
	 * @return 			The removed RadioButton
	 */
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

	/**
	 * Clears this group of all RadioButtons
	 * @return 			An array of the removed RadioButtons
	 */
	public function removeAll() : Array<RadioButton>
	{
		return removeArray(_buttons);
	}

	/**
	 * Removes the specified array of RadioButtons
	 * @param 			buttons The array of RadioButtons to be removed
	 * @return 			An array of the removed RadioButtons
	 */
	public function removeArray(buttons : Array<RadioButton>) : Array<RadioButton>
	{
		for (button in buttons) {
			remove(button);
		}
		return buttons;
	}

	private var _buttons : Array<RadioButton>;
}