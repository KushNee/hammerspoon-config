local chooser = require("hs.chooser")
local console = require("hs.console")
local inspect = require("hs.inspect")
local styledtext = require("hs.styledtext")

local completionFn = function(result)
	print(string.format("Result: %s", result and inspect(result)))
end

local fancyText = styledtext.new("First Choice", {
        color = {hex = "#FF0000", alpha = 1},
        font = { name = "Futura", size = 18 },
    })

local fancySubText = styledtext.new("This is the subtext of the first choice", {
        color = {hex = "#FF0000", alpha = 1},
        font = { name = "Futura", size = 12 },
    })

console.printStyledtext(fancyText)
console.printStyledtext(fancySubText)

local function getChoices()
    return {
        {
            ["text"] = fancyText,
            ["subText"] = fancySubText,
            ["uuid"] = "0001"
        },
        { 
            ["text"] = fancyText,
            ["uuid"] = "Bbbb"
        },
        { 
            ["text"] = "Third Possibility",
            ["subText"] = "What a lot of choosing there is going on here!",
            ["uuid"] = "III3"
        },
        {
            ["text"] = fancyText,
            ["subText"] = fancySubText,
            ["uuid"] = "0001"
        },
        { 
            ["text"] = fancyText,
            ["uuid"] = "Bbbb"
        },
        { 
            ["text"] = "Third Possibility",
            ["subText"] = "What a lot of choosing there is going on here!",
            ["uuid"] = "III3"
        },
        {
            ["text"] = fancyText,
            ["subText"] = fancySubText,
            ["uuid"] = "0001"
        },
        { 
            ["text"] = fancyText,
            ["uuid"] = "Bbbb"
        },
        { 
            ["text"] = "Third Possibility",
            ["subText"] = "What a lot of choosing there is going on here!",
            ["uuid"] = "III3"
        },
        {
            ["text"] = fancyText,
            ["subText"] = fancySubText,
            ["uuid"] = "0001"
        },
        { 
            ["text"] = fancyText,
            ["uuid"] = "Bbbb"
        },
        { 
            ["text"] = "Third Possibility",
            ["subText"] = "What a lot of choosing there is going on here!",
            ["uuid"] = "III3"
        },
        {
            ["text"] = fancyText,
            ["subText"] = fancySubText,
            ["uuid"] = "0001"
        },
        { 
            ["text"] = fancyText,
            ["uuid"] = "Bbbb"
        },
        { 
            ["text"] = "Third Possibility",
            ["subText"] = "What a lot of choosing there is going on here!",
            ["uuid"] = "III3"
        },				
    }
end

theChooser = chooser.new(completionFn)
	:choices(getChoices)
	:rightClickCallback(function() 
	    theChooser:refreshChoicesCallback() 
	    print("refresh!")
	end)
	:show()