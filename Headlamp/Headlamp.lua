--// Attributes
local angle = script:GetAttribute("Angle")
local range = script:GetAttribute("Range")
local brightness = script:GetAttribute("Brightness")
local smoothing = script:GetAttribute("Smoothing")


--// Player Variables
local player = game.Players.LocalPlayer
local char = player.Character
local head = char:WaitForChild("Head")
local mouse = player:GetMouse()


--// Functions
function createLight()
	-- Part to anchor spotlight to
	local headlamp = Instance.new("Part", head)
	headlamp.Name = "headlamp"
	
	headlamp.Anchored = true
	headlamp.CanCollide = false	
	headlamp.Transparency = 1
	
	headlamp.CFrame = CFrame.lookAt(head.CFrame.Position, mouse.Hit.Position)
	
	-- Light
	local light = Instance.new("SpotLight", headlamp)
	light.Name = "light"
	light.Angle = angle
	light.Range = range
	light.Shadows = true
	light.Brightness = brightness
end

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

function orientLight(step)
	-- Orient light every frame to be where the mouse is
	local headlamp = head:FindFirstChild("headlamp")
	if headlamp then
		-- We only want the orientation, so we remove the position
		local goal = headlamp.CFrame:Lerp(CFrame.lookAt(head.CFrame.Position, mouse.Hit.Position), step / smoothing)
		goal = goal - goal.Position
		-- We then create a new CFrame using head's position and goal's orientation
		headlamp.CFrame = CFrame.new(head.CFrame.Position) * goal
	end
end


--// Hooks
game:GetService("UserInputService").InputBegan:Connect(inputHandler)
game:GetService("RunService").Heartbeat:Connect(orientLight)
