--[WezTerm Lua Config]--
-- https://wezfurlong.org/wezterm/config/files.html
-- NOTE: PowerlineExtraSymbols default-includes (patched fonts unecessaryy)

local wezterm = require("wezterm")
local wezAction = wezterm.action

return {
    --[initial size]
    initial_cols = 100,
    initial_rows = 55,

    --[Font]
    -- see more at: https://www.programmingfonts.org/
    -- NOTE: "nerdfont" additions are a built-in fallback; patched fonts not necessary
    --[[ Ligature examples:
    <= >= := == === != !== ~= ~== >>= >>== -->  ~~> ==> <==> <*> ## :: |> <|
    \\ =~ !~ {. .} .= :- ._ /= =< <<= <<== || && |= =| Fl Tl fi fj ft qu Qu  ]]
    -- font = wezterm.font("Anonymous Pro"), --[[solid; no ligatures]]
    -- font = wezterm.font("Hack"), --[[classic, but no ligatures]]
    -- font = wezterm.font("Iosevka"), --[[elegant and horizontally efficient; MANY custom versions]]
    font = wezterm.font("Iosevka Slab"), --[[elegant and horizontally efficient; MANY custom versions]]
    -- font = wezterm.font("JetBrains Mono"),  --[[default; solid, but .0]]
    -- font = wezterm.font("Major Mono Display"),  --[[fun]]
    -- font = wezterm.font("Monoflow"), --[[monospace kerning control via ligatures, uses .0]]
    -- font = wezterm.font("Syne Mono"), --[[quasi-modernist; 0=~=O]]
    -- font = wezterm.font("Victor Mono"), --[[strong cursive comments=>very parsable commented code; but .0]]
    font_size = 20,

    --[terminal colorschemes]
    -- see more at: https://wezfurlong.org/wezterm/colorschemes/index.html
    -- color_scheme = "Pretty and Pastel (terminal.sexy)", --[[chill]]
    -- color_scheme = "primary", --[[white background]]
    -- color_scheme = "Sequoia Monochrome", --[[Shades of Gray]]
    -- color_scheme = "SynthwaveAlpha", --[[Purple Text]]
    -- color_scheme = "Purple Rain", --[[Purple Background]]

    --[Window options]
    -- {RESIZE, TITLE, NONE} <-- specify what you want present, with '|' between
    window_decorations = "RESIZE",
    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
    },
    -- enable_tab_bar = false, --[[for minimalist terminal]]
    use_fancy_tab_bar = true, --[[no effect if 'enable_tab_bar' is false]]
    window_background_opacity = 0.85,

    --[inactive pane configuration]
    inactive_pane_hsb = {
        saturation = 0.7,
        brightness = 0.7,
    },

    --[key binds]
    keys = {
        -- -- Commented out, because triggers and is obviated by vi-mode
        -- -- Rebind OPT-Left, OPT-Right as ALT-b, ALT-f respectively to match standard macOS behavior
        -- {
        --     key = "LeftArrow",
        --     mods = "OPT",
        --     action = wezAction.SendKey({
        --         key = "b",
        --         mods = "ALT",
        --     }),
        -- },
        -- {
        --     key = "RightArrow",
        --     mods = "OPT",
        --     action = wezAction.SendKey({
        --         key = "f",
        --         mods = "ALT"
        --     }),
        -- },
    },
    -- [macOS Opt~~>Alt key]
    -- this sets the Left_alt to be standard 'alt' for a CLI
    -- leaving the Right_alt to like macOS 'opt', e.g. for accenting chars
    send_composed_key_when_left_alt_is_pressed = false, --[[Default]]
    send_composed_key_when_right_alt_is_pressed = true, --[[Default]]
}
