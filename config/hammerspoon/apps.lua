local function toggleApplication(name)
    local app = hs.application.find(name)
    if not app or app:isHidden() then
      hs.application.launchOrFocus(name)
    elseif hs.application.frontmostApplication() ~= app then
      app:activate()
    else
      app:hide()
    end
  end
  
  hs.hotkey.bind(mash, "e", function() toggleApplication("Emacs") end)
  hs.hotkey.bind(mash, "b", function() toggleApplication("Arc") end)
  hs.hotkey.bind(mash, "f", function() toggleApplication("Finder") end)
  hs.hotkey.bind(mash, "m", function() toggleApplication("Mathematica") end)
  hs.hotkey.bind(mash, "o", function() toggleApplication("Microsoft Outlook") end)
  hs.hotkey.bind(mash, "p", function() toggleApplication("System Preferences") end)
  hs.hotkey.bind(mash, "t", function() toggleApplication("Terminal") end)