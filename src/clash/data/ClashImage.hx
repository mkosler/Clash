package clash.data;

/**
 * The image data object for the Clash data object
 */
class ClashImage
{
	/**
	 * @private
	 */
	public var name(default, null) : String;

	/**
	 * @private
	 */
	public var path(default, null) : String;

	/**
	 * @private
	 */
	public function new(name : String, path : String)
	{
		this.name = name;
		this.path = path;
	}

	/**
	 * @private
	 */
	public function toString() : String
	{
		return Std.format("{name => $name, path => $path}");
	}
}