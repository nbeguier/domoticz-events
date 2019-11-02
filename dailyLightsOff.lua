commandArray = {}
time = os.date("*t")

function sendEmail( title, body )
    return title..'#'..body..'#'..uservariables['email']
end

if (time.hour == 8 and time.min == 0) then
    for deviceName,deviceValue in pairs(otherdevices) do
        if (deviceName == 'Lumière salon' and 
            uservariables['reportLightOff'] == 'On') then
            -- send mail
            commandArray['SendEmail'] = sendEmail(
                "[Dz] Lumière Salon",
                "La lumière a été éteinte à minuit.")
        end
    end
end

-- Lights off at midnight
if (time.hour == 0 and time.min == 0) then
    print ('Lights off at midnight');
    for deviceName,deviceValue in pairs(otherdevices) do
        if (deviceName == 'Lumière salon') then
            commandArray['Variable:reportLightOff'] = deviceValue
            commandArray['Lumière salon'] = 'Off'
        end
    end
end

return commandArray
