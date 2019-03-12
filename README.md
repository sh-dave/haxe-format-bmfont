# haxe-format-bmfont

Reader for various kinds of bitmapfont files.

## supported file formats

- [BMFont](http://www.angelcode.com/products/bmfont) (xml)
- [Littera](http://kvazars.com/littera) (xml)

## usage with rendering example

(Doesn't do any fancy stuff like kerning etc...)

```haxe
package;

import format.bmfont.types.BitmapFont;
import format.bmfont.XmlReader;
import kha.graphics2.Graphics;

using Main.G2BitmapFontExtension;

class G2BitmapFontExtension {
    public static function drawBMFString( g: Graphics, font: BitmapFont, pages: Array<kha.Image>, x, y, text: String )
        for (i in 0...text.length) {
            var cc = text.charCodeAt(i);
            var char = font.chars.get(cc);

            g.drawSubImage(
                pages[char.pageId],
                x + char.xOffset, y + char.yOffset,
                char.x, char.y, char.width, char.height
            );

            x += char.width;
        }
}

class Main {
    public static function main()
        kha.System.start({}, function( _ ) kha.Assets.loadEverything(init));

    static function init()
        var fnt = XmlReader.read(Xml.parse(kha.Assets.blobs.SomeFont_fnt.toString());
        var pages = [kha.Assets.images.SomeFont_0];
        
        kha.System.notifyOnFrames(function( fbs ) {
            var fb = fbs[0];
            var g2 = fb.g2;

            g2.begin();
                g2.drawBMFString(fnt, pages, 16, 16, 'hello bmfont world!');
            g2.end();
        });
}
```
