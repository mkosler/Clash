package clash.data;

import clash.ClashWidget;

class Clash 
{
	public var version(default, null) : String;
	public var name(default, null) : String;
	public var width(default, null) : Int;
	public var height(default, null) : Int;
	private var _images : Hash<ClashImage>;
	private var _currentImage : ClashImage;
	private var _elements : Hash<ClashElement>;
	private var _widgets : Array<ClashWidget>;

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

	public function getImage(name : String) : ClashImage
	{
		if (_images.exists(name)) return _images.get(name);
		else {
			trace("Unknown image name: " + name);
			return null;
		}
	}

	public function getElement(name : String) : ClashElement
	{
		if (_elements.exists(name)) return _elements.get(name);
		else {
			trace("Unknown element name: " + name);
			return null;
		}
	}

	public function getCurrentImage() : ClashImage
	{
		return _currentImage;
	}

	public function setCurrentImage(name : String) : Void
	{
		_currentImage = _images.get(name);
		for (i in 0..._widgets.length) {
			_widgets[i].reskin(_currentImage);
		}
	}

	public function addWidget(widget : ClashWidget) : Int
	{
		return _widgets.push(widget);
	}

	public function removeWidget(index : Int) : Void
	{
		_widgets.splice(index, 1);
	}
}