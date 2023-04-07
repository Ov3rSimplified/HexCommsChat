net.Receive("HexComms::Error", function()
    local read = net.ReadString()
    notification.AddLegacy( read, NOTIFY_ERROR, 3 )
end)

net.Receive("HexSh.COMMS.SyncCommTraffic", function()
    local read = HexSh:ReadCompressedTable()
    HexSh.Comms.Log = read
end)

// AddaNewMessageToTheTraffic
net.Receive("HexComms::addNewCommToTraffic", function()
    local read = HexSh:ReadCompressedTable()
    table.insert(HexSh.Comms.Log,read)
end)

// Send a Message lol
net.Receive("HexComms::sendCommMessage", function()
    local read = HexSh:ReadCompressedTable()
    chat.AddText( read.Color, "["..read.Prefix.."]", Color(255,255,255), read.Content )
    if (isstring(read.NotifySound)) then surface.PlaySound(read.NotifySound) end 
end)

net.Receive("HexComms::OpenTrafficMenu", function()
    local dataa = HexSh:ReadCompressedTable()
    local l = HexSh.Comms.UI.OpenCommsTraffic
    local scrw,  scrh = ScrW(), ScrH()
    l.MainMenu = vgui.Create("DFrame")
    l.MainMenu:SetSize(scrw*0.6,scrh*0.9)
    l.MainMenu:Center()
    l.MainMenu:MakePopup()
    l.MainMenu.Paint = function(self,w,h)
        draw.RoundedBox(15,0,0,w,h,Color(255,255,255))
        draw.RoundedBox(15,2,2,w-4,h-4,Color(22,22,22))
        draw.SimpleText("CommTraffic", "HexSh.COMMS.Title", self:GetWide() /2, scrh*0.05  , Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    l.HistoryPanel = vgui.Create("DPanel", l.MainMenu)
    l.HistoryPanel:Dock(FILL)
    l.HistoryPanel:DockMargin(60,100,60,20)
    l.HistoryPanel.Paint = function(self,w,h)
        surface.SetDrawColor(Color(255,255,255))
        surface.DrawOutlinedRect(0,0,w,h,2)
    end

    local Top = vgui.Create("DPanel", l.HistoryPanel)
    Top:Dock(TOP)
    Top:SetTall(scrh*0.1)
    Top.Paint = function(self,w,h)
        draw.RoundedBox(0,0,0,w/2-20,h,Color(255,255,255))
        local unten_left_Dreieck = { 
            { x = scrw * 0.25, y = scrh * 0.0},
            { x = scrw * 0.32, y = scrh * 0.0 },
            { x = scrw * 0.25, y = scrh * 0.11 }
        }
        draw.NoTexture()
        surface.DrawPoly(unten_left_Dreieck)
        draw.SimpleText("All Sendend Messages", "HexSh.50", scrw*0.01, scrh*0.05  , Color(0,0,0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end


    l.Taskbar = vgui.Create("DPanel", Top)
    l.Taskbar:SetSize(scrw*0.18,scrh*0.03)
    l.Taskbar:SetPos(scrw*0.33,scrh*0.06)
    l.Taskbar.Paint = nil


    l.Search = vgui.Create("DTextEntry", l.Taskbar)
    l.Search:Dock(FILL)
    l.Search:SetPlaceholderText(HexSh:L("src_communications", "Search"))
    l.Search:SetFont("HexSh.30")
    l.Search.Think = function()
        if l.Filter:GetValue() == "Filter" then 
            l.Search:SetDisabled(true)
        else
            l.Search:SetDisabled(false)
        end
    end

    l.Filter = vgui.Create("DComboBox", l.Taskbar)
    l.Filter:Dock(RIGHT)
    l.Filter:SetWide(scrw*0.07)
    l.Filter:SetValue( "Filter" )
    l.Filter:AddChoice("Name")
    l.Filter:AddChoice("Time")
    l.Filter:AddChoice("Human")


    l.Scroll = vgui.Create("DScrollPanel", l.HistoryPanel)
    l.Scroll:Dock(FILL)
    l.Scroll:DockMargin(10,10,10,10)

    for k,v in pairs(dataa) do  
        local datapack = {}

        datapack.Button = vgui.Create("DButton", l.Scroll)
        datapack.Button:Dock(TOP)
        datapack.Button:DockMargin(0,5,0,5)
        datapack.Button:SetTall(scrh*0.1)
        datapack.Button:SetText("")
        datapack.Button.Time = v.Time
        datapack.Button.Paint = function(self,w,h)
            draw.RoundedBox(0,0,0,w,h,Color(0,0,0))
            surface.SetDrawColor(Color(255,255,255))
            surface.DrawOutlinedRect(0,0,w,h,1)
           -- draw.SimpleText("Time: " .. v.Time, "HexSh.30", 10, scrh*0.055, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
        end

        local topp = vgui.Create("DPanel", datapack.Button)
        topp:Dock(TOP)
        topp:SetTall(scrh*0.04)
        topp.Paint = function(self,w,h)
            draw.RoundedBox(0,0,0,w/2-180,h,Color(255,255,255))
            local unten_left_Dreieck = { 
                { x = scrw * 0.16, y = scrh * 0.0},
                { x = scrw * 0.2, y = scrh * 0.0 },
                { x = scrw * 0.16, y = scrh * 0.11 }
            }
            draw.NoTexture()
            surface.DrawPoly(unten_left_Dreieck)
            if v.Encryptlevel == "1" then
                draw.SimpleText("UNKNOWN", "HexSh.30", 5, h/2, Color(0,0,0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            else
                draw.SimpleText(v.Sender, "HexSh.30", 5, h/2, Color(0,0,0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            end
        end

        local content = vgui.Create("RichText", datapack.Button)
        content:Dock(FILL)
        content:DockMargin(scrw*0.19,5,5,5)
        if v.Encryptlevel == "2" then 
            content:AppendText("UNKNOWWN")
        else
            --content:AppendText(v.Content)
        end
    end

    l.CloseButton = vgui.Create("DButton", l.MainMenu)
    l.CloseButton:Dock(BOTTOM)
    l.CloseButton:DockMargin(scrw*0.15,0,scrw*0.15,0)
    l.CloseButton:SetText("Close!")
    l.CloseButton:SetTall(scrh*0.035)
    l.CloseButton.DoClick = function()
        l.MainMenu:Remove()
    end

    
    
    
    
    
    
    /*
    for k,v in pairs(HexSh.Comms.Log) do 

        local b = vgui.Create("DButton", l.HistoryPanel)
        b:Dock(TOP)
        b:SetTall(scrh*0.1)
        b:SetText(v.Content)
    end
    */

end)
