ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RMenu.Add('loca', 'loca_test', RageUI.CreateMenu("Location","Choisissez votre véhicule de location :"))
RMenu:Get('loca', 'loca_test').Closed = function()end

--Afficher le point s'il est loin ou non--

Citizen.CreateThread(function()
    while true do
        local interval = 1
        local pos = GetEntityCoords(PlayerPedId())
        local dest = vector3(-1034.49, -2732.1, 19.17)
        local distance = GetDistanceBetweenCoords(pos, dest, true)

        if distance > 30 then
            interval = 200
        else
            interval = 1
            if distance < 3 then
                AddTextEntry("LOCA", "Appuyez sur [~b~E~w~] pour louer un véhicule.")
                DisplayHelpTextThisFrame("LOCA", false)
                if IsControlJustPressed(1, 51) then
                    RageUI.Visible(RMenu:Get("loca","loca_test"), true)
                end
            end
        end
        Citizen.Wait(interval)
    end  
end)

--Afficher le menu--

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get("loca", "loca_test"),true,true,true,function()

            RageUI.Button("Scooter", "Scooter", {RightLabel = "~g~100$"}, true,function(h,a,s)
                if s then
                    TriggerServerEvent('popo_loca:vehicule', 100)
                    spawnCar("faggio")
                    RageUI.CloseAll()
                end
            end)

            RageUI.Button("Blista", "Blista", {RightLabel = "~g~300$"}, true,function(h,a,s)
                if s then
                    TriggerServerEvent('popo_loca:vehicule', 300)
                    spawnCar("blista")
                    RageUI.CloseAll()
                end
            end)

            RageUI.Button("Prairie", "Prairie", {RightLabel = "~g~500$"}, true,function(h,a,s)
                if s then
                    TriggerServerEvent('popo_loca:vehicule', 500)
                    spawnCar("prairie")
                    RageUI.CloseAll()
                end
            end)

        end, function()
        end)
        Citizen.Wait(0)
    end
end)

--Spawn le véhicule--

function spawnCar(car)
    local car = GetHashKey(car)
    

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end
    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    local vehicle = CreateVehicle(car, -1033.58, -2729.02, 20.1, 241.51, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    SetVehicleNumberPlateText(vehicle, "LOCATION") 
    SetPedIntoVehicle(GetPlayerPed(-1),vehicle,-1)
        local time = 3600 -- 1 heure
        while (time ~= 0) do
        Wait( 1000 ) -- Wait a second
        time = time - 1
        -- 1 Second should have past by now
        if time == 600 then
            ESX.ShowNotification("~r~ Vous rendez la voiture de location dans 10 minutes !")
        end
        end
    DeleteVehicle(vehicle)
end

--Ped + Blips--

    DecorRegister("Yay", 4)
    pedHash = "s_m_m_security_01"
    zone = vector3(-1034.49, -2732.1, 19.17)
    Heading = 145.64
    Ped = nil
    HeadingSpawn = 145.64

Citizen.CreateThread(function()

    LoadModel(pedHash)
    Ped = CreatePed(2, GetHashKey(pedHash), zone, Heading, 0, 0)
    DecorSetInt(Ped, "Yay", 5431)
    FreezeEntityPosition(Ped, 1)
    TaskStartScenarioInPlace(Ped, "WORLD_HUMAN_CLIPBOARD", 0, false)
    SetEntityInvincible(Ped, true)
    SetBlockingOfNonTemporaryEvents(Ped, 1)

    local blip = AddBlipForCoord(zone)
    SetBlipSprite(blip, 464)
    SetBlipScale(blip, 0.7)
    SetBlipShrink(blip, true)
    SetBlipColour(blip, 11)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Location")
    EndTextCommandSetBlipName(blip)
    end)

function LoadModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Wait(1)
    end
end