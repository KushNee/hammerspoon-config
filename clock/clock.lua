function toggleShow()
    if timer then
        timer:stop()
        timer = nil
        canvas:hide()
    else
        local mainScreen = hs.screen.mainScreen()
        local mainRes = mainScreen:fullFrame()
        canvas = hs.canvas.new({x=0, y=0, w=0, h=0}):show()
        canvas[1] = {
            type = "text",
            text = "",
            textFont = "Impact",
            textSize = 130,
            textColor = {hex="#1891C3"},
            textAlignment = "center",
        }
        canvas:frame({
            x = (mainRes.w)/3,
            y = (mainRes.h)/3,
            w = 700,
            h = 460
        })
        canvas[1].text = os.date("%m/%d %a")
        canvas:show()
        timer = hs.timer.doAfter(4, function()
            canvas:hide()
            timer = nil
        end)
    end
end

hs.hotkey.bind({ "alt"}, "t", toggleShow)
