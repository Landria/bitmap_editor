# Bitmap editor

Module **BitmapEditor** is for image bitmap processing. It converts given instructions into an image.

Ruby v2.3.4


# Commands

There are 6 supported commands:

1. **I N M** - Create a new M x N image with all pixels coloured white (O).
2. **C** - Clears the table, setting all pixels to white (O).
3. **L X Y C** - Colours the pixel (X,Y) with colour C.
4. **V X Y1 Y2 C** - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
5. **H X1 X2 Y C** - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
6. **S** - Show the contents of the current image

# Installation

    $ git clone git@github.com:Landria/bitmap_editor.git

    $ cd bitmap_editor && bundle install

# Runnings specs

```
rspec spec
```

# Running

    $ bin/bitmap_editor examples/show.txt
