package clash.data;

class ClashSlice 
{
	public var name(default, null) : String;
	public var x(default, null) : Float;
	public var y(default, null) : Float;
	public var width(default, null) : Int;
	public var height(default, null) : Int;
	public var checked(default, null) : Bool;

	public function new(name : String, x : Float, y : Float, width : Int, height : Int, checked : Bool = false)
	{
		this.name = name;
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
		this.checked = checked;
	}

	public function toString() : String
	{
		return Std.format("{name => $name, x => $x, y => $y, width => $width, height => $height, checked => $checked}");
	}
}