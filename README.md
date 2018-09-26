# Print3r

## Introduction

Print3r is a command-line tool (without GUI) to print 3d parts (.stl, .scad) to 3d printer(s).

### Main Features

Print `.gcode`, `.stl` and `.scad` files to USB connected 3d printers.

### Examples
```
print3r --printer=prusa-i3.ini cube.gcode
print3r --printer=prusa-i3.ini cube.stl
print3r --printer=prusa-i3.ini cube.scad
```

## Platform
Primary focus in on Linux and alike platforms like FreeBSD and such.

## Requirements
- install `openscad` 
- install `slic3r`
- run `make requirements` to install required Perl modules

## Install

```
make install
```

### Printer Configurations
In order to use slicing and printing command `print3r` requires Slic3r printer configuration:
- run `slic3r` GUI and configure your printer(s)
- export the configuration (e.g. `my_printer.ini`)
- reference it with `--printer=my_printer.ini` when you use `print3r`

## Usage
```
Print3r (print3r) 0.0.3 USAGE: [<options>] <cmd> <file1> [<...>]

   options:
      --verbose or -v or -vv  increase verbosity
      --quiet or -q           no output except fatal errors
      --baudrate=<n>          set baudrate, default: 115200
      --device=<d>            set device, default: /dev/ttyUSB0
      --printer=<config.ini>  slic3r config of printer
      --version               display version and exit
      --output=<file>         define output file for 'slice' and 'render' command
      slice-only:
         --random-placement
         --multiply-part=<n>  
         --<key>=<value>      include any valid slic3r option

   commands:
      slice <file.stl>        slice stl into gcode
      print <file.gcode>      print gcode
         print <file.stl>     slice & print in one go
         print <file.scad>    convert, slice & print in one go
      analyze <file.gcode>
         analyze <file.stl>
      render <file.gcode>     render an image
         render <file.stl>
         render <file.scad>
      help
   
   examples:
      print3r --printer=my_printer.ini slice cube.stl
      print3r --printer=my_printer.ini --layer-height=0.2 --output=test.gcode slice cube.stl
      print3r --device=/dev/ttyUSB1 print test.gcode
      print3r --device=/dev/ttyUSB1 --nozzle-diameter=0.5 --layer-height=0.4 --fill-density=0 print cube.stl
      print3r --printer=my_printer.ini print cube.scad

```

## More Examples
```
print3r --printer=prusa-i3.ini --fill-density=0 --layer-height=0.2 print cube.scad
print3r --printer=prusa-i3.ini --print-center=100,100 print cube.scad
print3r --printer=prusa-i3.ini --random-placement print cube.scad
print3r --printer=prusa-i3.ini --multiply-part=3 print cube.scad
```
