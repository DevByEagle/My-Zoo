local roamPoints = workspace:WaitForChild("NPCPaths"):GetChildren()

return function(npc)
	while true do
		local target = roamPoints[math.random(1, #roamPoints)]
		npc:WalkTo(target.Position)
		wait(math.random(3, 7)) -- pause before next move
	end
end