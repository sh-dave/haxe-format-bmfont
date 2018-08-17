package format.bmfont.types;

@:structInit
class Character {
	public var id: Int; // could be dropped
	public var x: Int;
	public var y: Int;
	public var width: Int;
	public var height: Int;
	public var xOffset: Int;
	public var yOffset: Int;
	public var xAdvance: Int;
	public var pageId: Int;
	public var channel: Channel;
}
