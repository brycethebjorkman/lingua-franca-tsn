import socket
import time

HOST = '192.168.4.20'
PORT = 4002

def log(*x):
    print('\033[94m', 'federate_p_serve_c:', x, '\033[0m')

log('listening for packets on {0}:{1}'.format(HOST, PORT))

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.bind((HOST, PORT))
    s.listen()
    conn, addr = s.accept()
    i = 0
    with conn:
        log('accepted connection from {0}'.format(addr))
        while True:
            i = i + 1
            data = conn.recv(1024)
            if not data:
                break
            log('received packet from {0} with data {1}: {2}'.format(addr, i, data))

log('exiting')
