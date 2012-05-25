package clash.data;

/**
 * The element/widget data object for the Clash data object
 */
class ClashElement 
{
	/**
	 * @private
	 */
	public var name(default, null) : String;

	/**
	 * @private
	 */
	public function new(name : String, styles : Array<ClashStyle>)
	{
		this.name = name;
		_styles = new Hash<ClashStyle>();
		for (i in 0...styles.length) {
			_styles.set(styles[i].name, styles[i]);
		}
	}

	/**
	 * @private
	 */
	public function getStyle(name : String) : ClashStyle
	{
		if (_styles.exists(name)) return _styles.get(name);
		else {
			trace(Std.format("Unknown style name: ${name}"));
			return null;
		}
	}

	/**
	 * @private
	 */
	public function toString() : String
	{
		var self : String = Std.format("{name => $name}");
		var styles : String = "";
		for (style in _styles) {
			styles += Std.format("${style}\n");
		}
		return Std.format("$self\n$styles");
	}

	private var _styles : Hash<ClashStyle>;
}