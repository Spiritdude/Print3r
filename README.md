# Print3r

## Introduction

**Print3r** is a command-line tool (without GUI) to print 3d parts (.gcode, .stl, .scad) to 3d printers, utilizing a slice of your choice (Slic3r, Slic3r PE, CuraEngine, CuraEngine-Legacy).

### Examples
```
print3r print cube.gcode
print3r print cube.stl
print3r print cube.scad
```

### Main Features
- **print** `.scad`, `.stl`\* or `.gcode` to 3d printers
- **slice** `.scad` or `.stl`\* saving `.gcode` without printing
- **preprocess parts** with `--scale=<x>,<y>,<z>`, `--rotate=<x>,<y>,<z>`, `--translate=<x>,<y>,<z>`, `--random-placement`, `--auto-center`, `--multiply-part=<n>`
- **use slicer-independent arguments** like `--temperature=<c>`, `--layer-height=<h>`, `--fill-density=<f>`, `--perimeters=<n>`, etc.
- **send Gcode** from command line arguments or console interactively
- **render Gcode** and sliced .stl, .scad into `.png` image

\*) `.stl` (ascii & binary), and preliminary `.amf` and `.obj` supported as well.

## Changelog
- 0.1.6: restructure the file layout of settings (e.g. at /usr/share/print3r & ~/.config/print3r/) 
- 0.1.5: new option '--scad=<code>' to additionally execute openscad code
- 0.1.4: various improvements, remap() of general settings to slice-specific settings via settings/<slicer>/map.ini
- 0.1.1: better support for '--slicer=cura' and 'cura-legacy'
- 0.1.0: '--slicer=<slicer>' with '--printer=<profile>' leads to settings/<slicer>/<profile>, '@<setting>' leads to 'settings/<setting>'
- 0.0.9: preliminary `.amf` and `.obj` native support for preprocessing (scale,rotate,translate,mirror)
- 0.0.8: absolute scaling like `--scale=0,0,30mm` or `--scale=50mm`, and `--scale=50%` same as `--scale=0.5`, `--auto-center` to center print
- 0.0.7: `PRINT3R` enviromental variable considered, `'baudrate=auto'` probes baudrate.
- 0.0.6: publically released source on github

### To Do / Planned
- slicer agnostic, e.g. support of CuraEngine (just the slicer)
- network connectivity, distributed printing via tcp/ip
- preview gcode in OpenGL/WebGL zoomable views

## Platform
Primary focus in on **Linux** (Debian, Ubuntu) and alike platforms like FreeBSD and such.

## Requirements
- install `openscad`, see [OpenSCAD.org](http://www.openscad.org/)
- install `slic3r`, Debian/Ubuntu: `apt install slic3r`
- optional:
  - recommended: [install Slic3r PE](https://github.com/Spiritdude/Print3r/wiki/Print3r:-Slic3r-&-Slic3r-PE)
  - recommended: [install CuraEngine](https://github.com/Spiritdude/Print3r/wiki/Print3r:-Cura)
  - [install CuraEngine Legacy](https://github.com/Spiritdude/Print3r/wiki/Print3r:-Cura-Legacy)
- run `make requirements` to install required Perl modules & Perl GD.pm with libgd

## License
The software is licensed under GPLv3 

## Install

```
make install
```

### Printer Configurations
See [Profiles](https://github.com/Spiritdude/Print3r/wiki/Print3r:-Profiles) how to setup a dedicated printer profile.

## Usage
```
```

## More Examples
```
print3r --fill-density=0 --layer-height=0.2 print cube.scad
print3r --print-center=100,100 print cube.scad
print3r --printer=ender3.ini --device=/dev/ttyUSB1 --random-placement --rotate=45,0,0 print cube.scad
print3r --multiply-part=3 --scale=50% print cube.scad
```

### Scaling Parts
```
print3r --scale=2 print cube.scad
print3r --scale=1,4,0.5 print cube.scad
print3r --scale=30% print cube.scad
print3r --scale=50mm print cube.scad
print3r --scale=0,0,30mm print 3DBenchy.stl
```

### Environment Variable `PRINT3R`
You can set any option into PRINT3R environment variable, "&lt;key&gt;=&lt;value&gt;", combined with ":", like:
```
export PRINT3R "printer=prusa-i3.ini:temperature=190:..."
print3r print cube.scad
```

## Render Example
Instead to actually print parts, you can also let them render into .png image as well (e.g. for documentation purposes or preview):
```
print3r --output=benchy.png render 3DBenchy.stl
```
![](https://raw.githubusercontent.com/Spiritdude/Print3r/master/examples/benchy.png)

## See Also
- [Print3r Github Wiki](https://github.com/Spiritdude/Print3r/wiki)
- [Spiritdude's Public Notebook: Print3r](https://spiritdude.wordpress.com/tag/print3r/)

