local M = {}

local TARGET_SCREEN_NAME = "flipgo"
local TARGET_SCREEN_UUID = "63174F3C-2517-46D3-A8FA-FB300927477F"

local DEBOUNCE_SECONDS = 0.18
local EDGE_TOLERANCE = 12
local HORIZONTAL_TOLERANCE = 24
local EXTRA_TOLERANCE = 32
local HINGE_GAP = 0

local pending = {}
local adjusting = {}

local function isTargetScreen(screen)
	if not screen then
		return false
	end

	if TARGET_SCREEN_UUID then
		return screen:getUUID() == TARGET_SCREEN_UUID
	end

	local name = (screen:name() or ""):lower()
	return name:find(TARGET_SCREEN_NAME, 1, true) ~= nil
end

local function matchesHorizontalTile(windowFrame, usableFrame)
	local windowRight = windowFrame.x + windowFrame.w
	local usableRight = usableFrame.x + usableFrame.w
	local nearLeft = math.abs(windowFrame.x - usableFrame.x) <= HORIZONTAL_TOLERANCE
	local nearRight = math.abs(windowRight - usableRight) <= HORIZONTAL_TOLERANCE
	local widthRatio = windowFrame.w / usableFrame.w

	local fullWidth = widthRatio >= 0.75 and (nearLeft or nearRight)
	local edgeTile = widthRatio >= 0.38 and widthRatio < 0.75 and (nearLeft or nearRight)

	return fullWidth or edgeTile
end

local function hingeTileSide(windowFrame, usableFrame, fullFrame)
	local hingeY = fullFrame.y + fullFrame.h / 2
	local windowBottom = windowFrame.y + windowFrame.h
	local menuBarHeight = usableFrame.y - fullFrame.y
	local plausibleOffset = math.max(menuBarHeight + EXTRA_TOLERANCE, 48)

	local roughlyHalfHeight = math.abs(windowFrame.h - fullFrame.h / 2)
		<= plausibleOffset
	if not roughlyHalfHeight or not matchesHorizontalTile(windowFrame, usableFrame) then
		return nil
	end

	local nearTop = math.abs(windowFrame.y - usableFrame.y) <= EDGE_TOLERANCE
	local overrun = windowBottom - hingeY
	if nearTop and overrun > 1 and overrun <= plausibleOffset then
		return "top"
	end

	local usableBottom = usableFrame.y + usableFrame.h
	local nearBottom = math.abs(windowBottom - usableBottom) <= HORIZONTAL_TOLERANCE
	local gapAboveHinge = windowFrame.y - hingeY
	if nearBottom and gapAboveHinge > 1 and gapAboveHinge <= plausibleOffset then
		return "bottom"
	end

	return nil
end

function M.correctWindow(window)
	if not window or not window:isStandard() or window:isFullScreen() then
		return
	end

	local screen = window:screen()
	if not isTargetScreen(screen) then
		return
	end

	local windowFrame = window:frame()
	local usableFrame = screen:frame()
	local fullFrame = screen:fullFrame()

	local tileSide = hingeTileSide(windowFrame, usableFrame, fullFrame)
	if not tileSide then
		return
	end

	local hingeY = fullFrame.y + fullFrame.h / 2
	local correctedY = windowFrame.y
	local correctedHeight

	if tileSide == "top" then
		correctedHeight = hingeY - windowFrame.y - HINGE_GAP
	else
		local windowBottom = windowFrame.y + windowFrame.h
		correctedY = hingeY + HINGE_GAP
		correctedHeight = windowBottom - correctedY
	end

	if correctedHeight <= 0 then
		return
	end

	local windowID = window:id()
	adjusting[windowID] = true

	local targetFrame = hs.geometry.rect(
		windowFrame.x,
		correctedY,
		windowFrame.w,
		correctedHeight
	)

	window:setFrame(targetFrame, 0)
	hs.timer.doAfter(0.25, function()
		adjusting[windowID] = nil
	end)
end

local function scheduleCorrection(window)
	local windowID = window and window:id()
	if not windowID or adjusting[windowID] then
		return
	end

	if pending[windowID] then
		pending[windowID]:stop()
	end

	pending[windowID] = hs.timer.doAfter(DEBOUNCE_SECONDS, function()
		pending[windowID] = nil

		local ok, err = pcall(M.correctWindow, window)
		if not ok then
			hs.printf("[flipgo-hinge] %s", err)
		end
	end)
end

M.watcher = hs.window.filter.new(function(window)
	return window:isStandard() and window:isVisible() and not window:isFullScreen()
end, "flipgo-hinge")

M.watcher:subscribe(hs.window.filter.windowMoved, scheduleCorrection)

return M
