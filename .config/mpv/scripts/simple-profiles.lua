-- Simple Profile Switcher - No Memory Leak
local msg = require 'mp.msg'

local profiles = {
    ["anime"] = function()
    mp.command("no-osd change-list glsl-shaders clr")
    mp.command("no-osd change-list glsl-shaders append ~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl")
    mp.command("set deband yes")
    mp.osd_message("Anime Profile", 2)
    end,

    ["movie"] = function()
    mp.command("no-osd change-list glsl-shaders clr")
    mp.command("no-osd change-list glsl-shaders append ~~/shaders/FSRCNNX_x2_16-0-4-1.glsl")
    mp.command("set deband yes")
    mp.osd_message("Movie Profile", 2)
    end,

    ["sharpen"] = function()
    mp.command("no-osd change-list glsl-shaders clr")
    mp.command("no-osd change-list glsl-shaders append ~~/shaders/adaptive-sharpen.glsl")
    mp.osd_message("Sharpen Profile", 2)
    end,

    ["reset"] = function()
    mp.command("no-osd change-list glsl-shaders clr")
    mp.command("set deband no")
    mp.command("set interpolation no")
    mp.osd_message("Reset All Effects", 2)
    end
}

-- Bind keys
mp.add_key_binding("Ctrl+1", "profile-anime", function() profiles["anime"]() end)
mp.add_key_binding("Ctrl+2", "profile-movie", function() profiles["movie"]() end)
mp.add_key_binding("Ctrl+3", "profile-sharpen", function() profiles["sharpen"]() end)
mp.add_key_binding("Ctrl+0", "profile-reset", function() profiles["reset"]() end)

msg.info("Simple Profile Switcher loaded")
