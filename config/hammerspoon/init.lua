mash = {"⌘", "⌥", "⌃"}

require "apps"
require "grid"

hs.hotkey.bind(mash, "r", function() hs.reload(); end)
hs.hotkey.bind(mash, "-", function() hs.caffeinate.lockScreen(); end)
hs.hotkey.bind(mash, "a", function()
    hs.caffeinate.set("displayIdle", true, true)
    hs.caffeinate.set("systemIdle", true, true)
    hs.caffeinate.set("system", true, true)
    hs.alert.show("Preventing Sleep")
  end)
hs.hotkey.bind(mash, "s", function()
    hs.caffeinate.set("displayIdle", false, true)
    hs.caffeinate.set("systemIdle", false, true)
    hs.caffeinate.set("system", false, true)
    hs.alert.show("Allowing Sleep")
  end)
hs.alert("Hammerspoon config loaded")