commandArray = {}
time = os.date("*t")

function sendEmail( title, body )
    return title..'#'..body..'#'..uservariables['email']
end

if (time.hour == 8 and time.min == 0) then
    print ('dailyReport');
    -- loop through all the devices
    for deviceName,deviceValue in pairs(otherdevices) do
        -- Anthurium_Humidity
        if (deviceName == 'Anthurium') then
            AnthuriumTemperature = tonumber(deviceValue:match("[^,]+;([^,]+);"))
            if (AnthuriumTemperature < 75) then
                -- send mail
                commandArray['SendEmail'] = sendEmail(
                    "[Dz] Anthurium "..AnthuriumTemperature.."%",
                    "Hello, you should watering your Anthurium.\n"
                    .."https://jardinage.ooreka.fr/plante/voir/89/anthurium")
            end
        end
    end
end

return commandArray
