package format.bmfont.types;

@:structInit
class Common {
	public var lineHeight: Int;
	public var base: Int;
	public var scaleWidth: Int;
	public var scaleHeight: Int;
	public var pageCount: Int;
	public var packed: Bool;
	public var alphaChannel: Channel;
	public var redChannel: Channel;
	public var greenChannel: Channel;
	public var blueChannel: Channel;
}
