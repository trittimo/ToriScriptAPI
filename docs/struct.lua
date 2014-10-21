local f = io.open("struct.txt", "w")
f:write("return {")
for k,v in pairs(_G) do
	f:write("[\"".. k .. "\"]" .."=true,")
end
f:write("}")
f:close()