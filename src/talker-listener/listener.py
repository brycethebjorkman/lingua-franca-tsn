import socket

HOST = '192.168.3.20'
PORT = 4004

def log(*x):
    print('\033[94m', x, '\033[0m')

log('listener starting')

with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as s:
    s.bind((HOST, PORT))
    log('listener listening for packets on {0}:{1}'.format(HOST, PORT))
    i = 0
    while True:
        i = i + 1
        data, addr = s.recvfrom(1024)
        if not data:
            break
        log('listener received packet {0} from {1} with data {2}'.format(i, addr, data))

log('listener exiting')
