require "mathx"
require "console"
require "tile"
require "tilegraphics"
require "board"
require "boardcontrol"
require "camera"
require "input"
require "cameracontrol"

function love.load()
	console = Console.Create()
	board = Board.Create()
	boardcontrol = BoardControl.Create(board)
	
	local dx, dy = love.graphics.getDimensions()
	camera = Camera.Create(5,5,dx,dy, 10)
	cameracontrol = CameraControl.Create(camera)
end

function love.draw()
	camera:Draw(board)
	console:Draw(0,0,300,500)
end

function love.update(dt)
	Input:DoEvents(cameracontrol)
	Input:DoEvents(boardcontrol)
	Input:Update()
end

function love.keypressed( key, scancode, isrepeat )
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
	console:Log("mousebutton: "..button..", "..x..", "..y)
end