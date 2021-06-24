# Print3r

## Introduction

**Print3r** is a command-line tool (without GUI) to print 3d parts (.gcode, .stl, .scad) to 3d printers, utilizing a slicer of your choice (Slic3r, Slic3r PE, PrusaSlicer, CuraEngine (3.5.0), CuraEngine4 (4.2.0 or later) , CuraEngine-Legacy).

### Examples
```
print3r --printer=prusa-i3 print cube.scad
print3r --printer=ender3 --device=/dev/ttyUSB1 print cube.stl
print3r preview cube.gcode
```

### Main Features
- **print** `.scad`, `.stl`\* or `.gcode` to 3d printers
- **slice** `.scad` or `.stl`\* saving `.gcode` without printing
- **preprocess parts** with `--scale=<x>,<y>,<z>`, `--rotate=<x>,<y>,<z>`, `--translate=<x>,<y>,<z>`, `--random-placement`, `--auto-center`, `--multiply-part=<n>`
- **use slicer-independent arguments** like `--temperature=<c>`, `--layer-height=<h>`, `--fill-density=<f>`, `--perimeters=<n>`, etc.
- **send Gcode** from command line arguments with **gcode** or console interactively with **gconsole** command
- **render Gcode** and sliced .stl, .scad into `.png` image with **render** command
- **preview Gcode** using `yagv` Gcode viewer with **preview** command

\*) `.stl` (ascii & binary), and preliminary `.amf` and `.obj` supported as well.

## Changelog
- 0.3.5: experimental support for --slicer=cura-slicer & 5dmaker
- 0.3.4: --cols=<n> and --rows=<n> in case --multiply-part is used
- 0.3.3: experimental support for `--slicer=mandoline` added
- 0.3.2: experimental support for `--slicer=slicer4rtn` added
- 0.3.0: better pipeline of processing div. formats, preliminary 3mf and 3mj (new format) support
- 0.2.8: CuraEngine-4.2.0 support via `--slicer=cura4`, see wiki for install instructions
- 0.2.6: cleaner script-layer within Gcode processing, slic3r-*: better multi-extruder support `--toolmap` & `--toolremap`
- 0.2.5: preliminary `--slicer=prusa` support, additional inline functions support for gcode transformation: `&toolcolor(n,a,b,c,d,e)`, `&hsl2cmy(h,s,l)`, `&phases(n=2|3,p=3|4)`
- 0.2.3: support for `--prepend_gcode=...` for start-gcode addition, and `--layer-gcode=...`
- 0.2.2: support for `skirts`, `brims` and `rafts`, `support` and `seam` slicer-independent
- 0.2.0: `client` command added, and `--device=tcp:<remote-ip>[:<n>]` added for remote printing capabilities
- 0.1.8: proper cleanup of temporary files (incl. CTRL-C abort)
- 0.1.7: more slicer-independent speed settings (`print/travel/infill/perimeter/small_perimeter/bridge/retract_speed`)
- 0.1.6: restructure the file layout of settings (e.g. at `/usr/share/print3r` & `~/.config/print3r/`) 
- 0.1.5: new option `--scad=<code>` to additionally execute openscad code
- 0.1.4: various improvements, remap() of general settings to slice-specific settings via `.../<slicer>/map.ini`
- 0.1.1: better support for `--slicer=cura` and `cura-legacy`
- 0.1.0: `--slicer=<slicer>` with `--printer=<profile>` leads to `../<slicer>/<profile>`, `@<setting>` leads to `settings/macro/<setting>`
- 0.0.9: preliminary `.amf` and `.obj` native support for preprocessing (scale,rotate,translate,mirror)
- 0.0.8: absolute scaling like `--scale=0,0,30mm` or `--scale=50mm`, and `--scale=50%` same as `--scale=0.5`, `--auto-center` to center print
- 0.0.7: `PRINT3R` enviromental variable considered, `'baudrate=auto'` probes baudrate.
- 0.0.6: publically released source on github

### To Do / Planned
- ~~slicer agnostic, e.g. support of CuraEngine (just the slicer)~~: done since 0.1.6 with `slic3r`, `slic3r-pe`, `cura-legacy` and `cura`
- ~~network connectivity, distributed printing via tcp/ip~~: done since 0.2.0 with `client` command and `--device=tcp:<remote-ip>[:<n>]` (n=0 (default),1,2 etc)
- ~~preview gcode in OpenGL/WebGL zoomable views~~: done with 0.1.6 via external [`yagv` viewer](https://github.com/Spiritdude/yagv)
- multiple extruder support (preferably slicer-independent)

## Platform
Primary focus in on **Linux** (Debian, Ubuntu) and alike platforms like FreeBSD and such.

## Requirements
- install `openscad`, see [OpenSCAD.org](http://www.openscad.org/)
- install `slic3r`, Debian/Ubuntu: `apt install slic3r`
- optional:
  - recommended: [install Slic3r PE](https://github.com/Spiritdude/Print3r/wiki/Print3r:-Slic3r-&-Slic3r-PE)
  - recommended: [install CuraEngine](https://github.com/Spiritdude/Print3r/wiki/Print3r:-Cura)
  - [install CuraEngine Legacy](https://github.com/Spiritdude/Print3r/wiki/Print3r:-Cura-Legacy)

## License
The software is licensed under GPLv3 

## Download
```
git clone https://github.com/Spiritdude/Print3r
cd Print3r
```
## Install
```
make requirements
make install
```

### Printer Configurations
See [Profiles](https://github.com/Spiritdude/Print3r/wiki/Print3r:-Profiles) how to setup a dedicated printer profile.

## Usage
```
Print3r (print3r) 0.2.0 USAGE: [<options>] <cmd> <file1> [<...>]

   options:
      --verbose or -v or -vv  increase verbosity
      --quiet or -q           no output except fatal errors
      --baudrate=<n>          set baudrate, default: 115200
      --device=<d>            set device, default: /dev/ttyUSB0
      --slicer=<slicer>       set slicer, default: slic3r
                                 slic3r, slic3r-pe, prusa, cura-legacy, cura
      --printer=<name>        config of printer, default: default
      --version               display version and exit
      --output=<file>         define output file for 'slice' and 'render' command
      --scad                  consider all arguments as actual OpenSCAD code (not files)
      --scadlib=<files>       define OpenSCAD files separated by "," or ":"
      part preprocessing:
         --random-placement   place print randomly on the bed
         --auto-center        place print in the center
         --multiply-part=<n>  multiply part(s)
            --rows=<n>           define rows for multiplied parts
            --cols=<n>           define cols for multiplied parts
         --scale=<x>,<y>,<z>     scale part x,y,z (absolute if 'mm' is appended)
         --scale=<f>             scale part f,f,f
         --rotate=<x>,<y>,<z>    rotate x,y,z
         --translate=<x>,<y>,<z> translate x,y,z
         --mirror=<x>,<y>,<z>    mirror x,y,z (0=keep, 1=mirror)
      --<key>=<value>         include any valid slicer option (e.g. slic3r --help)

   commands:
      print <file> [...]      print (convert & slice & print) part(s) (.scad, .stl, .obj, .gcode)
      slice <file> [...]      slice file(s) to gcode (.scad, .stl, .amf, .obj, .3mf)
      preview <file> [...]    slice & preview (.scad, .stl, .obj, .gcode)
      render <file> [...]     render an image (use '--output=sample.png' or so)
      gcode <code1> [...]     send gcode lines
      gconsole                start gcode console
      client                  map USB connected printer to network (per device)
      help

   examples:
      export PRINT3R "printer=my_printer" --OR-- setenv PRINT3R "printer=my_printer"
      print3r slice cube.stl
      print3r --layer-height=0.2 --output=test.gcode slice cube.stl
      print3r --printer=ender3 --device=/dev/ttyUSB1 print test.gcode
      print3r --printer=corexy --device=/dev/ttyUSB2 --layer-height=0.3 --fill-density=0 print cube.stl
      print3r --printer=ender3 --device=tcp:192.168.0.2 --layer-height=0.25 print cube.stl
      print3r print cube.scad
      print3r --scad print "cube(20)"
      print3r gcode 'G28 X Y' 'G1 X60' 'G28 Z'
      print3r gconsole
      == Print3r: Gcode Console (gconsole) - use CTRL-C or 'exit' or 'quit' to exit
         for valid Gcode see https://reprap.org/wiki/G-code
         conf: device /dev/ttyUSB0, connected
      > M115
      ...

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
export PRINT3R "printer=prusa-i3:temperature=190:..."
print3r print cube.scad
```

## Render Example
Instead to actually print parts, you can also let them render into .png image as well (e.g. for documentation purposes or preview):
```
print3r --output=benchy.png render 3DBenchy.stl
```
![](https://raw.githubusercontent.com/Spiritdude/Print3r/master/examples/benchy.png)

## See Also
- **[Print3r Wiki](https://github.com/Spiritdude/Print3r/wiki)**, detailed documentation
- [Spiritdude's Public Notebook: Print3r](https://spiritdude.wordpress.com/tag/print3r/)

