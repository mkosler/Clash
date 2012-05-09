#if flash
import flash.xml;
#else
import sys.io.File;
#end
import haxe.xml.Fast;

class SomethingStupid
{
	public function new()
	{
		var xml = Xml.parse(File.read("test.xml", false).readAll().toString());	
		var image : Fast = new Fast(xml.firstElement());
		trace(image.att.name);		// Test Image
		trace(image.att.width);		// 640
		trace(image.att.height);	// 480
		trace(image.att.path);		// gfx/testing/testImage.png
		for (section in image.nodes.section) {
			parseSection(section);
		}
	}

	private function parseSection(section : Fast) : Void
	{
		trace(section.att.name);	// Button, Checkbox, Radiobutton
		trace(section.att.x);		// 0, 0, 0
		trace(section.att.y);		// 0, 0, 0
		trace(section.att.width);	// 75, 40, 40
		trace(section.att.height);	// 90, 60, 40
		if (section.hasNode.group) {
			for (group in section.nodes.group) {
				parseGroup(group);
			}
		} else {
			for (slice in section.nodes.slice) {
				parseSlice(slice);
			}
		}
	}

	private function parseGroup(group : Fast) : Void
	{
		trace(group.att.checked);	// true, false
		for (slice in group.nodes.slice) {
			parseSlice(slice);
		}
	}

	private function parseSlice(slice : Fast) : Void
	{
		trace(slice.att.name);
		trace(slice.att.x);
		trace(slice.att.y);
		trace(slice.att.width);
		trace(slice.att.height);
	}

	public static function main()
	{
		var app = new Main();
	}
}