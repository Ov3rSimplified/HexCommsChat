--
HexSh.Comms.UI = {}
HexSh.Comms.UI.OpenCommsTraffic = {}

/*function HexSh.Comms.AddText( ... )
	local args = {...} -- Create a table of varargs

	for _, obj in ipairs( args ) do
		if type( obj ) == "table" then -- We were passed a color object
			HexSh.Comms.UI.TextField:InsertColorChange( obj.r, obj.g, obj.b, 255 )
		elseif type( obj ) == "string"  then -- This is just a string
			HexSh.Comms.UI.TextField:AppendText( obj )
		elseif obj:IsPlayer() then
			local col = GAMEMODE:GetTeamColor( obj ) -- Get the player's team color
			HexSh.Comms.UI.TextField:InsertColorChange( col.r, col.g, col.b, 255 ) -- Make their name that color
			HexSh.Comms.UI.TextField:AppendText( obj:Nick() )
		end
	end
	HexSh.Comms.UI.TextField:AppendText( "\n" )
end*/

--[[
    local function OpenMenu()
    HexSh.Comms.UI.Visible = true
    local scrw, scrh = ScrW(), ScrH()
    if HexSh.Comms.UI.MainMenu then HexSh.Comms.UI.MainMenu:Remove()  end

    HexSh.Comms.UI.MainMenu = vgui.Create("DPanel")
    HexSh.Comms.UI.MainMenu:SetSize(scrw * 0.2, scrh * 0.45)
    HexSh.Comms.UI.MainMenu:SetPos(scrw*0.8,scrh*0.15)
        HexSh.Comms.UI.MainMenu.Paint = function(self,w,h)
            draw.RoundedBoxEx(15,0,0,w,h,Color(0,0,0,130),true,false,true,false)
        end

    local top = HexSh.Comms.UI.MainMenu:Add("DLabel")
    top:Dock(TOP)
    top:DockMargin(0, 30, 0, 0)
    top:SetText("")
    top:SetTall(scrh * 0.06)
        top.Paint = function(self, w, h)
            draw.DrawText("COMMCHAT", "HexSh.40", self:GetWide() / 2, 0, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end

    HexSh.Comms.UI.TextField = vgui.Create("RichText", HexSh.Comms.UI.MainMenu )
    HexSh.Comms.UI.TextField:Dock(FILL)
    HexSh.Comms.UI.TextField.PerformLayout = function(self)
        self:SetFontInternal("HexSh.20")
    end 

   -- for k,v in pairs(lastmess) do 
    --    HexSh.Comms.AddText( v.Content )
   -- end

    local bottom = HexSh.Comms.UI.MainMenu:Add("DLabel")
    bottom:Dock(BOTTOM)
    bottom:DockMargin(0, 0, 0, 5)
    bottom:SetText("")
    bottom:SetTall(scrh * 0.02)
        bottom.Paint = function(self, w, h)
            draw.DrawText("⸻ " ..  HexSh:L("src_communications", "F3.Informations") .. " ⸻", "HexSh.20", self:GetWide() / 2, 0, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end

    end; net.Receive("HexSh.COMMS.OpenMenu", OpenMenu)

    local delay = 0
    local open = false 
    hook.Add( "PlayerButtonDown", "HexSh.Bind", function(ply, btn)
        if delay < CurTime() then 
            if btn == KEY_F2 then
                if IsValid(HexSh.Comms.UI.MainMenu) then 
                    if HexSh.Comms.UI.Visible then 
                        HexSh.Comms.UI.MainMenu:SetVisible(false)
                        HexSh.Comms.UI.Visible = false
                    else
                        HexSh.Comms.UI.MainMenu:SetVisible(true)
                        HexSh.Comms.UI.Visible = true
                    end
                else
                    net.Start("HexSh.COMMS.OpenMenu")
                    net.SendToServer()
                end
            end
            delay = CurTime() + 0.2
        end
    end)
]]