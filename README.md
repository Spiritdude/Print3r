# Print3r

## Introduction

Print3r is a command-line tool (without GUI) to print 3d parts (.stl, .scad) to 3d printer(s).

### Main Features

Print `.gcode`, `.stl` and `.scad` files to USB connected 3d printers.

### Examples
```
print3r --printer=prusa-i3.ini print cube.gcode
print3r --printer=prusa-i3.ini print cube.stl
print3r --printer=prusa-i3.ini print cube.scad
```

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
- reference it with `--printer=my_printer.ini` when you use `print3r`

## Usage
```
Print3r (print3r) 0.0.6 USAGE: [<options>] <cmd> <file1> [<...>]

   options:
      --verbose or -v or -vv  increase verbosity
      --quiet or -q           no output except fatal errors
      --baudrate=<n>          set baudrate, default: 115200
      --device=<d>            set device, default: /dev/ttyUSB0
      --printer=<config.ini>  slic3r config of printer
      --version               display version and exit
      --output=<file>         define output file for 'slice' and 'render' command
      slice-only:
         --random-placement   place print randomly on the bed
         --multiply-part=<n>  multiply part(s)
         --scale=<x>,<y>,<z>     scale part x,y,z
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
      print3r --printer=my_printer.ini slice cube.stl
      print3r --printer=my_printer.ini --layer-height=0.2 --output=test.gcode slice cube.stl
      print3r --device=/dev/ttyUSB1 print test.gcode
      print3r --device=/dev/ttyUSB1 --nozzle-diameter=0.5 --layer-height=0.4 --fill-density=0 print cube.stl
      print3r --printer=my_printer.ini print cube.scad
      print3r --printer=my_printer.ini gcode 'G1 X Y' 'G1 X60' 'G1 Z'
      print3r --printer=my_printer.ini gconsole
      > M105
      ...

```

## More Examples
```
print3r --printer=prusa-i3.ini --fill-density=0 --layer-height=0.2 print cube.scad
print3r --printer=prusa-i3.ini --print-center=100,100 print cube.scad
print3r --printer=prusa-i3.ini --random-placement --rotate=45,0,0 print cube.scad
print3r --printer=prusa-i3.ini --multiply-part=3 --scale=0.5 print cube.scad
```

### Render Example
```
print3r --printer=prusa-i3.ini --output=cube-example.png render cube.scad
```
![](https://raw.githubusercontent.com/Spiritdude/Print3r/master/cube-example.png)

## See Also
- [Spiritdude's Public Notebook: Print3r](https://spiritdude.wordpress.com/tag/print3r/)

