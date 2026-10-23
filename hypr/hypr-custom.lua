
local terminal    = "foot"
local fileManager = "dolphin"
local menu        = "wofi --show drun"

local mainMod = "SUPER" -- Sets "Windows" key as main modifier
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
local closeWindowBind = hl.bind(mainMod .. " + Q", hl.dsp.window.close())

hl.config({
    input = {
        follow_mouse = 1,
        touchpad = {
            natural_scroll = true,
        },
    },
    general = {
        gaps_in  = 1,
        gaps_out = 1,
        border_size = 1
    },
    xwayland = {
        force_zero_scaling = true,
    },
     misc = {
        disable_splash_rendering = true,
    },
})


hl.on("hyprland.start", function () 
   hl.exec_cmd("hyprpaper")
   --hl.exec_cmd("nm-applet")
   --hl.exec_cmd("waybar")
end)


-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + H",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J",  hl.dsp.focus({ direction = "down" }))

-- Resize windows
hl.bind(mainMod .. " + SHIFT + H",
    hl.dsp.window.resize({ x = -30, y = 0, relative = true }))

hl.bind(mainMod .. " + SHIFT + L",
    hl.dsp.window.resize({ x = 30, y = 0, relative = true }))

hl.bind(mainMod .. " + SHIFT + K",
    hl.dsp.window.resize({ x = 0, y = -30, relative = true }))

hl.bind(mainMod .. " + SHIFT + J",
    hl.dsp.window.resize({ x = 0, y = 30, relative = true }))

hl.bind(
    mainMod .. " + F",
    hl.dsp.window.fullscreen({
        mode = "maximized",
        action = "toggle",
    })
)
hl.bind(mainMod .. " + bracketleft", hl.dsp.focus({ workspace = "r-1" }))
hl.bind(mainMod .. " + bracketright", hl.dsp.focus({ workspace = "r+1" }))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd(
  "sh -c 'grim -g \"$(slurp)\" - | satty --filename - --output-filename \"$HOME/Pictures/Screenshots/satty-$(date +%Y%m%d-%H%M%S).png\"'"
))

hl.bind(mainMod .. " + P", hl.dsp.exec_cmd(
    [[grim -g "$(slurp)" - | satty --filename - --output-filename "$HOME/Pictures/Screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png"]]
))
