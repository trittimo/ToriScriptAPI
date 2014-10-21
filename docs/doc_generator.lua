-- Documentation skeleton generator by Motota
local ignore = dofile("struct.txt")

local maxGen = 4

local function traverse(t, gen)
	gen = gen or 0
	if (gen > maxGen) then
		return {}
	end

	local doc = {}
	for k, v in pairs(t) do
		if gen > 0 and k == "_G" then
			return {"table"}
		end
		if type(v) == "table" then
			doc[k] = traverse(v, gen + 1)
		elseif type(v) == "function" then
			doc[k] = "function"
		else
			doc[k] = v
		end
	end
	return doc
end

local function writeToFile(file, t, prepend)
	prepend = prepend or ""
	for k, v in pairs(t) do
		if not ignore[k] then
			if type(v) == "table" then
				file:write(prepend .. k .." ->\n")
				writeToFile(file, v, prepend.."\t")
			else
				file:write(prepend .. k .." -> ")
				file:write(prepend .. tostring(v) .. "\n")
			end
		end
	end
end

local file = io.open("doc_skeleton.txt", "w")
writeToFile(file, traverse(_G))
file:close()