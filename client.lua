-- vehicle_indicators v1.1.0 by SEYA CODING
-- Discord: seya_coding #6497
-- Community: https://discord.gg/RT3uJRdXS

local leftSignal = false
local rightSignal = false
local hazards = false

CreateThread(function()
    while true do
        local sleep = 5
        local ped = PlayerPedId()

        if IsPedInAnyVehicle(ped, false) then
            local veh = GetVehiclePedIsIn(ped, false)

            -- LEFT BLINKER
            if IsControlJustPressed(0, Config.LeftSignalKey) then
                leftSignal = not leftSignal
                rightSignal = false
                hazards = false

                SetVehicleIndicatorLights(veh, 0, leftSignal) -- Left
                SetVehicleIndicatorLights(veh, 1, false)      -- Right
            end

            -- RIGHT BLINKER
            if IsControlJustPressed(0, Config.RightSignalKey) then
                rightSignal = not rightSignal
                leftSignal = false
                hazards = false

                SetVehicleIndicatorLights(veh, 1, rightSignal)
                SetVehicleIndicatorLights(veh, 0, false)
            end

            -- HAZARD LIGHTS (both blink)
            if IsControlJustPressed(0, Config.HazardKey) then
                hazards = not hazards
                leftSignal = hazards
                rightSignal = hazards

                SetVehicleIndicatorLights(veh, 0, hazards)
                SetVehicleIndicatorLights(veh, 1, hazards)
            end

            -- FLASH HIGH BEAM
            if IsControlPressed(0, Config.FlashKey) then
                SetVehicleFullbeam(veh, true)
            else
                SetVehicleFullbeam(veh, false)
            end

        else
            sleep = 500
        end

        Wait(sleep)
    end
end)
