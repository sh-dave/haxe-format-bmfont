package format.bmfont.types;

@:structInit
class BitmapFont {
	public var info: Null<Info>;
	public var common: Null<Common>;
	public var pages: Map<Int, String>;
	public var chars: Map<Int, Character>;
	public var kernings: Null<Map<Int, Kerning>>;
}