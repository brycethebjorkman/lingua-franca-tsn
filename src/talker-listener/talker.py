import socket
import time

HOST = '192.168.2.99'
PORT = 4004

def log(*x):
    print('\033[92m', x, '\033[0m')

log('talker starting')

with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as s:
    log('talker attempting to send packets to {0}:{1}'.format(HOST, PORT))
    i = 0
    while True:
        i = i + 1
        log('talker sending data {0}'.format(i), (HOST, PORT))
        bytecount = s.sendto('Data {0}'.format(i).encode(), (HOST, PORT))
        log('talker sent {0} bytes'.format(bytecount))
        time.sleep(1)

log('talker exiting')
