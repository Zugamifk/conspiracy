BoardControl = Class()

function BoardControl.Create(board)
	local bc = {
		board = board,
		selectedtile = nil
	}
	return bc
end

function BoardControl:Update(events)
	if events.boardinput then
		local i = events.boardinput.event
		self:SelectTile(i.x, i.y)
	end
end

function BoardControl:SelectTile(x,y)
	if self.selectedtile then
		self.selectedtile.selected = false
	end
	local t = self.board:GetTile(x,y)
	t.selected = true
	self.selectedtile = t
	if #t.objects>0 then 
		ui:SelectObject(t.objects[1])
	else
		ui:SelectObject(nil)
	end
end