import socket
import time
from argparse import ArgumentParser

def init_argparse() -> ArgumentParser:
    parser = ArgumentParser()
    parser.add_argument("--host")
    parser.add_argument("-p", "--port")
    return parser

def log(*x):
    print('\033[92m', x, '\033[0m')


def main() -> None:
    log('talker starting')
    HOST = '192.168.2.99'
    PORT = 4004
    parser = init_argparse()
    args = parser.parse_args()
    if args.host:
        HOST = args.host
    if args.port:
        PORT = int(args.port)
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

if __name__ == "__main__":
    main()
