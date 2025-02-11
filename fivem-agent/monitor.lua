-- fivem-agent/monitor.lua

-- A simple JSON encode function for our purposes.
function toJSON(tbl)
    local json = "{"
    local first = true
    for k, v in pairs(tbl) do
        if not first then json = json .. "," end
        first = false
        if type(v) == "string" then
            json = json .. string.format('"%s":"%s"', k, v)
        else
            json = json .. string.format('"%s":%s', k, tostring(v))
        end
    end
    json = json .. "}"
    return json
end

Citizen.CreateThread(function()
    while true do
        -- Simulate metrics: you would replace these with real data.
        local cpuUsage = math.random(50, 100)       -- Simulated CPU usage percentage.
        local memoryUsage = math.random(200, 500)     -- Simulated memory usage in MB.
        local data = {
            cpu = cpuUsage,
            memory = memoryUsage,
            timestamp = os.time()
        }
        local jsonData = toJSON(data)
        
        -- Send the data to the backend
        PerformHttpRequest('http://localhost:3000/metrics', function(err, text, headers)
            if err ~= 200 then
                print("Error sending metrics: " .. tostring(err))
            end
        end, 'POST', jsonData, { ['Content-Type'] = 'application/json' })
        
        Citizen.Wait(5000)  -- Wait 5 seconds before sending the next metric.
    end
end)
