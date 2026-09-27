local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('nametag_system:getPlayerNametag', function(source, cb, target)
    local xPlayer = ESX.GetPlayerFromId(target)
    if xPlayer then
        MySQL.Async.fetchScalar('SELECT nametag_text FROM nametag_system WHERE player_id = @player_id', {
            ['@player_id'] = xPlayer.identifier
        }, function(result)
            if result then
                cb(result)
            else
                cb('Player')
            end
        end)
    else
        cb('Player')
    end
end)

RegisterServerEvent('nametag_system:updatePlayerNametag')
AddEventHandler('nametag_system:updatePlayerNametag', function(text)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        MySQL.Async.execute('UPDATE nametag_system SET nametag_text = @nametag_text WHERE player_id = @player_id', {
            ['@player_id'] = xPlayer.identifier,
            ['@nametag_text'] = text
        }, function(rowsChanged)
            if rowsChanged == 0 then
                MySQL.Async.execute('INSERT INTO nametag_system (player_id, nametag_text, nametag_color) VALUES (@player_id, @nametag_text, @nametag_color)', {
                    ['@player_id'] = xPlayer.identifier,
                    ['@nametag_text'] = text,
                    ['@nametag_color'] = '255,255,255'
                })
            end
        end)
    end
end)