ESX	= nil
PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	Citizen.Wait(5000)
	PlayerData = ESX.GetPlayerData()
end)

-- Venta Boleto NPC
-- Change coordinates if you want | Cambia las coordenadas si quieres
Citizen.CreateThread(function()
    SpawnNPC('a_f_m_eastsa_01', vector4(219.80, -859.85, 29.20, 340.30)) -- Person (Vendedor/a Euromillon)
    --SpawnNPC('a_c_shepherd', vector4(220.50, -860.15, 29.20, 340.30)) -- Dog (comment this line for get lower cost and usage)
    while true do
        local _char = PlayerPedId()
        local _charPos = GetEntityCoords(_char)
        local _sleep = 1000
        if #(_charPos - vector3(219.80, -859.85, 29.20)) <= 3 and not IsPedSwimming(_char) and not IsEntityDead(_char) then
            _sleep = 0
            DrawText3D(219.80, -859.85, 31.25, _U('npc_txt'))
            if IsControlJustPressed(0, 38) then 
                OpenMenu()
            end
        end
        Citizen.Wait(_sleep)
    end
end)

-- DrawText3D
function DrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

-- SpawnNPC

SpawnNPC = function(modelo, x, y, z, h)
    hash = GetHashKey(modelo)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(1)
    end
    crearNPC = CreatePed(5, hash, x, y, z, h, false, true)
    FreezeEntityPosition(crearNPC, true)
    SetEntityInvincible(crearNPC, true)
    SetBlockingOfNonTemporaryEvents(crearNPC, true)
    TaskStartScenarioInPlace(crearNPC, "WORLD_HUMAN_SMOKING", 0, false) -- "WORLD_HUMAN_SMOKING"
end

function OpenMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'loterias',
	{
		title    = _U('title_menu'),--'Loterías y Apuestas del Estado',
        align    = 'top-right',
		elements = {
			{label = _U('rasca_menu'),     value = 'rasca'},
			{label = _U('boleto_menu'), value = 'boleto'}
		}
	}, function(data, menu)
		if data.current.value == 'rasca' then
			TriggerServerEvent('esx_euromillon_d4xn:comprarRasca_d4xn')
		elseif data.current.value == 'boleto' then
			TriggerServerEvent('esx_euromillon_d4xn:comprarBoleto_d4xn', PlayerPedId())
		end

		menu.close()
	end, function(data, menu)
		menu.close()
	end)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(3600000)
        local _char = PlayerPedId()
        TriggerServerEvent('esx_euromillon_d4xn:sorteoBoleto_d4xn', _char)
        TriggerServerEvent('esx_euromillon_d4xn:reiniciarLista_d4xn')
    end
end)


local blips = {
    -- Example {title="", colour=, id=, x=, y=, z=},
    -- Change the title if you speak other language
    {title=_U('blip_name'), colour=7, id=280, x = 219.80, y = -859.85, z = 30.20} -- Change the coordinates of the blip if you want
  
}
  
  local showBlip = true
        
  if showBlip == true then
    Citizen.CreateThread(function()
      for _, info in pairs(blips) do
        info.blip = AddBlipForCoord(info.x, info.y, info.z)
        SetBlipSprite(info.blip, info.id)
        SetBlipDisplay(info.blip, 4)
        SetBlipScale(info.blip, 1.0)
        SetBlipColour(info.blip, info.colour)
        SetBlipAsShortRange(info.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(info.title)
        EndTextCommandSetBlipName(info.blip)
      end
      
    end)
  
  end