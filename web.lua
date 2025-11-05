local http = require('http')

function onRequest(req, res)
	req:on("data",function(data) print(data.."\n") end)
	
	print("HTTP".." "..req.httpVersion.." "..req.method.." "..req.url.."\n")
	
	for i=1,#req.headers do
		local header = req.headers[i]
		print(header[1].." = "..header[2])
	end
	print("\n")
	local str = '{"value":11111111}'
	res:writeHead(200,{
		["Content-Length"] = #str,
		["Content-Type"] = "application/json"
	})
	res:finish(str)
end

http.createServer(onRequest):listen(8080)
print('running')
