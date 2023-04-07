local MODULE = bLogs:Module()

MODULE.Category = "HexComms"
MODULE.Name = "CommMessages"
MODULE.Colour = Color(42, 135, 229)
MODULE:Hook("HexComms::Messages", "HexComms::Messages", function(ply, type, prefix, content )
    MODULE:Log("{"..type.."} - ".. ply:GetName() .. " " ..tostring(prefix).." ~" .. content )
end)

bLogs:AddModule(MODULE)