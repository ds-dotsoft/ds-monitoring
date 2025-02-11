-- fivem-agent/monitor.lua

--- Advanced Monitoring Agent for FiveM.
-- This script collects key server metrics every 5 seconds:
-- * Memory usage (in KB) via `collectgarbage("count")`
-- * Tick time (calculated from `GetGameTimer()` differences)
-- * Player count (via `GetPlayers()`)
-- 
-- The metrics are then encoded as JSON and sent to a Node.js backend.
-- @module monitor

--- Starts the monitoring loop.
-- Collects metrics and sends them to the backend every 5 seconds.
Citizen.CreateThread(function()
    local lastTick = GetGameTimer()

    while true do
        local currentTick = GetGameTimer()
        local tickTime = currentTick - lastTick  -- Tick time in milliseconds.
        lastTick = currentTick

        --- Collect memory usage in kilobytes.
        local memoryUsage = collectgarbage("count")

        --- Retrieve the current number of players.
        local players = GetPlayers() or {}
        local playerCount = #players

        --- Get current Unix timestamp.
        local timestamp = os.time()

        --- Build the data table to be sent.
        local data = {
            memory = memoryUsage,   -- Memory usage in KB.
            tickTime = tickTime,    -- Tick time in ms.
            playerCount = playerCount,
            timestamp = timestamp
        }

        --- Encode the data table as a JSON string using FiveM's built-in JSON library.
        local jsonData = json.encode(data)

        --- Send the JSON data to the Node.js backend.
        PerformHttpRequest("http://localhost:3000/metrics", function(errorCode, resultData, resultHeaders)
            if errorCode ~= 200 then
                print("[Monitor] Error sending metrics: " .. tostring(errorCode))
            end
        end, 'POST', jsonData, { ["Content-Type"] = "application/json" })

        --- Wait 5 seconds (5000 milliseconds) before sending the next update.
        Citizen.Wait(5000)
    end
end)