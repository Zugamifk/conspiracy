require "mathx"
vec2 = require "vec2"
callback = require "callback"
argassert = require"assertarg"
require "tablep"
require "tableo"

require "namespace"
require "class"
require "rect"
require "circle"

require "Graph/graph"

require "Console/console"

require "assets"
require "tile"
require "tilegraphics"
require "character"
require "board"
require "boardcontrol"
require "cameracontext"
require "camera"
require "input"
require "cameracontrol"
require "distribution"
require "pathfinding"

require "UI/ui"
require "Editors/editor"

require "Animation/animation"

require "wang"
require "wangtiles"

function love.load()
	console = Console.OldConsole()
	consolecontrol = Console.OldControl(console)

	board = Board()
	boardcontrol = BoardControl(board)
	pathfinding = PathFinding(board)

	TileGraphics.Init(board)

	local dx, dy = love.graphics.getDimensions()
	camera = Camera(5,5,dx,dy, 10)
	cameracontrol = CameraControl(camera)

	editor = Editor.UI()

--	tablep.Test()
	--tableo.test()

	-- argassert.test()
	UI.AnchoredRect.Test()

	-- wang = Wang.Create()
	-- wangtiles = WangTiles.Create(wang)
	-- wang:Generate(board)
	assets = Assets()
	assets:Load()
end

function love.draw()
	camera:Draw(board)
	editor:Draw()
	console:Draw(0,0,500,500)
end

function love.update(dt)
	Input:DoEvents(consolecontrol)
	Input:DoEvents(editor.ui)
	Input:DoEvents(cameracontrol)
	Input:DoEvents(boardcontrol)
	Input:Update()

	editor:Update()
	Console.Update()

	boardcontrol:Update(dt)
end

function love.keypressed( key, scancode, isrepeat )
	if key == 'escape' then
		love.event.push('quit') -- Quit the game.
	end
	if key == 'r' then
		love.load()
	end
	Input:GenerateEvent(scancode, "pressed")
	console:Log("pressed "..scancode.." key: "..key)
end

function love.textinput(text)
	Input:GenerateEvent("textinput", text)
	console:Log("textinput: "..text)
end

function love.wheelmoved( x, y )
	Input:GenerateEvent("mousewheelX", x)
	Input:GenerateEvent("mousewheelY", y)
	console:Log("mousewheel: "..x..", "..y)
end

function love.mousepressed( x, y, button, istouch )
	Input:GenerateEvent("mousebutton", {x=x,y=y,button=button,buttonevent="pressed"})
	console:Log("mousebutton pressed: "..button..", "..x..", "..y)
end

function love.mousereleased(x,y,button)
	Input:GenerateEvent("mousebutton", {x=x,y=y,button=button,buttonevent="released"})
	console:Log("mousebutton released: "..button..", "..x..", "..y)
end

function love.resize(w,h)
	camera.width = w
	camera.height = h
end
