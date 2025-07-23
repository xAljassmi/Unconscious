local knockedOut = false

CreateThread(function()
    while true do
        Wait(50)
        local ped = PlayerPedId()
        local health = GetEntityHealth(ped)
        -- Stealth Knockout
        if Config.EnableStealthKnockout and not knockedOut and WasPedKilledByStealth(ped) then
            ClearPedTasksImmediately(ped)
            SetEntityHealth(ped, Config.StealthHealth)
            KnockedOut()
        end

        -- Melee Knockout
        if Config.EnableMeleeKnockout and not knockedOut and health <= 110 then
            if HasEntityBeenDamagedByWeapon(playerPed, `WEAPON_UNARMED`, 0) then
                ClearPedTasksImmediately(playerPed)
                SetEntityHealth(playerPed, 109)
                ClearEntityLastDamageEntity(playerPed)
                ClearPedLastWeaponDamage(playerPed)
                KnockedOut()
            end
        end
    end
end)

function KnockedOut()
    if knockedOut then return end
    knockedOut = true

    local ped = PlayerPedId()
    SetPedCanRagdoll(true)
    ClearPedTasksImmediately(ped)

    -- Play animation
    TaskPlayAnim(ped, "missarmenian2", "drunk_loop", 1.0, 8.0, -1, 33, -1, false, false, false)

    -- ox_lib progress bar
    if lib.progressBar({
        duration = Config.KnockoutTime,
        label = Config.KnockoutText,
        useWhileDead = true,
        canCancel = false,
        disable = {
            move = true,
            car = true,
            mouse = false,
            combat = true,
        }
    }) then
        ClearPedTasksImmediately(ped)
        if WasPedKilledByStealth(ped) then
            SetPedConfigFlag(ped, 69, false)
        end
        knockedOut = false
    end
end
