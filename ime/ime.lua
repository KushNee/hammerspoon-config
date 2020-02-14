local function Chinese()
    -- hs.keycodes.currentSourceID("com.apple.inputmethod.SCIM.Shuangpin")
    hs.keycodes.currentSourceID("com.logcg.inputmethod.LogInputMac2.LogInputMac2SP")
end

local function English()
    -- hs.keycodes.currentSourceID("com.apple.keylayout.ABC")
    hs.keycodes.currentSourceID("com.logcg.inputmethod.LogInputMac2.LogInputMac2SP")
end

-- app to expected ime config
local app2Ime = {
    {'/Applications/kitty.app', 'English'},
    {'/Applications/Xcode.app', 'English'},
    {'/Applications/Firefox.app', 'Chinese'},
    {'/System/Library/CoreServices/Finder.app', 'English'},
    {'/Applications/DingTalk.app', 'Chinese'},
    {'/Applications/微信.app', 'Chinese'},
    {'/Applications/System Preferences.app', 'English'},
    {'/Applications/Dash.app', 'English'},
    {'/Applications/MindNode.app', 'Chinese'},
    {'/Applications/Preview.app', 'Chinese'},
    {'/Applications/wechatwebdevtools.app', 'English'},
    {'/Applications/Emacs.app', 'English'},
    {'/Applications/Kodi.app', 'English'},
    {'/Users/kushnee/Library/Application Support/JetBrains/Toolbox/apps/IDEA-U/ch-0/193.5662.53/IntelliJ IDEA.app', 'English'},
    {'/Users/kushnee/Library/Application Support/JetBrains/Toolbox/apps/PyCharm-P/ch-0/193.5662.61/PyCharm.app', 'English'},
    {'/Users/kushnee/Library/Application Support/JetBrains/Toolbox/apps/CLion/ch-0/193.5662.56/CLion.app', 'English'},
    {'/Users/kushnee/Library/Application Support/JetBrains/Toolbox/apps/Goland/ch-0/193.5233.112/GoLand.app', 'English'},
}

function updateFocusAppInputMethod()
    local focusAppPath = hs.window.frontmostWindow():application():path()
    for index, app in pairs(app2Ime) do
        local appPath = app[1]
        local expectedIme = app[2]

        if focusAppPath == appPath then
            if expectedIme == 'English' then
                English()
            else
                Chinese()
            end
            break
        end
    end
end

function showName()
  inputName = ""
  if hs.keycodes.currentMethod() ~= nil then
    inputName = hs.keycodes.currentMethod()
  else
    inputName = hs.keycodes.currentLayout()
  end
  hs.alert.show(string.format("输入法：%s", inputName), 0.75)
end

-- Handle cursor focus and application's screen manage.
function applicationWatcher(appName, eventType, appObject)
    if (eventType == hs.application.watcher.activated) then
        updateFocusAppInputMethod()
        showName()
    end
end

appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()
