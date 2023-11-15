import socket

HOST = '192.168.3.20'
PORT = 4004

def log(*x):
    print('\033[94m', 'server:', x, '\033[0m')

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
            log('received data {0}: {1}'.format(i,data))

log('exiting')
