Xorg supports several mechanisms for supplying/obtaining
configuration and run-time parameters:

* command line options
* environment variables
* the xorg.conf and xorg.conf.d configuration files
* auto-detection
* fallback defaults.


When the same information is supplied in more than one way,
the highest precedence mechanism is used. The list of
mechanisms is ordered from highest precedence to lowest.
Note that not all parameters can be supplied via all
methods. The available command line options and environment
variables (and some defaults) are described in the
<a href="../man1/Xserver.1.xhtml"><em>Xserver</em>(1)</a> and <a href="../man1/Xorg.1.xhtml"><em>Xorg</em>(1)</a> manual pages. Most configuration file
parameters, with their defaults, are described below. Driver
and module specific configuration parameters are described
in the relevant driver or module manual page.


<h2 id="conf-location" class="page-header">Conf File Locations</h2>

Xorg uses a configuration file called xorg.conf and files ending in the suffix .conf from the directory xorg.conf.d for its initial setup. The xorg.conf configuration file is searched for in the following places when the server is started as a normal user:

```
/etc/X11/<cmdline>
/usr/etc/X11/<cmdline>
/etc/X11/$XORGCONFIG
/usr/etc/X11/$XORGCONFIG
/etc/X11/xorg.conf
/etc/xorg.conf
/usr/etc/X11/xorg.conf.<hostname>
/usr/etc/X11/xorg.conf
/usr/lib/X11/xorg.conf.<hostname>
/usr/lib/X11/xorg.conf
```
where 'cmdline' is a relative path (with no “..” components) specified with the −config command line option, $XORGCONFIG is the relative path (with no “..” components) specified by that environment variable, and 'hostname' is the machine’s hostname as reported by <a href="../man3/gethostname.3.xhtml"><em>gethostname</em>(3)</a>.

When the Xorg server is started by the “root” user, the config file search locations are as follows:

```
<cmdline>
/etc/X11/<cmdline>
/usr/etc/X11/<cmdline>
$XORGCONFIG
/etc/X11/$XORGCONFIG
/usr/etc/X11/$XORGCONFIG
/etc/X11/xorg.conf
/etc/xorg.conf
/usr/etc/X11/xorg.conf.<hostname>
/usr/etc/X11/xorg.conf
/usr/lib/X11/xorg.conf.<hostname>
/usr/lib/X11/xorg.conf
```
where 'cmdline' is the path specified with the −config command line option (which may be absolute or relative), $XORGCONFIG is the path specified by that environment variable (absolute or relative), $HOME is the path specified by that environment variable (usually the home directory), and 'hostname' is the machine’s hostname as reported by <a href="../man3/gethostname.3.xhtml"><em>gethostname</em>(3)</a>.

Finally, configuration files will also be searched for in directories reserved for system use. These are to separate configuration files from the vendor or 3rd party packages from those of local administration. These files are found in the following directories:

```
/usr/share/X11/xorg.conf.d
/usr/share/X11/xorg.conf.d
```

<h2 id="conf-location" class="page-header">Conf File Sections</h2>

The xorg.conf and xorg.conf.d files are composed of a number of sections which may be present in any order, or omitted to use default configuration values. Each section has the form:

>**Section **"SectionName"
>
>SectionEntry
>
>...
>
>**EndSection**

The section names are:


>**Files** File pathnames

>**ServerFlags** Server flags

>**Module** Dynamic module loading

>**Extensions** Extension enabling

>**InputDevice** Input device description

>**InputClass** Input class description

>**Device** Graphics device description

>**VideoAdaptor** Xv video adaptor description

>**Monitor** Monitor description

>**Modes** Video modes descriptions

>**Screen** Screen configuration

>**ServerLayout** Overall layout

>**DRI** DRI−specific configuration

>**Vendor** Vendor−specific configuration

The following obsolete section names are still recognised for compatibility purposes. In new config files, the InputDevice section should be used instead.

>**Keyboard** Keyboard configuration
>
>**Pointer** Pointer/mouse configuration

The old **XInput** section is no longer recognised.

The **ServerLayout** sections are at the highest level. They bind together the input and output devices that will be used in a session. The input devices are described in the **InputDevice** sections. Output devices usually consist of multiple independent components (e.g., a graphics board and a monitor). These multiple components are bound together in the **Screen** sections, and it is these that are referenced by the **ServerLayout** section. Each Screen section binds together a graphics board and a monitor. The graphics boards are described in the **Device** sections, and the monitors are described in the **Monitor** sections.

Config file keywords are case−insensitive, and “\_” characters are ignored. Most strings (including Option names) are also case-insensitive, and insensitive to white space and “_” characters.

Each config file entry usually takes up a single line in the file. They consist of a keyword, which is possibly followed by one or more arguments, with the number and types of the arguments depending on the keyword. The argument types are:

>**Integer** an integer number in decimal, hex or octal
>
>**Real** a floating point number
>
>**String** a string enclosed in double quote marks (")

Note: hex integer values must be prefixed with “0x”, and octal values with “0”.

A special keyword called Option may be used to provide free−form data to various components of the server. The Option keyword takes either one or two string arguments. The first is the option name, and the optional second argument is the option value. Some commonly used option value types include:

>**Integer** an integer number in decimal, hex or octal
>
>**Real** a floating point number
>
>**String** a sequence of characters
>
>**Boolean** a boolean value (see below)
>
>**Frequency** a frequency value (see below)

Note that all Option values, not just strings, must be enclosed in quotes.

Boolean options may optionally have a value specified. When no value is specified, the option’s value is TRUE. The following boolean option values are recognised as TRUE:

>1, on, true, yes

and the following boolean option values are recognised as FALSE:

>0, off, false, no

If an option name is prefixed with "No", then the option value is negated.

Example: the following option entries are equivalent:

>**Option** "Accel" "Off"
>
>**Option** "NoAccel"
>
>**Option** "NoAccel" "On"
>
>**Option** "Accel" "false"
>
>**Option** "Accel" "no"

Frequency option values consist of a real number that is optionally followed by one of the following frequency units:

>Hz, k, kHz, M, MHz

When the unit name is omitted, the correct units will be determined from the value and the expectations of the appropriate range of the value. It is recommended that the units always be specified when using frequency option values to avoid any errors in determining the value.
