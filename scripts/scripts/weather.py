from subprocess import Popen, PIPE
process = Popen(['bash', 'weather.sh'], stdout=PIPE, stderr=PIPE)
stdout, stderr = process.communicate()
emojies = {
'🌫': '󰖝',
'☀': '󰖙',
'⛅': '󰖕',
'☁': '󰖐'
}

weather = stdout.decode('UTF-8')
result = str(weather)
for emoji in emojies:
    result = result.replace(emoji, emojies[emoji])
    

if len(result) > 10:
   print('Err.')
else:
   print(result)
