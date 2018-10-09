# Print3r

## Introduction

Print3r is a command-line tool (without GUI) to print 3d parts (.gcode, .stl, .scad) to 3d printer(s).

### Main Features

Print `.gcode`, `.stl` and `.scad` files to USB connected 3d printers.

### Examples
```
print3r print cube.gcode
print3r print cube.stl
print3r print cube.scad
```

## Changelog
- 0.0.8: absolute scaling like `--scale=0,0,30mm` or `--scale=50mm`, and `--scale=50%` same as `--scale=0.5`, '--auto-center' to center print
- 0.0.7: `PRINT3R` enviromental variable considered, `'baudrate=auto'` probes baudrate.
- 0.0.6: publically released source on github

### To Do / Planned
- slicer agnostic, e.g. support of CuraEngine (just the slicer)
- network connectivity, distributed printing via tcp/ip
- preview gcode in OpenGL/WebGL zoomable views

## Platform
Primary focus in on Linux (Debian, Ubuntu) and alike platforms like FreeBSD and such.

## Requirements
- install `openscad`, see [OpenSCAD.org](http://www.openscad.org/)
- install `slic3r`, Debian/Ubuntu: `apt install slic3r`
- run `make requirements` to install required Perl modules & Perl GD.pm with libgd

## License
The software is licensed under GPLv3 

## Install

```
make install
```

### Printer Configurations
In order to use slicing and printing command `print3r` requires Slic3r printer configuration:
- run `slic3r` GUI and configure your printer(s) using the wizard
- export the configuration (e.g. `my_printer.ini`)
- reference it with `--printer=my_printer.ini` or rename it as `default.ini` or reference it in `PRINT3R` environment variable `export PRINT3R "printer=my_printer.ini:..."`

## Usage
```
Print3r (print3r) 0.0.8 USAGE: [<options>] <cmd> <file1> [<...>]

   options:
      --verbose or -v or -vv  increase verbosity
      --quiet or -q           no output except fatal errors
      --baudrate=<n>          set baudrate, default: 115200
      --device=<d>            set device, default: /dev/ttyUSB0
      --printer=<config.ini>  slic3r config of printer, default: ashtar-k-40x30.ini
      --version               display version and exit
      --output=<file>         define output file for 'slice' and 'render' command
      slice-only:
         --random-placement   place print randomly on the bed
         --auto-center        place print in the center
         --multiply-part=<n>  multiply part(s)
         --scale=<x>,<y>,<z>     scale part x,y,z (absolute if 'mm' is appended)
         --scale=<f>             scale part f,f,f
         --rotate=<x>,<y>,<z>    rotate x,y,z
         --translate=<x>,<y>,<z> translate x,y,z
         --mirror=<x>,<y>,<z>    mirror x,y,z (0=keep, 1=mirror)
         --<key>=<value>      include any valid slic3r option (slic3r --help)

   commands:
      slice <file.stl|amf..>  slice file to gcode (.stl, .amf, .obj, .3mf)
         slice <file.scad>
      print <file.gcode>      print gcode
         print <file.stl>     slice & print in one go
         print <file.scad>    convert, slice & print in one go
      render <file.gcode>     render an image (use '--output=sample.png' or so)
         render <file.stl>
         render <file.scad>
      gcode <code1> [...]     send gcode lines
      gconsole                start gcode console
      help
   
   examples:
      ln -s my_printer.ini default.ini --OR-- export PRINT3R "printer=my_printer.ini"
      print3r slice cube.stl
      print3r --layer-height=0.2 --output=test.gcode slice cube.stl
      print3r --printer=ender3.ini --device=/dev/ttyUSB1 print test.gcode
      print3r --printer=corexy.ini --device=/dev/ttyUSB2 --nozzle-diameter=0.5 --layer-height=0.4 --fill-density=0 print cube.stl
      print3r print cube.scad
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
ln -s prusa-i3.ini default.ini
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

## Printer Profiles

There are multiple ways to reference a particular printer profile:

### Command Line `--printer`
```
print3r --printer=prusa-i3.ini print Parts/3DBenchy.stl
```

### Default Profile `default.ini`
If `default.ini` exists, it's considered by default:
```
ln -s prusa-i3.ini default.ini
print3r print cube.scad
```

### Environment Variable `PRINT3R`
You can set any option into PRINT3R environment variable, "&lt;key&gt;=&lt;value&gt;", combined with ":", like:
```
export PRINT3R "printer=prusa-i3.ini:temperature=190:..."
print3r print cube.scad
```

### Render Example
Instead to actually print parts, you can also let them render into .png image as well (e.g. for documentation purposes or preview):
```
print3r --output=benchy.png render 3DBenchy.stl
```
![](https://raw.githubusercontent.com/Spiritdude/Print3r/master/examples/benchy.png)

## See Also
- [Spiritdude's Public Notebook: Print3r](https://spiritdude.wordpress.com/tag/print3r/)

