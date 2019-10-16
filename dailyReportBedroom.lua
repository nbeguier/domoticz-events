commandArray = {}
time = os.date("*t")

function tointeger( x )
    num = tonumber( x )
    return num < 0 and math.ceil( num ) or math.floor( num )
end

function sendEmail( title, body )
    return title..'#'..body..'#'..uservariables['email']
end

if time.hour == 8 and time.min == 0 then
    print ('dailyReport');
    -- send mail
    commandArray['SendEmail'] = sendEmail(
        "[Dz] Bedroom 1 "..
        tointeger(uservariables['minTempNight'])..
        "°C à "..
        tointeger(uservariables['maxTempNight'])..
        "°C", "dailyReport")
end

-- Reinit night temperature at 12:00
if time.hour == 12 and time.min == 0 then
    commandArray['Variable:minTempNight'] = '100'
    commandArray['Variable:maxTempNight'] = '0'
end

return commandArray
