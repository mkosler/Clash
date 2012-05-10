package clash.data;

class ClashStyle 
{
	public var name(default, null) : String;
	public var x(default, null) : Float;
	public var y(default, null) : Float;
	public var width(default, null) : Int;
	public var height(default, null) : Int;

	public function new(name : String, x : Float, y : Float, width : Int, height : Int, slices : Array<ClashSlice>)
	{
		this.name = name;
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
		_slices = new Hash<ClashSlice>();
		for (i in 0...slices.length) {
			var sliceName : String = slices[i].checked ? (slices[i].name + "Checked") : slices[i].name;
			_slices.set(sliceName, slices[i]);
		}
	}

	public function getSlice(name : String, checked : Bool = false) : ClashSlice
	{
		if (_slices.exists(name)) {
			if (checked) return _slices.get(name + "Checked");
			else return _slices.get(name);
		} else {
			trace(Std.format("Unknown slice name: ${name}"));
			return null;
		}
	}

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