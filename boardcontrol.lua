BoardControl = {
}

BoardControl.mt = {
	__index = BoardControl
}

function BoardControl.Create(board)
	local bc = {
		board = board,
		selectedtile = nil
	}
	return setmetatable(bc, BoardControl.mt)
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
end