local http = require("http")

function onRequest(req, res)
    local body = ""

    -- Capture POST data
    req:on("data", function(data)
        body = body .. data
    end)

    req:on("end", function()
        print("HTTP " .. req.httpVersion .. " " .. req.method .. " " .. req.url .. "\n")

        for i = 1, #req.headers do
            local header = req.headers[i]
            print(header[1] .. " = " .. header[2])
        end

        local responseValue = "11111110" -- default output

        if req.method == "POST" then
            print("POST received:\n" .. body .. "\n")

            -- when Roblox transmits input data (POST)
            -- this is the "received POST" output value
            responseValue = "11111111"  -- 👈 can be a different 8-bit value if needed
        end

        -- Build JSON response
        local str = '{"value":' .. responseValue .. '}'
        res:writeHead(200, {
            ["Content-Length"] = #str,
            ["Content-Type"] = "application/json"
        })
        res:finish(str)
    end)
end

http.createServer(onRequest):listen(8080)
print("running (GET = output 11111110, POST = output 11111111)")
