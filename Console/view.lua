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
        onSubmit = nil
    }
    local windowwidth = rect.width
    local scrollview = UI.ScrollView()
    scrollview.options.startsfrom = "bottom"
    scrollview.options.direction = "up"
	local scrollrect = Rect(10,10,windowwidth-20,rect.height - lineheight - 20)
	window:AddObject(scrollview, scrollrect)
    view.scrollview = scrollview

	local textinput = UI.TextInput()
	textinput.onSubmit = function()
        local text = textinput.text.text
        textinput.text.text = ""
        if view.onSubmit then
            view.onSubmit(text)
        end
	end
	window:AddObject(textinput, Rect(10,rect.height - lineheight - 8, windowwidth-20, lineheight+5))

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
