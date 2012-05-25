package clash.data;

import haxe.xml.Fast;
#if nme
import nme.Assets;
#else
import sys.io.File;
#end
import clash.data.Clash;

/**
 * A static object that parses the .clash files for the Clash data object
 */
class ClashParser 
{
	/**
	 * Parse the .clash file into a Clash data object
	 * @param path Path to the .clash file
	 * @return A new Clash data object
	 */
	public static function parse(path : String) : Clash
	{
#if nme
		var clashXML : Fast = new Fast(Xml.parse(Assets.getText(path)));
		clashXML = clashXML.node.clash;
#else
		var clashXML : Fast = new Fast(Xml.parse(File.getContent(path)).firstElement());
#end
		var version : String = clashXML.att.version;
		var name : String = clashXML.att.name;
		var width : Int = Std.parseInt(clashXML.att.width);
		var height : Int = Std.parseInt(clashXML.att.height);

		return new Clash(version, name, width, height, parseImages(clashXML), parseElements(clashXML));
	}

	private static function parseElements(node : Fast) : Array<ClashElement>
	{
		if (!node.hasNode.element) {
			throw "Missing elements: a .clash file must have elements to correspond to Clash widgets";
		}
		var elements : Array<ClashElement> = new Array<ClashElement>();
		for (element in node.nodes.element) {
			elements.push(new ClashElement(element.att.name, parseStyles(element)));
		}
		return elements;
	}

	private static function parseImages(node : Fast) : Array<ClashImage>
	{
		var images : Array<ClashImage> = new Array<ClashImage>();
		for (image in node.nodes.image) {
			images.push(new ClashImage(image.att.name, image.att.path));
		}
		return images;
	}

	private static function parseSlices(node : Fast) : Array<ClashSlice>
	{
		if (!node.hasNode.slice) {
			throw "Missing slices: each style must have slices to correspond with the images";
		}
		var slices : Array<ClashSlice> = new Array<ClashSlice>();
		for (slice in node.nodes.slice) {
			if (slice.has.checked) {
				slices.push(
					new ClashSlice(
						slice.att.name,
						Std.parseFloat(slice.att.x),
						Std.parseFloat(slice.att.y),
						Std.parseInt(slice.att.width),
						Std.parseInt(slice.att.height),
						slice.att.checked == "true" ? true : false));
			} else {
				slices.push(
					new ClashSlice(
						slice.att.name,
						Std.parseFloat(slice.att.x),
						Std.parseFloat(slice.att.y),
						Std.parseInt(slice.att.width),
						Std.parseInt(slice.att.height)));
			}
		}
		return slices;
	}

	private static function parseStyles(node : Fast) : Array<ClashStyle>
	{
		if (!node.hasNode.style) {
			throw "Missing styles: each element must have at least one (a default) style";
		}
		var styles : Array<ClashStyle> = new Array<ClashStyle>();
		for (style in node.nodes.style) {
			styles.push(
				new ClashStyle(
					style.att.name,
					Std.parseFloat(style.att.x),
					Std.parseFloat(style.att.y),
					Std.parseInt(style.att.width),
					Std.parseInt(style.att.width),
					parseSlices(style)));
		}
		return styles;
	}
}