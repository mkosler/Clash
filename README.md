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

### Future Elements

- Scrollable Text Fields;
- Listbox;
- Drop-down list;
- Handle;
- Dial;
- *and much more...*

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