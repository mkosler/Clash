package clash.data;

/**
 * The slice (image state) data object for the Clash data object
 */
class ClashSlice 
{
	/**
	 * @private
	 */
	public var name(default, null) : String;

	/**
	 * @private
	 */
	public var x(default, null) : Float;

	/**
	 * @private
	 */
	public var y(default, null) : Float;

	/**
	 * @private
	 */
	public var width(default, null) : Int;

	/**
	 * @private
	 */
	public var height(default, null) : Int;

	/**
	 * @private
	 */
	public var checked(default, null) : Bool;

	/**
	 * @private
	 */
	public function new(name : String, x : Float, y : Float, width : Int, height : Int, checked : Bool = false)
	{
		this.name = name;
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
		this.checked = checked;
	}

	/**
	 * @private
	 */
	public function toString() : String
	{
		return Std.format("{name => $name, x => $x, y => $y, width => $width, height => $height, checked => $checked}");
	}
}