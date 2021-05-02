local user = "smo0"
local frametimes = { }
local fps_prev = 0
local last_update_time = 0

function AccumulateFps()
	local ft = globals.absoluteframetime()
	if ft > 0 then
		table.insert(frametimes, 1, ft)
	end
	local count = #frametimes
	if count == 0 then
		return 0
	end
	local i, accum = 0, 0
	while accum < 0.5 do
		i = i + 1
		accum = accum + frametimes[i]
		if i >= count then
			break
		end
	end
	accum = accum / i
	while i < count do
		i = i + 1
		table.remove(frametimes)
	end
	local fps = 1 / accum
	local rt = globals.realtime()
	if math.abs(fps - fps_prev) > 4 or rt - last_update_time > 2 then
		fps_prev = fps
		last_update_time = rt
	else
		fps = fps_prev
	end
	return math.floor(fps + 0.5)
end

local is_inside = function(a, b, x, y, w, h) 
	return a >= x and a <= w and b >= y - 4 and b <= h 
end

local pos = database.read("watermarkpos") or {300,30} 
local tX, tY = pos[1], pos[2] 
local oX, oY, _d 
local drag_menu = function(x, y, w, h)
	if not ui.is_menu_open() then 
		return tX, tY
	end
	local mouse_down = client.key_state(0x01)
	if mouse_down then 
		local X, Y = ui.mouse_position()
		if not _d then 
		local w, h = x + w, y + h 
		if is_inside(X, Y, x, y, w, h) then 
			oX, oY, _d = X - x, Y - y, true 
		end 
		else 
			tX, tY = X - oX, Y - oY 
		end 
		else 
			_d = false 
		end 
	local screenx, screeny = client.screen_size()
	local clampedX, clampedY
	if tX <= 0 then
		clampedX = 0
	elseif tX > (screenx - w) then
		clampedX = screenx - w
	else
		clampedX = tX
	end
	if tY <= 0 then
		clampedY = 0
	elseif tY > (screeny - h) then
		clampedY = screeny - h
	else
		clampedY = tY
	end
	tX, tY = clampedX, clampedY
	return clampedX, clampedY
end    


watermarktext = ui.new_textbox("LUA", "B", "\n custom text")
ui.set_visible(watermarktext, false)
local enable = ui.new_checkbox("Lua", "B", "---Original's Watermark---")


----------COOL WATERMARK----------
client.set_event_callback("paint_ui", function()
	if ui.get(enable)then
		local fpsfunc = AccumulateFps()
		local customtext_widht = renderer.measure_text(nil, ui.get(watermarktext))
		local user_widht = renderer.measure_text(nil, user)
  		local pingtext_widht = renderer.measure_text(nil, " | rtt: ")
  		local ping_widht = renderer.measure_text(nil, Ping)
  		local fpstext_widht = renderer.measure_text(nil, " | fps: ")
  		local fps_widht = renderer.measure_text(nil, fpsfunc)
  		local line_widht = renderer.measure_text(nil, " | ")
  		local hour_widht = renderer.measure_text(nil, hours)
  		local dot_widht = renderer.measure_text(nil, ":")
  		local minute_widht = renderer.measure_text(nil, minutes)
  		local second_widht = renderer.measure_text(nil, seconds)
  		w2 = user_widht + pingtext_widht + ping_widht + fpstext_widht + fps_widht + line_widht + hour_widht + dot_widht + minute_widht + dot_widht + second_widht + 170	
		local x2, y2 = drag_menu(tX, tY, w2, 26)
		Ping = math.floor(math.min(1000, client.latency() * 1000) + 0.5)
		local hours, minutes, seconds, milliseconds = client.system_time()
		hours, minutes, seconds = string.format("%02d", hours), string.format("%02d", minutes), string.format("%02d", seconds)
		local fpsfunc = AccumulateFps()
		renderer.rectangle(x2, y2, w2, 26, 0,191,255 ,80)
		renderer.rectangle(x2, y2, w2, 4, 0, 255, 255, 255)
		renderer.text(x2 + 8, y2 + 8, 255, 255, 255, 255, "b", 0, "Lua By Original"," | Server: Safe"," | FPS: ", fpsfunc, " | ", hours, ":", minutes, ":", seconds)
	end
end)

client.set_event_callback("paint", function()
	if ui.get(enable)then
	local x5,y5 =client.screen_size()
	local x6,y6 = x5/2,y5/2
	renderer.text(x6, y6+50, 127,255,170, 255, "cb", 0, "Lua By Original")
	end
end)

client.set_event_callback("shutdown", function()
	database.write("watermarkpos", {tX, tY})
	database.write("watermarkcustom", ui.get(watermarktext))
end)
