local TextInput = Class()

function TextInput.Create()
    local textinput = {
        text = UI.Text()
    }

    local select = UI.Selectable(Rect.Zero())
    select.textinput = function(text)
        textinput:AddText(text)
        console:Log("text: "..text)
    end
    textinput.selectable = select

    return textinput
end

function TextInput:AddText(text)
    self.text:SetText(self.text.text..text)
end

function TextInput:Draw(rect, style)
    UI.Draw.FramedBox(rect, style)
    self.text:Draw(rect, style)
    self.selectable.rect = rect
end

return TextInput
