#!/usr/bin/env python3

import signal
import socket
import subprocess
import os
import sys
from threading import Event
from pathlib import Path


global value
global event
event = Event()


def daemon():
    signal.signal(signal.SIGUSR1, event_timer)
    while True:
        event.wait()
        event.clear()
        subprocess.check_output("eww open {}".format(value), shell=True)
        event.wait(1)
        if not event.is_set():
            subprocess.check_output("eww close {}".format(value), shell=True)
        else:
            continue

def event_timer(signo, _frame):
    event.set()

def send_signal(pid):
    subprocess.check_output("kill -s USR1 {}".format(pid), shell=True)

def get_lock(process_name):
    get_lock._lock_socket = socket.socket(socket.AF_UNIX, socket.SOCK_DGRAM)
    try:
        get_lock._lock_socket.bind('\0' + process_name)
        with Path("/tmp/open+{}.pid".format(value)).open('w') as f:
            f.write(str(os.getpid()))
        return True
    except socket.error:
        return False

def get_daemon_pid():
    with Path("/tmp/open+{}.pid".format(value)).open('r') as f:
        return int(f.read().strip())

if __name__ == '__main__':
    value = ""
    try:
        if sys.argv[1] == '-d':
            value = "brightness"
        if sys.argv[1] == '-v':
            value = "volume"
    except IndexError:
        exit(1)
    if get_lock('open.py' + value):
        daemon()
    else:
        pid = get_daemon_pid()
        send_signal(pid)
