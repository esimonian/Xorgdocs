<div class="tables-start"></div>

Option  | Value | Explanation
--|--|--
FontPath | "path"  | A comma separated list of font path elements which the Xorg server searches for font databases. Multiple FontPath entries may be specified, and they will be concatenated to build up the fontpath used by the server. Font path elements can be absolute directory paths, catalogue directories or a font server identifier. The formats of the later two are explained below:
ModulePath | "path" | A comma separated list of directories which the Xorg server searches for loadable modules loading in the order specified. Multiple ModulePath entries may be specified, and they will be concatenated to build the module search path used by the server. The default module path is /usr/lib/xorg/modules
XkbDir | "path" | Sets the base directory for keyboard layout files. The −xkbdir command line option can be used to override this. The default directory is /usr/share/X11/xkb

```
# Let X.Org know about the custom font directories
Section "Files"
    FontPath    "/usr/share/fonts/100dpi"
    FontPath    "/usr/share/fonts/75dpi"
    FontPath    "/usr/share/fonts/cantarell"
    FontPath    "/usr/share/fonts/cyrillic"
    FontPath    "/usr/share/fonts/encodings"
    FontPath    "/usr/share/fonts/misc"
    FontPath    "/usr/share/fonts/truetype"
    FontPath    "/usr/share/fonts/TTF"
    FontPath    "/usr/share/fonts/util"
EndSection
```

<h2 id="catalogue-directories">Catalogue directories</h2>

Catalogue directories can be specified using the prefix catalogue: before the directory name. The directory can then be populated with symlinks pointing to the real font directories, using the following syntax in the symlink name:

<identifier>:[attribute]:pri=<priority>

where <identifier> is an alphanumeric identifier, [attribute] is an attribute which will be passed to the underlying FPE and <priority> is a number used to order the fontfile FPEs. Examples:

75dpi:unscaled:pri=20 -> /usr/share/X11/fonts/75dpi
gscript:pri=60 -> /usr/share/fonts/default/ghostscript
misc:unscaled:pri=10 −> /usr/share/X11/fonts/misc

<h2 id="font-server">Font server identifiers</h2>

Font server identifiers have the form:

<trans>/<hostname>:<port−number>

where <trans> is the transport type to use to connect to the font server (e.g., unix for UNIX−domain sockets or tcp for a TCP/IP connection), <hostname> is the hostname of the machine running the font server, and <port−number> is the port number that the font server is listening on (usually 7100).

When this entry is not specified in the config file, the server falls back to the compiled−in default font path, which contains the following font path elements (which can be set inside a catalogue directory):

/usr/share/fonts/X11/misc/
/usr/share/fonts/X11/TTF/
/usr/share/fonts/X11/OTF/
/usr/share/fonts/X11/Type1/
/usr/share/fonts/X11/100dpi/
/usr/share/fonts/X11/75dpi/

Font path elements that are found to be invalid are removed from the font path when the server starts up.
<div class="tables-end"></div>
