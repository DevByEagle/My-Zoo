-- Behaviors/SitOnBench.lua
return function(npc)
	local benches = workspace:WaitForChild('Base'):WaitForChild("Benches"):GetChildren()
	local seat = benches[math.random(1, #benches)]:FindFirstChild("Seat")
	if seat then
		npc:WalkTo(seat.Position)
		wait(1)
		npc.Model:PivotTo(seat.CFrame) -- simulate sitting
		wait(math.random(5, 10))
	end
end
