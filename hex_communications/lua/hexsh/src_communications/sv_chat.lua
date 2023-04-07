// heeh
hook.Add( "PlayerSay", "HexSh.COMMS.Chathook", function(ply, text ) 
    local args = string.Explode(" ", text)
    local cmd = string.lower(args[1])

    for k,v in pairs( HexSh.Config.Comms.commChatCommands ) do 
        local sif = isstring(v.MessageForPrint(ply)) && v.MessageForPrint(ply) || "";
        if (cmd == v.Command) then 
            if (v.Type=="GLOBAL") then 
                if (!v.AccessFor(ply)==true) then return "" end 
                if args[2] == nil then net.Start("HexComms::Error") net.WriteString(HexSh:L("src_communications","GF.Arg")) net.Send(ply) return "" end
                if args[2] == "" then net.Start("HexComms::Error") net.WriteString(HexSh:L("src_communications","GF.Arg")) net.Send(ply) return "" end
                local send = {
                    Prefix = v.Prefix,
                    Sender = ply:GetName(),
                    Color = v.Color,
                    Sound = v.NotifySound,
                    Content = " " .. sif .. " " .. tostring(string.Trim(text .. args[1], args[1]))
                }
                local log = {
                    Type = "GLOBAL",
                    Encryptlevel = v.Encryptlevel,
                    Color = v.Color,
                    Sender = ply:GetName(),
                    Content = sif .. tostring(string.Trim(text .. args[1], args[1])),    
                    Time = os.date("%H:%M:%S"),
                    Prefix = v.Prefix,
                }
                table.insert(HexSh.Comms.Log,log)
    
                for _,p in pairs( player.GetAll() ) do 
                    if (!v.VisibleFor(ply)==true) then continue end

                    net.Start("HexComms::sendCommMessage")
                    HexSh:WriteCompressedTable(send)
                    net.Send(p)
                end

                hook.Call("HexComms::Messages", "HexComms::Messages", ply, "GLOBAL", v.Prefix, sif .. tostring(string.Trim(text .. args[1], args[1])))
                return ""
            elseif (v.Type=="PRIVATE") then 
                if (!v.AccessFor(ply)==true) then return "" end 
                if args[2] == nil then net.Start("HexComms::Error") net.WriteString(HexSh:L("src_communications","PF.Targetname.Error")) net.Send(ply) return "" end
                if args[3] == nil then net.Start("HexComms::Error") net.WriteString(HexSh:L("src_communications","PF.3Arg.Error")) net.Send(ply) return "" end

                if HexSh:FindPlayer(args[2]) then
                    if HexSh:FindPlayer(args[2]):GetName() == ply:GetName() then net.Start("HexComms::Error") net.WriteString(HexSh:L("src_communications","PF.CWys")) net.Send(ply) return "" end
                    if HexSh:FindPlayer(args[2]):IsBot() then net.Start("HexComms::Error") net.WriteString(HexSh:L("src_communications","PF.NonPlayer.Error")) net.Send(ply) return "" end
                    if !HexSh:FindPlayer(args[2]):IsPlayer() then net.Start("HexComms::Error") net.WriteString(HexSh:L("src_communications","PF.NonPlayer.Error")) net.Send(ply) return "" end
                
                    local send = {
                        Prefix = v.Prefix,
                        Sender = ply:GetName(),
                        Receiver = HexSh:FindPlayer(args[2]),
                        Color = v.Color,
                        Sound = v.NotifySound,
                        Content = " " .. sif .. " " .. tostring(string.Trim(text .. args[1], args[1]))
                    }

                    local log = {
                        Type = "GLOBAL",
                        Encryptlevel = v.Encryptlevel,
                        Color = v.Color,
                        Sender = ply:GetName(),
                        Receiver = HexSh:FindPlayer(args[2]),
                        Content = sif .. tostring(string.Trim(text .. args[1], args[1])),    
                        Time = os.date("%H:%M:%S"),
                        Prefix = v.Prefix,
                    }
                    table.insert(HexSh.Comms.Log,log)
        
                    if args[2] == nil then net.Start("HexComms::Error") net.WriteString(HexSh:L("src_communications","GF.Arg")) net.Send(ply) return "" end
                    net.Start("HexComms::sendCommMessage")
                        HexSh:WriteCompressedTable(send)
                    net.Send( HexSh:FindPlayer(args[2]) )

                    hook.Call("HexComms::Messages", "HexComms::Messages", ply, "PRIVATE", v.Prefix, sif .. tostring(string.Trim(text .. args[1], args[1])))
                    return ""
                else
                    net.Start("HexComms::Error") 
                    net.WriteString(HexSh:L("src_communications","Playernotfound")) 
                    net.Send(ply)
                    return "" 
                end
            elseif (v.Type=="SEMI") then 
                if (!v.AccessFor(ply)==true) then return "" end 
                if args[2] == nil then net.Start("HexComms::Error") net.WriteString(HexSh:L("src_communications","GF.Arg")) net.Send(ply) return "" end
                if args[2] == "" then net.Start("HexComms::Error") net.WriteString(HexSh:L("src_communications","GF.Arg")) net.Send(ply) return "" end
                local send = {
                    Prefix = v.Prefix,
                    Sender = ply:GetName(),
                    Color = v.Color,
                    Sound = v.NotifySound,
                    Content = " " .. sif .. " " .. tostring(string.Trim(text .. args[1], args[1]))
                }
                local log = {
                    Type = "GLOBAL",
                    Encryptlevel = v.Encryptlevel,
                    Color = v.Color,
                    Sender = ply:GetName(),
                    Content = sif .. tostring(string.Trim(text .. args[1], args[1])),    
                    Time = os.date("%H:%M:%S"),
                    Prefix = v.Prefix,
                }
                table.insert(HexSh.Comms.Log,log)

                for _,p in pairs( player.GetAll() ) do 
                    if (!v.VisibleFor(ply)==true) then continue end

                    net.Start("HexComms::sendCommMessage")
                    HexSh:WriteCompressedTable(send)
                    net.Send(p)
                end

                hook.Call("HexComms::Messages", "HexComms::Messages", ply, "PRIVATE", v.Prefix, sif .. tostring(string.Trim(text .. args[1], args[1])))
                return ""
            end
        end
    end
end )
