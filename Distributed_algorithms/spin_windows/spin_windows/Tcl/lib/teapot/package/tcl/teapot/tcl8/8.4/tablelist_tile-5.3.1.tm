# ACTIVESTATE TEAPOT-PKG BEGIN TM -*- tcl -*-
# -- Tcl Module

# @@ Meta Begin
# Package tablelist_tile 5.3.1
# Meta activestatetags ActiveTcl Public Tklib
# Meta as::build::date 2011-07-15
# Meta as::origin      http://sourceforge.net/projects/tcllib
# Meta license         BSD
# Meta platform        tcl
# Meta require         {Tcl 8.4}
# Meta require         {Tk 8.4}
# Meta require         {tablelist::common 5.3.1-5.3.1}
# Meta require         {tile 0.6}
# @@ Meta End


# ACTIVESTATE TEAPOT-PKG BEGIN DECLARE

package provide tablelist_tile 5.3.1

# ACTIVESTATE TEAPOT-PKG END DECLARE
# ACTIVESTATE TEAPOT-PKG END TM
#==============================================================================
# Main Tablelist_tile package module.
#
# Copyright (c) 2000-2011  Csaba Nemethi (E-mail: csaba.nemethi@t-online.de)
#==============================================================================

package require Tcl 8.4
package require Tk  8.4
if {$::tk_version < 8.5 || [regexp {^8\.5a[1-5]$} $::tk_patchLevel]} {
    package require tile 0.6
}
package require -exact tablelist::common 5.3.1

package provide tablelist_tile $::tablelist::version
package provide Tablelist_tile $::tablelist::version

::tablelist::useTile 1
::tablelist::createBindings

namespace eval ::tablelist {
    #
    # Commands related to tile themes:
    #
    namespace export	getThemes getCurrentTheme setTheme setThemeDefaults
}
