local UI = Class()
function UI.Init()
    local ui = UI.UserInterface()
    local windowwidth = 300
	local graphwindow = UI.Window(Rect(400,25,windowwidth,600))
	graphwindow:AddObject(UI.StatusBar("UI Test Window"))

	local graph = UI.Graph()
	graph:AddLine(nil, function (x) return x*x end,0,10,-2,2)
	graphwindow:AddObject(graph, Rect(25,25,200,100))

	local scrollview = UI.ScrollView()
	local scrollrect = Rect(10,150,windowwidth-100,380)
	graphwindow:AddObject(scrollview, scrollrect)

	local textinput = UI.TextInput()
	textinput.onSubmit = function()
		scrollview:AddObject(UI.Text(textinput.text.text), Rect(0,0,scrollrect.width,ui.style.lineheight))
		textinput.text.text = ""
	end
	graphwindow:AddObject(textinput, Rect(10,550, windowwidth-100, ui.style.lineheight+5))

    self.base:AddWindow("uitest", graphwindow)

    local statusbar = UI.StatusBar("Hello, World!")
    statusbar:AddButton(
        "T",
        function()
            controller:SetWindowActive("uitest")
        end
    )


    	--Console.Initialize(uicontrol)

    	--local animeditor = Animation.Editor.Window(Rect(400,0,400,600), ui)

    -- todo: fix
    --ui.statusbar = statusbar
    --ui.selectables.statusbar = statusbar:GetSelectables()
    self.ui = ui
end
return UI
