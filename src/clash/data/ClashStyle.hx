package clash.data;

/**
 * The style (for different visual representations of a single Clash UI widget) data object for the Clash data object
 */
class ClashStyle 
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
	public var hasSingleSlice(default, null) : Bool;

	/**
	 * @private
	 */
	public function new(name : String, x : Float, y : Float, width : Int, height : Int, slices : Array<ClashSlice>)
	{
		this.name = name;
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
		_slices = new Hash<ClashSlice>();
		hasSingleSlice = true;
		for (i in 0...slices.length) {
			var sliceName : String = slices[i].checked ? (slices[i].name + "Checked") : slices[i].name;
			_slices.set(sliceName, slices[i]);
			if (slices[i].name == "Hover" || slices[i].name == "Down") {
				hasSingleSlice = false;
			}
		}
	}

	/**
	 * @private
	 */
	public function getSlice(name : String, checked : Bool = false) : ClashSlice
	{
		if (hasSingleSlice && (name == "Hover" || name == "Down")) {
			name = "Normal";
		}
		if (_slices.exists(name)) {
			return !checked ? _slices.get(name) : _slices.get(name + "Checked");
		} else {
			trace(Std.format("Unknown slice name: ${name}"));
			return null;
		}
	}

	/**
	 * @private
	 */
	public function toString() : String
	{
		var self : String = Std.format("{name => $name, x => $x, y => $y, width => $width, height => $height}");
		var slices : String = "";
		for (slice in _slices) {
			slices += Std.format("${slice}\n");
		}
		return Std.format("$self\n$slices");
	}

	private var _slices : Hash<ClashSlice>;
}