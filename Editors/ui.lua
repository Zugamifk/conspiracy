local EditorUI = Class()
function EditorUI:Create()
    local ui = UI.UserInterface()

    local statusbar = UI.StatusBar("Hello, World!")
    statusbar:AddButton(
        "~",
        function()
            controller:SetWindowActive("console")
            console.enabled = not console.enabled
        end
    )
    statusbar:AddButton(
         "A",
         function()
             controller:SetWindowActive("animation")
         end
    )
    statusbar:AddButton(
        "T",
        function()
            controller:SetWindowActive("uitest")
        end
    )
    ui:AddObjectToMainWindow()

    Console.Initialize(ui.control)

    local animeditor = Animation.Editor.Window(Rect(400,0,400,600), ui.control)

    self.ui = ui
end

function EditorUI:Update()
    -- if events["`"] and events["`"].event == "pressed" then
	-- 	self:SetWindowActive("console")
	-- end
    self.ui:Update()
end

function EditorUI:Draw()
	-- old
	if self.selected then
		local selectedrect = rect:Copy()
		selectedrect.x = w - 300
		selectedrect.width = 290
		selectedrect.y = h - 200
		selectedrect.height = 190
		UI.Draw.FramedBox(selectedrect, self.style)
		selectedrect.x = selectedrect.x + 10
		selectedrect.width = 32
		selectedrect.y = selectedrect.y + 10
		selectedrect.height = 32

		love.graphics.setColor(
			255,255,255
		)
		if self.selected.Draw then
			self.selected:Draw(selectedrect)
		else
			love.graphics.rectangle("fill", unpack(selectedrect))
		end
	end
    self.ui.view:Draw()
end

-- old
function EditorUI:SelectObject(object)
	self.selected = object
end
return EditorUI
