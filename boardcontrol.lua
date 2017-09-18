BoardControl = Class()

function BoardControl.Create(board)
	local bc = {
		board = board,
		selectedtile = nil
	}
	return bc
end

function BoardControl:UpdateEvents(events)
	if events.boardinput then
		local i = events.boardinput.event
		local m = i.mouse
		if m.button == 1 then 
			self:SelectTile(i.x, i.y)
		else
			if ui.selected then
				ui.selected.path = pathfinding:Path(ui.selected.tile, self.board:GetTile(i.x,i.y))
				--board:MoveObject(ui.selected, self.board:GetTile(i.x,i.y))
			end
		end
	end
end

function BoardControl:Update(dt)
	for t in self.board:GetTiles() do
		for i,o in ipairs(t.objects) do 
			o:Update(dt)
		end
	end
end

function BoardControl:SelectTile(x,y)
	if self.selectedtile then
		self.selectedtile.selected = false
	end
	local t = self.board:GetTile(x,y)
	self.selectedtile = t
	if t then		
		t.selected = true
		if #t.objects>0 then 
			ui:SelectObject(t.objects[1])
		else
			ui:SelectObject(nil)
		end
	end
end