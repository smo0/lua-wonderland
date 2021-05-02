local enabled = ui.new_checkbox("Lua", "B", "---Original's Anti-Aim---")--enable checkbox

    local lable_1 = ui.new_label("AA", "Anti-aimbot angles", "-------------Original's Anti-Aim-------------")--add lable
    
    local AA_mode = ui.new_combobox("AA", "Anti-aimbot angles", "Anti-Aim Mode","Slow walk","In the Air","Freestanding","Duck","On peek","On Legit")
    local AA_mode1 = ui.new_combobox("AA", "Anti-aimbot angles", "Anti-Aim Force Mode","Off","Left","Right","Back")--add mode
    
    local zhishiqi_mode =  ui.new_combobox("AA", "Anti-aimbot angles", "Visuals Mode","Delta","Circle")--add ui paint mode circle/delta
    
    
    
    
    local high_angle_chk= ui.new_checkbox("AA", "Anti-aimbot angles", "High Angles Enabled")
    local high_angle_hotkey =ui.new_hotkey("AA", "Anti-aimbot angles", "AA Invert", 1)--ui add high angles
    
    ui.set(high_angle_hotkey,"Toggle")--set value high
    
    local Slow_walk = ui.new_checkbox("AA","Anti-aimbot angles", "Slow Walk Enable")
    local Slow_walk_type = ui.new_combobox("AA", "Anti-aimbot angles","Slow Walk Type", "Favor high speed","Favor anti-aim","High/Anti")
    local Slow_walk_mode = ui.new_combobox("AA", "Anti-aimbot angles","Slow Walk Mode", "Off","Always slide","Never slide","Always/Never slide")
    --slowwalk ui add 
    
    
    local AA_air = ui.new_label("AA", "Anti-aimbot angles", "In air Hotkey Bind  ->")
    local in_air_hotkey = ui.new_hotkey("AA", "Anti-aimbot angles", "In_air_hotkey", 1,32)
    
    local AA_duck = ui.new_label("AA", "Anti-aimbot angles", "Duck Hotkey Bind  ->")
    local duck_hotkey = ui.new_hotkey("AA", "Anti-aimbot angles", "In_duck_hotkey", 1,17)
    --air and duck
    
    local AA_left = ui.new_label("AA", "Anti-aimbot angles", "AA Left Hotkey Bind  ->")
    local left_hotkey = ui.new_hotkey("AA", "Anti-aimbot angles", "left_hotkey", 1,90)
    
    
    local AA_right = ui.new_label("AA", "Anti-aimbot angles", "AA Right Hotkey Bind  ->")
    local right_hotkey = ui.new_hotkey("AA", "Anti-aimbot angles", "right_hotkey", 1,67)
    
    
    local AA_back =  ui.new_label("AA", "Anti-aimbot angles", "AA Back Hotkey Bind  ->")
    local back_hotkey = ui.new_hotkey("AA", "Anti-aimbot angles", "back_hotkey", 1,88)
    
    
    local AA_legit =  ui.new_label("AA", "Anti-aimbot angles", "Legit AA Hotkey Bind  ->")
    local legit_hotkey = ui.new_hotkey("AA", "Anti-aimbot angles", "legit_hotkey", 1)
    -- AA hotkey bind ui add
    
    local AA_ref = ui.reference("AA","Anti-aimbot angles", "Enabled")
    local Pitch_ref = ui.reference("AA", "Anti-aimbot angles", "Pitch")
    -- ui ref add
    
    
    function hideallmenu()
        ui.set_visible(lable_1, false)
        ui.set_visible(AA_mode, false)
        ui.set_visible(AA_mode1, false)
        ui.set_visible(Slow_walk, false)
        ui.set_visible(Slow_walk_mode, false)
        ui.set_visible(Slow_walk_type, false)
        ui.set_visible(AA_air, false)
        ui.set_visible(in_air_hotkey,false)
        ui.set_visible(left_hotkey, false)
        ui.set_visible(AA_left, false)
        ui.set_visible(left_hotkey, false)
        ui.set_visible(right_hotkey, false)
        ui.set_visible(AA_right, false)
        ui.set_visible(back_hotkey, false)
        ui.set_visible(AA_back, false)
        ui.set_visible(AA_legit, false)
        ui.set_visible(legit_hotkey, false)
        ui.set_visible(AA_duck, false)
        ui.set_visible(duck_hotkey, false)
        ui.set_visible(zhishiqi_mode, false)
        ui.set_visible(high_angle_hotkey, false)
        ui.set_visible(high_angle_chk, false)
    end
    hideallmenu()
    
    function seeallmenu()
        ui.set_visible(lable_1, true)
        ui.set_visible(AA_mode, true)
        ui.set_visible(AA_mode1, true)
        ui.set_visible(Slow_walk, true)
    
        ui.set_visible(left_hotkey, true)
        ui.set_visible(AA_left, true)
        ui.set_visible(left_hotkey, true)
        ui.set_visible(right_hotkey, true)
        ui.set_visible(AA_right, true)
        ui.set_visible(back_hotkey, true)
        ui.set_visible(AA_back, true)
        ui.set_visible(AA_legit, true)
        ui.set_visible(legit_hotkey, true)
    
        ui.set_visible(zhishiqi_mode, true)
        ui.set_visible(high_angle_hotkey, true)
        ui.set_visible(high_angle_chk, true)
    end
    
    
    function Hidemenu()
        if ui.get(enabled)then
            ui.set(AA_ref,true)
            ui.set(Pitch_ref,"Default")
            seeallmenu()
        else
            ui.set(AA_ref,false)
            hideallmenu()
        end
    end
    ui.set_callback(enabled, Hidemenu)
    
    
    aa_1 ={}
    aa_1[0] = 0
    
    function value_set_1()
        if ui.get(enabled)then
            if ui.get(left_hotkey) then
                aa_1[0]=1
            elseif ui.get(right_hotkey)then
                aa_1[0]=2
            elseif ui.get(back_hotkey)then
                aa_1[0]=0
            end
            if aa_1[0]==1 then
                ui.set(AA_mode1,"Left")
            elseif aa_1[0]==2 then
                ui.set(AA_mode1,"Right")
            elseif aa_1[0]==0 then
                ui.set(AA_mode1,"Off")
            end
        end
    end
    client.set_event_callback("paint", value_set_1)
    
    
    
    
    
    
    
    function on_paint_visul()
        if ui.get(enabled)then
        local x1,y1 = client.screen_size()
        local x,y = x1/2,y1-20
        if ui.get(AA_mode1)=="Off" or ui.get(AA_mode)=="On Legit"then
        renderer.text(x,y,0,255,255,255,"c+",0,"Anti-Aim Mode: "..ui.get(AA_mode))
        renderer.text(x1/2, y1/2+30, 255,140,0, 255, "c", 0, ui.get(AA_mode))
        else
            renderer.text(x,y,0,255,255,255,"c+",0,"Anti-Aim Mode: "..ui.get(AA_mode1))
            renderer.text(x1/2, y1/2+30, 255,140,0, 255, "c", 0, ui.get(AA_mode1))
        end
    end
    end
    client.set_event_callback("paint",on_paint_visul)
    
    
    
    
    
    
    
    
    
    
    
    
    
    local slow_enable_ref,slow_hotkey_on = ui.reference("AA", "Other", "Slow motion")
    local slow_type_ref = ui.reference("AA", "Other", "Slow motion type")
    local slow_mode_ref = ui.reference("AA", "Other", "Leg movement")
    
    
    
    
    function slide_value_set()
        if ui.get(enabled)then
        if ui.get(Slow_walk)then
            if ui.get(Slow_walk_type)=="Favor high speed"then
                ui.set(slow_type_ref,"Favor high speed")
            elseif ui.get(Slow_walk_type)=="Favor anti-aim"then
                ui.set(slow_type_ref,"Favor anti-aim")
            elseif ui.get(Slow_walk_type)=="High/Anti"then
                local random = client.random_int(0, 10)
                if random >5 then
                    ui.set(slow_type_ref,"Favor anti-aim")
                else
                    ui.set(slow_type_ref,"Favor high speed")
                end
            end
        end
        end
    end
    client.set_event_callback("run_command", slide_value_set)
    
    
    function slide_mode_visible()
        if ui.get(enabled)then
        if ui.get(Slow_walk)then
            ui.set_visible(Slow_walk_mode, true)
            ui.set_visible(Slow_walk_type, true)
        else
            ui.set_visible(Slow_walk_mode, false)
            ui.set_visible(Slow_walk_type, false)
        end
    end
    end
    ui.set_callback(Slow_walk, slide_mode_visible)
    
    
    function slide_mode_set()
        if ui.get(enabled)then
        if ui.get(Slow_walk)then
            if ui.get(Slow_walk_mode)=="Off"then
                ui.set(slow_mode_ref,"Off")
            elseif ui.get(Slow_walk_mode)=="Always slide"then
                ui.set(slow_mode_ref,"Always slide")
            elseif ui.get(Slow_walk_mode)=="Never slide"then
                ui.set(slow_mode_ref,"Never slide")
            elseif ui.get(Slow_walk_mode)=="Always/Never slide"then
                local rand = client.random_int(0, 10)
                if rand <= 4 then
                    ui.set(slow_mode_ref, "always slide")
                  end
                  if rand == 0 then
                    ui.set(slow_mode_ref, "never slide")
                  end
                  if rand >= 5 then
                    ui.set(slow_mode_ref, "never slide")
                  end
                end
            end
        end
    end
    client.set_event_callback("run_command", slide_mode_set)
    
    
    left_value = 0
    right_value = 0
    back_value = 0 
    
    
    
    
    
    local duck_ref_hotkey = ui.reference("Rage", "Other", "Duck peek assist")
    local peek_ref_chk,peek_ref_hotkey = ui.reference("Rage", "Other", "Quick peek assist")
    
    function mode_set()
        if ui.get(enabled)then
            local tick_value = globals.tickcount()
            if tick_value >0 then
                if ui.get(legit_hotkey)then
                    ui.set(AA_mode,"On Legit")
                elseif ui.get(in_air_hotkey)then
                    ui.set(AA_mode,"In the Air")
                elseif ui.get(slow_hotkey_on)then
                    ui.set(AA_mode,"Slow walk")
                elseif ui.get(duck_hotkey) or ui.get(duck_ref_hotkey)then
                    ui.set(AA_mode,"Duck")
                elseif ui.get(peek_ref_chk) and ui.get(peek_ref_hotkey)then
                    ui.set(AA_mode,"On peek")
                else
                    ui.set(AA_mode,"Freestanding")
                end
            end
        end
    end
    client.set_event_callback("run_command", mode_set)
    
    
    
    function delta_paint()
        if ui.get(enabled)then
            local tick_value = globals.tickcount()
            if tick_value >0 then
                if ui.get(zhishiqi_mode)=="Delta"then
                local x,y = client.screen_size()
                local x0,y0 = x/2,y/2
                renderer.triangle(x0-100, y0, x0-80, y0-10, x0-80, y0+10, 255,250,250,255)
                renderer.triangle(x0+100, y0, x0+80, y0-10, x0+80, y0+10, 255,250,250,255)
                renderer.triangle(x0, y0+100, x0-10, y0+80, x0+10, y0+80, 255,250,250,255)
                if ui.get(AA_mode1)=="Back"then
                    renderer.triangle(x0, y0+100, x0-10, y0+80, x0+10, y0+80, 0,191,255,255)
                elseif ui.get(AA_mode1)=="Right"then
                    renderer.triangle(x0+100, y0, x0+80, y0-10, x0+80, y0+10, 0,191,255,255)
                elseif ui.get(AA_mode1)=="Left"then
                    renderer.triangle(x0-100, y0, x0-80, y0-10, x0-80, y0+10, 0,191,255,255)
                end
            elseif ui.get(zhishiqi_mode)=="Circle"then
                local x,y = client.screen_size()
                local x0,y0 = x/2,y/2
                renderer.circle_outline(x0-100, y0, 135,206,235, 255, 50, 90, 0.5, 5)
                renderer.circle_outline(x0+100, y0, 135,206,235, 255, 50, 270, 0.5, 5)
                renderer.circle_outline(x0, y0+100, 135,206,235, 255, 50, 0, 0.5, 5)
                if ui.get(AA_mode1)=="Left"then
                    renderer.circle_outline(x0-100, y0, 0,255,127, 255, 50, 90, 0.5, 5)
                elseif ui.get(AA_mode1)=="Right"then
                    renderer.circle_outline(x0+100, y0, 0,255,127, 255, 50, 270, 0.5, 5)
                elseif ui.get(AA_mode1)=="Back"then
                    renderer.circle_outline(x0, y0+100, 0,255,127, 255, 50, 0, 0.5, 5)
                end
        end
            end
        end
    end
    client.set_event_callback("paint", delta_paint)
    
    local yaw_base_ref = ui.reference("AA", "Anti-aimbot angles","Yaw base")
    local yaw_ref,yaw_sli_ref = ui.reference("AA", "Anti-aimbot angles", "Yaw")
    local yaw_jitter_ref,yaw_jitter_sli_ref = ui.reference("AA", "Anti-aimbot angles", "Yaw jitter")
    local body_yaw_ref,body_yaw_sli_ref = ui.reference("AA", "Anti-aimbot angles", "Body yaw")
    local lower_body_yaw_target_ref = ui.reference("AA", "Anti-aimbot angles", "Lower body yaw target")
    local fake_yaw_limit_ref = ui.reference("AA", "Anti-aimbot angles", "Fake yaw limit")
    
    
    
    
    
    g = 1
    function right_left_back_legit()
        if ui.get(enabled)then
        if ui.get(legit_hotkey)then
            ui.set(Pitch_ref,"Off")
            ui.set(yaw_base_ref, "At targets")
            ui.set(yaw_ref,"180")
            ui.set(yaw_sli_ref,180)
            ui.set(yaw_jitter_ref,"Off")
            --ui.set(body_yaw_ref,"static")
            if g == 0 then
                local random_value = client.random_int(-100, -60)
            ui.set(body_yaw_sli_ref,random_value)
            ui.set(lower_body_yaw_target_ref,"Eye yaw")
            local random_value1 = client.random_int(47, 58)
            local random_choose = client.random_int(0, 10)
            if random_choose <3 then
                ui.set(fake_yaw_limit_ref,random_value1)
            else
                ui.set(fake_yaw_limit_ref,58)
            end
            elseif g == 1 then
            local random_value = client.random_int(30, 60)
            ui.set(body_yaw_sli_ref,random_value)
            ui.set(lower_body_yaw_target_ref,"Eye yaw")
            local random_value1 = client.random_int(44, 58)
            local random_choose = client.random_int(0, 10)
            if random_choose <3 then
                ui.set(fake_yaw_limit_ref,random_value1)
            else
                ui.set(fake_yaw_limit_ref,58)
            end
        elseif g == 2 then
        local random_value = client.random_int(-115, -70)
        ui.set(body_yaw_sli_ref,random_value)
        ui.set(lower_body_yaw_target_ref,"Eye yaw")
        local random_value1 = client.random_int(44, 55)
        local random_choose = client.random_int(0, 10)
        if random_choose <3 then
            ui.set(fake_yaw_limit_ref,random_value1)
        else
            ui.set(fake_yaw_limit_ref,55)
        end
    elseif g == 3 then
    local random_value = client.random_int(35, 65)
    ui.set(body_yaw_sli_ref,random_value)
    ui.set(lower_body_yaw_target_ref,"Eye yaw")
    local random_value1 = client.random_int(44, 59)
    local random_choose = client.random_int(0, 10)
    if random_choose <3 then
        ui.set(fake_yaw_limit_ref,random_value1)
    else
        ui.set(fake_yaw_limit_ref,59)
    end
    elseif g == 4 then
        local random_value = client.random_int(85, 120)
        ui.set(body_yaw_sli_ref,random_value)
        ui.set(lower_body_yaw_target_ref,"Eye yaw")
        local random_value1 = client.random_int(44, 56)
        local random_choose = client.random_int(0, 10)
        if random_choose <3 then
            ui.set(fake_yaw_limit_ref,random_value1)
        else
            ui.set(fake_yaw_limit_ref,56)
        end
    elseif g == 5 then
        local random_value = client.random_int(-60,-35)
        ui.set(body_yaw_sli_ref,random_value)
        ui.set(lower_body_yaw_target_ref,"Eye yaw")
        local random_value1 = client.random_int(40, 60)
        local random_choose = client.random_int(0, 10)
        if random_choose <3 then
            ui.set(fake_yaw_limit_ref,random_value1)
        else
            ui.set(fake_yaw_limit_ref,54)
        end
            end
        elseif ui.get(AA_mode1)=="Left"then
            ui.set(Pitch_ref,"Default")
            ui.set(yaw_base_ref, "Local view")
            ui.set(yaw_ref,"180")
            ui.set(yaw_sli_ref,-90)
        elseif ui.get(AA_mode1)=="Right"then
            ui.set(Pitch_ref,"Default")
            ui.set(yaw_base_ref, "Local view")
            ui.set(yaw_ref,"180")
            ui.set(yaw_sli_ref,90)
        elseif ui.get(AA_mode1)=="Back"then
            ui.set(Pitch_ref,"Default")
            ui.set(yaw_base_ref, "Local view")
            ui.set(yaw_ref,"180")
            ui.set(yaw_sli_ref,0)
        else
            ui.set(Pitch_ref,"Default")
            ui.set(yaw_base_ref,"At targets")
            ui.set(yaw_ref,"180")
        end
    end
    end
    client.set_event_callback("paint", right_left_back_legit)
    
    
    color= {}
    color[0] = 255
    end_1 = 0

    
    
    on_fire={}
    on_fire[0]=0
    function fire_change()
        if on_fire[0]==0 then
            g = 0
            on_fire[0] = 1 
        elseif on_fire[0]==1 then
            g = 1 
            on_fire[0] = 2
        elseif on_fire[0]==2 then
            g = 2
            on_fire[0]=3
        elseif on_fire[0]==3 then
            g = 3
            on_fire[0]=4
        elseif on_fire[0]==4 then
            g = 4
            on_fire[0]=5
        elseif on_fire[0]==5 then
            g = 5
            on_fire[0]=0
        end
    end
    client.set_event_callback("weapon_fire", fire_change)
    
    
    function copyright()
        if ui.get(enabled)then
        local x,y = client.screen_size()
        local a = color[0]
        renderer.text(x-80, y-6, 0,255,127, a, "c", 0, "Lua Copyright@2021 By Original")
        if a == 0 then
            end_1 = 1
            elseif a== 255 then
            end_1 = 0
            end
            if end_1 == 0 then
                color[0]= a-1
            elseif end_1 == 1 then
                color[0] = a+1
            end
        end
    end
    client.set_event_callback("paint_ui", copyright)
    
    function high_angle_if()
        if ui.get(high_angle_chk) and ui.get(high_angle_hotkey)then
            return true
        else
            return false
        end
    end
    
    function paint_hotkey_high()
        if ui.get(enabled)then
            if high_angle_if()==true then
                local x,y= client.screen_size()
                local x1,y1 = 110,y/2
                renderer.text(x1, y1, 0,191,255, 255, "c+", 0, "Anti High Angle: ON")
            else
                local x,y= client.screen_size()
                local x1,y1 = 110,y/2
                renderer.text(x1, y1, 216,191,216, 255, "c+", 0, "Anti High Angle: OFF")
            end
        end
    end
    client.set_event_callback("paint", paint_hotkey_high)
    
    function in_air_set_value()
        if ui.get(enabled)then
            if ui.get(AA_mode)=="In the Air"then
            if high_angle_if()==true then
                ui.set(yaw_sli_ref,0)
                ui.set(yaw_jitter_ref,"Offset")
                ui.set(yaw_jitter_sli_ref,0)
                if g == 0 then
                local random= client.random_int(-95, -60)
                ui.set(body_yaw_sli_ref,random)
                else
                    local random= client.random_int(60, 95)
                    ui.set(body_yaw_sli_ref,random)
                end
                local random1 =client.random_int(28, 42)
                ui.set(fake_yaw_limit_ref,random1)
                ui.set(lower_body_yaw_target_ref,"Eye yaw")
            elseif high_angle_if()==false then
                ui.set(yaw_sli_ref,-3)
                ui.set(yaw_jitter_ref,"Offset")
                ui.set(yaw_jitter_sli_ref,2)
                if g == 0 then
                local random= client.random_int(-45, -25)
                ui.set(body_yaw_sli_ref,random)
                else
                    local random= client.random_int(25,45)
                    ui.set(body_yaw_sli_ref,random)
                end
                local random1 = client.random_int(23, 36)
                ui.set(fake_yaw_limit_ref,random1)
                ui.set(lower_body_yaw_target_ref,"Eye yaw")
            end
        end
        end
    end
    client.set_event_callback("run_command", in_air_set_value)
    
    
    function freestanding_set_value()
        if ui.get(enabled)then
            if ui.get(AA_mode)=="Freestanding"then
                if ui.get(AA_mode1)=="Off"then
                    ui.set(yaw_sli_ref,2)
                end
                ui.set(yaw_jitter_ref,"Offset")
                ui.set(lower_body_yaw_target_ref,"Eye yaw")
                local random_value_0 = client.random_int(0, 100)
                    if random_value_0 == 65 then
                        ui.set(yaw_sli_ref,5)
                        ui.set(yaw_jitter_sli_ref,4)
                    elseif random_value_0 == 13 then
                        ui.set(yaw_sli_ref,2)
                        ui.set(yaw_jitter_sli_ref,-1)
                    end
                if high_angle_if()==true then
                    local random = client.random_int(26, 38)
                    ui.set(fake_yaw_limit_ref,random)
                    if g==0 then
                        local random1 = client.random_int(45, 70)
                        ui.set(body_yaw_sli_ref,random1)
                    elseif g== 1 then
                        local random1 = client.random_int(-40, -20)
                        ui.set(body_yaw_sli_ref,random1)
                    elseif g== 2 then
                        local random1 = client.random_int(65, 80)
                        ui.set(body_yaw_sli_ref,random1)
                    elseif g== 3 then
                        local random1 = client.random_int(20, 35)
                        ui.set(body_yaw_sli_ref,random1)
                    elseif g== 4 then
                        local random1 = client.random_int(-85, -60)
                        ui.set(body_yaw_sli_ref,random1)
                    elseif g== 5 then
                        local random1 = client.random_int(-45, -20)
                        ui.set(body_yaw_sli_ref,random1)
                    end
                elseif high_angle_if()==false then
                    local random = client.random_int(20, 34)
                    ui.set(fake_yaw_limit_ref,random)
                    if g==0 then
                        local random1 = client.random_int(22, 45)
                        ui.set(body_yaw_sli_ref,random1)
                    elseif g== 1 then
                        local random1 = client.random_int(-40, -20)
                        ui.set(body_yaw_sli_ref,random1)
                    elseif g== 2 then
                        local random1 = client.random_int(17, 38)
                        ui.set(body_yaw_sli_ref,random1)
                    elseif g== 3 then
                        local random1 = client.random_int(-35, -10)
                        ui.set(body_yaw_sli_ref,random1)
                    elseif g== 4 then
                        local random1 = client.random_int(14, 33)
                        ui.set(body_yaw_sli_ref,random1)
                    elseif g== 5 then
                        local random1 = client.random_int(-50, -23)
                        ui.set(body_yaw_sli_ref,random1)
                    end
                end
            end
        end
    end
    client.set_event_callback("run_command", freestanding_set_value)
    
    function peek_set_value()
        if ui.get(enabled)then
            if ui.get(AA_mode)=="On peek"then
                if high_angle_if()==true then
                    --ui.set(yaw_sli_ref,7)
                    ui.set(yaw_jitter_ref,"Offset")
                    ui.set(yaw_jitter_sli_ref,5)
                    ui.set(lower_body_yaw_target_ref,"Eye yaw")
                    local random = client.random_int(30, 45)
                    ui.set(fake_yaw_limit_ref,random)
                    if g==0 or g==2 or g== 4 then
                        local random1 = client.random_int(40, 70)
                        ui.set(body_yaw_sli_ref,random1)
                    else
                        local random1 =client.random_int(-75, -50)
                        ui.set(body_yaw_sli_ref,random1)
                    end
                elseif high_angle_if()==false then
                    --ui.set(yaw_sli_ref,2)
                    ui.set(yaw_jitter_ref,"Offset")
                    ui.set(yaw_jitter_sli_ref,-2)
                    ui.set(lower_body_yaw_target_ref,"Eye yaw")
                    local random = client.random_int(24, 36)
                    ui.set(fake_yaw_limit_ref,random)
                    if g==0 or g==2 or g== 4 then
                        local random1 = client.random_int(20, 45)
                        ui.set(body_yaw_sli_ref,random1)
                    else
                        local random1 =client.random_int(-50, -25)
                        ui.set(body_yaw_sli_ref,random1)
                    end
                end
            end
        end
    end
    client.set_event_callback("run_command", peek_set_value)--peek value
    
    function duck_set_value()
        if ui.get(enabled)then
            if ui.get(AA_mode)=="Duck"then
                if high_angle_if()==true then
                    ui.set(yaw_sli_ref,0)
                    ui.set(yaw_jitter_ref,"Offset")
                    ui.set(yaw_jitter_sli_ref,0)
                    ui.set(lower_body_yaw_target_ref,"Eye yaw")
                    local random = client.random_int(25, 43)
                    ui.set(fake_yaw_limit_ref,random)
                    if g==0 or g==2 or g== 4 then
                    local random1 =client.random_int(65, 105)
                    ui.set(body_yaw_sli_ref,random1)
                    else
                        local random1 =client.random_int(-100, -60)
                        ui.set(body_yaw_sli_ref,random1)
                    end
                elseif high_angle_if()==false then
                        ui.set(yaw_sli_ref,0)
                    ui.set(yaw_jitter_ref,"Offset")
                    ui.set(yaw_jitter_sli_ref,0)
                    ui.set(lower_body_yaw_target_ref,"Eye yaw")
                    local random = client.random_int(20, 34)
                    ui.set(fake_yaw_limit_ref,random)
                    if g==0 or g==2 or g== 4 then
                    local random1 =client.random_int(23, 48)
                    ui.set(body_yaw_sli_ref,random1)
                    else
                        local random1 =client.random_int(-50, -22)
                        ui.set(body_yaw_sli_ref,random1)
                    end
                end
            end
        end
    end
    client.set_event_callback("run_command", duck_set_value)
    
    
    on_fire[1]=0
    value_slow = 0
    function fire_change()
        if on_fire[1]==0 then
            value_slow = 0
            on_fire[1] = 1 
        elseif on_fire[1]==1 then
            value_slow = 1 
            on_fire[1] = 2
        elseif on_fire[1]==2 then
            value_slow = 2
            on_fire[1]=3
        elseif on_fire[1]==3 then
            value_slow = 3
            on_fire[1]=4
        end
    end
    client.set_event_callback("weapon_fire", fire_change)--local the value about weaponfire value2
    
    
    
    
    function  slow_walk_set_value()
        if ui.get(enabled)then
            if ui.get(AA_mode)=="Slow walk"then
                local random_value1 = client.random_int(0, 10)
                if random_value1 <4 then 
                    local random_value2 = client.random_int(33, 48)
                    ui.set(fake_yaw_limit_ref,random_value2)
                else
                    ui.set(fake_yaw_limit_ref,26)
                end
                ui.set(lower_body_yaw_target_ref,"Eye yaw")
                if ui.get(AA_mode1)=="Off"then
                local random_11 = client.random_int(-5, 5)
                ui.set(yaw_sli_ref,random_11)
                end
                ui.set(yaw_jitter_ref,"Offset")
                local random_13 = client.random_int(-15, 15)
                ui.set(yaw_jitter_sli_ref,random_13)
                if high_angle_if()==true then
                    if value_slow == 0 then
                        local random1 = client.random_int(-50,-28)
                        ui.set(body_yaw_sli_ref,random1)
                    elseif value_slow == 1 then
                        local random1 = client.random_int(23,50)
                         ui.set(body_yaw_sli_ref,random1)
                    elseif value_slow == 2 then
                        local random1 = client.random_int(-45,-34)
                        ui.set(body_yaw_sli_ref,random1)
                    elseif value_slow == 3 then
                        local random1 = client.random_int(30,47)
                         ui.set(body_yaw_sli_ref,random1)
                    end
                elseif high_angle_if()==false then
                    if value_slow == 0 then
                        local random1 = client.random_int(-39,-24)
                        ui.set(body_yaw_sli_ref,random1)
                    elseif value_slow == 1 then
                        local random1 = client.random_int(18,33)
                         ui.set(body_yaw_sli_ref,random1)
                    elseif value_slow == 2 then
                        local random1 = client.random_int(-34,-22)
                        ui.set(body_yaw_sli_ref,random1)
                    elseif value_slow == 3 then
                        local random1 = client.random_int(23,34)
                         ui.set(body_yaw_sli_ref,random1)
                    end
                end
            end
        end
    end
    
    client.set_event_callback("run_command", slow_walk_set_value)
    
    --end
    
    
    
    
    function on_death()
        on_fire[0]=0
        on_fire[1]=0
    end
    client.set_event_callback("player_death", on_death)
    client.set_event_callback("round_start", on_death)
    client.set_event_callback("round_end", on_death)
        
    
    ui.set(body_yaw_ref,"Static")
    
