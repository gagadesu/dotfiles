-- Specify Spoons which will be loaded
hspoon_list = {
	"WinWin",
}

-- -- appM environment keybindings. Bundle `id` is prefered, but application `name` will be ok.
-- hsapp_list = {
-- 	{ key = "a", name = "Atom" },
-- 	{ key = "c", id = "com.google.Chrome" },
-- 	{ key = "d", name = "ShadowsocksX" },
-- 	{ key = "e", name = "Emacs" },
-- 	{ key = "f", name = "Finder" },
-- 	{ key = "i", name = "iTerm" },
-- 	{ key = "k", name = "KeyCastr" },
-- 	{ key = "l", name = "Sublime Text" },
-- 	{ key = "m", name = "MacVim" },
-- 	{ key = "o", name = "LibreOffice" },
-- 	{ key = "p", name = "mpv" },
-- 	{ key = "r", name = "VimR" },
-- 	{ key = "s", name = "Safari" },
-- 	{ key = "t", name = "Terminal" },
-- 	{ key = "v", id = "com.apple.ActivityMonitor" },
-- 	{ key = "w", name = "Mweb" },
-- 	{ key = "y", id = "com.apple.systempreferences" },
-- }

-- Modal supervisor keybinding, which can be used to temporarily disable ALL modal environments.
hsupervisor_keys = { { "cmd", "shift", "ctrl" }, "Q" }

-- Reload Hammerspoon configuration
hsreload_keys = { { "cmd", "shift", "ctrl" }, "R" }

-- Toggle help panel of this configuration.
hshelp_keys = { { "alt", "shift" }, "/" }

----------------------------------------------------------------------------------------------------
-- Those keybindings below could be disabled by setting to {"", ""} or {{}, ""}

-- Window hints keybinding: Focuse to any window you want
hswhints_keys = { "alt", "tab" }

-- Read Hammerspoon and Spoons API manual in default browser
-- hsman_keys = { "alt", "H" }

-- resizeM environment keybinding: Windows manipulation
hsresizeM_keys = { "alt", "R" }

-- -- cheatsheetM environment keybinding: Cheatsheet copycat
-- hscheats_keys = { "alt", "S" }

-- Type the URL and title of the frontmost web page open in Google Chrome or Safari.
hstype_keys = { "alt", "V" }

-- Toggle Hammerspoon console
hsconsole_keys = { "alt", "Z" }
