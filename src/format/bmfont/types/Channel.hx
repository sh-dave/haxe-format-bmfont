package format.bmfont.types;

@:enum abstract Channel(Int) from Int to Int {
	var Glyph = 0;
	var Outline = 1;
	var EncodedGlyphAndOutline = 2;
	var Zero = 3;
	var One = 4;
}
