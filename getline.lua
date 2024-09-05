local rawterm = require("rawterm")

local stdout = io.stdout

local function getline(prompt)
	stdout:write(prompt)
	rawterm.enableRawMode()
	return coroutine.wrap(function()
		local input = {}
		while true do
			local c = io.read(1) or "\0"
			local cbyte = c:byte()
			if cbyte == 0 or cbyte == 13 then
				stdout:write("\n")
				break
			elseif cbyte == 4 and #input == 0 then
				stdout:write("\n")
				return
			else
				stdout:write(c)
				input[#input + 1] = c
			end
		end
		rawterm.disableRawMode()
		return table.concat(input)
	end)()
end

return {
	getline = getline
}
