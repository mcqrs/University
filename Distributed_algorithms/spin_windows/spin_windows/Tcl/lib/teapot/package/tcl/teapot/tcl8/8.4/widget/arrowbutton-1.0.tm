# ACTIVESTATE TEAPOT-PKG BEGIN TM -*- tcl -*-
# -- Tcl Module

# @@ Meta Begin
# Package widget::arrowbutton 1.0
# Meta activestatetags ActiveTcl Public Tklib
# Meta as::build::date 2011-07-15
# Meta as::origin      http://sourceforge.net/projects/tcllib
# Meta license         BSD
# Meta platform        tcl
# Meta require         {Tcl 8.4}
# Meta require         widget
# @@ Meta End


# ACTIVESTATE TEAPOT-PKG BEGIN DECLARE

package provide widget::arrowbutton 1.0

# ACTIVESTATE TEAPOT-PKG END DECLARE
# ACTIVESTATE TEAPOT-PKG END TM
##+##########################################################################
#
# Reference
#    http://wiki.tcl.tk/8554
#
# arrows.tcl -- bitmaps for eight directional arrows
# by Keith Vetter, Mar 12, 2003
# by Keith Vetter, July 2, 2010  added diagonal arrows
# snit class by Andreas Kupries
#

package require widget

snit::widgetadaptor widget::arrowbutton {
    delegate option * to hull except -image
    delegate method * to hull

    option -orientation \
	-configuremethod C-orientation \
	-validatemethod  V-orientation

    constructor {args} {
        installhull using ttk::button
        $self configurelist $args
	return
    }

    method C-orientation {o value} {
	set options($o) $value
	$hull configure -image ::widget::arrowbutton::bit::$value
	return
    }

    method V-orientation {o value} {
	if {$value in $ourorientation} return
	return -code error "Expected one of [linsert [join $ourorientation {, }] end-1 or], got \"$value\""
    }

    typevariable ourorientation {
	down
	downleft
	downright
	left
	right
	star
	up
	upleft
	upright
    }
}

image create bitmap ::widget::arrowbutton::bit::up -data {
    #define up_width 11
    #define up_height 11
    static char up_bits = {
        0x00, 0x00, 0x20, 0x00, 0x70, 0x00, 0xf8, 0x00, 0xfc, 0x01, 0xfe,
        0x03, 0x70, 0x00, 0x70, 0x00, 0x70, 0x00, 0x00, 0x00, 0x00, 0x00
    }
}
image create bitmap ::widget::arrowbutton::bit::down -data {
    #define down_width 11
    #define down_height 11
    static char down_bits = {
        0x00, 0x00, 0x00, 0x00, 0x70, 0x00, 0x70, 0x00, 0x70, 0x00, 0xfe,
        0x03, 0xfc, 0x01, 0xf8, 0x00, 0x70, 0x00, 0x20, 0x00, 0x00, 0x00
    }
}
image create bitmap ::widget::arrowbutton::bit::left -data {
    #define left_width 11
    #define left_height 11
    static char left_bits = {
        0x00, 0x00, 0x20, 0x00, 0x30, 0x00, 0x38, 0x00, 0xfc, 0x01, 0xfe,
        0x01, 0xfc, 0x01, 0x38, 0x00, 0x30, 0x00, 0x20, 0x00, 0x00, 0x00
    }
}
image create bitmap ::widget::arrowbutton::bit::right -data {
    #define right_width 11
    #define right_height 11
    static char right_bits = {
        0x00, 0x00, 0x20, 0x00, 0x60, 0x00, 0xe0, 0x00, 0xfc, 0x01, 0xfc,
        0x03, 0xfc, 0x01, 0xe0, 0x00, 0x60, 0x00, 0x20, 0x00, 0x00, 0x00
    }
}
image create bitmap ::widget::arrowbutton::bit::upleft -data {
    #define upleft_width 11
    #define upleft_height 11
    static char upleft_bits = {
        0x00, 0x00, 0x7e, 0x00, 0x3e, 0x00, 0x3e, 0x00, 0x7e, 0x00, 0xfe,
        0x00, 0xf2, 0x01, 0xe0, 0x00, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00
    }    
}
image create bitmap ::widget::arrowbutton::bit::upright -data {
    #define upright_width 11
    #define upright_height 11
    static char upright_bits = {
        0x00, 0x00, 0xf0, 0x03, 0xe0, 0x03, 0xe0, 0x03, 0xf0, 0x03, 0xf8,
        0x03, 0x7c, 0x02, 0x38, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00
    }
}
image create bitmap ::widget::arrowbutton::bit::downleft -data {
    #define downleft_width 11
    #define downleft_height 11
    static char downleft_bits = {
        0x00, 0x00, 0x00, 0x00, 0x40, 0x00, 0xe0, 0x00, 0xf2, 0x01, 0xfe,
        0x00, 0x7e, 0x00, 0x3e, 0x00, 0x3e, 0x00, 0x7e, 0x00, 0x00, 0x00
    }
}
image create bitmap ::widget::arrowbutton::bit::downright -data {
    #define downright_width 11
    #define downright_height 11
    static char downright_bits = {
        0x00, 0x00, 0x00, 0x00, 0x10, 0x00, 0x38, 0x00, 0x7c, 0x02, 0xf8,
        0x03, 0xf0, 0x03, 0xe0, 0x03, 0xe0, 0x03, 0xf0, 0x03, 0x00, 0x00
    }
}
image create bitmap ::widget::arrowbutton::bit::star -data {
    #define plus_width 11
    #define plus_height 11
    static char plus_bits = {
        0x00, 0x00, 0x22, 0x02, 0x24, 0x01, 0xa8, 0x00, 0x70, 0x00, 0xfe,
        0x03, 0x70, 0x00, 0xa8, 0x00, 0x24, 0x01, 0x22, 0x02, 0x00, 0x00
    }
}

package provide widget::arrowbutton 1
return
