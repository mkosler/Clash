package clash.data;

import clash.ClashWidget;

/**
 * The main Clash data object; there must be at least one of these in your project in order to use
 * Clash
 */
class Clash 
{
	/**
	 * The version of Clash used for this object
	 */
	public var version(default, null) : String;

	/**
	 * The name of the Clash file
	 */
	public var name(default, null) : String;

	/**
	 * The width of all associated images
	 */
	public var width(default, null) : Int;

	/**
	 * The height of all associated images
	 */
	public var height(default, null) : Int;

	/**
	 * Constructor. Do not call this directly; rather, populate this object through ClashParser.parse(path)
	 * @param version The version of Clash used for this object
	 * @param name 			The name of the Clash file
	 * @param width 		The width of all associated images
	 * @param height 		The height of all associated images
	 * @param images 		The data for the associated images
	 * @param elements 		The data for the associated Clash UI elements/widgets
	 * @param currentImage 	The initial skin to be used
	 */
	public function new(version : String, name : String, width : Int, height : Int, images : Array<ClashImage>, elements : Array<ClashElement>, currentImage : String = "Default")
	{
		this.version = version;
		this.name = name;
		this.width = width;
		this.height = height;
		_images = new Hash<ClashImage>();
		for (i in 0...images.length) {
			_images.set(images[i].name, images[i]);
		}
		_currentImage = _images.get(currentImage);

		_elements = new Hash<ClashElement>();
		for (i in 0...elements.length) {
			_elements.set(elements[i].name, elements[i]);
		}

		_widgets = new Array<ClashWidget>();
	}

	/**
	 * @private
	 */
	public function addWidget(widget : ClashWidget) : Int
	{
		return _widgets.push(widget);
	}

	/**
	 * Gets the current skin being used
	 * @return The current skin being used
	 */
	public function getCurrentImage() : ClashImage
	{
		return _currentImage;
	}

	/**
	 * @private
	 */
	public function getElement(name : String) : ClashElement
	{
		if (_elements.exists(name)) return _elements.get(name);
		else {
			trace("Unknown element name: " + name);
			return null;
		}
	}

	/**
	 * @private
	 */
	public function getImage(name : String) : ClashImage
	{
		if (_images.exists(name)) return _images.get(name);
		else {
			trace("Unknown image name: " + name);
			return null;
		}
	}

	/**
	 * @private
	 */
	public function removeWidget(index : Int) : Void
	{
		_widgets.splice(index, 1);
	}

	/**
	 * Changes the current skin to the specified skin name
	 * @param name The new skin to be used
	 */
	public function setCurrentImage(name : String) : Void
	{
		_currentImage = _images.get(name);
		for (i in 0..._widgets.length) {
			_widgets[i].reskin(_currentImage);
		}
	}

	private var _images : Hash<ClashImage>;	
	private var _currentImage : ClashImage;
	private var _elements : Hash<ClashElement>;
	private var _widgets : Array<ClashWidget>;
}