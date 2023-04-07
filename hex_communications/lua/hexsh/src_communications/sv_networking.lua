-- 
util.AddNetworkString("HexSh.COMMS.Refresh")
util.AddNetworkString("HexComms::Error")
util.AddNetworkString("HexComms::OpenTrafficMenu")
util.AddNetworkString("HexSh.COMMS.SendCommLog")
util.AddNetworkString("HexSh.COMMS.SyncCommTraffic")
util.AddNetworkString("HexSh.COMMS.OpenMenu")
util.AddNetworkString("HexComms::addNewCommToTraffic")
util.AddNetworkString("HexComms::sendCommMessage")

net.Receive("HexComms::OpenTrafficMenu", function(len,ply)
    if (HexSh.Config.Comms.CommTrafficAcces[ply:GetUserGroup()] || HexSh.Config.Comms.CommTrafficAcces[ply:getJobTable().name]) then 
        net.Start("HexComms::OpenTrafficMenu")
            HexSh:WriteCompressedTable(HexSh.Comms.Log)
        net.Send(ply)
    end
end)
--[[net.Receive("HexSh.COMMS.OpenMenu", function(len,ply)
    local expotbl = {}
    local counttbl = table.Count(HexSh.Comms.Log)
    local mathh = counttbl > 20 && counttbl - 20 || 1 
    for i=mathh, counttbl do 
        expotbl[i] = HexSh.Comms.Log[i]
    end 

    for k,v in pairs(expotbl) do 
        if (v.Type=="GLOBAL") then 
            
        end
    end

    net.Start("HexSh.COMMS.OpenMenu")
        HexSh:WriteCompressedTable(expotbl)
    net.Send(ply)
end)]]