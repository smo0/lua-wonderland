    ui.new_label("AA", "Fake lag", "---Original Fake Lag V3.0[Beta]---")
    local sv_maxusrcmdprocessticks = ui.reference("MISC", "Settings", "sv_maxusrcmdprocessticks")
    ui.set(sv_maxusrcmdprocessticks,17)
    
    local fl_mode = ui.new_combobox("AA", "Fake lag", "Fake Lag Mode","Random","Fixed Random","Static")
    local random_fl_min = ui.new_slider("aa", "Fake lag", "[Random] Minimum Limit", 1, 16)
    local random_fl_max = ui.new_slider("aa", "Fake lag", "[Random] Maximum Limit", 1, 16)
    local static_fl_sli = ui.new_slider("aa", "Fake lag", "[Static] Fake Lag Limit", 1, 16)
    local fixed_random_fl_sli = ui.new_slider("aa", "Fake lag", "[Fixed] Fixed Fake Lag Limit", 1, 16)
    local fixed_random_fl_min = ui.new_slider("aa", "Fake lag", "[Fixed] Fixed Minimum Limit", 1, 16)
    local fixed_random_fl_max = ui.new_slider("aa", "Fake lag", "[Fixed] Fixed Maximum Limit", 1, 16)
    
    local on_fire_globle = ui.new_slider("aa", "Fake lag", "[Shoot] Global FakeLag Limit", 1, 16)
    local on_fire_AWP_scout = ui.new_slider("aa", "Fake lag", "[Shoot] AWP/Scout FakeLag Limit", 1, 16)
    local zero_fl =ui.new_checkbox("aa", "Fake lag","0FL")
    
    ui.new_label("AA", "Fake lag", "---Original Fake Lag V3.0[Beta] End---")
    
    ON = 0 
    client.set_event_callback("paint_ui", function()
        if ui.get(zero_fl)then
            ON = 1
        else
            ON = 0
        end
    end)
    
    
    client.set_event_callback("paint_ui", function()
        if ui.get(fl_mode)=="Random"then
            ui.set_visible(random_fl_min, true)
            ui.set_visible(random_fl_max, true)
            ui.set_visible(static_fl_sli,false)
            ui.set_visible(fixed_random_fl_sli,false)
            ui.set_visible(fixed_random_fl_min,false)
            ui.set_visible(fixed_random_fl_max,false)
        elseif ui.get(fl_mode)=="Fixed Random"then
            ui.set_visible(random_fl_min, false)
            ui.set_visible(random_fl_max,false)
            ui.set_visible(static_fl_sli,false)
            ui.set_visible(fixed_random_fl_sli,true)
            ui.set_visible(fixed_random_fl_min,true)
            ui.set_visible(fixed_random_fl_max,true)
        elseif ui.get(fl_mode)=="Static"then
            ui.set_visible(random_fl_min, false)
            ui.set_visible(random_fl_max, false)
            ui.set_visible(static_fl_sli,true)
            ui.set_visible(fixed_random_fl_sli,false)
            ui.set_visible(fixed_random_fl_min,false)
            ui.set_visible(fixed_random_fl_max,false)
        end
    end)
    
    client.set_event_callback("paint_ui", function()
    end)
    
    
    local TickDelay = globals.tickcount()
    client.set_event_callback("setup_command", function(cmd)
        if ON == 0 then
      if TickDelay < globals.tickcount() then
        cmd.allow_send_packet = true
        local value2 = ui.reference("AA", "Fake lag", "Limit")
        TickDelay = globals.tickcount() + ui.get(value2) 
      else
        cmd.allow_send_packet = false
      end
    end
    end)
    
    FIRE = 0 
    client.set_event_callback("aim_fire", function()
        local me = entity.get_local_player()
        local weapon_name = entity.get_classname(entity.get_player_weapon(me))
        if weapon_name ~= "CWeaponAWP" and weapon_name ~= "CWeaponSSG08" then
            FIRE = 1
        else
            FIRE = 2
        end
        client.delay_call(0.1, function()
            FIRE = 0
        end)
    end)
    
    local fl_ref = ui.reference("aa", "Fake lag", "Limit")
    client.set_event_callback("setup_command", function()
        if FIRE == 0 then
            if ui.get(fl_mode)=="Random"then
                local value = client.random_int(ui.get(random_fl_min), ui.get(random_fl_max))
                ui.set(fl_ref,value)
            elseif ui.get(fl_mode)=="Fixed Random"then
                local random_value = client.random_int(0, 10)
                if random_value >5 then
                    ui.set(fl_ref,ui.get(fixed_random_fl_sli))
                else
                    local random_value_1 = client.random_int(ui.get(fixed_random_fl_min), ui.get(fixed_random_fl_max))
                    ui.set(fl_ref,random_value_1)
                end
            elseif ui.get(fl_mode)=="Static"then
                ui.set(fl_ref,ui.get(static_fl_sli))
            end
        elseif FIRE == 1 then
            ui.set(fl_ref,ui.get(on_fire_globle))
        elseif FIRE == 2 then
            ui.set(fl_ref,ui.get(on_fire_AWP_scout))
        end
    end)
    
    local aa_by_mode_ref = ui.reference("AA", "Anti-aimbot angles", "Body yaw")
    local fl_ena_ref =ui.reference("AA", "Fake lag","Enabled")
    
    client.set_event_callback("aim_fire", function()
        if ON == 1 then
            local cache = ui.get(aa_by_mode_ref)
            ui.set(fl_ena_ref,false)
            ui.set(aa_by_mode_ref,"Off")
            client.delay_call(0.03, function()
                ui.set(fl_ena_ref,true)
                ui.set(aa_by_mode_ref,cache)
            end)
        end
    end)

