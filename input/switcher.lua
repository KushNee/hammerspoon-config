module = {}

module.showCurrentMethod = function ()
  hs.alert.show(hs.keycodes.currentLayout())
end

module.toUSEnglish = function ()
  hs.keycodes.setLayout("U.S.")
end

module.toSimplePinyin = function ()
  hs.keycodes.setMethod("Shuangpin - Simplified")
end

return module
