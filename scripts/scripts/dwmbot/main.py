from subprocess import Popen, PIPE
from telebot import TeleBot
from config import *
import time

bot = TeleBot(token)

vezono = admin


bot.send_message(vezono, 'dwm bot restarted!')

@bot.message_handler(commands=['id'])
def k(m):
    bot.reply_to(m, f'{m.from_user.id}')

@bot.message_handler(commands=['view'])
def k(m):
    if not m.text.count(' '):
        return
    tag = m.text.split(' ')[1]
    process = Popen(['dwm-msg', 'run_command', 'view', tag], stdout=PIPE, stderr=PIPE)
    stdout, stderr = process.communicate()
    bot.reply_to(m, stdout)

@bot.message_handler(commands=['sudo'])
def k(m):
    if not m.text.count(' '):
        return
    line = m.text.split(' ', 1)[1]
    process = Popen(line.split(), stdout=PIPE, stderr=PIPE)
    stdout, stderr = process.communicate()
    bot.reply_to(m, stdout) if stdout else None
    bot.reply_to(m, stderr) if stderr else None

@bot.message_handler(commands=['lock'])
def k(m):
    process = Popen("slock".split(), stdout=PIPE, stderr=PIPE)
    stdout, stderr = process.communicate()
    bot.reply_to(m, 'locked')
    bot.reply_to(m, stdout)
    bot.reply_to(m, stderr)

@bot.message_handler(commands=['unlock'])
def k(m):
    process = Popen("sudo killall -q slock".split(), stdout=PIPE, stderr=PIPE)
    stdout, stderr = process.communicate()
    bot.reply_to(m, 'unlocked')
    bot.reply_to(m, stdout)
    bot.reply_to(m, stderr)

@bot.message_handler(commands=['power'])
def k(m):
    bat_path = '/sys/class/power_supply/BAT1'

    process = Popen(['cat', f'{bat_path}/status'], stdout=PIPE, stderr=PIPE)
    status, stderr = process.communicate()

    process = Popen(['cat', f'{bat_path}/capacity'], stdout=PIPE, stderr=PIPE)
    energy, stderr = process.communicate()

    bot.reply_to(m, f'Status: {status}\nEnergy: {energy}')

@bot.message_handler(commands=['quit'])
def k(m):
    process = Popen(['dwm-msg', 'run_command', 'quit'], stdout=PIPE, stderr=PIPE)
    stdout, stderr = process.communicate()
    bot.reply_to(m, stdout)

@bot.message_handler(commands=['neofetch'])
def k(m):
    process = Popen('pfetch'.split(), stdout=PIPE, stderr=PIPE)
    stdout, stderr = process.communicate()
    bot.reply_to(m, stdout)

@bot.message_handler(commands=['screen'])
def k(m):
    process = Popen(['maim', '-u', 'screenshot.png'])
    photo = open('screenshot.png', 'rb')
    bot.send_photo(vezono, photo.read())
    photo.close()

@bot.message_handler(commands=['video'])
def k(m):
    process = Popen('ffmpeg -i /dev/video0 -c:v libx264 -pix_fmt yuv420p -t 00:00:02 out.mp4'.split())
    time.sleep(3)
    video = open('out.mp4', 'rb')
    bot.send_video(vezono, video.read())
    video.close()

@bot.message_handler(commands=['monitors'])
def k(m):
    process = Popen(['dwm-msg', 'get_monitors'], stdout=PIPE, stderr=PIPE)
    stdout, stderr = process.communicate()
    bot.reply_to(m, stdout)

bot.polling() 
