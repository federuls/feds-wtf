if not game:IsLoaded() then game.Loaded:Wait() end

local USER = "federuls"
local REPO = "feds-wtf"
local RAW = ("https://raw.githubusercontent.com/%s/%s/main/feds-wtf.lua"):format(USER, REPO)

local function get(url)
	local req = (syn and syn.request) or http_request or request
	if req then
		local ok, res = pcall(req, { Url = url, Method = "GET" })
		if ok and res and (res.StatusCode == 200 or res.Success) and res.Body then
			return res.Body
		end
	end
	if game.HttpGet then
		local ok, body = pcall(game.HttpGet, game, url)
		if ok then return body end
	end
end

local src = get(RAW)
if not src or #src < 100 then
	return warn("[feds.wtf] fetch failed")
end

local fn, err = loadstring(src)
if not fn then
	return warn("[feds.wtf] compile:", err)
end

local ok, e = pcall(fn)
if not ok then
	warn("[feds.wtf] runtime:", e)
end
