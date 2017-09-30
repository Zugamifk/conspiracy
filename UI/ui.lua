UI = Namespace{
	Events = require "UI/events",

	Colors = require "UI/colors",
	Style = require "UI/style",

	Draw = require "UI/draw",

	Selectable = require "UI/selectable",
}

UI:AddNames{
	Text = "UI/text",
	Button =  "UI/button",
	TextInput = "UI/textinput",
	TitleBar = "UI/titlebar",
	StatusBar = "UI/statusbar",
	Graph = "UI/graph",
	ScrollView = "UI/scrollview",
	Window = "UI/window"
}

UI:AddNames{
	UserInterface = "UI/userinterface"
}

function UI.BeginMask(rect)
	-- this stencil is for objects in viewport
	love.graphics.stencil(
		function()
			love.graphics.rectangle("fill", rect.x, rect.y, rect.width, rect.height)
		end,
		"replace",
		1)
	love.graphics.setStencilTest("greater", 0)
end

function UI.EndMask()
	love.graphics.setStencilTest()
end
