local View = Class()

function View.Create(rect, console)
    local window = UI.Window(rect)
    local lineheight = 16
    local view = {

        console = console,

        window = window,
        lineheight = lineheight,

        scrollview = nil,

        -- callbacks
        onSubmit = nil,
        onClose = nil
    }
    local windowwidth = rect.width

    local titlebar = UI.TitleBar("Console")
    titlebar:AddButton(
        "x",
        function()
            if view.onClose then
                view:onClose()
            end
        end
     )
    window:AddObject(titlebar, Rect(0,0,windowwidth,lineheight))

    local scrollview = UI.ScrollView()
    scrollview.options.startsfrom = "bottom"
    scrollview.options.direction = "up"
    local ypos = lineheight + 5
    local inputheight = lineheight
    local scrollheight  = rect.height - ypos -inputheight -10
	local scrollrect = Rect(5,ypos,windowwidth-10,scrollheight)
	window:AddObject(scrollview, scrollrect)
    view.scrollview = scrollview

    ypos = ypos + scrollheight + 3
	local textinput = UI.TextInput()
	textinput.onSubmit = function()
        local text = textinput.text.text
        textinput.text.text = ""
        if view.onSubmit then
            view.onSubmit(text)
        end
	end
	window:AddObject(textinput, Rect(5,ypos, windowwidth-10, lineheight+4))

    return view
end

function View:AddEntry(text)
    self.scrollview:AddObject(UI.Text(text), Rect(0,0,0,self.lineheight))
    if self.scrollview:ContentsLength() > self.console.max then
        self.scrollview:RemoveObject(1)
    end
end

function View:Update(dt)
    local i = 1
    for m in self.console:Entries() do
        if i > self.scrollview:ContentsLength() then
            self:AddEntry(m)
        else
            self.scrollview:GetObject(i):SetText(m)
        end
        i = i + 1
    end
end

return View
