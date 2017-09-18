UserInterface = Class()

function UserInterface.Create()
	local ui = {
		style = UI.Style(),
		statusbar = UI.StatusBar("Hello, World!"),

		selectables = {}, -- objects that can recieve input
		windows = {}
	}
	
	local windowwidth = 300
	local graphwindow = UI.Window(Rect(400,25,windowwidth,600))
	graphwindow:AddObject(UI.StatusBar("UI Test Window"))
	
	local graph = UI.Graph()
	graph:AddLine(nil, function (x) return x*x end,0,10,-2,2)
	graphwindow:AddObject(graph, Rect(25,25,200,100))
	
	local scrollview = UI.ScrollView()
	local scrollrect = Rect(10,150,windowwidth-20,380)
	for i=1,50 do
		scrollview:AddObject(UI.Text("Line "..i), Rect(0,0,scrollrect.width,ui.style.lineheight))
	end
	graphwindow:AddObject(scrollview, scrollrect)
	
	table.insert(ui.selectables, scrollview.scrollbar)
	table.insert(ui.selectables, graphwindow)
	
	table.insert(ui.windows, graphwindow)
	
	return setmetatable(ui, UserInterface.mt)
end

function UserInterface:Draw(rect)
	local w = rect.width
	local h = rect.height
	local x = rect.x
	local y = rect.y
	if self.selected then
		local selectedrect = rect:Copy()
		selectedrect.x = w - 300
		selectedrect.width = 290
		selectedrect.y = h - 200
		selectedrect.height = 190
		UI.Box(selectedrect, self.style)
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
	
	for i,s in ipairs(self.windows) do
		s:Draw(rect, self.style)
	end
	
	self.statusbar:Draw(rect, self.style)
end

function UserInterface:SelectObject(object)
	self.selected = object
end