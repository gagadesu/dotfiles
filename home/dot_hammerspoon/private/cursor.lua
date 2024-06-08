-- Move cursor between screens

hyperCtrl = { "alt", "ctrl" }

local hotkey = require("hs.hotkey")
local window = require("hs.window")
local screen = require("hs.screen")
local fnutils = require("hs.fnutils")
local geometry = require("hs.geometry")
local mouse = require("hs.mouse")

-- -- move cursor to previous monitor
-- hotkey.bind(hyperCtrl, "Left", function()
-- 	focusScreen(window.focusedWindow():screen():previous())
-- end)
--
-- -- move cursor to next monitor
-- hotkey.bind(hyperCtrl, "Right", function()
-- 	focusScreen(window.focusedWindow():screen():next())
-- end)

hotkey.bind(hyperCtrl, "Up", function()
	focusScreen2(window.focusedWindow():screen():next(), "top")
end)

hotkey.bind(hyperCtrl, "Down", function()
	focusScreen2(window.focusedWindow():screen():next(), "bottom")
end)

-- -- predicate that checks if a window belongs to a screen
-- function isInScreen(screen, win)
-- 	return win:screen() == screen
-- end

-- function focusScreen(screen)
-- 	--Get windows within screen, ordered from front to back.
-- 	--If no windows exist, bring focus to desktop. Otherwise, set focus on
-- 	--front-most application window.
-- 	local windows = fnutils.filter(window.orderedWindows(), fnutils.partial(isInScreen, screen))
-- 	local windowToFocus = #windows > 0 and windows[1] or window.desktop()
-- 	windowToFocus:focus()
--
-- 	-- move cursor to center of screen
-- 	local pt = geometry.rectMidPoint(screen:fullFrame())
-- 	mouse.setAbsolutePosition(pt)
-- end

function focusScreen2(screen, position)
	-- Get windows within screen, ordered from front to back.
	-- If no windows exist, bring focus to desktop. Otherwise, set focus on
	-- front-most application window.
	local windows = fnutils.filter(window.orderedWindows(), function(win)
		return win:screen() == screen
	end)
	local windowToFocus = #windows > 0 and windows[1] or window.desktop()
	windowToFocus:focus()

	-- Move cursor to the specified position on the screen
	local frame = screen:fullFrame()
	local pt

	if position == "top" then
		pt = { x = frame.x + frame.w / 2, y = frame.y + frame.h / 4 }
	elseif position == "bottom" then
		pt = { x = frame.x + frame.w / 2, y = frame.y + (3 * frame.h / 4) }
	else
		pt = geometry.rectMidPoint(frame)
	end

	mouse.absolutePosition(pt)
end
