from subprocess import Popen, PIPE
process = Popen(['bash', 'weather.sh'], stdout=PIPE, stderr=PIPE)
stdout, stderr = process.communicate()
emojies = {
'🌫': '󰖝',
'☀': '󰖙',
'⛅': '󰖕',
'☁': '󰖐',
'🌦': '󰼳',
'🌧': '󰖖'
}

weather = stdout.decode('UTF-8')
result = str(weather)
for emoji in emojies:
    result = result.replace(emoji, emojies[emoji])
    #result = result.replace(emoji, "").replace(' ', '')


if len(result) > 15:
   print('Err.')
else:
   print(result)
