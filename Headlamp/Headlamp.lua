--[[
Headlamp

Creates a light on player's head to provide a light based on
	where they're looking at.
--]]

-- Variables to change
local angle = script:GetAttribute("Angle")
local range = script:GetAttribute("Range")
local brightness = script:GetAttribute("Brightness")
local smoothing = script:GetAttribute("Smoothing")


-- We grab the parent of this script, which should be
-- the player's character since this script client side
local player = game.Players.LocalPlayer
local char = player.Character
local head = char:WaitForChild("Head")
local mouse = player:GetMouse()

function createLight()
	local headlamp = Instance.new("Part", head)
	headlamp.Name = "headlamp"
	
	-- Create light and set attributes
	local light = Instance.new("SpotLight", headlamp)
	light.Name = "light"
	light.Angle = angle
	light.Range = range
	light.Shadows = true
	light.Brightness = brightness
	
	headlamp.Anchored = true
	headlamp.CanCollide = false	
	headlamp.Transparency = 1
	
	-- COMMENT OUT IF NOT DEBUGGING!!!
	angle = script:GetAttribute("Angle")
	range = script:GetAttribute("Range")
	brightness = script:GetAttribute("Brightness")
	smoothing = script:GetAttribute("Smoothing")
	-- COMMENT OUT IF NOT DEBUGGING!!!
	
	headlamp.CFrame = CFrame.lookAt(head.CFrame.Position, mouse.Hit.Position)
end

createLight()

function inputHandler(obj, _)
	-- Handle input for light toggling
	if obj.KeyCode == Enum.KeyCode.F or obj.KeyCode == Enum.KeyCode.ButtonX then
		if head:FindFirstChild("headlamp") then
			script.flashlight_off:Play()
			head:FindFirstChild("headlamp"):Destroy()
		else
			script.flashlight_on:Play()
			createLight()
		end
	end
end

local counter = 0

function orientLight(step)
	-- This will orient the part to be facing where the mouse is.
	local headlamp = head:FindFirstChild("headlamp")
	if headlamp then
		-- We only want the orientation, so we remove the position
		local goal = headlamp.CFrame:Lerp(CFrame.lookAt(head.CFrame.Position, mouse.Hit.Position), step / smoothing)
		goal = goal - goal.Position
		-- We then create a new CFrame using head's position and goal's orientation
		headlamp.CFrame = CFrame.new(head.CFrame.Position) * goal
	end
end

-- Grab Player's input
game:GetService("UserInputService").InputBegan:Connect(inputHandler)
game:GetService("RunService").Heartbeat:Connect(orientLight)