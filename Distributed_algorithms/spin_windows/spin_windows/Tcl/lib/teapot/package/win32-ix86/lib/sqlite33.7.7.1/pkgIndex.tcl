#
# Tcl package index file
#
# Note sqlite*3* init specifically
#
package ifneeded sqlite3 3.7.7.1 \
    [list load [file join $dir sqlite3771.dll] Sqlite3]