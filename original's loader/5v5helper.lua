local ui_new_checkbox, ui_new_slider, ui_new_color_picker, table_remove, entity_get_prop, bit_band, entity_get_player_name, client_set_event_callback, ui_get, client_screen_size, entity_get_all, entity_is_enemy, renderer_text, renderer_rectangle, renderer_gradient, client_userid_to_entindex, globals_curtime = ui.new_checkbox, ui.new_slider, ui.new_color_picker, table.remove, entity.get_prop, bit.band, entity.get_player_name, client.set_event_callback, ui.get, client.screen_size, entity.get_all, entity.is_enemy, renderer.text, renderer.rectangle, renderer.gradient, client.userid_to_entindex, globals.curtime
local entity_get_local_player = entity.get_local_player

local chk = ui_new_checkbox("LUA", "B", "---Original's 5V5 helper---")
local pos_x = ui_new_slider("LUA", "B", "Helper X", 0, 100, 100)
local clr1 = ui_new_color_picker("LUA", "B", "Helper clr A", 0, 255, 255, 255)
local pos_y = ui_new_slider("LUA", "B", "Helper Y", 0, 100, 43)
local clr2 = ui_new_color_picker("LUA", "B", "Helper clr B", 255, 0, 255, 255)


ui.set_visible(clr1, false)
ui.set_visible(clr2, false)

local function paintEnabled()
    if ui.get(chk)then
        ui.set_visible(pos_x, true)
        ui.set_visible(pos_y, true)
    else
    ui.set_visible(pos_x, false)
    ui.set_visible(pos_y, false)
    end
end
client.set_event_callback("paint_ui", paintEnabled)

local weapon_names = {
    [1] = "Deagle",
    [2] = "Dualies",
    [3] = "FiveSeven",
    [4] = "Glock",
    [7] = "AK-47",
    [8] = "Aug",
    [9] = "*Awp*",
    [10] = "Famas",
    [11] = "*Auto*",
    [13] = "Galil",
    [14] = "M249",
    [16] = "M4A4",
    [17] = "MAC-10",
    [19] = "P90",
    [23] = "MP5",
    [24] = "UMP",
    [25] = "XM",
    [26] = "PP-Bizon",
    [27] = "MAG-7",
    [28] = "Negev",
    [29] = "Sawed-Off",
    [30] = "Tec-9",
    [31] = "Zeus",
    [32] = "P2000",
    [33] = "MP7",
    [34] = "MP9",
    [35] = "Nova",
    [36] = "P250",
    [38] = "*Auto*",
    [39] = "SG 553",
    [40] = "Scout",
    [41] = "Knife",
    [42] = "Knife",
    [43] = "Flash",
    [44] = "HE",
    [45] = "Smoke",
    [46] = "Molly",
    [47] = "Decoy",
    [48] = "Molly",
    [49] = "C4",
    [59] = "Knife",
    [60] = "M4",
    [61] = "USP",
    [63] = "CZ",
    [64] = "R8",
    [500] = "Knife",
    [505] = "Knife",
    [506] = "Knife",
    [507] = "Knife",
    [508] = "Knife",
    [509] = "Knife",
    [512] = "Knife",
    [514] = "Knife",
    [515] = "Knife",
    [516] = "Knife",
    [519] = "Knife",
    [520] = "Knife",
    [522] = "Knife",
    [523] = "Knife",
}

local player_names = {}
for i = 1, 64 do
    player_names[i] = "unk"
end

local player_health = {}
for i = 1, 64 do
    player_health[i] = 100
end

local player_armor = {}
for i = 1, 64 do
    player_armor[i] = 0
end

local player_helmet = {}
for i = 1, 64 do
    player_helmet[i] = false
end

local player_cash = {}
for i = 1, 64 do
    player_cash[i] = 800
end

local player_weapons = {}
for i = 1, 64 do
    player_weapons[i] = {}
end

local player_spawntime = {}
for i = 1, 64 do
    player_spawntime[i] = 0
end

local enemies = {}

local function add_weapon(idx, weapon)

    if weapon == "Knife" then
        return
    end
    if #player_weapons[idx] > 0 then
        for i=1, #player_weapons[idx] do
            if player_weapons[idx][i] == weapon then
                return
            end
        end
    end
    player_weapons[idx][#player_weapons[idx] + 1] = weapon
end

local function remove_weapon(idx, weapon)
    if #player_weapons[idx] > 0 then
        for i=1, #player_weapons[idx] do
            if player_weapons[idx][i] == weapon then
                table_remove(player_weapons[idx], i)
            end
        end
    end
end

local function get_all_weapons(idx)
    for i=0, 64 do
        local weapon = entity_get_prop(idx, "m_hMyWeapons", i)
        if weapon ~= nil then
            local iidx = entity_get_prop(weapon, "m_iItemDefinitionIndex")
            if iidx ~= nil then
                local weapon_id = bit_band(iidx, 0xFFFF)
                add_weapon(idx, weapon_names[weapon_id])
            end
        end
    end
end

local function update_player(idx, updatewep, updateaccount)
    local alreadyin = false
    if #enemies > 0 then
        for i=0, #enemies do
            if enemies[i] == idx then
                alreadyin = true
            end
        end
    end

    if player_names[idx] ~= nil then
        player_names[idx] = entity_get_player_name(idx)
    end

    if not alreadyin then
        enemies[#enemies + 1] = idx     
    end

    if updateaccount and player_cash[idx] ~= nil then
        player_cash[idx] = entity_get_prop(idx, "m_iAccount")
    end

    if updatewep then
        player_armor[idx] = entity_get_prop(idx, "m_ArmorValue")
        player_health[idx] = entity_get_prop(idx, "m_iHealth")
        player_helmet[idx] = entity_get_prop(idx, "m_bHasHelmet")
        get_all_weapons(idx)
    end
end

local function remove_player(idx)
    if #enemies > 0 then
        for i=1, #enemies do
            if enemies[i] == idx then
                table_remove(enemies, i)
            end
        end
    end
end

local function rgb_percent(percentage)
    local red = 124 * 2 - 124 * percentage
    local green = 195 * percentage
    local blue = 13
    return red, green, blue
end

client_set_event_callback("paint", function()

    local lplayer = entity_get_local_player()
    
    if not ui_get(chk) then
        return
    end

    local sx, sy = client_screen_size()
 
    local size_x, size_y = 400, 17 + (25 * #enemies)

    local px, py = sx * (ui_get(pos_x) / 100) - size_x, sy * (ui_get(pos_y) / 100) - 200

    local r1, g1, b1, a1 = ui_get(clr1)
    local r2, g2, b2, a2 = ui_get(clr2)

    renderer_gradient(px, py, size_x, size_y, r1, g1, b1, 100, r2, g2, b2, 100, false)
    renderer_rectangle(px + 1, py + 1, size_x - 2, size_y - 2, 25, 25, 25, 150)

    renderer_text(px + (size_x / 2), py + 8, 255, 255, 255, 255, "c", 0, "Lua By Original")

    renderer_gradient(px + 1, py + 15, size_x - 2, 2, r1, g1, b1, 255, r2, g2, b2, 255, false)   
    renderer_gradient(px + 50, py + 15, 2, size_y - 15, r1, g1, b1, 255, r2, g2, b2, 255, false)
    renderer_gradient(px + 90, py + 15, 2, size_y - 15, r1, g1, b1, 255, r2, g2, b2, 255, false)
    renderer_gradient(px + 135, py + 15, 2, size_y - 15, r1, g1, b1, 255, r2, g2, b2, 255, false)
    renderer_gradient(px + 155, py + 15, 2, size_y - 15, r1, g1, b1, 255, r2, g2, b2, 255, false)

    local allplayers = entity_get_all("CCSPlayer")

    if #allplayers > 0 then
        for i=1, #allplayers do
            if entity_is_enemy(allplayers[i]) then
                update_player(allplayers[i], true, true)
            end
        end
    end

    if #enemies == 0 then
        return 
    end

    local cy = 25
    for i=1, #enemies do

        local idx = enemies[i]

        if entity_get_prop(idx, "m_bConnected") == false then
            remove_player(idx)
        end

        renderer_text(px + 7, py + cy - 2, 255, 255, 255, 255, nil, 35, player_names[idx])

        local r, g, b = rgb_percent(player_health[idx] / 100)
        renderer_text(px + 55, py + cy - 2, r, g, b, 255, nil, 0, tostring(player_health[idx]) .. "HP")
        renderer_text(px + 95, py + cy - 2, 0, 255, 0, 255, nil, 0, "$" .. tostring(player_cash[idx]))
        local armortext = "无"
        if player_armor[idx] > 0 then
            armortext = player_helmet[idx] and "全" or "半"
        end
        renderer_text(px + 140, py + cy - 2, 255, 255, 255, 255, nil, 0, armortext)
        --loop through and print enemy weapons
        if #player_weapons[idx] > 0 then
            local text = ""
            for w=1, #player_weapons[idx] do
                text = (w == #player_weapons[idx] + 1 or w <= 1) and (text .. player_weapons[idx][w]) or (text .. ", " .. player_weapons[idx][w])
            end     
            renderer_text(px + 160, py + cy - 2, 255, 255, 255, 255, nil, 0, text)
        end

        --increase ypos after run
        cy = cy + 25
    end
end)

client_set_event_callback("item_pickup", function(e)
    if not ui_get(chk) then
        return
    end

    local idx = client_userid_to_entindex(e.userid)

    if not entity_is_enemy(idx) then
        return
    end

    update_player(idx, false, false)

    add_weapon(idx, weapon_names[e.defindex])
end)

client_set_event_callback("item_remove", function(e)
    if not ui_get(chk) then
        return
    end

    local idx = client_userid_to_entindex(e.userid)

    if not entity_is_enemy(idx) then
        return
    end

    update_player(idx, false, false)

    remove_weapon(idx, weapon_names[e.defindex])
end)

local function shit_to_cool(weapon)
    if weapon == "hegrenade" then
        return "HE"
    elseif weapon == "molotov" or weapon == "incgrenade" then
        return "Molly"
    elseif weapon == "decoy" then
        return "Decoy"
    elseif weapon == "smokegrenade" then
        return "Smoke"
    elseif weapon == "flashbang" then
        return "Flash"
    end
end

client_set_event_callback("grenade_thrown", function(e)
    if not ui_get(chk) then
        return
    end

    local idx = client_userid_to_entindex(e.userid)

    if not entity_is_enemy(idx) then
        return
    end

    update_player(idx, false, false)

    remove_weapon(idx, shit_to_cool(e.weapon))
end)

client_set_event_callback("player_death", function(e)
    if not ui_get(chk) then
        return
    end

    local idx = client_userid_to_entindex(e.userid)

    if not entity_is_enemy(idx) then
        return
    end

    update_player(idx, false, false)

    player_weapons[idx] = {}
    player_health[idx] = 0
end)

client_set_event_callback("player_hurt", function(e)
    if not ui_get(chk) then
        return
    end

    local idx = client_userid_to_entindex(e.userid)

    if not entity_is_enemy(idx) then
        return
    end

    update_player(idx, false, false)

    player_health[idx] = (player_health[idx] - e.dmg_health > 0) and (player_health[idx] - e.dmg_health) or 0
    player_armor[idx] = (player_armor[idx] - e.dmg_armor > 0) and (player_armor[idx] - e.dmg_armor) or 0

    if player_armor[idx] == 0 then
        player_helmet[idx] = false
    end
end)

client_set_event_callback("round_start", function(e)
    if not ui_get(chk) then
        return
    end

    if #enemies == 0 then
        return 
    end

    for i=1, #enemies do
        local idx = enemies[i]

        if idx == nil then
            remove_player(idx)
        end

        update_player(idx, false, true)

        if player_spawntime[idx] ~= globals_curtime() then
            remove_player(idx)
        end
        
        if player_health[idx] ~= nil then
            player_health[idx] = 100
        end
    end
end)

--ya might wanna update these :P
local item_prices = {
    ["weapon_unknown"] = 0,
    --GRENADE
    ["weapon_smokegrenade"] = 300,
    ["weapon_hegrenade"] = 300,
    ["weapon_incgrenade"] = 600,
    ["weapon_decoy"] = 50,
    ["weapon_flashbang"] = 200,
    ["weapon_molotov"] = 400,
    --GEAR
    ["item_kevlar"] = 650,
    ["item_defuser"] = 400,
    ["item_assaultsuit"] = 1000,
    ["weapon_taser"] = 200,
    --RIFLE
    ["weapon_ssg08"] = 1700,
    ["weapon_scar20"] = 5000,
    ["weapon_m4a1"] = 3100,
    ["weapon_m4a1_silencer"] = 3100,
    ["weapon_ak47"] = 2700,
    ["weapon_sg556"] = 3000,
    ["weapon_galilar"] = 1800,
    ["weapon_famas"] = 2050,
    ["weapon_aug"] = 3300,
    ["weapon_awp"] = 4750,
    ["weapon_g3sg1"] = 5000,
    ["weapon_p250"] = 300,
    --PISTOL
    ["weapon_elite"] = 400,
    ["weapon_glock"] = 200,
    ["weapon_revolver"] = 600,
    ["weapon_fiveseven"] = 500,
    ["weapon_hkp2000"] = 200,
    ["weapon_deagle"] = 700,
    ["weapon_cz75a"] = 500,
    ["weapon_usp_silencer"] = 200,
    --SMG
    ["weapon_bizon"] = 1400,
    ["weapon_mac10"] = 1700,
    ["weapon_mp7"] = 1700,
    ["weapon_ump45"] = 1200,
    ["weapon_mp5sd"] = 1500,
    ["weapon_mp9"] = 1250,
    ["weapon_p90"] = 2350, 
    --HEAVY
    ["weapon_nova"] = 1050,
    ["weapon_xm1014"] = 2000,
    ["weapon_sawedoff"] = 1300,
    ["weapon_mag7"] = 1300,
    ["weapon_m249"] = 5200,
    ["weapon_negev"] = 1700
}

client_set_event_callback("item_purchase", function(e)
    if not ui_get(chk) then
        return
    end

    local idx = client_userid_to_entindex(e.userid)

    if not entity_is_enemy(idx) then
        return
    end

    update_player(idx, false)

    if e.weapon == "item_kevlar" or e.weapon == "item_assaultsuit" then
        player_armor[idx] = 100
        if e.weapon == "item_assaultsuit" then
            player_helmet[idx] = true
        end
    end

    local price = (e.weapon == "item_assaultsuit" and player_armor[idx] == 100) and 350 or item_prices[e.weapon]
    player_cash[idx] = player_cash[idx] - price
end)

local function reset_data()
    for i = 1, 64 do
        player_names[i] = "unk"
        player_health[i] = 100
        player_armor[i] = 0
        player_cash[i] = 800
        player_spawntime[i] = 0
        player_weapons[i] = {}
    end
    enemies = {}
end

client_set_event_callback("game_newmap", function()
    if not ui_get(chk) then
        return
    end

    reset_data()
end)

client_set_event_callback("start_halftime", function()
    if not ui_get(chk) then
        return
    end

    reset_data()
end)

client_set_event_callback("cs_match_end_restart", function()
    if not ui_get(chk) then
        return
    end

    reset_data()
end)

client_set_event_callback("cs_game_disconnected", function()
    if not ui_get(chk) then
        return
    end

    reset_data()
end)

client_set_event_callback("player_spawn", function(e)
    if not ui_get(chk) then
        return
    end

    local idx = client_userid_to_entindex(e.userid)

    if not entity_is_enemy(idx) then
        return
    end

    player_spawntime[idx] = globals_curtime()
end)
