
# @@ Meta Begin
# Package img::tga 1.4.0.4
# Meta activestatetags ActiveTcl Public Img
# Meta as::build::date 2011-07-15
# Meta as::origin      http://sourceforge.net/projects/tkimg
# Meta category        Tk Image Format
# Meta description     This is support for the tga image format.
# Meta license         BSD
# Meta platform        win32-ix86
# Meta require         {img::base 1.4-2}
# Meta require         {Tcl 8.4}
# Meta require         {Tk 8.4}
# Meta subject         tga
# Meta summary         tga Image Support
# @@ Meta End


if {![package vsatisfies [package provide Tcl] 8.4]} return

package ifneeded img::tga 1.4.0.4 [string map [list @ $dir] {
        # ACTIVESTATE TEAPOT-PKG BEGIN REQUIREMENTS

        package require img::base 1.4-2
        package require Tcl 8.4
        package require Tk 8.4

        # ACTIVESTATE TEAPOT-PKG END REQUIREMENTS

            load [file join {@} tkimgtga1404.dll]

        # ACTIVESTATE TEAPOT-PKG BEGIN DECLARE

        package provide img::tga 1.4.0.4

        # ACTIVESTATE TEAPOT-PKG END DECLARE
    }]
