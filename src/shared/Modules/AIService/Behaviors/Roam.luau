local RoamPoints = workspace:WaitForChild('NPCPaths'):GetChildren()

return function(npc, onFinished)
    local moves = 5
    
    local function doNextMove(count)
        if count > moves then
            if onFinished then onFinished() end
            return
        end

        local target = RoamPoints[math.random(1, #RoamPoints)]
        npc:WalkTo(target.Position)

        task.delay(math.random(3, 7), function()
            doNextMove(count + 1)
        end)
    end

    doNextMove(1)
end