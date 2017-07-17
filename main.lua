require "mathx"
require "class"
require "console"
require "consolecontrol"
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

require "userinterface"

require "wang"
require "wangtiles"

function love.load()
	console = Console()
	consolecontrol = ConsoleControl(console)
	
	board = Board()
	boardcontrol = BoardControl(board)
	
	TileGraphics.Init(board)
	
	local dx, dy = love.graphics.getDimensions()
	camera = Camera(5,5,dx,dy, 10)
	cameracontrol = CameraControl(camera)
	
	ui = UserInterface()
	
	-- wang = Wang.Create()
	-- wangtiles = WangTiles.Create(wang)
	-- wang:Generate(board)
	assets = Assets()
	assets:Load()
end

function love.draw()
	camera:Draw(board)
	console:Draw(0,0,500,500)
end

function love.update(dt)
	Input:DoEvents(consolecontrol)
	Input:DoEvents(cameracontrol)
	Input:DoEvents(boardcontrol)
	Input:Update()
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

function love.wheelmoved( x, y )
	Input:GenerateEvent("mousewheelX", x)
	Input:GenerateEvent("mousewheelY", y)
	console:Log("mousewheel: "..x..", "..y)
end

function love.mousepressed( x, y, button, istouch )
	Input:GenerateEvent("mousebutton", {x=x,y=y,button=button,buttonEvent="pressed"})
	console:Log("mousebutton pressed: "..button..", "..x..", "..y)
end

function love.mousereleased(x,y,button)
	Input:GenerateEvent("mousebutton", {x=x,y=y,button=button,buttonEvent="released"})
	console:Log("mousebutton released: "..button..", "..x..", "..y)
end