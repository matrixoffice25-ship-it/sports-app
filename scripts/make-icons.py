#!/usr/bin/env python
"""Generate BUKO Network PWA icon set: dark rounded-square bg, teal husk blades (//) + white B glyph.
Output: icons/ dir next to index.html — favicon-32.png, favicon-16.png, apple-touch-icon.png (180),
pwa-192.png, pwa-512.png, maskable-512.png (with safe-zone padding)."""
import math, os
from PIL import Image, ImageDraw, ImageFont

OUT = r"C:/Users/terry/AppData/Local/hermes/projects/sports-app-staged/icons"
os.makedirs(OUT, exist_ok=True)

DARK_BG_TOP = (24, 32, 47)      # #18202F
DARK_BG_BOT = (10, 13, 21)      # #0A0D15
HUSK = (0, 229, 163)            # #00E5A3
GLYPH = (255, 255, 255)

def lerp(a, b, t):
    return tuple(int(a[i] + (b[i] - a[i]) * t) for i in range(3))

def make_bg(size, corner_ratio=0.22):
    img = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    radius = int(size * corner_ratio)
    # vertical gradient background inside rounded rect
    grad = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    gd = ImageDraw.Draw(grad)
    for y in range(size):
        gd.line([(0, y), (size, y)], fill=lerp(DARK_BG_TOP, DARK_BG_BOT, y / size))
    mask = Image.new("L", (size, size), 0)
    md = ImageDraw.Draw(mask)
    md.rounded_rectangle([0, 0, size - 1, size - 1], radius=radius, fill=255)
    img.paste(grad, (0, 0), mask)
    d = ImageDraw.Draw(img)
    d.rounded_rectangle([0, 0, size - 1, size - 1], radius=radius, outline=(255, 255, 255, 26), width=max(1, size // 100))
    return img, d

def draw_husk_blades(d, s, x0, y0, x1, y1, lean):
    """Two forward-slanted parallel blades (the // of the logo)."""
    w = (x1 - x0) * 0.38
    for i, (bx, by) in enumerate([(x0, y0), (x0 + (x1 - x0) * 0.55, y0)]):
        top = (bx, by)
        bot = (bx + lean, y1)
        half1 = (bx + w, by + lean * 0.35)
        half2 = (bx + w + lean * 0.35, y1)
        d.polygon([top, half1, half2, bot], fill=HUSK)

def draw_b_glyph(d, s, x0, y0, x1, y1):
    """Upright architectural B: vertical stem + two bowls."""
    stem_w = (x1 - x0) * 0.16
    d.rectangle([x0, y0, x0 + stem_w, y1], fill=GLYPH)
    bowl_h = (y1 - y0) * 0.46
    bowl_w = (x1 - x0) - stem_w
    # upper bowl
    d.rounded_rectangle(
        [x0, y0, x0 + stem_w + bowl_w, y0 + bowl_h],
        radius=int(bowl_h * 0.42),
        outline=GLYPH, width=max(2, s // 26), fill=(0, 0, 0, 0),
    )
    d.rectangle([x0, y0, x0 + stem_w, y0 + bowl_h], fill=GLYPH)
    # lower bowl
    d.rounded_rectangle(
        [x0, y1 - bowl_h, x0 + stem_w + bowl_w, y1],
        radius=int(bowl_h * 0.42),
        outline=GLYPH, width=max(2, s // 26), fill=(0, 0, 0, 0),
    )
    d.rectangle([x0, y1 - bowl_h, x0 + stem_w, y1], fill=GLYPH)
    # cut the middle (between bowls)
    d.rectangle([x0, y0 + bowl_h - max(1, s // 52), x0 + stem_w, y0 + bowl_h + max(1, s // 52)], fill=GLYPH)

def render(size, maskable=False):
    img, d = make_bg(size)
    pad = size * (0.30 if maskable else 0.16)
    box_h = size - 2 * pad
    blades_w = box_h * 0.30
    gap = box_h * 0.06
    glyph_w = box_h * 0.52
    total_w = blades_w + gap + glyph_w
    x_start = (size - total_w) / 2
    y0, y1 = pad, size - pad
    draw_husk_blades(d, size, x_start, y0, x_start + blades_w, y1, lean=blades_w * 0.45)
    gx = x_start + blades_w + gap
    draw_b_glyph(d, size, gx, y0, gx + glyph_w, y1)
    return img

sets = {
    "favicon-16.png": (16, False),
    "favicon-32.png": (32, False),
    "apple-touch-icon.png": (180, False),
    "pwa-192.png": (192, False),
    "pwa-512.png": (512, False),
    "maskable-512.png": (512, True),
}
for name, (size, maskable) in sets.items():
    render(size, maskable).save(os.path.join(OUT, name))
    print("wrote", name)
print("done")