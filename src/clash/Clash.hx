package clash;

import clash.ClashElement;

typedef ClashContainer = Hash<Hash<Dynamic>>;
typedef Element = Hash<Dynamic>;

class Clash 
{
	public var header(default, null) : Hash<Dynamic>;
	public var images(default, null) : ClashContainer;
	public var buttons(default, null) : Element;
	public var checkboxes(default, null) : Element;
	public var radioButtons(default, null) : Element;

	public var currentImage(default, null) : Hash<Dynamic>;
	// private var _currentImage : ClashContainer;
	// private function get_currentImage() : ClashContainer { return _currentImage; }
	// private function set_currentImage(s : String) : ClashContainer
	// {
	// 	var newImage : ClashContainer = images.get(s);
	// 	for (i in 0...clashElements.length) {
	// 		clashElements[i].reskin(newImage);
	// 	}
	// 	return newImage;
	// }

	public var clashElements : Array<ClashElement>;

	public function new(header : Hash<Dynamic>, images : ClashContainer, elements : Array<Element>)
	{
		this.header = header;
		this.images = images;
		for (i in 0...elements.length) {
			switch (elements[i].get("name")) {
				case "Buttons":
					buttons = elements[i];
				case "Checkbox":
					checkboxes = elements[i];
				case "Radio":
					radioButtons = elements[i];
			}
		}

		clashElements = new Array<ClashElement>();
		setCurrentImage("Default");
	}

	public function setCurrentImage(s : String) : Void
	{
		currentImage = images.get(s);
		for (i in 0...clashElements.length) {
			clashElements[i].reskin(currentImage);
		}
	}
}