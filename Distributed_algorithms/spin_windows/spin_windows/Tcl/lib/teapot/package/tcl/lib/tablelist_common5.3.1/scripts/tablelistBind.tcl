#==============================================================================
# Contains public and private procedures used in tablelist bindings.
#
# Structure of the module:
#   - Public helper procedures
#   - Binding tag Tablelist
#   - Binding tag TablelistWindow
#   - Binding tag TablelistBody
#   - Binding tags TablelistLabel, TablelistSubLabel, and TablelistArrow
#
# Copyright (c) 2000-2011  Csaba Nemethi (E-mail: csaba.nemethi@t-online.de)
#==============================================================================

#
# Public helper procedures
# ========================
#

#------------------------------------------------------------------------------
# tablelist::getTablelistColumn
#
# Gets the column number from the path name w of a (sub)label or sort arrow of
# a tablelist widget.
#------------------------------------------------------------------------------
proc tablelist::getTablelistColumn w {
    if {[regexp {^(\..+)\.hdr\.t\.f\.l([0-9]+)(-[it]l)?$} $w dummy win col] ||
	[regexp {^(\..+)\.hdr\.t\.f\.c([0-9]+)$} $w dummy win col]} {
	return $col
    } else {
	return -1
    }
}

#------------------------------------------------------------------------------
# tablelist::getTablelistPath
#
# Gets the path name of the tablelist widget from the path name w of one of its
# descendants.  It is assumed that all of the ancestors of w exist (but w
# itself needn't exist).
#------------------------------------------------------------------------------
proc tablelist::getTablelistPath w {
    return [mwutil::getAncestorByClass $w Tablelist]
}

#------------------------------------------------------------------------------
# tablelist::convEventFields
#
# Gets the path name of the tablelist widget and the x and y coordinates
# relative to the latter from the path name w of one of its descendants and
# from the x and y coordinates relative to the latter.
#------------------------------------------------------------------------------
proc tablelist::convEventFields {w x y} {
    return [mwutil::convEventFields $w $x $y Tablelist]
}

#
# Binding tag Tablelist
# =====================
#

#------------------------------------------------------------------------------
# tablelist::addActiveTag
#
# This procedure is invoked when the tablelist widget win gains the keyboard
# focus.  It moves the "active" tag to the line or cell that displays the
# active item or element of the widget in its body text child.
#------------------------------------------------------------------------------
proc tablelist::addActiveTag win {
    upvar ::tablelist::ns${win}::data data
    set data(ownsFocus) 1

    #
    # Conditionally move the "active" tag to the line
    # or cell that displays the active item or element
    #
    if {![info exists data(dispId)]} {
	moveActiveTag $win
    }
}

#------------------------------------------------------------------------------
# tablelist::removeActiveTag
#
# This procedure is invoked when the tablelist widget win loses the keyboard
# focus.  It removes the "active" tag from the body text child of the widget.
#------------------------------------------------------------------------------
proc tablelist::removeActiveTag win {
    upvar ::tablelist::ns${win}::data data
    set data(ownsFocus) 0

    $data(body) tag remove active 1.0 end
}

#------------------------------------------------------------------------------
# tablelist::cleanup
#
# This procedure is invoked when the tablelist widget win is destroyed.  It
# executes some cleanup operations.
#------------------------------------------------------------------------------
proc tablelist::cleanup win {
    #
    # Cancel the execution of all delayed updateKeyToRowMap, adjustSeps,
    # makeStripes, showLineNumbers, stretchColumns, updateColors,
    # updateScrlColOffset, updateHScrlbar, updateVScrlbar, updateView,
    # adjustElidedText, synchronize, displayItems, horizAutoScan, forceRedraw,
    # doCellConfig, redisplay, redisplayCol, and destroyWidgets commands
    #
    upvar ::tablelist::ns${win}::data data
    foreach id {mapId sepsId stripesId lineNumsId stretchId colorId offsetId \
		hScrlbarId vScrlbarId viewId elidedId syncId dispId afterId
		redrawId reconfigId} {
	if {[info exists data($id)]} {
	    after cancel $data($id)
	}
    }
    foreach name [array names data *redispId] {
	after cancel $data($name)
    }
    foreach destroyId $data(destroyIdList) {
	after cancel $destroyId
    }

    #
    # If there is a list variable associated with the
    # widget then remove the trace set on this variable
    #
    upvar #0 $data(-listvariable) var
    if {$data(hasListVar) && [info exists var]} {
	trace vdelete var wu $data(listVarTraceCmd)
    }

    #
    # Destroy any existing bindings for data(bodyTag),
    # data(labelTag), and data(editwinTag)
    #
    foreach event [bind $data(bodyTag)] {
	bind $data(bodyTag) $event ""
    }
    foreach event [bind $data(labelTag)] {
	bind $data(labelTag) $event ""
    }
    foreach event [bind $data(editwinTag)] {
	bind $data(editwinTag) $event ""
    }

    namespace delete ::tablelist::ns$win
    catch {rename ::$win ""}
}

#------------------------------------------------------------------------------
# tablelist::updateCanvases
#
# This procedure handles the events <Activate> and <Deactivate> by configuring
# the canvases displaying sort arrows.
#------------------------------------------------------------------------------
proc tablelist::updateCanvases win {
    upvar ::tablelist::ns${win}::data data
    foreach col $data(arrowColList) {
	configCanvas $win $col
	raiseArrow $win $col
    }
}

#------------------------------------------------------------------------------
# tablelist::updateConfigSpecs
#
# This procedure handles the virtual event <<ThemeChanged>> by updating the
# theme-specific default values of some tablelist configuration options.
#------------------------------------------------------------------------------
proc tablelist::updateConfigSpecs win {
    #
    # This might be an "after idle" callback; check whether the window exists
    #
    if {![winfo exists $win]} {
	return ""
    }

    set currentTheme [getCurrentTheme]
    upvar ::tablelist::ns${win}::data data
    if {[string compare $currentTheme $data(currentTheme)] == 0} {
	if {[string compare $currentTheme "tileqt"] == 0} {
	    set widgetStyle [tileqt_currentThemeName]
	    set colorScheme [getKdeConfigVal "KDE" "colorScheme"]
	    if {[string compare $widgetStyle $data(widgetStyle)] == 0 &&
		[string compare $colorScheme $data(colorScheme)] == 0} {
		return ""
	    }
	} else {
	    return ""
	}
    }

    #
    # Populate the array tmp with values corresponding to the old theme
    # and the array themeDefaults with values corresponding to the new one
    #
    array set tmp $data(themeDefaults)
    setThemeDefaults

    #
    # Set those configuration options whose values equal the old
    # theme-specific defaults to the new theme-specific ones
    #
    variable themeDefaults
    foreach opt {-background -foreground -disabledforeground -stripebackground
		 -selectbackground -selectforeground -selectborderwidth -font
		 -labelbackground -labelforeground -labelfont -labelborderwidth
		 -labelpady -arrowcolor -arrowdisabledcolor -arrowstyle
		 -treestyle} {
	if {[string compare $data($opt) $tmp($opt)] == 0} {
	    doConfig $win $opt $themeDefaults($opt)
	}
    }
    foreach opt {-background -foreground} {
	doConfig $win $opt $data($opt)	;# sets the bg color of the separators
    }
    updateCanvases $win

    #
    # Destroy and recreate the edit window if present
    #
    if {[set editCol $data(editCol)] >= 0} {
	set editRow $data(editRow)
	saveEditData $win
	destroy $data(bodyFr)
	doEditCell $win $editRow $editCol 1
    }

    #
    # Destroy and recreate the embedded windows
    #
    if {$data(winCount) != 0} {
	for {set row 0} {$row < $data(itemCount)} {incr row} {
	    for {set col 0} {$col < $data(colCount)} {incr col} {
		set key [lindex $data(keyList) $row]
		if {[info exists data($key,$col-window)]} {
		    set val $data($key,$col-window)
		    doCellConfig $row $col $win -window ""
		    doCellConfig $row $col $win -window $val
		}
	    }
	}
    }

    set data(currentTheme) $currentTheme
    set data(themeDefaults) [array get themeDefaults]
    if {[string compare $currentTheme "tileqt"] == 0} {
	set data(widgetStyle) [tileqt_currentThemeName]
	set data(colorScheme) [getKdeConfigVal "KDE" "colorScheme"]
    } else {
	set data(widgetStyle) ""
	set data(colorScheme) ""
    }
}

#
# Binding tag TablelistWindow
# ===========================
#

#------------------------------------------------------------------------------
# tablelist::cleanupWindow
#
# This procedure is invoked when a window aux embedded into a tablelist widget
# is destroyed.  It invokes the cleanup script associated with the cell
# containing the window, if any.
#------------------------------------------------------------------------------
proc tablelist::cleanupWindow aux {
    regexp {^(.+)\.body\.frm_(k[0-9]+),([0-9]+)$} $aux dummy win key col
    upvar ::tablelist::ns${win}::data data
    if {[info exists data($key,$col-windowdestroy)]} {
	set row [keyToRow $win $key]
	uplevel #0 $data($key,$col-windowdestroy) [list $win $row $col $aux.w]
    }
}

#
# Binding tag TablelistBody
# =========================
#

#------------------------------------------------------------------------------
# tablelist::defineTablelistBody
#
# Defines the bindings for the binding tag TablelistBody.
#------------------------------------------------------------------------------
proc tablelist::defineTablelistBody {} {
    variable priv
    array set priv {
	x			""
	y			""
	afterId			""
	prevRow			""
	prevCol			""
	prevActExpCollCtrlCell	""
	selection		{}
	clicked			0
	clickTime		0
	releaseTime		0
	clickedInEditWin	0
	clickedExpCollCtrl	0
    }

    foreach event {<Enter> <Motion> <Leave>} {
	bind TablelistBody $event [format {
	    foreach {tablelist::W tablelist::x tablelist::y} \
		[tablelist::convEventFields %%W %%x %%y] {}

	    tablelist::showOrHideTooltip $tablelist::W \
		$tablelist::x $tablelist::y %%X %%Y %s
	    tablelist::updateExpCollCtrl %%W %%x %%y
	} $event]
    }
    bind TablelistBody <Button-1> {
	if {[winfo exists %W]} {
	    foreach {tablelist::W tablelist::x tablelist::y} \
		[tablelist::convEventFields %W %x %y] {}

	    set tablelist::priv(x) $tablelist::x
	    set tablelist::priv(y) $tablelist::y
	    set tablelist::priv(row) [$tablelist::W nearest       $tablelist::y]
	    set tablelist::priv(col) [$tablelist::W nearestcolumn $tablelist::x]
	    set tablelist::priv(clicked) 1
	    set tablelist::priv(clickTime) %t
	    set tablelist::priv(clickedInEditWin) 0
	    if {[$tablelist::W cget -setfocus] &&
		[string compare [$tablelist::W cget -state] "normal"] == 0} {
		focus [$tablelist::W bodypath]
	    }
	    if {[tablelist::wasExpCollCtrlClicked %W %x %y]} {
		set tablelist::priv(clickedExpCollCtrl) 1
	    } else {
		tablelist::condEditContainingCell $tablelist::W \
		    $tablelist::x $tablelist::y
		tablelist::condBeginMove $tablelist::W $tablelist::priv(row)
		tablelist::beginSelect $tablelist::W \
		    $tablelist::priv(row) $tablelist::priv(col)
	    }
	}
    }
    bind TablelistBody <Double-Button-1> {
	if {[winfo exists %W]} {
	    foreach {tablelist::W tablelist::x tablelist::y} \
		[tablelist::convEventFields %W %x %y] {}

	    if {[$tablelist::W cget -editselectedonly]} {
		tablelist::condEditContainingCell $tablelist::W \
		    $tablelist::x $tablelist::y
	    }
	}
    }
    bind TablelistBody <B1-Motion> {
	if {$tablelist::priv(clicked) &&
	    %t - $tablelist::priv(clickTime) < 300} {
	    continue
	}

	foreach {tablelist::W tablelist::x tablelist::y} \
	    [tablelist::convEventFields %W %x %y] {}

	if {[string compare $tablelist::priv(x) ""] == 0 ||
	    [string compare $tablelist::priv(y) ""] == 0} {
	    set tablelist::priv(x) $tablelist::x
	    set tablelist::priv(y) $tablelist::y
	}
	set tablelist::priv(prevX) $tablelist::priv(x)
	set tablelist::priv(prevY) $tablelist::priv(y)
	set tablelist::priv(x) $tablelist::x
	set tablelist::priv(y) $tablelist::y
	tablelist::condAutoScan $tablelist::W
	if {!$tablelist::priv(clickedExpCollCtrl)} {
	    tablelist::motion $tablelist::W \
		[$tablelist::W nearest       $tablelist::y] \
		[$tablelist::W nearestcolumn $tablelist::x]
	    tablelist::condShowTarget $tablelist::W $tablelist::y
	}
    }
    bind TablelistBody <ButtonRelease-1> {
	if {[winfo exists %W]} {
	    foreach {tablelist::W tablelist::x tablelist::y} \
		[tablelist::convEventFields %W %x %y] {}

	    set tablelist::priv(x) ""
	    set tablelist::priv(y) ""
	    after cancel $tablelist::priv(afterId)
	    set tablelist::priv(afterId) ""
	    set tablelist::priv(releaseTime) %t
	    set tablelist::priv(releasedInEditWin) 0
	    if {!$tablelist::priv(clickedExpCollCtrl)} {
		if {$tablelist::priv(clicked) &&
		    %t - $tablelist::priv(clickTime) < 300} {
		    tablelist::moveOrActivate $tablelist::W \
			$tablelist::priv(row) $tablelist::priv(col)
		} else {
		    tablelist::moveOrActivate $tablelist::W \
			[$tablelist::W nearest       $tablelist::y] \
			[$tablelist::W nearestcolumn $tablelist::x]
		}
	    }
	    set tablelist::priv(clicked) 0
	    set tablelist::priv(clickedExpCollCtrl) 0
	    after 100 [list tablelist::condEvalInvokeCmd $tablelist::W]
	}
    }
    bind TablelistBody <Shift-Button-1> {
	foreach {tablelist::W tablelist::x tablelist::y} \
	    [tablelist::convEventFields %W %x %y] {}

	tablelist::beginExtend $tablelist::W \
	    [$tablelist::W nearest       $tablelist::y] \
	    [$tablelist::W nearestcolumn $tablelist::x]
    }
    bind TablelistBody <Control-Button-1> {
	foreach {tablelist::W tablelist::x tablelist::y} \
	    [tablelist::convEventFields %W %x %y] {}

	tablelist::beginToggle $tablelist::W \
	    [$tablelist::W nearest       $tablelist::y] \
	    [$tablelist::W nearestcolumn $tablelist::x]
    }

    bind TablelistBody <Return> {
	tablelist::condEditActiveCell [tablelist::getTablelistPath %W]
    }
    bind TablelistBody <KP_Enter> {
	tablelist::condEditActiveCell [tablelist::getTablelistPath %W]
    }
    bind TablelistBody <Tab> {
	tablelist::nextPrevCell [tablelist::getTablelistPath %W] 1
    }
    bind TablelistBody <Shift-Tab> {
	tablelist::nextPrevCell [tablelist::getTablelistPath %W] -1
    }
    bind TablelistBody <<PrevWindow>> {
	tablelist::nextPrevCell [tablelist::getTablelistPath %W] -1
    }
    bind TablelistBody <plus> {
	tablelist::plusMinus [tablelist::getTablelistPath %W] plus
    }
    bind TablelistBody <minus> {
	tablelist::plusMinus [tablelist::getTablelistPath %W] minus
    }
    bind TablelistBody <KP_Add> {
	tablelist::plusMinus [tablelist::getTablelistPath %W] plus
    }
    bind TablelistBody <KP_Subtract> {
	tablelist::plusMinus [tablelist::getTablelistPath %W] minus
    }
    bind TablelistBody <Up> {
	tablelist::upDown [tablelist::getTablelistPath %W] -1
    }
    bind TablelistBody <Down> {
	tablelist::upDown [tablelist::getTablelistPath %W] 1
    }
    bind TablelistBody <Left> {
	tablelist::leftRight [tablelist::getTablelistPath %W] -1
    }
    bind TablelistBody <Right> {
	tablelist::leftRight [tablelist::getTablelistPath %W] 1
    }
    bind TablelistBody <Prior> {
	tablelist::priorNext [tablelist::getTablelistPath %W] -1
    }
    bind TablelistBody <Next> {
	tablelist::priorNext [tablelist::getTablelistPath %W] 1
    }
    bind TablelistBody <Home> {
	tablelist::homeEnd [tablelist::getTablelistPath %W] Home
    }
    bind TablelistBody <End> {
	tablelist::homeEnd [tablelist::getTablelistPath %W] End
    }
    bind TablelistBody <Control-Home> {
	tablelist::firstLast [tablelist::getTablelistPath %W] first
    }
    bind TablelistBody <Control-End> {
	tablelist::firstLast [tablelist::getTablelistPath %W] last
    }
    bind TablelistBody <Shift-Up> {
	tablelist::extendUpDown [tablelist::getTablelistPath %W] -1
    }
    bind TablelistBody <Shift-Down> {
	tablelist::extendUpDown [tablelist::getTablelistPath %W] 1
    }
    bind TablelistBody <Shift-Left> {
	tablelist::extendLeftRight [tablelist::getTablelistPath %W] -1
    }
    bind TablelistBody <Shift-Right> {
	tablelist::extendLeftRight [tablelist::getTablelistPath %W] 1
    }
    bind TablelistBody <Shift-Home> {
	tablelist::extendToHomeEnd [tablelist::getTablelistPath %W] Home
    }
    bind TablelistBody <Shift-End> {
	tablelist::extendToHomeEnd [tablelist::getTablelistPath %W] End
    }
    bind TablelistBody <Shift-Control-Home> {
	tablelist::extendToFirstLast [tablelist::getTablelistPath %W] first
    }
    bind TablelistBody <Shift-Control-End> {
	tablelist::extendToFirstLast [tablelist::getTablelistPath %W] last
    }
    bind TablelistBody <space> {
	set tablelist::W [tablelist::getTablelistPath %W]

	tablelist::beginSelect $tablelist::W \
	    [$tablelist::W index active] [$tablelist::W columnindex active]
    }
    bind TablelistBody <Select> {
	set tablelist::W [tablelist::getTablelistPath %W]

	tablelist::beginSelect $tablelist::W \
	    [$tablelist::W index active] [$tablelist::W columnindex active]
    }
    bind TablelistBody <Control-Shift-space> {
	set tablelist::W [tablelist::getTablelistPath %W]

	tablelist::beginExtend $tablelist::W \
	    [$tablelist::W index active] [$tablelist::W columnindex active]
    }
    bind TablelistBody <Shift-Select> {
	set tablelist::W [tablelist::getTablelistPath %W]

	tablelist::beginExtend $tablelist::W \
	    [$tablelist::W index active] [$tablelist::W columnindex active]
    }
    bind TablelistBody <Escape> {
	tablelist::cancelSelection [tablelist::getTablelistPath %W]
    }
    bind TablelistBody <Control-slash> {
	tablelist::selectAll [tablelist::getTablelistPath %W]
    }
    bind TablelistBody <Control-backslash> {
	set tablelist::W [tablelist::getTablelistPath %W]

	if {[string compare [$tablelist::W cget -selectmode] "browse"] != 0} {
	    $tablelist::W selection clear 0 end
	    event generate $tablelist::W <<TablelistSelect>>
	}
    }
    foreach pattern {Tab Shift-Tab ISO_Left_Tab hpBackTab} {
	catch {
	    foreach modifier {Control Meta} {
		bind TablelistBody <$modifier-$pattern> [format {
		    mwutil::processTraversal %%W Tablelist <%s>
		} $pattern]
	    }
	}
    }

    variable winSys
    if {[string compare $winSys "classic"] == 0 ||
	[string compare $winSys "aqua"] == 0} {
	bind TablelistBody <MouseWheel> {
	    [tablelist::getTablelistPath %W] yview scroll [expr {-%D}] units
	    break
	}
	bind TablelistBody <Shift-MouseWheel> {
	    [tablelist::getTablelistPath %W] xview scroll [expr {-%D}] units
	    break
	}
	bind TablelistBody <Option-MouseWheel> {
	    [tablelist::getTablelistPath %W] yview scroll \
		[expr {-10 * %D}] units
	    break
	}
	bind TablelistBody <Shift-Option-MouseWheel> {
	    [tablelist::getTablelistPath %W] xview scroll \
		[expr {-10 * %D}] units
	    break
	}
    } else {
	bind TablelistBody <MouseWheel> {
	    [tablelist::getTablelistPath %W] yview scroll \
		[expr {-(%D / 120) * 4}] units
	    break
	}
	bind TablelistBody <Shift-MouseWheel> {
	    [tablelist::getTablelistPath %W] xview scroll \
		[expr {-(%D / 120) * 4}] units
	    break
	}
    }

    if {[string compare $winSys "x11"] == 0} {
	bind TablelistBody <Button-4> {
	    if {!$tk_strictMotif} {
		[tablelist::getTablelistPath %W] yview scroll -5 units
		break
	    }
	}
	bind TablelistBody <Button-5> {
	    if {!$tk_strictMotif} {
		[tablelist::getTablelistPath %W] yview scroll 5 units
		break
	    }
	}
	bind TablelistBody <Shift-Button-4> {
	    if {!$tk_strictMotif} {
		[tablelist::getTablelistPath %W] xview scroll -5 units
		break
	    }
	}
	bind TablelistBody <Shift-Button-5> {
	    if {!$tk_strictMotif} {
		[tablelist::getTablelistPath %W] xview scroll 5 units
		break
	    }
	}
    }

    foreach event {<<Copy>> <Control-Left> <Control-Right>
		   <Control-Prior> <Control-Next> <Button-2> <B2-Motion>} {
	set script [strMap {
	    "%W" "$tablelist::W"  "%x" "$tablelist::x"  "%y" "$tablelist::y"
	} [bind Listbox $event]]

	if {[string compare $script ""] != 0} {
	    bind TablelistBody $event [format {
		if {[winfo exists %%W]} {
		    foreach {tablelist::W tablelist::x tablelist::y} \
			[tablelist::convEventFields %%W %%x %%y] {}
		    %s
		}
	    } $script]
	}
    }
}

#------------------------------------------------------------------------------
# tablelist::showOrHideTooltip
#
# This procedure is invoked when the mouse pointer enters or leaves the body of
# a tablelist widget win or one of its separators, or is moving within it.  If
# the pointer has crossed a cell boundary then the procedure removes the old
# tooltip and displays the one corresponding to the new cell.
#------------------------------------------------------------------------------
proc tablelist::showOrHideTooltip {win x y X Y event} {
    upvar ::tablelist::ns${win}::data data
    if {[string compare $data(-tooltipaddcommand) ""] == 0 ||
	[string compare $data(-tooltipdelcommand) ""] == 0} {
	return ""
    }

    #
    # Get the containing cell from the coordinates relative to the parent
    #
    if {[string compare $event "<Leave>"] == 0} {
	set row -1
	set col -1
    } else {
	set row [containingRow $win $y]
	set col [containingCol $win $x]
    }
    if {[string compare $row,$col $data(prevCell)] == 0} {
	return ""
    }

    #
    # Remove the old tooltip, if any.  Then, if we are within a
    # cell, display the new tooltip corresponding to that cell.
    #
    event generate $win <Leave>
    catch {uplevel #0 $data(-tooltipdelcommand) [list $win]}
    set data(prevCell) $row,$col
    if {$row >= 0 && $col >= 0} {
	set focus [focus -displayof $win]
	if {[string compare $focus ""] == 0 ||
	    [string first $win $focus] != 0 ||
	    [string compare [winfo toplevel $focus] \
	     [winfo toplevel $win]] == 0} {
	    uplevel #0 $data(-tooltipaddcommand) [list $win $row $col]
	    event generate $win <Enter> -rootx $X -rooty $Y
	}
    }
}

#------------------------------------------------------------------------------
# tablelist::updateExpCollCtrl
#
# This procedure is invoked when the mouse pointer enters or leaves the body of
# a tablelist widget win or one of its separators, or is moving within it.  It
# activates or deactivates the expand/collapse control under the mouse pointer.
#------------------------------------------------------------------------------
proc tablelist::updateExpCollCtrl {w x y} {
    foreach {win _x _y} [tablelist::convEventFields $w $x $y] {}
    set row [containingRow $win $_y]
    set col [containingCol $win $_x]
    upvar ::tablelist::ns${win}::data data
    set key [lindex $data(keyList) $row]
    set indentLabel $data(body).ind_$key,$col

    #
    # Check whether the x coordinate is inside the expand/collapse control
    #
    set inExpCollCtrl 0
    if {[winfo exists $indentLabel]} {
	if {[string compare $w $data(body)] == 0 &&
	    $x < [winfo x $indentLabel] &&
	    [string compare $data($key-parent) "root"] == 0} {
	    set imgName [$indentLabel cget -image]
	    if {[regexp {^tablelist_(.+)_(collapsed|expanded).*Img([0-9]+)$} \
			 $imgName dummy treeStyle state depth]} {
		#
		# The mouse position is in the tablelist body, to the left
		# of an expand/collapse control of a top-level item:  Handle
		# this like a position inside the expand/collapse control
		#
		set inExpCollCtrl 1
	    }
	} elseif {[string compare $w $indentLabel] == 0} {
	    set imgName [$w cget -image]
	    if {[regexp {^tablelist_(.+)_(collapsed|expanded).*Img([0-9]+)$} \
			 $imgName dummy treeStyle state depth]} {
		#
		# The mouse position is in an expand/collapse
		# image (which ends with the expand/collapse
		# control):  Check whether it is inside the control
		#
		set baseWidth [image width tablelist_${treeStyle}_collapsedImg]
		if {$x >= [winfo width $w] - $baseWidth - 5} {
		    set inExpCollCtrl 1
		}
	    }
	}
    }

    #
    # Conditionally deactivate the previously activated expand/collapse control
    #
    variable priv
    set prevCellIdx $priv(prevActExpCollCtrlCell)
    if {[string compare $prevCellIdx ""] != 0 &&
	[info exists data($prevCellIdx-indent)] &&
	(!$inExpCollCtrl || [string compare $prevCellIdx $key,$col] != 0)} {
	set data($prevCellIdx-indent) \
	    [strMap {"Act" ""} $data($prevCellIdx-indent)]
	$data(body).ind_$prevCellIdx configure -image $data($prevCellIdx-indent)
	set priv(prevActExpCollCtrlCell) ""
    }

    if {!$inExpCollCtrl || [string compare $prevCellIdx $key,$col] == 0} {
	return ""
    }

    #
    # Activate the expand/collapse control under the mouse pointer
    #
    variable ${treeStyle}_collapsedActImg
    if {[info exists ${treeStyle}_collapsedActImg]} {
	set data($key,$col-indent) [strMap {"expanded" "expandedAct"
	    "collapsed" "collapsedAct"} $data($key,$col-indent)]
	$data(body).ind_$key,$col configure -image $data($key,$col-indent)
	set priv(prevActExpCollCtrlCell) $key,$col
    }
}

#------------------------------------------------------------------------------
# tablelist::wasExpCollCtrlClicked
#
# This procedure is invoked when mouse button 1 is pressed in the body of a
# tablelist widget or in one of its separators.  It checks whether the mouse
# click occurred inside an expand/collapse control.
#------------------------------------------------------------------------------
proc tablelist::wasExpCollCtrlClicked {w x y} {
    foreach {win _x _y} [tablelist::convEventFields $w $x $y] {}
    set row [containingRow $win $_y]
    set col [containingCol $win $_x]
    upvar ::tablelist::ns${win}::data data
    set key [lindex $data(keyList) $row]
    set indentLabel $data(body).ind_$key,$col
    if {![winfo exists $indentLabel]} {
	return 0
    }

    #
    # Check whether the x coordinate is inside the expand/collapse control
    #
    set inExpCollCtrl 0
    if {[string compare $w $data(body)] == 0 && $x < [winfo x $indentLabel] &&
	[string compare $data($key-parent) "root"] == 0} {
	set imgName [$indentLabel cget -image]
	if {[regexp {^tablelist_(.+)_(collapsed|expanded).*Img([0-9]+)$} \
		     $imgName dummy treeStyle state depth]} {
	    #
	    # The mouse position is in the tablelist body, to the left
	    # of an expand/collapse control of a top-level item:  Handle
	    # this like a position inside the expand/collapse control
	    #
	    set inExpCollCtrl 1
	}
    } elseif {[string compare $w $indentLabel] == 0} {
	set imgName [$w cget -image]
	if {[regexp {^tablelist_(.+)_(collapsed|expanded).*Img([0-9]+)$} \
		     $imgName dummy treeStyle state depth]} {
	    #
	    # The mouse position is in an expand/collapse
	    # image (which ends with the expand/collapse
	    # control):  Check whether it is inside the control
	    #
	    set baseWidth [image width tablelist_${treeStyle}_collapsedImg]
	    if {$x >= [winfo width $w] - $baseWidth - 5} {
		set inExpCollCtrl 1
	    }
	}
    }

    if {!$inExpCollCtrl} {
	return 0
    }

    #
    # Save the current vertical position
    #
    set topRow [expr {int([$data(body) index @0,0]) - 1}]

    #
    # Toggle the state of the expand/collapse control
    #
    if {[string compare $state "collapsed"] == 0} {
	::$win expand $row -partly
    } else {
	::$win collapse $row -partly
    }

    #
    # Restore the saved vertical position
    #
    $data(body) yview $topRow
    updateViewWhenIdle $win

    return 1
}

#------------------------------------------------------------------------------
# tablelist::condEditContainingCell
#
# This procedure is invoked when mouse button 1 is pressed in the body of a
# tablelist widget win or in one of its separators.  If the mouse click
# occurred inside an editable cell and the latter is not already being edited,
# then the procedure starts the interactive editing in that cell.  Otherwise it
# finishes a possibly active cell editing.
#------------------------------------------------------------------------------
proc tablelist::condEditContainingCell {win x y} {
    #
    # Get the containing cell from the coordinates relative to the parent
    #
    set row [containingRow $win $y]
    set col [containingCol $win $x]

    upvar ::tablelist::ns${win}::data data
    if {$data(-editselectedonly) &&
	![::$win cellselection includes $row,$col]} {
	set canEdit 0
    } else {
	set canEdit [expr {$row >= 0 && $col >= 0 &&
		     [isCellEditable $win $row $col]}]
    }
    if {$canEdit} {
	#
	# Get the coordinates relative to the
	# tablelist body and invoke doEditCell
	#
	set w $data(body)
	incr x -[winfo x $w]
	incr y -[winfo y $w]
	scan [$w index @$x,$y] "%d.%d" line charPos
	doEditCell $win $row $col 0 "" $charPos
    } else {
	#
	# Finish a possibly active cell editing
	#
	doFinishEditing $win
    }
}

#------------------------------------------------------------------------------
# tablelist::condBeginMove
#
# This procedure is typically invoked on button-1 presses in the body of a
# tablelist widget or in one of its separators.  It begins the process of
# moving the nearest row if the rows are movable and the selection mode is not
# browse or extended.
#------------------------------------------------------------------------------
proc tablelist::condBeginMove {win row} {
    upvar ::tablelist::ns${win}::data data
    if {$data(isDisabled) || !$data(-movablerows) || $data(itemCount) == 0 ||
	[string compare $data(-selectmode) "browse"] == 0 ||
	[string compare $data(-selectmode) "extended"] == 0} {
	return ""
    }

    set data(sourceRow) $row
    set sourceKey [lindex $data(keyList) $row]
    set data(sourceEndRow) [nodeRow $win $sourceKey end]
    set data(sourceDescCount) [descCount $win $sourceKey]

    set data(sourceParentKey) $data($sourceKey-parent)
    set data(sourceParentRow) [keyToRow $win $data(sourceParentKey)]
    set data(sourceParentEndRow) [nodeRow $win $data(sourceParentKey) end]

    set topWin [winfo toplevel $win]
    set data(topEscBinding) [bind $topWin <Escape>]
    bind $topWin <Escape> [list tablelist::cancelMove [strMap {"%" "%%"} $win]]
}

#------------------------------------------------------------------------------
# tablelist::beginSelect
#
# This procedure is typically invoked on button-1 presses in the body of a
# tablelist widget or in one of its separators.  It begins the process of
# making a selection in the widget.  Its exact behavior depends on the
# selection mode currently in effect for the widget.
#------------------------------------------------------------------------------
proc tablelist::beginSelect {win row col} {
    upvar ::tablelist::ns${win}::data data
    switch $data(-selecttype) {
	row {
	    if {[string compare $data(-selectmode) "multiple"] == 0} {
		if {[::$win selection includes $row]} {
		    ::$win selection clear $row
		} else {
		    ::$win selection set $row
		}
	    } else {
		::$win selection clear 0 end
		::$win selection set $row
		::$win selection anchor $row
		variable priv
		set priv(selection) {}
		set priv(prevRow) $row
	    }
	}

	cell {
	    if {[string compare $data(-selectmode) "multiple"] == 0} {
		if {[::$win cellselection includes $row,$col]} {
		    ::$win cellselection clear $row,$col
		} else {
		    ::$win cellselection set $row,$col
		}
	    } else {
		::$win cellselection clear 0,0 end
		::$win cellselection set $row,$col
		::$win cellselection anchor $row,$col
		variable priv
		set priv(selection) {}
		set priv(prevRow) $row
		set priv(prevCol) $col
	    }
	}
    }

    event generate $win <<TablelistSelect>>
}

#------------------------------------------------------------------------------
# tablelist::condAutoScan
#
# This procedure is invoked when the mouse leaves or enters the scrollable part
# of a tablelist widget's body text child.  It either invokes the autoScan
# procedure or cancels its invocation as an "after" command.
#------------------------------------------------------------------------------
proc tablelist::condAutoScan win {
    variable priv
    set w [::$win bodypath]
    set wX [winfo x $w]
    set wY [winfo y $w]
    set wWidth  [winfo width  $w]
    set wHeight [winfo height $w]
    set x [expr {$priv(x) - $wX}]
    set y [expr {$priv(y) - $wY}]
    set prevX [expr {$priv(prevX) - $wX}]
    set prevY [expr {$priv(prevY) - $wY}]
    set minX [minScrollableX $win]

    if {($y >= $wHeight && $prevY < $wHeight) ||
	($y < 0 && $prevY >= 0) ||
	($x >= $wWidth && $prevX < $wWidth) ||
	($x < $minX && $prevX >= $minX)} {
	if {[string compare $priv(afterId) ""] == 0} {
	    autoScan $win
	}
    } elseif {($y < $wHeight && $prevY >= $wHeight) ||
	      ($y >= 0 && $prevY < 0) ||
	      ($x < $wWidth && $prevX >= $wWidth) ||
	      ($x >= $minX && $prevX < $minX)} {
	after cancel $priv(afterId)
	set priv(afterId) ""
    }
}

#------------------------------------------------------------------------------
# tablelist::autoScan
#
# This procedure is invoked when the mouse leaves the scrollable part of a
# tablelist widget's body text child.  It scrolls the child up, down, left, or
# right, depending on where the mouse left the scrollable part of the
# tablelist's body, and reschedules itself as an "after" command so that the
# child continues to scroll until the mouse moves back into the window or the
# mouse button is released.
#------------------------------------------------------------------------------
proc tablelist::autoScan win {
    if {![winfo exists $win] || [string compare [::$win editwinpath] ""] != 0} {
	return ""
    }

    upvar ::tablelist::ns${win}::data data
    variable priv
    set w [::$win bodypath]
    set x [expr {$priv(x) - [winfo x $w]}]
    set y [expr {$priv(y) - [winfo y $w]}]
    set minX [minScrollableX $win]

    if {$y >= [winfo height $w]} {
	::$win yview scroll 1 units
	set ms 50
    } elseif {$y < 0} {
	::$win yview scroll -1 units
	set ms 50
    } elseif {$x >= [winfo width $w]} {
	if {$data(-titlecolumns) == 0} {
	    ::$win xview scroll 2 units
	    set ms 50
	} else {
	    ::$win xview scroll 1 units
	    set ms 250
	}
    } elseif {$x < $minX} {
	if {$data(-titlecolumns) == 0} {
	    ::$win xview scroll -2 units
	    set ms 50
	} else {
	    ::$win xview scroll -1 units
	    set ms 250
	}
    } else {
	return ""
    }

    motion $win [::$win nearest $priv(y)] [::$win nearestcolumn $priv(x)]
    set priv(afterId) [after $ms [list tablelist::autoScan $win]]
}

#------------------------------------------------------------------------------
# tablelist::minScrollableX
#
# Returns the least x coordinate within the scrollable part of the body of the
# tablelist widget win.
#------------------------------------------------------------------------------
proc tablelist::minScrollableX win {
    upvar ::tablelist::ns${win}::data data
    if {$data(-titlecolumns) == 0} {
	return 0
    } else {
	set sep [::$win separatorpath]
	if {[winfo viewable $sep]} {
	    return [expr {[winfo x $sep] - [winfo x [::$win bodypath]] + 1}]
	} else {
	    return 0
	}
    }
}

#------------------------------------------------------------------------------
# tablelist::motion
#
# This procedure is called to process mouse motion events in the body of a
# tablelist widget or in one of its separators. while button 1 is down.  It may
# move or extend the selection, depending on the widget's selection mode.
#------------------------------------------------------------------------------
proc tablelist::motion {win row col} {
    upvar ::tablelist::ns${win}::data data
    variable priv
    switch $data(-selecttype) {
	row {
	    if {$row == $priv(prevRow)} {
		return ""
	    }

	    switch -- $data(-selectmode) {
		browse {
		    ::$win selection clear 0 end
		    ::$win selection set $row
		    set priv(prevRow) $row
		    event generate $win <<TablelistSelect>>
		}
		extended {
		    if {[string compare $priv(prevRow) ""] != 0} {
			::$win selection clear anchor $priv(prevRow)
		    }
		    ::$win selection set anchor $row
		    set priv(prevRow) $row
		    event generate $win <<TablelistSelect>>
		}
	    }
	}

	cell {
	    if {$row == $priv(prevRow) && $col == $priv(prevCol)} {
		return ""
	    }

	    switch -- $data(-selectmode) {
		browse {
		    ::$win cellselection clear 0,0 end
		    ::$win cellselection set $row,$col
		    set priv(prevRow) $row
		    set priv(prevCol) $col
		    event generate $win <<TablelistSelect>>
		}
		extended {
		    if {[string compare $priv(prevRow) ""] != 0 &&
			[string compare $priv(prevCol) ""] != 0} {
			::$win cellselection clear anchor \
			       $priv(prevRow),$priv(prevCol)
		    }
		    ::$win cellselection set anchor $row,$col
		    set priv(prevRow) $row
		    set priv(prevCol) $col
		    event generate $win <<TablelistSelect>>
		}
	    }
	}
    }
}

#------------------------------------------------------------------------------
# tablelist::condShowTarget
#
# This procedure is called to process mouse motion events in the body of a
# tablelist widget or in one of its separators. while button 1 is down.  It
# visualizes the would-be target position of the clicked row if a move
# operation is in progress.
#------------------------------------------------------------------------------
proc tablelist::condShowTarget {win y} {
    upvar ::tablelist::ns${win}::data data
    if {![info exists data(sourceRow)]} {
	return ""
    }

    set w $data(body)
    incr y -[winfo y $w]
    set textIdx [$w index @0,$y]
    set dlineinfo [$w dlineinfo $textIdx]
    set lineY [lindex $dlineinfo 1]
    set lineHeight [lindex $dlineinfo 3]
    set row [expr {int($textIdx) - 1}]

    if {$::tk_version >= 8.3} {
	if {$y < $lineY + $lineHeight/3} {
	    set data(targetRow) $row
	    set data(targetChildIdx) -1
	    set gapY $lineY
	} elseif {$y < $lineY + $lineHeight*2/3} {
	    set data(targetRow) $row
	    set data(targetChildIdx) 0
	    set gapY [expr {$lineY + $lineHeight/2}]
	} else {
	    set y [expr {$lineY + $lineHeight}]
	    set textIdx [$w index @0,$y]
	    set row2 [expr {int($textIdx) - 1}]
	    if {$row2 == $row} {
		set row2 $data(itemCount)
	    }
	    set data(targetRow) $row2
	    set data(targetChildIdx) -1
	    set gapY $y
	}
    } else {
	if {$y < $lineY + $lineHeight/2} {
	    set data(targetRow) $row
	    set gapY $lineY
	} else {
	    set y [expr {$lineY + $lineHeight}]
	    set textIdx [$w index @0,$y]
	    set row2 [expr {int($textIdx) - 1}]
	    if {$row2 == $row} {
		set row2 $data(itemCount)
	    }
	    set data(targetRow) $row2
	    set gapY $y
	}
	set data(targetChildIdx) -1
    }

    #
    # Get the key and node index of the potential target parent
    #
    if {$data(targetRow) > $data(lastRow)} {
	if {$data(targetRow) > $data(sourceParentEndRow)} {
	    set targetParentKey root
	    set targetParentNodeIdx root
	} else {
	    set targetParentKey $data(sourceParentKey)
	    set targetParentNodeIdx $data(sourceParentRow)
	}
    } elseif {$data(targetChildIdx) == 0} {
	set targetParentKey [lindex $data(keyList) $data(targetRow)]
	set targetParentNodeIdx $data(targetRow)
    } else {
	set targetParentKey [::$win parentkey $data(targetRow)]
	set targetParentNodeIdx [keyToRow $win $targetParentKey]
	if {$targetParentNodeIdx < 0} {
	    set targetParentNodeIdx root
	}
    }

    if {($data(targetRow) == $data(sourceRow)) ||
	($data(targetRow) == $data(sourceRow) - 1 &&
	 $data(targetRow) == $data(sourceParentRow) &&
	 $data(targetChildIdx) == 0) ||
	($data(targetRow) == $data(sourceEndRow) &&
	 $data(targetChildIdx) < 0) ||
	($data(targetRow) > $data(sourceRow) &&
	 $data(targetRow) <= $data(sourceRow) + $data(sourceDescCount)) ||
	([string compare $data(sourceParentKey) $targetParentKey] != 0 &&
	 ($::tk_version < 8.3 ||
	 ([string compare $data(-acceptchildcommand) ""] != 0 &&
	  ![uplevel #0 $data(-acceptchildcommand) \
	    [list $win $targetParentNodeIdx $data(sourceRow)]])))} {
	unset data(targetRow)
	unset data(targetChildIdx)
	$w configure -cursor $data(-cursor)
	place forget $data(rowGap)
    } else {
	$w configure -cursor $data(-movecursor)
	if {$data(targetChildIdx) == 0} {
	    place $data(rowGap) -anchor w -y $gapY -height $lineHeight -width 5
	} else {
	    place $data(rowGap) -anchor w -y $gapY -height 4 \
				-width [winfo width $data(hdrTxtFr)]
	}
	raise $data(rowGap)
    }
}

#------------------------------------------------------------------------------
# tablelist::moveOrActivate
#
# This procedure is invoked whenever mouse button 1 is released in the body of
# a tablelist widget or in one of its separators.  It either moves the
# previously clicked row before or after the one containing the mouse cursor,
# or activates the given nearest item or element (depending on the widget's
# selection type).
#------------------------------------------------------------------------------
proc tablelist::moveOrActivate {win row col} {
    #
    # Return if both <Button-1> and <ButtonRelease-1> occurred in the
    # temporary embedded widget used for interactive cell editing
    #
    variable priv
    if {$priv(clickedInEditWin) && $priv(releasedInEditWin)} {
	return ""
    }

    upvar ::tablelist::ns${win}::data data
    if {[info exists data(sourceRow)]} {
	set sourceKey [lindex $data(keyList) $data(sourceRow)]
	unset data(sourceRow)
	unset data(sourceEndRow)
	unset data(sourceDescCount)
	unset data(sourceParentKey)
	unset data(sourceParentRow)
	unset data(sourceParentEndRow)
	bind [winfo toplevel $win] <Escape> $data(topEscBinding)
	$data(body) configure -cursor $data(-cursor)
	place forget $data(rowGap)

	if {[info exists data(targetRow)]} {
	    if {$data(targetRow) > $data(lastRow)} {
		if {[catch {::$win move $sourceKey $data(targetRow)}] != 0} {
		    ::$win move $sourceKey root end
		}
	    } else {
		set targetChildIdx $data(targetChildIdx)
		if {$targetChildIdx == 0} {
		    set targetParentKey [lindex $data(keyList) $data(targetRow)]

		    #
		    # The first expand invocation below is necessary in
		    # case the target node has already children, while
		    # the second one is needed in the opposite case.
		    #
		    ::$win expand $targetParentKey -partly
		    ::$win move $sourceKey $targetParentKey $targetChildIdx
		    ::$win expand $targetParentKey -partly
		} else {
		    set targetParentKey [::$win parentkey $data(targetRow)]
		    set targetChildIdx [::$win childindex $data(targetRow)]
		    ::$win move $sourceKey $targetParentKey $targetChildIdx
		}
	    }

	    event generate $win <<TablelistRowMoved>>
	    unset data(targetRow)
	    unset data(targetChildIdx)
	} else {
	    switch $data(-selecttype) {
		row  { ::$win activate $row }
		cell { ::$win activatecell $row,$col }
	    }
	}
    } else {
	switch $data(-selecttype) {
	    row  { ::$win activate $row }
	    cell { ::$win activatecell $row,$col }
	}
    }
}

#------------------------------------------------------------------------------
# tablelist::condEvalInvokeCmd
#
# This procedure is invoked when mouse button 1 is released in the body of a
# tablelist widget win or in one of its separators.  If interactive cell
# editing is in progress in a column whose associated edit window has an invoke
# command that hasn't yet been called in the current edit session, then the
# procedure evaluates that command.
#------------------------------------------------------------------------------
proc tablelist::condEvalInvokeCmd win {
    #
    # This is an "after 100" callback; check whether the window exists
    #
    if {![winfo exists $win]} {
	return ""
    }

    upvar ::tablelist::ns${win}::data data
    if {$data(editCol) < 0} {
	return ""
    }

    variable editWin
    set name [getEditWindow $win $data(editRow) $data(editCol)]
    if {[string compare $editWin($name-invokeCmd) ""] == 0 || $data(invoked)} {
	return ""
    }

    #
    # Return if both <Button-1> and <ButtonRelease-1> occurred in the
    # temporary embedded widget used for interactive cell editing
    #
    variable priv
    if {$priv(clickedInEditWin) && $priv(releasedInEditWin)} {
	return ""
    }

    #
    # Return if the edit window is an editable combobox widget
    #
    set w $data(bodyFrEd)
    switch [winfo class $w] {
	TCombobox {
	    if {[string compare [$w cget -state] "normal"] == 0} {
		return ""
	    }
	}
	ComboBox -
	Combobox {
	    if {[$w cget -editable]} {
		return ""
	    }
	}
    }

    #
    # Evaluate the edit window's invoke command
    #
    update
    if {![winfo exists $w]} {				;# because of update
	return ""
    }
    eval [strMap {"%W" "$w"} $editWin($name-invokeCmd)]
    set data(invoked) 1
}

#------------------------------------------------------------------------------
# tablelist::cancelMove
#
# This procedure is invoked to process <Escape> events in the top-level window
# containing the tablelist widget win during a row move operation.  It cancels
# the action in progress.
#------------------------------------------------------------------------------
proc tablelist::cancelMove win {
    upvar ::tablelist::ns${win}::data data
    if {![info exists data(sourceRow)]} {
	return ""
    }

    unset data(sourceRow)
    unset data(sourceEndRow)
    unset data(sourceDescCount)
    unset data(sourceParentKey)
    unset data(sourceParentRow)
    unset data(sourceParentEndRow)
    catch {unset data(targetRow)}
    catch {unset data(targetChildIdx)}
    bind [winfo toplevel $win] <Escape> $data(topEscBinding)
    $data(body) configure -cursor $data(-cursor)
    place forget $data(rowGap)
}

#------------------------------------------------------------------------------
# tablelist::beginExtend
#
# This procedure is typically invoked on shift-button-1 presses in the body of
# a tablelist widget or in one of its separators.  It begins the process of
# extending a selection in the widget.  Its exact behavior depends on the
# selection mode currently in effect for the widget.
#------------------------------------------------------------------------------
proc tablelist::beginExtend {win row col} {
    if {[string compare [::$win cget -selectmode] "extended"] != 0} {
	return ""
    }

    if {[::$win selection includes anchor]} {
	motion $win $row $col
    } else {
	beginSelect $win $row $col
    }
}

#------------------------------------------------------------------------------
# tablelist::beginToggle
#
# This procedure is typically invoked on control-button-1 presses in the body
# of a tablelist widget or in one of its separators.  It begins the process of
# toggling a selection in the widget.  Its exact behavior depends on the
# selection mode currently in effect for the widget.
#------------------------------------------------------------------------------
proc tablelist::beginToggle {win row col} {
    upvar ::tablelist::ns${win}::data data
    if {[string compare $data(-selectmode) "extended"] != 0} {
	return ""
    }

    variable priv
    switch $data(-selecttype) {
	row {
	    set priv(selection) [::$win curselection]
	    set priv(prevRow) $row
	    ::$win selection anchor $row
	    if {[::$win selection includes $row]} {
		::$win selection clear $row
	    } else {
		::$win selection set $row
	    }
	}

	cell {
	    set priv(selection) [::$win curcellselection]
	    set priv(prevRow) $row
	    set priv(prevCol) $col
	    ::$win cellselection anchor $row,$col
	    if {[::$win cellselection includes $row,$col]} {
		::$win cellselection clear $row,$col
	    } else {
		::$win cellselection set $row,$col
	    }
	}
    }

    event generate $win <<TablelistSelect>>
}

#------------------------------------------------------------------------------
# tablelist::condEditActiveCell
#
# This procedure is invoked whenever Return or KP_Enter is pressed in the body
# of a tablelist widget.  If the selection type is cell and the active cell is
# editable then the procedure starts the interactive editing in that cell.
#------------------------------------------------------------------------------
proc tablelist::condEditActiveCell win {
    upvar ::tablelist::ns${win}::data data
    if {[string compare $data(-selecttype) "cell"] != 0 ||
	[firstViewableRow $win] < 0 || [firstViewableCol $win] < 0} {
	return ""
    }

    set row $data(activeRow)
    set col $data(activeCol)
    if {[isCellEditable $win $row $col]} {
	doEditCell $win $row $col 0
    }
}

#------------------------------------------------------------------------------
# tablelist::plusMinus
#
# Partially expands or collapses the active row if possible.
#------------------------------------------------------------------------------
proc tablelist::plusMinus {win keysym} {
    upvar ::tablelist::ns${win}::data data
    set row $data(activeRow)
    set col $data(treeCol)
    set key [lindex $data(keyList) $row]
    set op ""

    if {[info exists data($key,$col-indent)]} {
	set indentLabel $data(body).ind_$key,$col
	set imgName [$indentLabel cget -image]
	if {[regexp {^tablelist_(.+)_(collapsed|expanded).*Img([0-9]+)$} \
		     $imgName dummy treeStyle state depth]} {
	    if {[string compare $keysym "plus"] == 0 &&
		[string compare $state "collapsed"] == 0} {
		set op "expand"
	    } elseif {[string compare $keysym "minus"] == 0 &&
		      [string compare $state "expanded"] == 0} {
		set op "collapse"
	    }
	}
    }

    if {[string compare $op ""] != 0} {
	#
	# Save the current vertical position
	#
	set topRow [expr {int([$data(body) index @0,0]) - 1}]

	#
	# Toggle the state of the expand/collapse control
	#
	::$win $op $row -partly

	#
	# Restore the saved vertical position
	#
	$data(body) yview $topRow
	updateViewWhenIdle $win
    }
}

#------------------------------------------------------------------------------
# tablelist::nextPrevCell
#
# Does nothing unless the selection type is cell; in this case it moves the
# location cursor (active element) to the next or previous element, and changes
# the selection if we are in browse or extended selection mode.
#------------------------------------------------------------------------------
proc tablelist::nextPrevCell {win amount} {
    upvar ::tablelist::ns${win}::data data
    switch $data(-selecttype) {
	row {
	    # Nothing
	}

	cell {
	    if {$data(editRow) >= 0} {
		return -code break ""
	    }

	    set row $data(activeRow)
	    set col $data(activeCol)
	    set oldRow $row
	    set oldCol $col

	    while 1 {
		incr col $amount
		if {$col < 0} {
		    incr row $amount
		    if {$row < 0} {
			set row $data(lastRow)
		    }
		    set col $data(lastCol)
		} elseif {$col > $data(lastCol)} {
		    incr row $amount
		    if {$row > $data(lastRow)} {
			set row 0
		    }
		    set col 0
		}

		if {$row == $oldRow && $col == $oldCol} {
		    return -code break ""
		} elseif {[isRowViewable $win $row] && !$data($col-hide)} {
		    condChangeSelection $win $row $col
		    return -code break ""
		}
	    }
	}
    }
}

#------------------------------------------------------------------------------
# tablelist::upDown
#
# Moves the location cursor (active item or element) up or down by one line,
# and changes the selection if we are in browse or extended selection mode.
#------------------------------------------------------------------------------
proc tablelist::upDown {win amount} {
    upvar ::tablelist::ns${win}::data data
    if {$data(editRow) >= 0} {
	return ""
    }

    switch $data(-selecttype) {
	row {
	    set row $data(activeRow)
	    set col -1
	}

	cell {
	    set row $data(activeRow)
	    set col $data(activeCol)
	}
    }

    while 1 {
	incr row $amount
	if {$row < 0 || $row > $data(lastRow)} {
	    return ""
	} elseif {[isRowViewable $win $row]} {
	    condChangeSelection $win $row $col
	    return ""
	}
    }
}

#------------------------------------------------------------------------------
# tablelist::leftRight
#
# Partially expands or collapses the active row if possible.  Otherwise, if the
# tablelist widget's selection type is "row" then this procedure scrolls the
# widget's view left or right by the width of the character "0".  Otherwise it
# moves the location cursor (active element) left or right by one column, and
# changes the selection if we are in browse or extended selection mode.
#------------------------------------------------------------------------------
proc tablelist::leftRight {win amount} {
    upvar ::tablelist::ns${win}::data data
    set row $data(activeRow)
    set col $data(treeCol)
    set key [lindex $data(keyList) $row]
    set op ""

    if {[info exists data($key,$col-indent)]} {
	set indentLabel $data(body).ind_$key,$col
	set imgName [$indentLabel cget -image]
	if {[regexp {^tablelist_(.+)_(collapsed|expanded).*Img([0-9]+)$} \
		     $imgName dummy treeStyle state depth]} {
	    if {$amount > 0 && [string compare $state "collapsed"] == 0} {
		set op "expand"
	    } elseif {$amount < 0 && [string compare $state "expanded"] == 0} {
		set op "collapse"
	    }
	}
    }

    if {[string compare $op ""] == 0} {
	switch $data(-selecttype) {
	    row {
		::$win xview scroll $amount units
	    }

	    cell {
		if {$data(editRow) >= 0} {
		    return ""
		}

		set col $data(activeCol)
		while 1 {
		    incr col $amount
		    if {$col < 0 || $col > $data(lastCol)} {
			return ""
		    } elseif {!$data($col-hide)} {
			condChangeSelection $win $row $col
			return ""
		    }
		}
	    }
	}
    } else {
	#
	# Save the current vertical position
	#
	set topRow [expr {int([$data(body) index @0,0]) - 1}]

	#
	# Toggle the state of the expand/collapse control
	#
	::$win $op $row -partly

	#
	# Restore the saved vertical position
	#
	$data(body) yview $topRow
	updateViewWhenIdle $win
    }
}

#------------------------------------------------------------------------------
# tablelist::priorNext
#
# Scrolls the tablelist view up or down by one page.
#------------------------------------------------------------------------------
proc tablelist::priorNext {win amount} {
    upvar ::tablelist::ns${win}::data data
    if {$data(editRow) >= 0} {
	return ""
    }

    ::$win yview scroll $amount pages
    ::$win activate @0,0
}

#------------------------------------------------------------------------------
# tablelist::homeEnd
#
# If selecttype is row then the procedure scrolls the tablelist widget
# horizontally to its left or right edge.  Otherwise it sets the location
# cursor (active element) to the first/last element of the active row, selects
# that element, and deselects everything else in the widget.
#------------------------------------------------------------------------------
proc tablelist::homeEnd {win keysym} {
    upvar ::tablelist::ns${win}::data data
    switch $data(-selecttype) {
	row {
	    switch $keysym {
		Home { ::$win xview moveto 0 }
		End  { ::$win xview moveto 1 }
	    }
	}

	cell {
	    set row $data(activeRow)
	    switch $keysym {
		Home { set col [firstViewableCol $win] }
		End  { set col [ lastViewableCol $win] }
	    }
	    changeSelection $win $row $col
	}
    }
}

#------------------------------------------------------------------------------
# tablelist::firstLast
#
# Sets the location cursor (active item or element) to the first/last item or
# element in the tablelist widget, selects that item or element, and deselects
# everything else in the widget.
#------------------------------------------------------------------------------
proc tablelist::firstLast {win target} {
    switch $target {
	first {
	    set row [firstViewableRow $win]
	    set col [firstViewableCol $win]
	}

	last {
	    set row [lastViewableRow $win]
	    set col [lastViewableCol $win]
	}
    }

    changeSelection $win $row $col
}

#------------------------------------------------------------------------------
# tablelist::extendUpDown
#
# Does nothing unless we are in extended selection mode; in this case it moves
# the location cursor (active item or element) up or down by one line, and
# extends the selection to that point.
#------------------------------------------------------------------------------
proc tablelist::extendUpDown {win amount} {
    upvar ::tablelist::ns${win}::data data
    if {[string compare $data(-selectmode) "extended"] != 0} {
	return ""
    }

    switch $data(-selecttype) {
	row {
	    set row $data(activeRow)
	    while 1 {
		incr row $amount
		if {$row < 0 || $row > $data(lastRow)} {
		    return ""
		} elseif {[isRowViewable $win $row]} {
		    ::$win activate $row
		    ::$win see active
		    motion $win $data(activeRow) -1
		    return ""
		}
	    }
	}

	cell {
	    set row $data(activeRow)
	    set col $data(activeCol)
	    while 1 {
		incr row $amount
		if {$row < 0 || $row > $data(lastRow)} {
		    return ""
		} elseif {[isRowViewable $win $row]} {
		    ::$win activatecell $row,$col
		    ::$win seecell active
		    motion $win $data(activeRow) $data(activeCol)
		    return ""
		}
	    }
	}
    }
}

#------------------------------------------------------------------------------
# tablelist::extendLeftRight
#
# Does nothing unless we are in extended selection mode and the selection type
# is cell; in this case it moves the location cursor (active element) left or
# right by one column, and extends the selection to that point.
#------------------------------------------------------------------------------
proc tablelist::extendLeftRight {win amount} {
    upvar ::tablelist::ns${win}::data data
    if {[string compare $data(-selectmode) "extended"] != 0} {
	return ""
    }

    switch $data(-selecttype) {
	row {
	    # Nothing
	}

	cell {
	    set row $data(activeRow)
	    set col $data(activeCol)
	    while 1 {
		incr col $amount
		if {$col < 0 || $col > $data(lastCol)} {
		    return ""
		} elseif {!$data($col-hide)} {
		    ::$win activatecell $row,$col
		    ::$win seecell active
		    motion $win $data(activeRow) $data(activeCol)
		    return ""
		}
	    }
	}
    }
}

#------------------------------------------------------------------------------
# tablelist::extendToHomeEnd
#
# Does nothing unless the selection mode is multiple or extended and the
# selection type is cell; in this case it moves the location cursor (active
# element) to the first/last element of the active row, and, if we are in
# extended mode, it extends the selection to that point.
#------------------------------------------------------------------------------
proc tablelist::extendToHomeEnd {win keysym} {
    upvar ::tablelist::ns${win}::data data
    switch $data(-selecttype) {
	row {
	    # Nothing
	}

	cell {
	    set row $data(activeRow)
	    switch $keysym {
		Home { set col [firstViewableCol $win] }
		End  { set col [ lastViewableCol $win] }
	    }

	    switch -- $data(-selectmode) {
		multiple {
		    ::$win activatecell $row,$col
		    ::$win seecell $row,$col
		}
		extended {
		    ::$win activatecell $row,$col
		    ::$win seecell $row,$col
		    if {[::$win selection includes anchor]} {
			motion $win $row $col
		    }
		}
	    }
	}
    }
}

#------------------------------------------------------------------------------
# tablelist::extendToFirstLast
#
# Does nothing unless the selection mode is multiple or extended; in this case
# it moves the location cursor (active item or element) to the first/last item
# or element in the tablelist widget, and, if we are in extended mode, it
# extends the selection to that point.
#------------------------------------------------------------------------------
proc tablelist::extendToFirstLast {win target} {
    switch $target {
	first {
	    set row [firstViewableRow $win]
	    set col [firstViewableCol $win]
	}

	last {
	    set row [lastViewableRow $win]
	    set col [lastViewableCol $win]
	}
    }

    upvar ::tablelist::ns${win}::data data
    switch $data(-selecttype) {
	row {
	    switch -- $data(-selectmode) {
		multiple {
		    ::$win activate $row
		    ::$win see $row
		}
		extended {
		    ::$win activate $row
		    ::$win see $row
		    if {[::$win selection includes anchor]} {
			motion $win $row -1
		    }
		}
	    }
	}

	cell {
	    switch -- $data(-selectmode) {
		multiple {
		    ::$win activatecell $row,$col
		    ::$win seecell $row,$col
		}
		extended {
		    ::$win activatecell $row,$col
		    ::$win seecell $row,$col
		    if {[::$win selection includes anchor]} {
			motion $win $row $col
		    }
		}
	    }
	}
    }
}

#------------------------------------------------------------------------------
# tablelist::cancelSelection
#
# This procedure is invoked to cancel an extended selection in progress.  If
# there is an extended selection in progress, it restores all of the items or
# elements between the active one and the anchor to their previous selection
# state.
#------------------------------------------------------------------------------
proc tablelist::cancelSelection win {
    upvar ::tablelist::ns${win}::data data
    if {[string compare $data(-selectmode) "extended"] != 0} {
	return ""
    }

    variable priv
    switch $data(-selecttype) {
	row {
	    set first $data(anchorRow)
	    set last $priv(prevRow)
	    if {[string compare $last ""] == 0} {
		return ""
	    }

	    if {$last < $first} {
		set tmp $first
		set first $last
		set last $tmp
	    }

	    ::$win selection clear $first $last
	    for {set row $first} {$row <= $last} {incr row} {
		if {[lsearch -exact $priv(selection) $row] >= 0} {
		    ::$win selection set $row
		}
	    }
	    event generate $win <<TablelistSelect>>
	}

	cell {
	    set firstRow $data(anchorRow)
	    set firstCol $data(anchorCol)
	    set lastRow $priv(prevRow)
	    set lastCol $priv(prevCol)
	    if {[string compare $lastRow ""] == 0 ||
		[string compare $lastCol ""] == 0} {
		return ""
	    }

	    if {$lastRow < $firstRow} {
		set tmp $firstRow
		set firstRow $lastRow
		set lastRow $tmp
	    }
	    if {$lastCol < $firstCol} {
		set tmp $firstCol
		set firstCol $lastCol
		set lastCol $tmp
	    }

	    ::$win cellselection clear $firstRow,$firstCol $lastRow,$lastCol
	    for {set row $firstRow} {$row <= $lastRow} {incr row} {
		for {set col $firstCol} {$col <= $lastCol} {incr col} {
		    if {[lsearch -exact $priv(selection) $row,$col] >= 0} {
			::$win cellselection set $row,$col
		    }
		}
	    }
	    event generate $win <<TablelistSelect>>
	}
    }
}

#------------------------------------------------------------------------------
# tablelist::selectAll
#
# This procedure is invoked to handle the "select all" operation.  For single
# and browse mode, it just selects the active item or element.  Otherwise it
# selects everything in the widget.
#------------------------------------------------------------------------------
proc tablelist::selectAll win {
    upvar ::tablelist::ns${win}::data data
    switch $data(-selecttype) {
	row {
	    if {[string compare $data(-selectmode) "single"] == 0 ||
		[string compare $data(-selectmode) "browse"] == 0} {
		::$win selection clear 0 end
		::$win selection set active
	    } else {
		::$win selection set 0 end
	    }
	}

	cell {
	    if {[string compare $data(-selectmode) "single"] == 0 ||
		[string compare $data(-selectmode) "browse"] == 0} {
		::$win cellselection clear 0,0 end
		::$win cellselection set active
	    } else {
		::$win cellselection set 0,0 end
	    }
	}
    }

    event generate $win <<TablelistSelect>>
}

#------------------------------------------------------------------------------
# tablelist::firstViewableRow
#
# Returns the index of the first viewable row of the tablelist widget win.
#------------------------------------------------------------------------------
proc tablelist::firstViewableRow win {
    upvar ::tablelist::ns${win}::data data
    for {set row 0} {$row < $data(itemCount)} {incr row} {
	if {[isRowViewable $win $row]} {
	    return $row
	}
    }

    return -1
}

#------------------------------------------------------------------------------
# tablelist::lastViewableRow
#
# Returns the index of the last viewable row of the tablelist widget win.
#------------------------------------------------------------------------------
proc tablelist::lastViewableRow win {
    upvar ::tablelist::ns${win}::data data
    for {set row $data(lastRow)} {$row >= 0} {incr row -1} {
	if {[isRowViewable $win $row]} {
	    return $row
	}
    }

    return -1
}

#------------------------------------------------------------------------------
# tablelist::firstViewableCol
#
# Returns the index of the first non-hidden column of the tablelist widget win.
#------------------------------------------------------------------------------
proc tablelist::firstViewableCol win {
    upvar ::tablelist::ns${win}::data data
    for {set col 0} {$col < $data(colCount)} {incr col} {
	if {!$data($col-hide)} {
	    return $col
	}
    }

    return -1
}

#------------------------------------------------------------------------------
# tablelist::lastViewableCol
#
# Returns the index of the last non-hidden column of the tablelist widget win.
#------------------------------------------------------------------------------
proc tablelist::lastViewableCol win {
    upvar ::tablelist::ns${win}::data data
    for {set col $data(lastCol)} {$col >= 0} {incr col -1} {
	if {!$data($col-hide)} {
	    return $col
	}
    }

    return -1
}

#------------------------------------------------------------------------------
# tablelist::condChangeSelection
#
# Activates the given item or element, and selects it exclusively if we are in
# browse or extended selection mode.
#------------------------------------------------------------------------------
proc tablelist::condChangeSelection {win row col} {
    upvar ::tablelist::ns${win}::data data
    switch $data(-selecttype) {
	row {
	    ::$win activate $row
	    ::$win see active

	    switch -- $data(-selectmode) {
		browse {
		    ::$win selection clear 0 end
		    ::$win selection set active
		    event generate $win <<TablelistSelect>>
		}
		extended {
		    ::$win selection clear 0 end
		    ::$win selection set active
		    ::$win selection anchor active
		    variable priv
		    set priv(selection) {}
		    set priv(prevRow) $data(activeRow)
		    event generate $win <<TablelistSelect>>
		}
	    }
	}

	cell {
	    ::$win activatecell $row,$col
	    ::$win seecell active

	    switch -- $data(-selectmode) {
		browse {
		    ::$win cellselection clear 0,0 end
		    ::$win cellselection set active
		    event generate $win <<TablelistSelect>>
		}
		extended {
		    ::$win cellselection clear 0,0 end
		    ::$win cellselection set active
		    ::$win cellselection anchor active
		    variable priv
		    set priv(selection) {}
		    set priv(prevRow) $data(activeRow)
		    set priv(prevCol) $data(activeCol)
		    event generate $win <<TablelistSelect>>
		}
	    }
	}
    }
}

#------------------------------------------------------------------------------
# tablelist::changeSelection
#
# Activates the given item or element and selects it exclusively.
#------------------------------------------------------------------------------
proc tablelist::changeSelection {win row col} {
    upvar ::tablelist::ns${win}::data data
    switch $data(-selecttype) {
	row {
	    ::$win activate $row
	    ::$win see active

	    ::$win selection clear 0 end
	    ::$win selection set active
	}

	cell {
	    ::$win activatecell $row,$col
	    ::$win seecell active

	    ::$win cellselection clear 0,0 end
	    ::$win cellselection set active
	}
    }

    event generate $win <<TablelistSelect>>
}

#
# Binding tags TablelistLabel, TablelistSubLabel, and TablelistArrow
# ==================================================================
#

#------------------------------------------------------------------------------
# tablelist::defineTablelistSubLabel
#
# Defines the binding tag TablelistSubLabel (for sublabels of tablelist labels)
# to have the same events as TablelistLabel and the binding scripts obtained
# from those of TablelistLabel by replacing the widget %W with the containing
# label as well as the %x and %y fields with the corresponding coordinates
# relative to that label.
#------------------------------------------------------------------------------
proc tablelist::defineTablelistSubLabel {} {
    foreach event [bind TablelistLabel] {
	set script [strMap {
	    "%W" "$tablelist::W"  "%x" "$tablelist::x"  "%y" "$tablelist::y"
	} [bind TablelistLabel $event]]

	bind TablelistSubLabel $event [format {
	    set tablelist::W \
		[string range %%W 0 [expr {[string length %%W] - 4}]]
	    set tablelist::x \
		[expr {%%x + [winfo x %%W] - [winfo x $tablelist::W]}]
	    set tablelist::y \
		[expr {%%y + [winfo y %%W] - [winfo y $tablelist::W]}]
	    %s
	} $script]
    }
}

#------------------------------------------------------------------------------
# tablelist::defineTablelistArrow
#
# Defines the binding tag TablelistArrow (for sort arrows) to have the same
# events as TablelistLabel and the binding scripts obtained from those of
# TablelistLabel by replacing the widget %W with the containing label as well
# as the %x and %y fields with the corresponding coordinates relative to that
# label.
#------------------------------------------------------------------------------
proc tablelist::defineTablelistArrow {} {
    foreach event [bind TablelistLabel] {
	set script [strMap {
	    "%W" "$tablelist::W"  "%x" "$tablelist::x"  "%y" "$tablelist::y"
	} [bind TablelistLabel $event]]

	bind TablelistArrow $event [format {
	    set tablelist::W \
		[winfo parent %%W].l[string range [winfo name %%W] 1 end]
	    set tablelist::x \
		[expr {%%x + [winfo x %%W] - [winfo x $tablelist::W]}]
	    set tablelist::y \
		[expr {%%y + [winfo y %%W] - [winfo y $tablelist::W]}]
	    %s
	} $script]
    }
}

#------------------------------------------------------------------------------
# tablelist::labelEnter
#
# This procedure is invoked when the mouse pointer enters the header label w of
# a tablelist widget, or is moving within that label.  It updates the cursor,
# displays the tooltip, and activates or deactivates the label, depending on
# whether the pointer is on its right border or not.
#------------------------------------------------------------------------------
proc tablelist::labelEnter {w X Y x} {
    parseLabelPath $w win col
    upvar ::tablelist::ns${win}::data data
    configLabel $w -cursor $data(-cursor)

    if {[string compare $data(-tooltipaddcommand) ""] != 0 &&
	[string compare $data(-tooltipdelcommand) ""] != 0 &&
	$col != $data(prevCol)} {
	#
	# Display the tooltip corresponding to this label
	#
	set data(prevCol) $col
	set focus [focus -displayof $win]
	if {[string compare $focus ""] == 0 ||
	    [string first $win $focus] != 0 ||
	    [string compare [winfo toplevel $focus] \
	     [winfo toplevel $win]] == 0} {
	    uplevel #0 $data(-tooltipaddcommand) [list $win -1 $col]
	    event generate $win <Leave>
	    event generate $win <Enter> -rootx $X -rooty $Y
	}
    }

    if {$data(isDisabled)} {
	return ""
    }

    if {[inResizeArea $w $x col] &&
	$data(-resizablecolumns) && $data($col-resizable)} {
	configLabel $w -cursor $data(-resizecursor)
	configLabel $w -active 0
    } else {
	configLabel $w -active 1
    }
}

#------------------------------------------------------------------------------
# tablelist::labelLeave
#
# This procedure is invoked when the mouse pointer leaves the header label w of
# a tablelist widget.  It removes the tooltip and deactivates the label.
#------------------------------------------------------------------------------
proc tablelist::labelLeave {w X x y} {
    parseLabelPath $w win col
    upvar ::tablelist::ns${win}::data data

    #
    # The following code is needed because the event
    # can also occur in a widget placed into the label
    #
    set hdrX [winfo rootx $data(hdr)]
    if {$X >= $hdrX && $X < $hdrX + [winfo width $data(hdr)] &&
	$x >= 1 && $x < [winfo width $w] - 1 &&
	$y >= 0 && $y < [winfo height $w]} {
	return ""
    }

    if {[string compare $data(-tooltipaddcommand) ""] != 0 &&
	[string compare $data(-tooltipdelcommand) ""] != 0} {
	#
	# Remove the tooltip, if any
	#
	event generate $win <Leave>
	catch {uplevel #0 $data(-tooltipdelcommand) [list $win]}
	set data(prevCol) -1
    }

    if {$data(isDisabled)} {
	return ""
    }

    configLabel $w -active 0
}

#------------------------------------------------------------------------------
# tablelist::labelB1Down
#
# This procedure is invoked when mouse button 1 is pressed in the header label
# w of a tablelist widget.  If the pointer is on the right border of the label
# then the procedure records its x-coordinate relative to the label, the width
# of the column, and some other data needed later.  Otherwise it saves the
# label's relief so it can be restored later, and changes the relief to sunken.
#------------------------------------------------------------------------------
proc tablelist::labelB1Down {w x shiftPressed} {
    parseLabelPath $w win col
    upvar ::tablelist::ns${win}::data data
    if {$data(isDisabled) ||
	[info exists data(colBeingResized)]} {	;# resize operation in progress
	return ""
    }

    set data(labelClicked) 1
    set data(X) [expr {[winfo rootx $w] + $x}]
    set data(shiftPressed) $shiftPressed

    if {[inResizeArea $w $x col] &&
	$data(-resizablecolumns) && $data($col-resizable)} {
	set data(colBeingResized) $col
	set data(colResized) 0

	set w $data(body)
	set topTextIdx [$w index @0,0]
	set btmTextIdx [$w index @0,[expr {[winfo height $w] - 1}]]
	$w tag add visibleLines "$topTextIdx linestart" "$btmTextIdx lineend"
	set data(topRow) [expr {int($topTextIdx) - 1}]
	set data(btmRow) [expr {int($btmTextIdx) - 1}]

	set w $data(hdrTxtFrLbl)$col
	set labelWidth [winfo width $w]
	set data(oldStretchedColWidth) [expr {$labelWidth - 2*$data(charWidth)}]
	set data(oldColDelta) $data($col-delta)
	set data(configColWidth) [lindex $data(-columns) [expr {3*$col}]]

	if {[lsearch -exact $data(arrowColList) $col] >= 0} {
	    set canvasWidth $data(arrowWidth)
	    if {[llength $data(arrowColList)] > 1} {
		incr canvasWidth 6
	    }
	    set data(minColWidth) $canvasWidth
	} elseif {$data($col-wrap)} {
	    set data(minColWidth) $data(charWidth)
	} else {
	    set data(minColWidth) 0
	}
	incr data(minColWidth)

	set data(focus) [focus -displayof $win]
	set topWin [winfo toplevel $win]
	focus $topWin
	set data(topEscBinding) [bind $topWin <Escape>]
	bind $topWin <Escape> \
	     [list tablelist::escape [strMap {"%" "%%"} $win] $col]
    } else {
	set data(inClickedLabel) 1
	set data(relief) [$w cget -relief]

	if {[info exists data($col-labelcommand)] ||
	    [string compare $data(-labelcommand) ""] != 0} {
	    set data(changeRelief) 1
	    configLabel $w -relief sunken -pressed 1
	} else {
	    set data(changeRelief) 0
	}

	if {$data(-movablecolumns)} {
	    set data(focus) [focus -displayof $win]
	    set topWin [winfo toplevel $win]
	    focus $topWin
	    set data(topEscBinding) [bind $topWin <Escape>]
	    bind $topWin <Escape> \
		 [list tablelist::escape [strMap {"%" "%%"} $win] $col]
	}
    }
}

#------------------------------------------------------------------------------
# tablelist::labelB1Motion
#
# This procedure is invoked to process mouse motion events in the header label
# w of a tablelist widget while button 1 is down.  If this event occured during
# a column resize operation then the procedure computes the difference between
# the pointer's new x-coordinate relative to that label and the one recorded by
# the last invocation of labelB1Down, and adjusts the width of the
# corresponding column accordingly.  Otherwise a horizontal scrolling is
# performed if needed, and the would-be target position of the clicked label is
# visualized if the columns are movable.
#------------------------------------------------------------------------------
proc tablelist::labelB1Motion {w X x y} {
    parseLabelPath $w win col
    upvar ::tablelist::ns${win}::data data
    if {!$data(labelClicked)} {
	return ""
    }

    if {[info exists data(colBeingResized)]} {	;# resize operation in progress
	set width [expr {$data(oldStretchedColWidth) + $X - $data(X)}]
	if {$width >= $data(minColWidth)} {
	    set col $data(colBeingResized)
	    set data(colResized) 1
	    set idx [expr {3*$col}]
	    set data(-columns) [lreplace $data(-columns) $idx $idx -$width]
	    set idx [expr {2*$col}]
	    set data(colList) [lreplace $data(colList) $idx $idx $width]
	    set data($col-lastStaticWidth) $width
	    set data($col-delta) 0
	    redisplayCol $win $col $data(topRow) $data(btmRow)

	    #
	    # Handle the case that the bottom row has become
	    # greater (due to the redisplayCol invocation)
	    #
	    set b $data(body)
	    set btmTextIdx [$b index @0,$data(btmY)]
	    set btmRow [expr {int($btmTextIdx) - 1}]
	    while {$btmRow > $data(btmRow)} {
		$b tag add visibleLines [expr {double($data(btmRow) + 2)}] \
					"$btmTextIdx lineend"
		incr data(btmRow)
		redisplayCol $win $col $data(btmRow) $btmRow
		set data(btmRow) $btmRow

		set btmTextIdx [$b index @0,$data(btmY)]
		set btmRow [expr {int($btmTextIdx) - 1}]
	    }

	    #
	    # Handle the case that the top row has become
	    # less (due to the redisplayCol invocation)
	    #
	    set topTextIdx [$b index @0,0]
	    set topRow [expr {int($topTextIdx) - 1}]
	    while {$topRow < $data(topRow)} {
		$b tag add visibleLines "$topTextIdx linestart" \
					"[expr {double($data(topRow))}] lineend"
		incr data(topRow) -1
		redisplayCol $win $col $topRow $data(topRow)
		set data(topRow) $topRow

		set topTextIdx [$b index @0,0]
		set topRow [expr {int($topTextIdx) - 1}]
	    }

	    adjustColumns $win {} 0
	    adjustElidedText $win
	    updateColors $win
	    updateVScrlbarWhenIdle $win
	}
    } else {
	#
	# Scroll the window horizontally if needed
	#
	set hdrX [winfo rootx $data(hdr)]
	if {$data(-titlecolumns) == 0 || ![winfo viewable $data(sep)]} {
	    set leftX $hdrX
	} else {
	    set leftX [expr {[winfo rootx $data(sep)] + 1}]
	}
	set rightX [expr {$hdrX + [winfo width $data(hdr)]}]
	set scroll 0
	if {($X >= $rightX && $data(X) < $rightX) ||
	    ($X < $leftX && $data(X) >= $leftX)} {
	    set scroll 1
	} elseif {($X < $rightX && $data(X) >= $rightX) ||
		  ($X >= $leftX && $data(X) < $leftX)} {
	    after cancel $data(afterId)
	    set data(afterId) ""
	}
	set data(X) $X
	if {$scroll} {
	    horizAutoScan $win
	}

	if {$x >= 1 && $x < [winfo width $w] - 1 &&
	    $y >= 0 && $y < [winfo height $w]} {
	    #
	    # The following code is needed because the event
	    # can also occur in a widget placed into the label
	    #
	    set data(inClickedLabel) 1
	    configLabel $w -cursor $data(-cursor)
	    $data(hdrTxtFrCanv)$col configure -cursor $data(-cursor)
	    if {$data(changeRelief)} {
		configLabel $w -relief sunken -pressed 1
	    }

	    place forget $data(colGap)
	} else {
	    #
	    # The following code is needed because the event
	    # can also occur in a widget placed into the label
	    #
	    set data(inClickedLabel) 0
	    configLabel $w -relief $data(relief) -pressed 0

	    if {$data(-movablecolumns)} {
		#
		# Get the target column index
		#
		set contW [winfo containing -displayof $w $X [winfo rooty $w]]
		if {[parseLabelPath $contW dummy targetCol]} {
		    set master $contW
		    if {$X < [winfo rootx $contW] + [winfo width $contW]/2} {
			set relx 0.0
		    } else {
			incr targetCol
			set relx 1.0
		    }
		} elseif {[string compare $contW $data(colGap)] == 0} {
		    set targetCol $data(targetCol)
		    set master $data(master)
		    set relx $data(relx)
		} elseif {$X >= $rightX || $X >= [winfo rootx $w]} {
		    for {set targetCol $data(lastCol)} {$targetCol >= 0} \
			{incr targetCol -1} {
			if {!$data($targetCol-hide)} {
			    break
			}
		    }
		    incr targetCol
		    set master $data(hdrTxtFr)
		    set relx 1.0
		} else {
		    for {set targetCol 0} {$targetCol < $data(colCount)} \
			{incr targetCol} {
			if {!$data($targetCol-hide)} {
			    break
			}
		    }
		    set master $data(hdrTxtFr)
		    set relx 0.0
		}

		#
		# Visualize the would-be target position
		# of the clicked label if appropriate
		#
		if {$targetCol == $col || $targetCol == $col + 1 ||
		    ($data(-protecttitlecolumns) &&
		     (($col >= $data(-titlecolumns) &&
		       $targetCol < $data(-titlecolumns)) ||
		      ($col < $data(-titlecolumns) &&
		       $targetCol > $data(-titlecolumns))))} {
		    catch {unset data(targetCol)}
		    configLabel $w -cursor $data(-cursor)
		    $data(hdrTxtFrCanv)$col configure -cursor $data(-cursor)
		    place forget $data(colGap)
		} else {
		    set data(targetCol) $targetCol
		    set data(master) $master
		    set data(relx) $relx
		    configLabel $w -cursor $data(-movecolumncursor)
		    $data(hdrTxtFrCanv)$col configure -cursor \
					    $data(-movecolumncursor)
		    place $data(colGap) -in $master -anchor n \
					-bordermode outside \
					-relheight 1.0 -relx $relx
		}
	    }
	}
    }
}

#------------------------------------------------------------------------------
# tablelist::labelB1Enter
#
# This procedure is invoked when the mouse pointer enters the header label w of
# a tablelist widget while mouse button 1 is down.  If the label was not
# previously clicked then nothing happens.  Otherwise, if this event occured
# during a column resize operation then the procedure updates the mouse cursor
# accordingly.  Otherwise it changes the label's relief to sunken.
#------------------------------------------------------------------------------
proc tablelist::labelB1Enter w {
    parseLabelPath $w win col
    upvar ::tablelist::ns${win}::data data
    if {!$data(labelClicked)} {
	return ""
    }

    configLabel $w -cursor $data(-cursor)

    if {[info exists data(colBeingResized)]} {	;# resize operation in progress
	configLabel $w -cursor $data(-resizecursor)
    } else {
	set data(inClickedLabel) 1
	if {$data(changeRelief)} {
	    configLabel $w -relief sunken -pressed 1
	}
    }
}

#------------------------------------------------------------------------------
# tablelist::labelB1Leave
#
# This procedure is invoked when the mouse pointer leaves the header label w of
# a tablelist widget while mouse button 1 is down.  If the label was not
# previously clicked then nothing happens.  Otherwise, if no column resize
# operation is in progress then the procedure restores the label's relief, and,
# if the columns are movable, then it changes the mouse cursor, too.
#------------------------------------------------------------------------------
proc tablelist::labelB1Leave {w x y} {
    parseLabelPath $w win col
    upvar ::tablelist::ns${win}::data data
    if {!$data(labelClicked) ||
	[info exists data(colBeingResized)]} {	;# resize operation in progress
	return ""
    }

    #
    # The following code is needed because the event
    # can also occur in a widget placed into the label
    #
    if {$x >= 1 && $x < [winfo width $w] - 1 &&
	$y >= 0 && $y < [winfo height $w]} {
	return ""
    }

    set data(inClickedLabel) 0
    configLabel $w -relief $data(relief) -pressed 0
}

#------------------------------------------------------------------------------
# tablelist::labelB1Up
#
# This procedure is invoked when mouse button 1 is released, if it was
# previously clicked in a label of the tablelist widget win.  If this event
# occured during a column resize operation then the procedure redisplays the
# column and stretches the stretchable columns.  Otherwise, if the mouse button
# was released in the previously clicked label then the procedure restores the
# label's relief and invokes the command specified by the -labelcommand or
# -labelcommand2 configuration option, passing to it the widget name and the
# column number as arguments.  Otherwise the column of the previously clicked
# label is moved before the column containing the mouse cursor or to its right,
# if the columns are movable.
#------------------------------------------------------------------------------
proc tablelist::labelB1Up {w X} {
    parseLabelPath $w win col
    upvar ::tablelist::ns${win}::data data
    if {!$data(labelClicked)} {
	return ""
    }

    if {[info exists data(colBeingResized)]} {	;# resize operation in progress
	configLabel $w -cursor $data(-cursor)
	if {[winfo exists $data(focus)]} {
	    focus $data(focus)
	}
	bind [winfo toplevel $win] <Escape> $data(topEscBinding)
	set col $data(colBeingResized)
	if {$data(colResized)} {
	    if {$data(-width) <= 0} {
		$data(hdr) configure -width $data(hdrPixels)
		$data(lb) configure -width \
			  [expr {$data(hdrPixels) / $data(charWidth)}]
	    } elseif {[info exists data(stretchableCols)] &&
		      [lsearch -exact $data(stretchableCols) $col] >= 0} {
		set oldColWidth \
		    [expr {$data(oldStretchedColWidth) - $data(oldColDelta)}]
		set stretchedColWidth \
		    [expr {$data(oldStretchedColWidth) + $X - $data(X)}]
		if {$oldColWidth < $data(stretchablePixels) &&
		    $stretchedColWidth >= $data(minColWidth) &&
		    $stretchedColWidth < $oldColWidth + $data(delta)} {
		    #
		    # Compute the new column width,
		    # using the following equations:
		    #
		    # $colWidth = $stretchedColWidth - $colDelta
		    # $colDelta / $colWidth =
		    #    ($data(delta) - $colWidth + $oldColWidth) /
		    #    ($data(stretchablePixels) + $colWidth - $oldColWidth)
		    #
		    set colWidth [expr {
			$stretchedColWidth *
			($data(stretchablePixels) - $oldColWidth) /
			($data(stretchablePixels) + $data(delta) -
			 $stretchedColWidth)
		    }]
		    if {$colWidth < 1} {
			set colWidth 1
		    }
		    set idx [expr {3*$col}]
		    set data(-columns) \
			[lreplace $data(-columns) $idx $idx -$colWidth]
		    set idx [expr {2*$col}]
		    set data(colList) \
			[lreplace $data(colList) $idx $idx $colWidth]
		    set data($col-delta) [expr {$stretchedColWidth - $colWidth}]
		}
	    }
	}
	unset data(colBeingResized)
	$data(body) tag remove visibleLines 1.0 end
	$data(body) tag configure visibleLines -tabs {}

	if {$data(colResized)} {
	    redisplayCol $win $col 0 end
	    adjustColumns $win {} 0
	    stretchColumns $win $col
	    updateColors $win
	    event generate $win <<TablelistColumnResized>>
	}
    } else {
	if {[info exists data(X)]} {
	    unset data(X)
	    after cancel $data(afterId)
	    set data(afterId) ""
	}
    	if {$data(-movablecolumns)} {
	    if {[winfo exists $data(focus)]} {
		focus $data(focus)
	    }
	    bind [winfo toplevel $win] <Escape> $data(topEscBinding)
	    place forget $data(colGap)
	}

	if {$data(inClickedLabel)} {
	    configLabel $w -relief $data(relief) -pressed 0
	    if {$data(shiftPressed)} {
		if {[info exists data($col-labelcommand2)]} {
		    uplevel #0 $data($col-labelcommand2) [list $win $col]
		} elseif {[string compare $data(-labelcommand2) ""] != 0} {
		    uplevel #0 $data(-labelcommand2) [list $win $col]
		}
	    } else {
		if {[info exists data($col-labelcommand)]} {
		    uplevel #0 $data($col-labelcommand) [list $win $col]
		} elseif {[string compare $data(-labelcommand) ""] != 0} {
		    uplevel #0 $data(-labelcommand) [list $win $col]
		}
	    }
	} elseif {$data(-movablecolumns)} {
	    $data(hdrTxtFrCanv)$col configure -cursor $data(-cursor)
	    if {[info exists data(targetCol)]} {
		moveCol $win $col $data(targetCol)
		event generate $win <<TablelistColumnMoved>>
	    }
	    catch {unset data(targetCol)}
	}
    }

    set data(labelClicked) 0
}

#------------------------------------------------------------------------------
# tablelist::labelB3Down
#
# This procedure is invoked when mouse button 3 is pressed in the header label
# w of a tablelist widget.  If the Shift key was down when this event occured
# then the procedure restores the last static width of the given column;
# otherwise it configures the width of the given column to be just large enough
# to hold all the elements (including the label).
#------------------------------------------------------------------------------
proc tablelist::labelB3Down {w shiftPressed} {
    parseLabelPath $w win col
    upvar ::tablelist::ns${win}::data data
    if {!$data(isDisabled) &&
	$data(-resizablecolumns) && $data($col-resizable)} {
	if {$shiftPressed} {
	    doColConfig $col $win -width -$data($col-lastStaticWidth)
	} else {
	    doColConfig $col $win -width 0
	}
	event generate $win <<TablelistColumnResized>>
    }
}

#------------------------------------------------------------------------------
# tablelist::labelDblB1
#
# This procedure is invoked when the header label w of a tablelist widget is
# double-clicked.  If the pointer is on the right border of the label then the
# procedure performs the same action as labelB3Down.
#------------------------------------------------------------------------------
proc tablelist::labelDblB1 {w x shiftPressed} {
    parseLabelPath $w win col
    upvar ::tablelist::ns${win}::data data
    if {!$data(isDisabled) && [inResizeArea $w $x col] &&
	$data(-resizablecolumns) && $data($col-resizable)} {
	if {$shiftPressed} {
	    doColConfig $col $win -width -$data($col-lastStaticWidth)
	} else {
	    doColConfig $col $win -width 0
	}
	event generate $win <<TablelistColumnResized>>
    }
}

#------------------------------------------------------------------------------
# tablelist::escape
#
# This procedure is invoked to process <Escape> events in the top-level window
# containing the tablelist widget win during a column resize or move operation.
# The procedure cancels the action in progress and, in case of column resizing,
# it restores the initial width of the respective column.
#------------------------------------------------------------------------------
proc tablelist::escape {win col} {
    upvar ::tablelist::ns${win}::data data
    set w $data(hdrTxtFrLbl)$col
    if {[info exists data(colBeingResized)]} {	;# resize operation in progress
	configLabel $w -cursor $data(-cursor)
	update idletasks
	if {![winfo exists $win]} {		;# because of update idletasks
	    return ""
	}
	if {[winfo exists $data(focus)]} {
	    focus $data(focus)
	}
	bind [winfo toplevel $win] <Escape> $data(topEscBinding)
	set data(labelClicked) 0
	set col $data(colBeingResized)
	set idx [expr {3*$col}]
	setupColumns $win [lreplace $data(-columns) $idx $idx \
				    $data(configColWidth)] 0
	redisplayCol $win $col $data(topRow) $data(btmRow)
	unset data(colBeingResized)
	$data(body) tag remove visibleLines 1.0 end
	$data(body) tag configure visibleLines -tabs {}
	adjustColumns $win {} 1
	updateColors $win
    } elseif {!$data(inClickedLabel)} {
	configLabel $w -cursor $data(-cursor)
	$data(hdrTxtFrCanv)$col configure -cursor $data(-cursor)
	if {[winfo exists $data(focus)]} {
	    focus $data(focus)
	}
	bind [winfo toplevel $win] <Escape> $data(topEscBinding)
	place forget $data(colGap)
	catch {unset data(targetCol)}
	if {[info exists data(X)]} {
	    unset data(X)
	    after cancel $data(afterId)
	    set data(afterId) ""
	}
	set data(labelClicked) 0
    }
}

#------------------------------------------------------------------------------
# tablelist::horizAutoScan
#
# This procedure is invoked when the mouse leaves the scrollable part of a
# tablelist widget's header frame.  It scrolls the header and reschedules
# itself as an after command so that the header continues to scroll until the
# mouse moves back into the window or the mouse button is released.
#------------------------------------------------------------------------------
proc tablelist::horizAutoScan win {
    if {![winfo exists $win]} {
	return ""
    }

    upvar ::tablelist::ns${win}::data data
    if {![info exists data(X)]} {
	return ""
    }

    set X $data(X)
    set hdrX [winfo rootx $data(hdr)]
    if {$data(-titlecolumns) == 0 || ![winfo viewable $data(sep)]} {
	set leftX $hdrX
    } else {
	set leftX [expr {[winfo rootx $data(sep)] + 1}]
    }
    set rightX [expr {$hdrX + [winfo width $data(hdr)]}]
    if {$data(-titlecolumns) == 0} {
	set units 2
	set ms 50
    } else {
	set units 1
	set ms 250
    }

    if {$X >= $rightX} {
	::$win xview scroll $units units
    } elseif {$X < $leftX} {
	::$win xview scroll -$units units
    } else {
	return ""
    }

    set data(afterId) [after $ms [list tablelist::horizAutoScan $win]]
}

#------------------------------------------------------------------------------
# tablelist::inResizeArea
#
# Checks whether the given x coordinate relative to the header label w of a
# tablelist widget is in the resize area of that label or of the one to its
# left.
#------------------------------------------------------------------------------
proc tablelist::inResizeArea {w x colName} {
    upvar $colName col
    parseLabelPath $w dummy _col

    if {$x >= [winfo width $w] - 5} {
	set col $_col
	return 1
    } elseif {$x < 5} {
	set X [expr {[winfo rootx $w] - 3}]
	set contW [winfo containing -displayof $w $X [winfo rooty $w]]
	return [parseLabelPath $contW dummy col]
    } else {
	return 0
    }
}
