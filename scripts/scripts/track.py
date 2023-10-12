import os
import subprocess


text = 'GOIDA'

result = subprocess.run(f'export CURRENT_TRACK={text}', shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
print(result)

# Get the value of an environment variable
my_variable_value = os.environ.get('CURRENT_TRACK')

if my_variable_value is not None:
    print(f'The value of CURRENT_TRACK is: {my_variable_value}')
else:
    print('CURRENT_TRACK is not set.')
    os.environ['CURRENT_TRACK'] = 'my_value'
