# Clash: A HaxePunk UI project

Clash is a skinnable UI for the [HaxePunk](http://www.haxepunk.com) game engine. It's main purpose is to provide an easy and efficient way to reskin a UI using the internal ClashBuilder tool. Simply create a bitmap or bitmaps with the skins of your UI elements, upload the files into the ClashBuilder tool, and you'll be given an XML file that you import, along with your bitmaps, to have Clash instantly reskin itself, without the need to hard code any of this information in the source files of your project.


## Clash UI

*Note: Most of the initial beta of Clash UI is nearly complete.*

The Clash UI is an easy to use graphical user interface library for HaxePunk projects. It uses simple syntax, and leverages the power of the HaxePunk game engine to provide instant usability.

Currently, Clash consists of:

- Button;
- Checkbox;
- Radio Button;
- Text Input (single line or multiline);

### Future Widgets

- Scrollable Text Fields;
- Listbox;
- Drop-down list;
- Handle;
- Dial;
- *and much more...*

### Using Clash UI => Getting Started

Using Clash UI in your project is fairly simple, with added simplicity coming down the pipeline in future updates. Currently, you will need to have a full copy of the Clash UI source code (src/ in this Github repository) included in your project.

Additionally, you will need to add the following line to your build.nmml file:

	<assets path="assets/CLASH_DIR" rename="clash" type="clash" include="*.clash" />

Change `CLASH_DIR` to the path to your .clash files inside your assets directory. This allows non-native (Flash/JS) NME targets to have access to the .clash files.

Finally, in the world in which you want your Clash UI widgets to appear, create a private variable and initialize it using ClashParser.

	import clash.data.Clash;
	import clash.data.ClashParser;
	import clash.Button;
	// ...

	class TestWorld extends World
	{
		private var clash : Clash;

		public function new()
		{
			clash = ClashBuilder.parse("CLASH_DIR/default.clash");
			add(new Button(50, 50, clash, "Default", "Clash Button"));
			// ...
		}
	}

And that's all you need. No need to hard code dimensions of your images, or paths, or figure out the clipRect for an individual element from a larger sheet. Clash does the tedious work for you. You can also easily switch between different images (associated with that particular .clash file) easily:

	clash.setCurrentImage("Monochromatic");

This will change from the Default skin associated with the .clash file to the included Monochromatic skin.

Included in this repository are three example skins - **Default, Monochromatic, and Wooden** - and their associated .clash file - **default.clash**. You can also download an **example** through the Download link here on Github, or [play the online Flash example here](http://dl.dropbox.com/u/49569739/ClashUIExample.swf) to see Clash UI working. To change between the three different skins, press 1 for *Default*, 2 for *Monochromatic*, and 3 for *Wooden*.

## ClashBuilder

*Note: ClashBuilder, on the other hand, will take some time to get working correctly; much of the following is more theoretical and a roadmap*

ClashBuilder is a simple tool that allows for the creation new skins in two ways: *following a template*, or *using a graphical interface to create your own.*

### ClashBuilder Templates

Following a template is the quickest way to get started with a new skin. A template is simply a previously mapped bitmap using ClashBuilder. As long as your bitmap follows the same structure as the template (i.e. the buttons are in the same position in their file, aligned the same way, in the same order, etc.), then making a new skin for Clash UI is very easy.

This portion can be done using the command line:

	ClashBuilder Command Line Interface - Michael Kosler (http://www.github.com/mkosler)

	Usage: neko ClashBuilder.n [OPTIONS] [.clash file] {add : images}
	Brackets designate an optional argument. If add option is used, images go at the end of the
	arguments.

	Running with no options will load the GUI interface; otherwise, you must designate a .clash file
	to use the command line interface.

	Options:
	  add [images] : Adds new images to the current .clash file
	  clear        : Removes all linked images from the current .clash file
	  list         : Lists the currently linked images on the current .clash file
	  build        : brings up an interactive CLI to hand build the .clash file
	  gui          : Loads the GUI interface, and opens the current .clash file

	Examples:
	  neko ClashBuilder.n                         : Launches the GUI interface
	  neko ClashBuilder.n add test.clash test.png : Adds test.png to the test.clash
	  neko ClashBuilder.n clear test.clash        : Removes all linked images from test.clash
	  neko ClashBuilder.n gui test.clash          : Loads the GUI interface and opens test.clash

### ClashBuilder GUI

Using the GUI is more time-consuming, but it allows you to have more freedom when building your bitmaps. Here, you load up your bitmap into ClashBuilder, then are able to visually select and annotate areas to represent different elements of your skin. When done, simply export the information to create a new `.clash` file.

*Clash is based off these [tutorials](http://active.tutsplus.com/tutorials/games/how-to-make-ui-components-for-flashpunk-games/), which we in turn based off the [PunkUI](http://flashpunk.net/forums/index.php?topic=1415.0) project for the [FlashPunk](http://flashpunk.net/) game engine.*