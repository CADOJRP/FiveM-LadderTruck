-- This table only works for normal vehicle spawn names not addon vehicles. To do an addon vehicle look to line 16.
local allowedVehicles = {
    "trash",
    "trash2",
    "flatbed"
}

local angleVert = 0.00
local angleHori = 0.00
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        local ped = PlayerPedId()
        local pedveh = GetVehiclePedIsIn(ped, false)
        if pedveh ~= nil then
            if vehicleAllowed(pedveh) or GetEntityModel(pedveh) == -103717954 or GetEntityModel(pedveh) == -1506060729 then
                if IsControlPressed(1, 127) then -- UP
                    if angleVert < 1.0 then
                        angleVert = angleVert + 0.01
                        controlGadget(pedveh, 5, angleVert)
                    end
                elseif IsControlPressed(1, 128) then -- DOWN
                    if angleVert > 0.0 then
                        angleVert = angleVert - 0.01
                        controlGadget(pedveh, 5, angleVert)
                    end
                end
                if IsControlPressed(1, 124) then -- LEFT
                    if angleHori > 0.0 then
                        angleHori = angleHori - 0.01
                        controlGadget(pedveh, 4, angleHori)
                    end
                elseif IsControlPressed(1, 125) then -- RIGHT
                    if angleHori < 1.0 then
                        angleHori = angleHori + 0.01
                        controlGadget(pedveh, 4, angleHori)
                    end
                end
            end
        end
    end
end)

function controlGadget(vehicle, door, angle)
    SetVehicleDoorControl(vehicle, door, 1, angle)
    SetVehicleCurrentRpm(vehicle, 1.0)
    -- Future Syncing Here
end

function vehicleAllowed(veh)
	local model = GetEntityModel(veh)
	for i = 1, #allowedVehicles, 1 do
		if model == GetHashKey(allowedVehicles[i]) then
			return true
		end
	end
	return false
end


RegisterCommand("getvehicle", function(source, args, rawCommand)
    print('Model: ' .. GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), false)));
end)