-- jeppe

drawTxt = function(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
	DrawText(x - width/2, y - height/2 + 0.005)
	DrawRect(0.920, 0.300, 0.13, 0.15, 17, 22, 31, 250)
end

function toggle()
	if IsControlJustReleased(0, 47) and Toggle == true then
		TriggerEvent("pNotify:SendNotification",{text = "Du stängde av Dashboarden", type = "warning", timeout = 5000, layout = "bottomcenter"})
		Toggle = false
	elseif Toggle == false and IsControlJustReleased(0, 47) then
		TriggerEvent("pNotify:SendNotification",{text = "Du slog på Dashboarden", type = "success", timeout = 5000, layout = "bottomcenter"})
		Toggle = true
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local veh = GetVehiclePedIsUsing(PlayerPedId())
		local vehSpeed = GetEntitySpeed(veh) * 3.6
		local vehGear = GetVehicleCurrentGear(veh)
		local gas = math.floor(GetVehicleFuelLevel(veh))
		local plateText = GetVehicleNumberPlateText(veh)
		local locked = GetVehicleDoorLockStatus(veh)
		toggle()
		if IsPedInVehicle(PlayerPedId(), veh, false) and Toggle == true and GetIsVehicleEngineRunning(veh) then
	drawTxt(1.37, 0.72, 1.0, 1.0, 0.7, plateText, 255, 0, 0, 255)
	drawTxt(1.37, 0.755, 1.0, 1.0, 0.5, "Hastighet: ~r~"..math.floor(vehSpeed).." Km/h", 255, 255, 255, 255)
	drawTxt(1.37, 0.78, 1.0, 1.0, 0.5, "Växel: ~r~"..vehGear, 255, 255, 255, 255)
	drawTxt(1.37, 0.803, 1.0, 1.0, 0.5, "Bensin: ~r~"..gas.."%", 255, 255, 255, 255)
	drawTxt(1.37, 0.83, 1.0, 1.0, 0.5, "[~r~G~w~] toggle HUD ", 255, 255, 255, 255)
		end
	end
end)