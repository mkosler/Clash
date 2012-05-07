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

So simple, that it can even be done using the command line. Here is an theoretical example:

	clashbuilder path/to/new/skin/bitmap template.clashtemplate

which will output an XML file: `newskin.clash` in the same directory as your bitmap. You can also create a new template from a pre-existing XML file:

	clashbuilder new path/to/newskin.clash

which will output a template `newskin.clashtemplate`.

### ClashBuilder GUI

Using the GUI is more time-consuming, but it allows you to have more freedom when building your bitmaps. Here, you load up your bitmap into ClashBuilder, then are able to visually select and annotate areas to represent different elements of your skin. When done, simply export the information to create a new `.clash` file.