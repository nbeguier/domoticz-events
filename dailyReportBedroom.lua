commandArray = {}
time = os.date("*t")
timestamp = os.date("%A %d %b, %X")

function onedecimal( x )
    num = tonumber( x )
    return math.ceil(x*10)*0.1
end

function sendEmail( title, body )
    return title..'#'..body..'#'..uservariables['email']
end

if time.hour == 8 and time.min == 0 then
    -- send mail
    commandArray['SendEmail'] = sendEmail(
        "[Dz] Bedroom "..
        onedecimal(uservariables['minNightlyTemp'])..
        "°C à "..
        onedecimal(uservariables['maxNightlyTemp'])..
        "°C", timestamp)
end

-- Reinit night temperature at 12:00
if time.hour == 12 and time.min == 0 then
    commandArray['Variable:minNightlyTemp'] = '100'
    commandArray['Variable:maxNightlyTemp'] = '0'
end

return commandArray
