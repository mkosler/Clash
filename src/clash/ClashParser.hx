package clash;

import haxe.xml.Fast;
// #if (flash || flash9)
// import flash.xml.XML;
// import nme.filesystem.File;
// #else
// import sys.io.File;
// #end
import clash.Clash;

// typedef ClashContainer = Hash<Hash<Dynamic>>;
// typedef Element = Hash<Dynamic>;

class ClashParser 
{
	// public var clash : Fast;
	private static var _header : Hash<Dynamic> = new Hash<Dynamic>();
	
	private static var _images : ClashContainer = new ClashContainer();

	private static var _buttons : Element = new ClashContainer();
	private static var _checkboxes : Element = new ClashContainer();
	private static var _radios : Element = new ClashContainer();

	// public function new(path : String)
	// {
	// 	clash = new Fast(Xml.parse(File.getContent(path)).firstElement());

	// 	_header = new Hash<Dynamic>();

	// 	_buttons = new Element();
	// 	_checkboxes = new Element();
	// 	_radios = new Element();
	// }

	public static function parse(path : String) : Clash
	{
		var clashXML : Fast = new Fast(Xml.parse(path));
// #if (flash || flash9)
// 		var clashXML : Fast = new Fast(new XML(new File(path));
// #else
// 		var clashXML : Fast = new Fast(Xml.parse(File.getContent(path)).firstElement());
// #end

		parseHeader(clashXML);
		
		_images = parseImages(clashXML);

		for (element in clashXML.nodes.element) {
			switch (element.att.name) {
				case "Button":
					_buttons = parseElement(element);
				case "Checkbox":
					_checkboxes = parseElement(element);
				case "Radio":
					_radios = parseElement(element);
				default:
					throw Std.format("Unknown element type: ${element.att.name}");
			}
		}
		return new Clash(_header, _images, [_buttons, _checkboxes, _radios]);
	}

	public static function print() : Void
	{
		trace(Std.format("
==================
=      HEADER    =
==================

Template: ${_header}

==================
=      IMAGES    =
==================
${stringifyClashContainer(_images, \"Image\")}

==================
=     ELEMENTS   =
==================

${stringifyElement(_buttons)}
${stringifyElement(_checkboxes)}
${stringifyElement(_radios)}"));
	}

	private static function stringifyElement(element : Element) : String
	{
		var s : String = "";
		for (item in element) {
			if (!Std.is(item, String)) s += "\n" + item.toString();
		} s += "\n";
		return Std.format("Element:  {name => ${element.get(\"name\")}}
$s");
		// var s : String = "";
		// s += Std.format("Element:  {name => ${element.get(\"name\")}}\n");
		// for (item in element) {
		// 	if (!Std.is(item, String)) {
		// 		s += item.toString() + "\n";
		// 	}
		// }
		// return s;
	}

	public static function stringifyClashContainer(container : ClashContainer, title : String) : String
	{
		var s : String = "";
		for (hash in container) {
			s += Std.format("\n$title:    ${hash}");
		}
		return s;
	}

	private static function parseHeader(node : Fast) : Void
	{
		_header.set("name", node.att.name);
		_header.set("width", Std.parseInt(node.att.width));
		_header.set("height", Std.parseInt(node.att.height));
		_header.set("path", node.att.path);
	}

	private static function parseImages(node : Fast) : ClashContainer
	{
		var images : ClashContainer = new ClashContainer();
		for (image in node.nodes.image) {
			var newImage : Hash<Dynamic> = new Hash<Dynamic>();
			newImage.set("name", image.att.name);
			newImage.set("path", image.att.path);
			images.set(image.att.name, newImage);
		}
		return images;
	}

	private static function parseElement(node : Fast) : Element
	{
		var element : Element = new Element();
		element.set("name", node.att.name);
		
		if (!node.hasNode.style) {
			throw "Missing styles: all elements must have at least one style";
		}
		for (style in node.nodes.style) {
			element.set(style.att.name, parseStyle(style));
		}

		return element;
	}

	private static function parseStyle(node : Fast) : Style
	{
		var style : Style = new Style();
		style.name = node.att.name;
		style.x = Std.parseFloat(node.att.x);
		style.y = Std.parseFloat(node.att.y);
		style.width = Std.parseInt(node.att.width);
		style.height = Std.parseInt(node.att.height);

		if (!node.hasNode.slice) {
			throw "Missing slices: all element styles must include slices";
		}

		// If a slice has the checked attribute, set the name to slice_nameChecked if it is a checked slice,
		// otherwise just set the name to slice_name
		// If it does not have the checked attribute, simply set the name to slice_name
		for (slice in node.nodes.slice) {
			if (slice.has.checked) {
				style.slices.set(parseBool(slice.att.checked) ? slice.att.name + "Checked" : slice.att.name, parseSlice(slice));
			} else {
				style.slices.set(slice.att.name, parseSlice(slice));
			}
		}
		return style;
	}

	private static function parseSlice(node : Fast) : Hash<Dynamic>
	{
		var slice : Hash<Dynamic> = new Hash<Dynamic>();
		slice.set("name", node.att.name);
		slice.set("x", Std.parseFloat(node.att.x));
		slice.set("y", Std.parseFloat(node.att.y));
		slice.set("width", Std.parseInt(node.att.width));
		slice.set("height", Std.parseInt(node.att.height));
		if (node.has.checked) slice.set("checked", parseBool(node.att.checked));
		return slice;
	}

	private static function parseBool(s : String) : Bool
	{
		if (s == "true") return true;
#if (flash || flash9)
		else return false;
#else
		else if (s == "false") return false;
		else return null;
#end
	}
}

class Style 
{
	public var name : String;
	public var x : Float;
	public var y : Float;
	public var width : Int;
	public var height : Int;

	public var slices : ClashContainer;

	public function new()
	{
		slices = new ClashContainer();
	}

	public function toString() : String
	{
		var s : String = Std.format("Style:    {name => $name, x => $x, y => $y, width => $width, height => $height}");
		s += ClashParser.stringifyClashContainer(slices, "Slice");
		return s;
	}
}