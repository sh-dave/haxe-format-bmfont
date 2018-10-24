package format.bmfont;

import format.bmfont.types.*;
import haxe.io.Bytes;
import haxe.io.BytesData;
import haxe.xml.Access;

typedef ReaderError = Any;

class XmlReader {
	public static function read( data: BytesData, done: ?BitmapFont -> ?ReaderError -> Void ) {
		if (data == null) {
			done(null, 'invalid input');
			return;
		}

		var bytes = Bytes.ofData(data);
		var xml = Xml.parse(bytes.toString());
		var fast = new Access(xml);
		var f = fast.node.font;

		var fnt: BitmapFont = {
			info: f.hasNode.info ? readInfo(f.node.info) : null,
			common: f.hasNode.common ? readCommon(f.node.common) : null,
			pages: [for (p in f.node.pages.elements) _int(p.att.id) => p.att.file],
			chars: [for (c in f.node.chars.elements) _int(c.att.id) => readCharacter(c)],
			kernings: f.hasNode.kernings ? readKernings(f.node.kernings) : null,
		}

		done(fnt, null);
	}

	static function readInfo( f: Access ) : Info
		return {
			face: f.att.face,
			size: _int(f.att.size),
			bold: f.att.bold == '1',
			italic: f.att.italic == '1',
			charset: f.has.charset ? _int(f.att.charset) : 0, // TODO (DK) not a string?
			unicode: f.att.unicode == '1',
			stretchHeight: f.has.stretchH ? _int(f.att.stretchH) : 0,
			smooth: f.att.smooth == '1',
			aa: f.has.aa ? _int(f.att.aa) : 1,
			padding: readPadding(f.att.padding),
			spacing: readSpacing(f.att.spacing),
			outline: f.has.outline ? _int(f.att.outline) : 0,
		}

	static inline function readPadding( s: String ) : Padding
		return switch s.split(',').map(_int) {
			case [a]: { left: a, top: a, right: a, bottom: a }
			case [v, h]: { left: h, top: v, right: h, bottom: v }
			case [t, r, b, l]: { left: l, top: t, right: r, bottom: b }
			case _: { left: 0, top: 0, right: 0, bottom: 0 }
		}

	static inline function readSpacing( s: String ) : Spacing
		return switch s.split(',').map(_int) {
			case [a]: { horizontal: a, vertical: a }
			case [h, v]: { horizontal: h, vertical: v }
			case _: { horizontal: 0, vertical: 0 }
		}

	static function readCommon( f: Access ) : Common
		return {
			lineHeight: _int(f.att.lineHeight),
			base: _int(f.att.base),
			scaleWidth: _int(f.att.scaleW),
			scaleHeight: _int(f.att.scaleH),
			pageCount: _int(f.att.pages),
			packed: f.att.packed == '1',
			alphaChannel: f.att.packed == '1' ? f.has.alphaChnl ? _int(f.att.alphaChnl) : 0 : 0,
			redChannel: f.att.packed == '1' ? f.has.redChnl ? _int(f.att.redChnl) : 0 : 0,
			greenChannel: f.att.packed == '1' ? f.has.greenChnl ? _int(f.att.greenChnl) : 0 : 0,
			blueChannel: f.att.packed == '1' ? f.has.blueChnl ? _int(f.att.blueChnl) : 0 : 0,
		}

	static inline function readCharacter( c: Access ) : Character
		return {
			id: _int(c.att.id),
			x: _int(c.att.x),
			y: _int(c.att.y),
			width: _int(c.att.width),
			height: _int(c.att.height),
			xOffset: _int(c.att.xoffset),
			yOffset: _int(c.att.yoffset),
			xAdvance: _int(c.att.xadvance),
			pageId: _int(c.att.page),
			channel: _int(c.att.chnl)
		}

	static inline function readKernings( f: Access )
		return [for (k in f.elements) _int(k.att.first) => readKerning(k)];

	static inline function readKerning( k: Access ) : Kerning
		return {
			toCharacter: _int(k.att.second),
			amount: _int(k.att.amount)
		}

	static inline function _int( s: String ) : Null<Int>
		return Std.parseInt(s);
}
