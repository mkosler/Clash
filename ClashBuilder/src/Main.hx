package;

import haxe.xml.Fast;
import sys.io.File;

import ClashParser;

class Main 
{
	private static var help : String = File.getContent(Sys.getCwd() + "help.txt");
	private static var clashExtension : String = "clash";

	private function new(args : Array<String>)
	{
		// for (i in 0...args.length) {
		// 	trace(Std.format("$i: ${args[i]}"));
		// }

		if (args[0] == null) {
			// Start GUI interface without a starting file
		} else {
			switch(args[0]) {
				case "add":
				case "clear":
				case "list":
				case "build":
				case "parse":
					ClashParser.parse(checkExtension(sys.FileSystem.fullPath(args[1])));
					ClashParser.print();
					// var parser : ClashParser = new ClashParser(checkExtension(sys.FileSystem.fullPath(args[1])));
					// parser.parse();
					// parser.print();
				case "gui":
				default:
					trace(Std.format("Unknown option argument: ${args[0]}"));
					printHelp();
			}
		}
	}

	private function checkExtension(path : String) 
	{
		var ext : String = haxe.io.Path.extension(path);
		if (ext != clashExtension) {
			throw Std.format("Unknown file type: $ext; XML file must have an extension of $clashExtension");
		} else {
			return path;
		}
	}

	public static function main()
	{
		try {
			var app : Main = new Main(Sys.args());
		} catch (e : String) {
			trace(e);
			printHelp();
		}
	}

	public static function printHelp() : Void
	{
		trace(help);
		Sys.exit(1);
	}
}