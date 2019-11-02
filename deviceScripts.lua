commandArray = {}
time = os.date("*t")
weekday = os.date("%A")
timestamp = os.date("%A %d %b, %X")

function sendEmail( title, body )
    return title..'#'..body..'#'..uservariables['email']
end

-- loop through all the changed devices
for deviceName,deviceValue in pairs(devicechanged) do
    -- Porte d'entrée
    if (deviceName == "Porte d'entrée"
        and deviceValue == 'On'
        and weekday ~= 'Saturday'
        and weekday ~= 'Sunday'
        and time.hour >= 9
        and time.hour < 18) then
        -- send mail
        commandArray['SendEmail'] = sendEmail(
            "[Dz] Ouverture porte d'entrée",
            timestamp)
    end
    -- Porte d'entrée [MODE VACANCES]
    if (deviceName == "Porte d'entrée"
        and deviceValue == 'On'
        and uservariables['modeHolidays'] == 'On') then
        -- send mail
        commandArray['SendEmail'] = sendEmail(
            "[Dz] Ouverture porte d'entrée",
            timestamp.." - Mode Vacances")
    end
    -- Mode Vacances
    if (deviceName == "Mode vacances (D)") then
        -- set user var
        uservariables['modeHolidays'] = deviceValue
        -- send mail
        commandArray['SendEmail'] = sendEmail(
            "[Dz] Mode Vacances "..deviceValue,
            timestamp)
    end
    -- Update night temperature
    if (deviceName == "Chambre Bedroom_Temperature"
        and timeofday['Nighttime']) then
        if (deviceValue < tonumber(uservariables['minNightlyTemp'])) then
            commandArray['Variable:minNightlyTemp'] = tostring(deviceValue)
        end
        if (deviceValue > tonumber(uservariables['maxNightlyTemp'])) then
            commandArray['Variable:maxNightlyTemp'] = tostring(deviceValue)
        end
    end
end

return commandArray
