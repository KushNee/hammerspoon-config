-- Window Switcher

local choices = {}
local width = 30

local screenshot = nil
local preChoice = nil
local timer = hs.timer.new(0.3, function ()
  local currentChoice = switcher:selectedRowContents()

  if preChoice == nil or preChoice.wid ~= currentChoice.wid then
    if screenshot ~= nil then
      screenshot:hide()
    end

    local app = hs.application.applicationForPID(currentChoice.pid)
    local window = app:getWindow(currentChoice.wid) or app:mainWindow()
    local windowFrame = window:frame()

    local switcherFrame = hs.window.focusedWindow():frame()

    local snapshot = hs.window.snapshotForID(currentChoice.wid)
    local w = switcherFrame.w
    local h = w * (windowFrame.h / windowFrame.w)
    local x = switcherFrame.x + switcherFrame.w + 5
    local y = switcherFrame.y
    screenshot = hs.drawing.image({x = x, y = y, w = w, h = h}, snapshot)
    screenshot:setBehavior(hs.drawing.windowBehaviors.moveToActiveSpace)
    screenshot:show()
    preChoice = currentChoice
  end
end)

switcher = hs.chooser.new(function (choice)
  if choice ~= nil then
    local app = hs.application.applicationForPID(choice.pid)
    local windows = app:allWindows()

    print(hs.inspect.inspect(app))
    app:activate()
    if #windows > 0 then
      local window = app:getWindow(choice.wid)
      print(hs.inspect.inspect(window))
      print(window:isMinimized())
      if window:isMinimized() then
        window:unminimize()
      end
      window:focus()
    end
  end
  -- clear switcher query string
  if switcher:query() ~= "" then
    switcher:query("")
  end

  screenshot:hide()
  timer:stop()
  preChoice = nil
end)

switcher:queryChangedCallback(function (query)
  local result = hs.fnutils.filter(choices, function (item)
    function isMatch(text)
      return string.match(string.lower(text), string.lower(query))
    end
    return isMatch(item.text) or isMatch(item.subText)
  end)
  switcher:choices(result)
  timer:start()
end)

function showSwitcher(part)
  switcher:width(width)
  switcher:show()
  local wf
  if part == true then
    wf=hs.window.filter.new():setCurrentSpace(true):setScreens(hs.screen.mainScreen():name())
  else
    wf=hs.window.filter.new(true)
  end
  local windows = wf:getWindows()
  choices = hs.fnutils.map(windows, function (window)
    local app = window:application()

    if app:name() ~= "" 
    and app:name() ~= "Hammerspoon" then
    -- and (app:name() ~= "Hammerspoon" or (app:name() == "Hammerspoon" and window:title() == "Hammerspoon Console")) then
      return {
        wid = window:id(),
        pid = app:pid(),
        text = window:title(),
        subText = app:name(),
        image = hs.image.imageFromAppBundle(app:bundleID())
      }
    end
  end)

  switcher:choices(choices)
  timer:start()
end

switcherTapper = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function (evt)
  local flags = evt:getFlags()
  local keyCode = evt:getKeyCode()

  -- reset timer if press down or up when switcher is visible
  if switcher:isVisible() and flags['ctrl'] then
    if keyCode == 45 or keyCode == 35 then
      timer:stop()
      timer:start()
    end
  end
end)
switcherTapper:start()

switchBind = hs.hotkey.bind({ "alt" }, "tab", function ()
  if switcher:isVisible() then
    hs.eventtap.keyStroke({ "ctrl" }, "n")
  else
    showSwitcher(true)
  end
end)

switchAllBind = hs.hotkey.bind({"alt", "shift"}, "tab", function ()
  if switcher:isVisible() then
    hs.eventtap.keyStroke({"ctrl"}, "n")
  else
    showSwitcher(false)
  end
end)

