package;

import haxe.xml.Fast;
import sys.io.File;

class ClashParser 
{
	public var clash : Xml;
	public var clashData : Array<Hash<Dynamic>>;

	// private static var _headAttr    : Array<String> = ["name", "width", "height"];
	// private static var _imageAttr   : Array<String> = ["name", "path"];
	// private static var _sectionAttr : Array<String> = ["name", "x", "y", "width", "height", "path"];
	// private static var _sliceAttr   : Array<String> = ["name", "x", "y", "width", "height", "checked"];

	public function new(path : String)
	{
		clash = Xml.parse(File.getContent(path)).firstElement();
		clashData = new Array<Hash<Dynamic>>();
	}

	public function parse() : Void
	{
		clash = parseNode(clash);	// Parse the header (clash) element
	}

	private function parseNode(node : Xml) : Xml
	{
		var data : Hash<Dynamic> = new Hash<Dynamic>();
		data.set("title", node.nodeName);

		for (attribute in node.attributes()) {
			if (attribute == "name") {	// Ugly hack to stop the -nan business
				data.set(attribute, node.get(attribute));
			} else if (Std.parseFloat(node.get(attribute)) != null ||
				Std.parseFloat(node.get(attribute)) != 0) {
				data.set(attribute, Std.parseFloat(node.get(attribute)));
			} else if (parseBool(node.get(attribute)) != null) {
				data.set(attribute, parseBool(node.get(attribute)));
			} else {
				data.set(attribute, node.get(attribute));
			}
		}

		clashData.push(data);
		return node;
	}

	public function print() : Void
	{
		for (i in 0...clashData.length) {
			switch (clashData[i].get("title")) {
				case "clash":
					trace("Template");
				default:
					// TODO: Add more stuff
			}
			printData(clashData[i]);
		}
	}

	private function printData(data : Hash<Dynamic>) : Void
	{
		for (key in data.keys()) {
			trace(Std.format("${key} : ${data.get(key)}"));
		}
	}

	// private function parseNode(node : Fast, attr : Array<String>) : Fast
	// {
	// 	var data : Hash<Dynamic> = new Hash<Dynamic>();
	// 	data.set("title", node.name);

	// 	// Loop through the given attributes, checking to see if they exist
	// 	for (i in 0...attr.length) {
	// 		var attrib : String = attr[i];
	// 		if (node.has.attrib) {
	// 			// Attempt to make a float or boolean out of the attribute, and store it
	// 			// If both fail, it must be a string, so store it as so
	// 			var param : String = node.att.attr[i];
	// 			if (Std.parseFloat(param) != null || Std.parseFloat(param) != 0) {
	// 				data.set(param, Std.parseFloat(param));
	// 			} else if (parseBool(param) != null) {
	// 				data.set(param, parseBool(param));
	// 			} else {
	// 				data.set(param, param);
	// 			}
	// 		}
	// 		else {
	// 			trace(Std.format("Skipping ${attr[i]}"));
	// 		}
	// 	}

	// 	clashData.push(data);
	// 	return node;
	// }

	// private function parseHead(head : Fast) : Void
	// {
	// 	var data : Hash<Dynamic> = new Hash<Dynamic>();
	// 	data.set("title", head.name);
	// 	data.set("name", head.att.name);
	// 	data.set("width", Std.parseInt(head.att.width));
	// 	data.set("height", Std.parseInt(head.att.height));
	// 	clashData.push(data);
	// 	if (head.hasNode.image) {
	// 		for (image in head.nodes.image) {
	// 			parseImage(image);
	// 		}
	// 	}
	// }

	// private function parseImage(image : Fast) : Void
	// {
	// 	var data : Hash<Dynamic> = new Hash<Dynamic>();
	// 	data.set("title", 
	// }

	private function parseBool(s : String) : Bool
	{
		if (s == "true") return true;
		else if (s == "false") return false;
		else return null;
	}
}