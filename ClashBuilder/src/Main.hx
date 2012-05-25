package;

import haxe.xml.Fast;
import sys.io.File;

import clash.data.ClashParser;

typedef ArgumentFunction = Array<String> -> Void;
typedef Option = Hash<Array<String>>;

class Main
{
	function new()
	{
		var helpArg : EReg = ~/-*help/i;
		if (Sys.args().length == 0 || helpArg.match(Sys.args()[0])) {
			printHelp();
		} else {
			var mainArg : String = spliceArgs(Sys.args(), _options, _flags);
			trace(Std.format("
Main Argument: $mainArg
Options: $_options
Flags: $_flags"));
		}
	}

	public static function main()
	{
		try {
			var app = new Main();
		} catch (e : String) {
			trace(e);
		}
	}

	private static function checkExtension(path : String) 
	{
		var ext : String = haxe.io.Path.extension(path);
		if (ext != _clashExtension) {
			throw Std.format("Unknown file type: $ext; XML file must have an extension of $_clashExtension");
		} else {
			return path;
		}
	}


	private static function printHelp() : Void
	{
		trace(_help);
		Sys.exit(1);
	}

	private static function build(options : Array<String>) : Void
	{
		return null;
	}

	private static function spliceArgs(arguments : Array<String>, options : Option = null, flags : Array<String> = null) : String
	{
		var mainArg : String = arguments.shift();
		if (options != null || flags != null) {
			while (arguments.length > 0) {
				var argBuffer : String = arguments.shift();
				if (arguments.length == 0 || StringTools.startsWith(arguments[0], "-")) {
					flags.push(argBuffer);
				} else if (options != null) {
					options.set(argBuffer, spliceOptionArgs(arguments));
				}
			}
		}
		return mainArg;
	}

	private static function spliceOptionArgs(arguments : Array<String>) : Array<String>
	{
		var optionArgs : Array<String> = new Array<String>();
		while (arguments.length != 0 && !StringTools.startsWith(arguments[0], "-")) {
			optionArgs.push(arguments.shift());
		}
		return optionArgs;
	}

	private static var _help : String = File.getContent(Sys.getCwd() + "help.txt");
	private static var _clashExtension : String = "clash";
	// private static var _knownArguments : Hash<ArgumentFunction> = {
	// 	var args : Hash<ArgumentFunction> = new Hash<ArgumentFunction>();
	// 	args.set("add", null);
	// 	args.set("clear", null);
	// 	args.set("list", null);
	// 	args.set("build", null);
	// 	args.set("parse", null);
	// 	args.set("gui", null);
	// 	return args;
	// };
	private static var _options : Option = new Option();
	private static var _flags : Array<String> = new Array<String>();
}