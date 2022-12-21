# Explanation
I think it would make more sense to explain everything here instead of in the code itself.

## Variables

### Attributes
    local angle = script:GetAttribute("Angle")
    local range = script:GetAttribute("Range")
    local brightness = script:GetAttribute("Brightness")
    local smoothing = script:GetAttribute("Smoothing")
<p>This is somewhat self explanatory. Basically, on the Script object, I added four attributes: Angle, Range, Brightness, and Smoothing. This allows me to change them in the editor's GUI on the fly instead of having to dig through the code to change the variable values. This makes it a little easier to tweak values and allows compatability with places that have different lighting settings.</p>

### Player 
  local player = game.Players.LocalPlayer
  local char = player.Character
  local head = char:WaitForChild("Head")
  local mouse = player:GetMouse()
<p>This just grabs the player itself, the player's character, as well as it's mouth. We use these to help position and orient the flashlight later on.</p>

## Functions

### createLight

	-- Part to anchor spotlight to
	local headlamp = Instance.new("Part", head)
	headlamp.Name = "headlamp"
<p>First things first, we need to create a part that we can manipulate separately from the player. The "Spotlight" object doesn't have a CFrame, it is oriented and positioned wherever its parent is, so we need to create a helper object to position it.</p>

	headlamp.Anchored = true
	headlamp.CanCollide = false	
	headlamp.Transparency = 1
<p>We then basically just disable any in-game interaction it might have. We disable physics moving it (Anchored), collision with other objects (CanCollide), and visibility (Transparency). This effectively removes it from the game but still gives us something to work with.</p>

	headlamp.CFrame = CFrame.lookAt(head.CFrame.Position, mouse.Hit.Position)
<p>We then just orient and position the headlamp part to be looking where we want to in the first place. That way as soon as the flashlight comes on, it's already in the right place.</p>

	-- Light
	local light = Instance.new("SpotLight", headlamp)
	light.Name = "light"
	light.Angle = angle
	light.Range = range
	light.Shadows = true
	light.Brightness = brightness
<p>Finally, we create the light. We set it's parent to the headlamp part so it'll inherit it's position and orientation.</p>

