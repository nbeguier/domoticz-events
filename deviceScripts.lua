commandArray = {}
time = os.date("*t")
weekday = os.date("%A")

function tointeger( x )
    num = tonumber( x )
    return num < 0 and math.ceil( num ) or math.floor( num )
end

function sendEmail( title, body )
    return title..'#'..body..'#'..uservariables['email']
end

-- loop through all the changed devices
for deviceName,deviceValue in pairs(devicechanged) do
    -- Front door
    if (deviceName == "Front door"
        and deviceValue == 'On'
        and weekday ~= 'Saturday'
        and weekday ~= 'Sunday'
        and time.hour >= 9
        and time.hour < 18) then
        -- send mail
        commandArray['SendEmail'] = sendEmail(
            "[Dz] Front door open",
            "auto reporting")
    end
    -- Front door [Holidays mode]
    if (deviceName == "Front door"
        and deviceValue == 'On'
        and uservariables['modeHolidays'] == 'On') then
        -- send mail
        commandArray['SendEmail'] = sendEmail(
            "[Dz] Front door open",
            "auto reporting - Holidays mode")
    end
    -- Holidays mode
    if (deviceName == "Holidays mode (D)") then
        -- set user var
        uservariables['modeHolidays'] = deviceValue
        -- send mail
        commandArray['SendEmail'] = sendEmail(
            "[Dz] Holidays mode "..deviceValue,
            "auto reporting")
    end
    -- Update night temperature
    if (deviceName == "Bedroom 1_Temperature"
        and timeofday['Nighttime']) then
        if (deviceValue < tonumber(uservariables['minTempNight'])) then
            commandArray['Variable:minTempNight'] = tostring(deviceValue)
        end
        if (deviceValue > tonumber(uservariables['maxTempNight'])) then
            commandArray['Variable:maxTempNight'] = tostring(deviceValue)
        end
    end
end

return commandArray
