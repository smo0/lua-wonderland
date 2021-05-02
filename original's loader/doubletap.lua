ui.new_label("Rage", "Other", "---Original Double Tap V3.0[Beta]---")
    local unsafe_dt_chk  = ui.new_checkbox("Rage", "Other", "Unsafe Double Tap")
    
    function right()
        if ui.get(unsafe_dt_chk)then
            cvar.cl_clock_correction:set_int(0)
        else
            cvar.cl_clock_correction:set_int(1)
        end
    end
    
    right()
    ui.set(ui.set_callback(unsafe_dt_chk, right))
    client.set_event_callback("shutdown", function()
        cvar.cl_clock_correction:set_int(1)
    end)
    
    
    ui.new_label("Rage", "Other", "---Original Double Tap V3.0[Beta] End---")
