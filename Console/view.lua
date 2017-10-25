local View = Class()

function View:Create(rect, console)
    local window = UI.Window(rect)
    local lineheight = 16
    self.console = console

    self.window = window
    self.lineheight = lineheight

    self.scrollview = nil

    -- callbacks
    self.onSubmit = nil
    self.onClose = nil

    local windowwidth = rect.width

    local titlebar = UI.TitleBar("Console")
    titlebar:AddButton(
        "x",
        function()
            if self.onClose then
                self:onClose()
            end
        end
     )
     window:AddObject(titlebar,
        UI.AnchoredRect(
            Rect(0,0,windowwidth,lineheight),
            UI.AnchoredRect.presets.stretch.top))

    local scrollview = UI.ScrollView()
    scrollview.options.startsfrom = "bottom"
    scrollview.options.direction = "up"
    local ypos = lineheight + 5
    local inputheight = lineheight
    local scrollheight  = rect.height - ypos -inputheight -10
	local scrollrect = UI.AnchoredRect(
        Rect(5,ypos,windowwidth-10,scrollheight)
    )
	window:AddObject(scrollview, scrollrect)
    self.scrollview = scrollview

	local textinput = UI.TextInput()
    local textrect = UI.AnchoredRect(
        Rect(5, rect.height - inputheight - 5, windowwidth-10, inputheight)
    )
	textinput.onSubmit = function()
        local text = textinput.text.text
        textinput.text.text = ""
        if self.onSubmit then
            self.onSubmit(text)
        end
	end
	window:AddObject(textinput, textrect)
end

function View:AddEntry(text)
    local obj = UI.Text(text)
    obj.rect = UI.AnchoredRect(Rect(0,0,0,self.lineheight))
    self.scrollview:AddObject(obj)
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
