package clash;

typedef ClashContainer = Hash<Hash<Dynamic>>;
typedef Element = Hash<Dynamic>;

class Clash 
{
	public var header(default, null) : Hash<Dynamic>;
	public var images(default, null) : ClashContainer;
	public var buttons(default, null) : Element;
	public var checkboxes(default, null) : Element;
	public var radioButtons(default, null) : Element;

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
	}
}