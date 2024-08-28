-- Config here
local UI = { 
	x = 0.3735,
	y = 0.46,
}

local units = "Imperial" --Acceptable values: "Imperial" or "Metric"
local AnchorScript = "On" -- Acceptable values: "On", false

--[[



PRESETS:
Bottom of screen
x = 0.000,
y = 0.43,

Bottom right of screen
x = 0.3,
y = 0.43,

Top of screen
x = 0.000,
y = -0.43,



DO NOT EDIT ANYTHING BELOW THIS IF YOU DON'T KNOW WHAT YOU'RE DOING!
]]--




function Text(text, x, y, scale)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextOutline()
	SetTextJustification(0)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

function Vector3ToCompassHeading(vector)
    -- Calculate the angle in radians
    local angle = math.atan2(vector.y, vector.x)
    -- Convert angle to degrees
    local angleDeg = math.deg(angle)
    -- Normalize angle to be within 0 to 360 degrees
    if angleDeg < 0 then
        angleDeg = angleDeg + 360
    end
    return angleDeg
end


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)			
		-------------------------BOAT-------------------
		local ped = PlayerPedId()
		local boat = IsPedInAnyBoat(ped)
		local pedVehicle = GetVehiclePedIsIn(ped,false)
		local inDriverSeat = GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == ped
		local inPassengerSeat = GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), 0) == ped
		-------------------------BOAT-------------------
		local coords = GetEntityCoords(pedVehicle)
		local heading = GetEntityHeading(pedVehicle)
		local speed = GetEntitySpeed(pedVehicle)
		local mph = speed * 2.236936
		local kph = speed * 3.6
		local kts = speed * 1.944
		-------------------------Systems----------------
		local engine = GetIsVehicleEngineRunning(pedVehicle)
		local engineHealth = GetVehicleEngineHealth(pedVehicle)
		local oilPressure = GetVehicleDashboardOilPressure(pedVehicle)
		local oilTemp = GetVehicleDashboardOilTemp(pedVehicle)
		local hullHealth = GetVehicleBodyHealth(pedVehicle)
		local upsideDown = IsEntityUpsidedown(pedVehicle)
		local _, headLightsOn = GetVehicleLightsState(pedVehicle)
		local _, _, highBeamsOn = GetVehicleLightsState(pedVehicle)
		local waterDepth =  GetEntityHeightAboveGround(pedVehicle)
		local onFire = IsEntityOnFire(pedVehicle)
		local isAnchored = IsBoatAnchoredAndFrozen(pedVehicle)

		if boat and (inDriverSeat or inPassengerSeat) then	 
			-------------------------Systems----------------
			local engineTemp = GetVehicleEngineTemperature(pedVehicle)
			local oilLevel = GetVehicleOilLevel(pedVehicle)
			local fuelLevel = GetVehicleFuelLevel(pedVehicle)*10
			
			if engine then

				-- engine display	
				if engineHealth > 600 and engineHealth < 900 then
					Text("~y~ENGINE", UI.x + 0.4, UI.y + 0.473, 0.30)
					Text("~y~⚠️", UI.x + 0.415, UI.y + 0.475, 0.15)
				elseif engineHealth > 400 and engineHealth < 600  then
					Text("~o~ENGINE", UI.x + 0.4, UI.y + 0.473, 0.30)
					Text("~o~⚠️", UI.x + 0.415, UI.y + 0.475, 0.15)
				elseif engineHealth > 200 and engineHealth < 400  then
					Text("~r~ENGINE", UI.x + 0.4, UI.y + 0.473, 0.30)
					Text("~r~⚠️", UI.x + 0.415, UI.y + 0.475, 0.15)					
				elseif engineHealth < 200 then
					Text("~r~ENGINE", UI.x + 0.4, UI.y + 0.473, 0.30)
					Text("~r~❌", UI.x + 0.415, UI.y + 0.475, 0.15)				
				elseif engineTemp > 106 then
					Text("~r~ENGINE TEMP", UI.x + 0.4, UI.y + 0.473, 0.30)
				elseif engineHealth > 850 then
					Text("~g~ENGINE", UI.x + 0.4, UI.y + 0.473, 0.30)
				end
				
				-- Oil display
				if oilTemp > 0.8 then
					Text("~r~OIL TEMP", UI.x + 0.4, UI.y + 0.488, 0.30)	
				elseif oilPressure < 0.2 then
					Text("~r~OIL PRESSURE", UI.x + 0.4, UI.y + 0.488, 0.30)
				elseif oilLevel < 1 then
					Text("~r~OIL LEVEL", UI.x + 0.4, UI.y + 0.488, 0.30)
				elseif oilTemp > 0.75 and oilTemp < 0.8 then
					Text("~r~OIL TEMP", UI.x + 0.4, UI.y + 0.488, 0.30)
				elseif oilPressure < 0.2 and oilPressure > 0.1 then
					Text("~r~OIL PRESSURE", UI.x + 0.4, UI.y + 0.488, 0.30)
				elseif oilLevel < 1.5 and oilLevel > 1 then
					Text("~r~OIL LEVEL", UI.x + 0.4, UI.y + 0.488, 0.30)
				elseif oilTemp > 0.7 and oilTemp < 0.75 then
					Text("~o~OIL TEMP", UI.x + 0.4, UI.y + 0.488, 0.30)
				elseif oilPressure < 0.3 and oilPressure > 0.2 then
					Text("~o~OIL PRESURE", UI.x + 0.4, UI.y + 0.488, 0.30)
				elseif oilLevel < 2 and oilLevel > 1.5 then
					Text("~o~OIL LEVEL", UI.x + 0.4, UI.y + 0.488, 0.30)
				elseif oilTemp > 0.65 and oilTemp < 0.7 then
					Text("~y~OIL TEMP", UI.x + 0.4, UI.y + 0.488, 0.30)
				elseif oilPressure < 0.4 and oilPressure > 0.3 then
					Text("~y~OIL PRESSSURE", UI.x + 0.4, UI.y + 0.488, 0.30)
				elseif oilLevel < 2.5 and oilLevel > 2 then
					Text("~y~OIL LEVEL", UI.x + 0.4, UI.y + 0.488, 0.30)
				else
					Text("~g~OIL", UI.x + 0.4, UI.y + 0.488, 0.30)
				end
				
				-- Other Warnings
				if onFire then
					Text("~r~FIRE", UI.x + 0.4, UI.y + 0.502, 0.30)
				elseif hullHealth < 800 or upsideDown then
					Text("~b~BILGE ACTIVE", UI.x + 0.4, UI.y + 0.502, 0.30)	
				elseif isAnchored then
					Text("~o~ACHORED", UI.x + 0.4, UI.y + 0.502, 0.30)	
				end

				-- Fuel display
				if fuelLevel > 15.0 then
					Text(math.ceil(fuelLevel), UI.x + 0.438, UI.y + 0.475, 0.45)  
				elseif fuelLevel < 15.0 and fuelLevel > 5.1 then
					Text(string.format("~y~%.f", fuelLevel), UI.x + 0.435, UI.y + 0.475, 0.45) 
					Text("~y~⚠️", UI.x + 0.445, UI.y + 0.484, 0.15)
				elseif fuelLevel < 5.0 then
					Text(string.format("~o~%.f", fuelLevel), UI.x + 0.435, UI.y + 0.475, 0.45)
					Text("~o~⚠️", UI.x + 0.445, UI.y + 0.484, 0.15)
				end	

				-- Speed in kts
				Text(math.ceil(kts), UI.x + 0.5235, UI.y + 0.476, 0.45)
				Text("~w~KN", UI.x + 0.5345, UI.y + 0.481, 0.35)
				
				-- Speed and Depth display
				if units == "Imperial" then
					--Speed (Freedom Units)
					Text(math.ceil(mph), UI.x + 0.4955, UI.y + 0.476, 0.45)
					Text("~w~MPH", UI.x + 0.5095, UI.y + 0.481, 0.35)
					--Depth (Freedom Units)
					if IsEntityInWater(pedVehicle) then
						if waterDepth > 5 then
							Text(math.ceil(waterDepth*3.2808399), UI.x + 0.465, UI.y + 0.476, 0.45)
						elseif waterDepth < 5 and waterDepth > 1.5 then
							Text(string.format("~y~%.f", waterDepth*3.2808399), UI.x + 0.465, UI.y + 0.476, 0.45)
						else
							Text(string.format("~o~%.f", waterDepth*3.2808399), UI.x + 0.465, UI.y + 0.476, 0.45)
						end
					else
						Text("~w~-", UI.x + 0.465, UI.y + 0.476, 0.45)
					end
					Text("~w~ft", UI.x + 0.4764, UI.y + 0.481, 0.35)
				elseif units == "Metric" then
					--Speed
					Text(math.ceil(kph), UI.x + 0.4955, UI.y + 0.476, 0.45)
					Text("~w~KPH", UI.x + 0.5095, UI.y + 0.481, 0.35)
					--Depth
					if IsEntityInWater(pedVehicle) then
						if waterDepth > 5 then
							Text(math.ceil(waterDepth), UI.x + 0.465, UI.y + 0.476, 0.45)
						elseif waterDepth < 5 and waterDepth > 1.5 then
							Text(string.format("~y~%.f", waterDepth), UI.x + 0.465, UI.y + 0.476, 0.45)
						else
							Text(string.format("~o~%.f", waterDepth), UI.x + 0.465, UI.y + 0.476, 0.45)
						end
					else
						Text("~w~-", UI.x + 0.465, UI.y + 0.476, 0.45)
					end
					Text("~w~m", UI.x + 0.4764, UI.y + 0.481, 0.35)
				else
					print("Fix your units")
				end

				-- Heading
				Text(math.ceil(heading), UI.x + 0.561, UI.y + 0.476, 0.45)
				-- Coords
				Text(string.format("%.f", coords.x), UI.x + 0.589, UI.y + 0.476, 0.363)
				Text("~w~,", UI.x + 0.599, UI.y + 0.476, 0.37)
				Text(string.format("%.f", coords.y), UI.x + 0.609, UI.y + 0.476, 0.363)
			end

			--UI
			if (headLightsOn == 1 or highBeamsOn == 1) and engine then   --green hud
				Text("~g~SPEED", UI.x + 0.5145, UI.y + 0.508, 0.35)
				Text("~g~DEPTH", UI.x + 0.4685, UI.y + 0.508, 0.35)
				Text("~g~FUEL", UI.x + 0.438, UI.y + 0.508, 0.35)
				Text("~g~HEADING", UI.x + 0.561, UI.y + 0.508, 0.35)
				Text("~g~COORDS", UI.x + 0.599, UI.y + 0.508, 0.35)
				-- Big rectangles on the ui
				DrawRect(UI.x + 0.5, UI.y + 0.5, 0.255, 0.085, 143, 234, 27, 255) --exterior abajo
			else    --greyhud --
				Text("~w~SPEED", UI.x + 0.5145, UI.y + 0.508, 0.35)
				Text("~w~DEPTH", UI.x + 0.4685, UI.y + 0.508, 0.35)
				Text("~w~FUEL", UI.x + 0.438, UI.y + 0.508, 0.35)
				Text("~w~HEADING", UI.x + 0.561, UI.y + 0.508, 0.35)
				Text("~w~COORDS", UI.x + 0.599, UI.y + 0.508, 0.35)
				-- Big rectangles on the ui
				DrawRect(UI.x + 0.5, UI.y + 0.5, 0.255, 0.085, 40, 40, 40, 255) --exterior abajo
			end
			--main UI
			DrawRect(UI.x + 0.5, UI.y + 0.5, 0.25, 0.075, 0, 0, 0, 255) -- Base
			-- Smaller squares in the rectangles.
			DrawRect(UI.x + 0.4, UI.y + 0.5, 0.040, 0.051, 51, 62, 52, 255) --Warning Panel
			DrawRect(UI.x + 0.438, UI.y + 0.49, 0.025, 0.032, 51, 62, 52, 255)	--Fuel Panel			
			DrawRect(UI.x + 0.4685, UI.y + 0.49, 0.025, 0.032, 51, 62, 52, 255)	--Depth Panel		
			DrawRect(UI.x + 0.5145, UI.y + 0.49, 0.055, 0.032, 51, 62, 52, 255) -- Speed Panel	
			DrawRect(UI.x + 0.561, UI.y + 0.49, 0.025, 0.032, 51, 62, 52, 255) -- Heading
			DrawRect(UI.x + 0.599, UI.y + 0.49, 0.04, 0.032, 51, 62, 52, 255) -- Coords				
		end
	end
end)

if AnchorScript == "On" then
	local anchorOn = false
	local function toggleAnchor()
		if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId() then
			anchorOn = not anchorOn
			if anchorOn then
				SetBoatAnchor(GetVehiclePedIsIn(PlayerPedId()), true)
				SetBoatFrozenWhenAnchored(GetVehiclePedIsIn(PlayerPedId()), true)
			else
				SetBoatAnchor(GetVehiclePedIsIn(PlayerPedId()), false)
				SetBoatFrozenWhenAnchored(GetVehiclePedIsIn(PlayerPedId()), false)
			end
		end
	end

	-- Register the toggle command
	RegisterCommand('toggleAnchor', toggleAnchor, false)

	-- Register key mapping to the toggle command
	RegisterKeyMapping('toggleAnchor', 'Toggle Boat Anchor', 'keyboard', 'ADD')
end
