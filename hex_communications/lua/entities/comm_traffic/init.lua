AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/props_c17/FurnitureDrawer001a.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    local phys = self:GetPhysicsObject()

    if phys:IsValid() then
        phys:Wake()
    end
end
local delay = 2
function ENT:Use(activator, caller)
    if delay < CurTime() then 
        if (HexSh.Config.Comms.CommTrafficAcces[caller:GetUserGroup()] || HexSh.Config.Comms.CommTrafficAcces[caller:getJobTable().name]) then 
            net.Start("HexComms::OpenTrafficMenu")
                HexSh:WriteCompressedTable(HexSh.Comms.Log)
            net.Send(activator)
        end
        delay = CurTime() + 0.2
    end
end 

function ENT:Think()
end
