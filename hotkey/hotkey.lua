local hyper = {'ctrl', 'cmd'}

-- hs.hotkey.bind({"cmd"}, "L", hs.caffeinate.systemSleep)

-- show front activated app infos
hs.hotkey.bind(
    hyper, ".",
    function()
      hs.alert.show(string.format("App path:        %s\nApp name:      %s\nApp ID:            %s\nIM source id:  %s",
                                    hs.window.focusedWindow():application():path(),
                                    hs.window.focusedWindow():application():name(),
                                    hs.window.focusedWindow():application():bundleID(),
                                    hs.keycodes.currentLayout()))
    end)

hs.hotkey.bind(
  hyper, "h",
  function()
    os.execute("sh /Users/kushnee/heyspace.sh")
  end
)
