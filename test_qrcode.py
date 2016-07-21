# -*- coding: utf-8 -*-

import qrcode
import qrcode.image.pil

factory = qrcode.image.pil.PilImage


im = qrcode.make('44261604275237', image_factory=factory)

print im.format, im.size, im.mode

im.save('44261604275237.png')
