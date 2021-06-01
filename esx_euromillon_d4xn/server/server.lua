ESX								= nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local _players = {}

RegisterNetEvent('esx_euromillon_d4xn:reiniciarLista_d4xn')
AddEventHandler('esx_euromillon_d4xn:reiniciarLista_d4xn', function()
        _players = {}
end)

RegisterNetEvent('esx_euromillon_d4xn:sorteoBoleto_d4xn')
AddEventHandler('esx_euromillon_d4xn:sorteoBoleto_d4xn', function(_charId)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local _winner = math.random(1, 100000)

    TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'success', text = _U('euromillon_start')})

    if _players[_winner] ~= nil then
        local _winnerId = _players[_winner]
        if _winnerId == _charId then 
            TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'success', text = _U('euromillon_win')})
            TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = _U('euromillon_end')})
            xPlayer.addMoney(1000000)
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = _U('euromillon_end')})
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = _U('euromillon_end')})
    end
end)

-- Compra de boletos
RegisterNetEvent('esx_euromillon_d4xn:comprarBoleto_d4xn')
AddEventHandler('esx_euromillon_d4xn:comprarBoleto_d4xn', function(_id)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local _coords = xPlayer.getCoords(true)

    if #(_coords-vector3(219.80, -859.85, 29.20)) <= 3 then
        if xPlayer.getMoney() >= 100 then
            local _num = 0
            local _inList = false
            while _num <= #_players do
                if _players[_num] == _id then
                    _inList = true
                    break
                end
                _num = _num +1
            end
            if not _inList then
                xPlayer.removeMoney(100)
                _players[#_players+1]=_id
                TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'success', text = _U('play_euromillon')})
            else
                if #_players < 100 then
                    xPlayer.removeMoney(100)
                    _players[#_players+1]=_id
                    TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'success', text = _U('play_again_euromillon')})

                else
                    TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = _U('no_more_boletos')})
                end
            end
        else 
            TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = _U('no_money')})
        end
    end
end)

-- Compra de rascas
RegisterNetEvent('esx_euromillon_d4xn:comprarRasca_d4xn')
AddEventHandler('esx_euromillon_d4xn:comprarRasca_d4xn', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local _coords = xPlayer.getCoords(true)
    
    if #(_coords-vector3(219.80, -859.85, 29.20)) <= 3 then
        if xPlayer.getMoney() >= 12 then
            xPlayer.removeMoney(12)

            local winner = math.random(0, 100000)
            local number = math.random(0, 100000)
            local winner2 = math.random(0, 1000)
            local number2 = math.random(0, 1000)
            local luck = math.random(0, 100)

            if winner == number then
                TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'success', text = _U('first_prize')})
                xPlayer.addMoney(1000000) -- 1/1,000,000 possibilities

            elseif winner2 == number2 then
                TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'success', text = _U('second_prize')})
                xPlayer.addMoney(10000)

            else
                if luck >= 25 then
                    if luck >= 50 then
                        if luck >= 85 then
                            if luck >= 95 then
                                TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'success', text = _U('third_prize')})
                                xPlayer.addMoney(125)
                            else
                                TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'success', text = _U('fourth_prize')})
                                xPlayer.addMoney(50)
                            end
                        else
                            TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'success', text = _U('fifth_prize')})
                            xPlayer.addMoney(12)
                        end
                    else
                        TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = _U('sixth_prize')})
                        xPlayer.addMoney(6)
                    end
                else
                    TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = _U('loose_all')})
                end
            end

        elseif xPlayer.getMoney() < 12 then
            TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = _U('no_money')})
        end
    end
end)