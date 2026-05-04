-- ================================================================
-- TROLL STUB  (replaces the real UI library)
-- All UI-building calls are silent no-ops.
-- The only thing that renders is a "LOL YOU SKID" box.
-- ================================================================

local players    = game:GetService("Players")
local lp         = players.LocalPlayer

-- ── Show troll GUI ───────────────────────────────────────────────
local gui = Instance.new("ScreenGui")
gui.Name          = "TrollUI"
gui.ResetOnSpawn  = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
local ok = pcall(function() gui.Parent = game.CoreGui end)
if not ok or not gui.Parent then
pcall(function() gui.Parent = lp.PlayerGui end)
end

local frame = Instance.new("Frame")
frame.Size            = UDim2.fromOffset(240, 64)
frame.Position        = UDim2.fromScale(0.5, 0.5)
frame.AnchorPoint     = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
frame.BorderSizePixel = 0
frame.Parent          = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

local lbl = Instance.new("TextLabel")
lbl.Size               = UDim2.fromScale(1, 1)
lbl.BackgroundTransparency = 1
lbl.Text               = "LOL YOU SKID FUCK YOU JEW USE THE UPDATED SCRIPT \n https://discord.gg/a8mZx7cJSW" 
lbl.TextColor3         = Color3.fromRGB(255, 55, 55)
lbl.TextSize           = 22
lbl.Font               = Enum.Font.GothamBold
lbl.TextStrokeTransparency = 0.6
lbl.Parent             = frame

-- ── Stub helpers ────────────────────────────────────────────────
-- A stub element: every method call returns self so chained calls never error.
local elem_mt = {}
elem_mt.__index = function(self, _key)
return function(...) return self end
end
local function new_elem()
return setmetatable({ refresh_options = function() end }, elem_mt)
end

-- A stub section: every method returns a stub element and registers defaults.
local section_mt = {}
section_mt.__index = function(_self, _key)
return function(self2, opts)
if type(opts) == "table" then
if opts.flag ~= nil then
if opts.default ~= nil then
library.flags[opts.flag] = opts.default
end
if type(opts.callback) == "function" then
library.config_flags[opts.flag] = opts.callback
end
end
end
return new_elem()
end
end
local function new_section()
return setmetatable({}, section_mt)
end

-- A stub tab: every method returns a stub section.
local tab_mt = {}
tab_mt.__index = function(_self, _key)
return function(_self2, _opts) return new_section() end
end
local function new_tab()
return setmetatable({}, tab_mt)
end

-- Stub window
local stub_window = {}
stub_window.set_menu_visibility = function() end
stub_window.toggle_playerlist   = function() end
stub_window.toggle_watermark    = function() end
stub_window.toggle_list         = function() end
stub_window.tab = function(_self, _opts) return new_tab() end

-- ── Library stub ────────────────────────────────────────────────
library = {
flags        = {},
config_flags = {},
connections  = {},
instances    = {},
directory    = "inactivity",
config_holder   = nil,
autoload_holder = nil,
config_dir      = nil,
}

function library:window(_opts)          return stub_window          end
function library:notification(_opts)                                 end
function library:update_theme(_t, _c)                               end
function library:config_list_update()                               end
function library:panel(_opts)                                        end
function library:get_config()           return "{}"                 end
function library:load_config(_json)                                 end
function library:unload()
pcall(function() gui:Destroy() end)
getgenv().library = nil
end
function library:convert_enum(str)
local parts = {}
for p in string.gmatch(tostring(str or ""), "[%w_]+") do
table.insert(parts, p)
end
local t = Enum
for i = 2, #parts do
local ok2, v = pcall(function() return t[parts[i]] end)
if ok2 and v ~= nil then t = v else return nil end
end
return t
end
function library:connection(signal, cb)
local c = signal:Connect(cb)
table.insert(self.connections, c)
return c
end

return library
