import time
import socket

def connect_time():
  try:
    host = socket.gethostbyname('vezono.duckdns.org')
    # connect to the host -- tells us if the host is actually
    # reachable
    before = time.perf_counter()
    for i in range(4):
      s = socket.create_connection((host, 80), 2)
    after = time.perf_counter()
    return f'{int((after - before)*100)} ms'
  except Exception as e:
    return '-1 ms'
print(connect_time())
