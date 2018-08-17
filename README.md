# haxe-format-bmfont

Parser for [Angelcode's Bitmap Font Generator](http://www.angelcode.com/products/bmfont)

# usage

```haxe
    import format.bmfont.types.*;

    var bytesData = ...; // load the xml font file somehow

    format.bmfont.XmlReader.read(bytesData, function( ?fnt: BitmapFont, ?err ) {
        // do stuff with `fnt`, or handle the error
    });
```

# simple rendering example using [Kha](https://github.com/Kode/Kha.git)

(Doesn't do any fancy stuff like kerning etc...)

```haxe
package;

import format.bmfont.types.BitmapFont;
import format.bmfont.XmlReader;
import kha.graphics2.Graphics;

using Main.G2BitmapFontExtension;

class G2BitmapFontExtension {
    public static function drawBMFString( g: Graphics, font: BitmapFont, x, y, text: String )
        for (i in 0...text.length) {
            var cc = text.charCodeAt(i);
            var char = font.chars.get(cc);

            g.drawSubImage(
                kha.Assets.images.SomeFont_0,
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
        XmlReader.read(kha.Assets.blobs.SomeFont_fnt.bytes.getData(), function( ?fnt, ?err ) {
            if (err) {
                trace(err);
                return;
            }

            kha.System.notifyOnFrames(function( fbs ) {
                var fb = fbs[0];
                var g2 = fb.g2;

                g2.begin();
                    g2.drawBMFString(fnt, 16, 16, 'hello bmfont world!');
                    g2.drawBMFString(fnt, 16, 128, '!world bmfont hello');
                g2.end();
            });
        });
}
```
