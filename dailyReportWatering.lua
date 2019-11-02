commandArray = {}
time = os.date("*t")

function sendEmail( title, body )
    return title..'#'..body..'#'..uservariables['email']
end

if (time.hour == 8 and time.min == 0) then
    for deviceName,deviceValue in pairs(otherdevices) do
        -- Anthurium_Humidity
        if (deviceName == 'Anthurium') then
            AnthuriumTemperature = tonumber(deviceValue:match("[^,]+;([^,]+);"))
            if (AnthuriumTemperature < 75) then
                -- send mail
                commandArray['SendEmail'] = sendEmail(
                    "[Dz] Anthurium "..AnthuriumTemperature.."%",
                    "Bonjour, Il faudrait arroser l'Anthurium car son taux "
                    .."d'humidité est inférieur à 75%.\n"
                    .."https://jardinage.ooreka.fr/plante/voir/89/anthurium")
            end
        end
    end
end

return commandArray
