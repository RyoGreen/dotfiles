#!/usr/bin/env sh

# Send the focused window to a display, then follow it.
#
# usage: win-to-display.sh <DISPLAY_SEL> [FALLBACK_DISPLAY_SEL]
#
# The fallback exists because prev/next do not wrap: on the last display
# "next" fails, so pass "first" to close the loop.
#
# The window id is captured before the move so the follow-up focus targets
# the window itself rather than re-resolving the display selector, which
# would point somewhere else once the fallback kicks in. Focusing a window
# that lives on another display moves display focus there as a side effect.

wid=$(yabai -m query --windows --window 2>/dev/null | jq -r '.id // empty')
[ -n "$wid" ] || exit 0

yabai -m window --display "$1" 2>/dev/null ||
    { [ -n "${2:-}" ] && yabai -m window --display "$2" 2>/dev/null; } ||
    exit 0

yabai -m window --focus "$wid"
