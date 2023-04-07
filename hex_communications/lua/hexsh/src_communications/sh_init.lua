HexSh.Comms = HexSh.Comms or {}
HexSh.Comms.Log = HexSh.Comms.Log or {}
if (CLIENT) then 
    surface.CreateFont( "HexSh.COMMS.Title", {
        font = "Arial",
        extended = false,
        size = ScrH() * 0.090,
        weight = 1000,
        blursize = 0,
        scanlines = 0,
        antialias = true,
        underline = false,
        italic = false,
        strikeout = false,
        symbol = false,
        rotary = false,
        shadow = false,
        additive = false,
        outline = false,
    } )

	surface.CreateFont( "HexSh.40", {
        font = "Arial", 
        extended = false,
        size = ScrH() * 0.040,
        weight = 1000,
        blursize = 0,
        scanlines = 0, 
        antialias = true,
        underline = false,
        italic = false,
        strikeout = false,
        symbol = false,
        rotary = false,
        shadow = false,
        additive = false,
        outline = false,
    } )
    surface.CreateFont( "HexSh.20", {
        font = "Arial", 
        extended = false,
        size = ScrH() * 0.020,
        weight = 1000,
        blursize = 0,
        scanlines = 0, 
        antialias = true,
        underline = false,
        italic = false,
        strikeout = false,
        symbol = false,
        rotary = false,
        shadow = false,
        additive = false,
        outline = false,
    } )
    surface.CreateFont( "HexSh.30", {
        font = "Arial", 
        extended = false,
        size = ScrH() * 0.030,
        weight = 1000,
        blursize = 0,
        scanlines = 0, 
        antialias = true,
        underline = false,
        italic = false,
        strikeout = false,
        symbol = false,
        rotary = false,
        shadow = false,
        additive = false,
        outline = false,
    } )
    surface.CreateFont( "HexSh.50", {
        font = "Arial", 
        extended = false,
        size = ScrH() * 0.050,
        weight = 1000,
        blursize = 0,
        scanlines = 0, 
        antialias = true,
        underline = false,
        italic = false,
        strikeout = false,
        symbol = false,
        rotary = false,
        shadow = false,
        additive = false,
        outline = false,
    } )
end

local function loadDir( dir )
	local files = file.Find( dir .. "/*", "LUA" );

	for k, v in pairs(files) do 
		if (v == "sh_init.lua" && dir == "hexsh/src_communications") then continue end 
        if string.StartWith(v, "sh") then
			local load = include(dir.. "/".. v)
			if load then load() end
			AddCSLuaFile(dir.. "/".. v)
		end

        if string.StartWith(v, "cl") then
			if CLIENT then 
				local load = include(dir.. "/".. v)
				if load then load() end
			end
			AddCSLuaFile(dir.. "/".. v)
		end
	
		if string.StartWith(v, "sv") then
			if SERVER then 
				local load = include(dir.. "/".. v)
				if load then load() end
			end
		end
	end
end 

--[[ load ]]
loadDir( "hexsh/src_communications" )
loadDir( "hexsh/src_communications/lang" )
