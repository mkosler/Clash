package clash.data;

class ClashElement 
{
	public var name(default, null) : String;

	public function new(name : String, styles : Array<ClashStyle>)
	{
		this.name = name;
		_styles = new Hash<ClashStyle>();
		for (i in 0...styles.length) {
			_styles.set(styles[i].name, styles[i]);
		}
	}

	public function getStyle(name : String) : ClashStyle
	{
		if (_styles.exists(name)) return _styles.get(name);
		else {
			trace(Std.format("Unknown style name: ${name}"));
			return null;
		}
	}

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