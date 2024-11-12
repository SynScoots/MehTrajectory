PMapLineArr = {}
PMapLineData = { x = 0, y = 0, o = 0, had = 0 }

local parent = WorldMapDetailFrame
for i=1, 64 do
local tex = parent:CreateTexture("PMapLine-" .. i, "OVERLAY")
tex:SetTexture("Interface/BUTTONS/WHITE8X8")
tex:SetSize(2, 2)
tex:Hide()
PMapLineArr[i] = tex
end

parent:HookScript("OnUpdate", function(self, elapsed)
if not WorldMapFrame:IsShown() then return end

local o = GetPlayerFacing()
local x, y = GetPlayerMapPosition("player")

local has = true
if x == 0 and y == 0 then
o = 0
has = false
end

if PMapLineData.x == x and PMapLineData.y == y and PMapLineData.o == o then return end

PMapLineData.x = x
PMapLineData.y = y
PMapLineData.o = o

if not has then
for i=1, PMapLineData.had do
PMapLineArr[i]:Hide()
end
PMapLineData.had = 0
return
end

local mapw, maph = WorldMapDetailFrame:GetWidth(), WorldMapDetailFrame:GetHeight()
x = x * mapw
y = -y * maph
--x = x * WORLDMAP_SETTINGS.size
--y = y * WORLDMAP_SETTINGS.size
local fcos, fsin = math.cos(o), math.sin(o)

local count = #PMapLineArr
for i=1, count do
local nx = x - fsin* i * 8
local ny = y + fcos * i * 8
if nx <= 0 or nx >= mapw or ny >= 0 or ny <= -maph then
for j=i, PMapLineData.had do
PMapLineArr[j]:Hide()
end
PMapLineData.had = i - 1
count = -1
break
end
local tex = PMapLineArr[i]
tex:SetPoint("TOPLEFT", nx, ny)
tex:Show()
end

if count >= 0 then
PMapLineData.had = count
end
end)