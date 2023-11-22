import socket
import time

HOST = '192.168.3.99'
SELF = '192.168.3.20'
PORT = 4001

def log(*x):
    print('\033[92m', 'federate_c_client_rti:', x, '\033[0m')

log('attempting to connect to {0}:{1}'.format(HOST, PORT))

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.bind((SELF, PORT))
    s.connect((HOST, PORT))
    i = 0
    while True:
        i = i + 1
        log('sending data {0}'.format(i))
        s.sendall('Data {0}'.format(i).encode())
        time.sleep(1)

log('exiting')
