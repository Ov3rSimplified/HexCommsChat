HexSh.Config.Comms = HexSh.Config.Comms or {}
HexSh.Config.Comms.commChatCommands = {
    --[[ DESCRIPTION
        
        for Global Comm: 
            {
                Type = "GLOBAL",
                Encryptlevel = 0, -- Encryptlevel is for Enemies & Friends because in the CommConsole you can view everything and everybody have access to Encrypt Messages
                Prefix = "[FUNK]",
                Command = "/funk", -- The command wich activate & send the CommMessage 
                Color = Color(112,250,0),
                NotifySound = "common/talk.wav", -- The Sound that play while the message reach you 
                //VisibleFor = function(ply) return true end, -- You didn´t need this while you using the type "GLOBAL"
                AccessFor = function(ply) return true end, -- Who has access to use this
                MessageForPrint = function(ply) return false end, -- e.g. [PREFIX] -> YOURPRINT -> COMMON MESSAGE
            },
        for PRIVATE Comm: 
            {
                Type = "PRIVATE",
                Encryptlevel = 0, -- Encryptlevel is for Enemies & Friends because in the CommConsole you can view everything and everybody have access to Encrypt Messages
                Prefix = "[FUNK]",
                Command = "/funk", -- The command wich activate & send the CommMessage 
                Color = Color(112,250,0),
                NotifySound = "common/talk.wav", -- The Sound that play while the message reach you 
                //VisibleFor = function(ply) return true end, -- You didn´t need this while you using the type "PRIVATE", because this Message is only for Player like a PrivateMessage
                AccessFor = function(ply) return true end, -- Who has access to use this
                MessageForPrint = function(ply) return false end, -- e.g. [PREFIX] -> YOURPRINT -> COMMON MESSAGE
            },
        for SEMI-PRIVATE Comm: 
            {
                Type = "SEMI",
                Encryptlevel = 0, -- Encryptlevel is for Enemies & Friends because in the CommConsole you can view everything and everybody have access to Encrypt Messages
                Prefix = "[FUNK]",
                Command = "/funk", -- The command wich activate & send the CommMessage 
                Color = Color(112,250,0),
                NotifySound = "common/talk.wav", -- The Sound that play while the message reach you
                VisibleFor = function(ply) return true end, --Usergroups/Ranks/Categories or something who has access to see this Message 
                AccessFor = function(ply) return true end, -- Who has access to use this
                MessageForPrint = function(ply) return false end, -- e.g. [PREFIX] -> YOURPRINT -> COMMON MESSAGE
            },

            E.G: 
                {
                    Type = "SEMI",
                    Encryptlevel = 1, 
                    Prefix = "[Group]",
                    Command = "/g", 
                    NotifySound = "common/talk.wav",
                    Color = Color(78,192,135),
                    VisibleFor = function(ply) 
                        local cat = ply:getJobTable().category
                        if (cat == "HEXAGONCATEGORY") then 
                            return true
                        else
                            return false
                        end
                    end,
                    AccessFor = function(ply) 
                        local cat = ply:getJobTable().category
                        if (cat == "HEXAGONCATEGORY") then 
                            return true
                        else
                            return false
                        end
                    end, 
                    MessageForPrint = function(ply) return ply:GetName() end,
                },
    ]]
    {
        Type = "GLOBAL",
        Encryptlevel = 0,
        Prefix = "FUNK",
        Command = "/g", 
        Color = Color(112,250,0),
        NotifySound = "common/talk.wav",
        VisibleFor = function(ply) return true end,
        AccessFor = function(ply) return true end,
        MessageForPrint = function(ply) return false end,
    },
    {
        Type = "PRIVATE",
        Encryptlevel = 0,
        Prefix = "PVT",
        Command = "/pvt", 
        Color = Color(112,250,0),
        NotifySound = "common/talk.wav",
        //VisibleFor = function(ply) return true end,
        AccessFor = function(ply) return true end,
        MessageForPrint = function(ply) return false end,
    },
    {
        Type = "SEMI",
        Encryptlevel = 0,
        Prefix = "Faction",
        Command = "/fef", 
        Color = Color(0,200,250),
        NotifySound = "common/talk.wav",
        VisibleFor = function(ply) return true end,
        AccessFor = function(ply) return true end,
        MessageForPrint = function(ply) return ply:GetName() .. " - " end,
    },
} 

HexSh.Config.Comms.CommTrafficAcces = {
    ["superadmin"] = true,
    ["Citizen"] = true,
}