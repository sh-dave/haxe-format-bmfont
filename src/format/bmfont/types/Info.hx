package format.bmfont.types;

@:structInit
class Info {
	public var face: String;
	public var size: Int;
	public var bold: Bool;
	public var italic: Bool;
	public var charset: Int;
	public var unicode: Bool;
	public var stretchHeight: Int;
	public var smooth: Bool;
	public var aa: Int;
	public var padding: Padding;
	public var spacing: Spacing;
	public var outline: Int;
}
