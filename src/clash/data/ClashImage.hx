package clash.data;

class ClashImage
{
	public var name(default, null) : String;
	public var path(default, null) : String;

	public function new(name : String, path : String)
	{
		this.name = name;
		this.path = path;
	}

	public function toString() : String
	{
		return Std.format("{name => $name, path => $path}");
	}
}