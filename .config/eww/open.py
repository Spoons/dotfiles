#!/usr/bin/env python3

import signal
import socket
import subprocess
import os
from threading import Event
from pathlib import Path

global reset
reset = Event()

def daemon():
    while True:
        reset.wait()
        reset.clear()
        subprocess.check_output("eww open volume", shell=True)
        reset.wait(1)
        if not reset.is_set():
            subprocess.check_output("eww close volume", shell=True)
        else:
            continue

def reset_timer(signo, _frame):
    reset.set()

def send_signal(pid):
    subprocess.check_output("kill -s USR1 {}".format(pid), shell=True)


def get_lock(process_name):
    get_lock._lock_socket = socket.socket(socket.AF_UNIX, socket.SOCK_DGRAM)
    try:
        get_lock._lock_socket.bind('\0' + process_name)
        with Path("/tmp/open.pid").open('w') as f:
            f.write(str(os.getpid()))
        return True
    except socket.error:
        return False

def get_daemon_pid():
    with Path("/tmp/open.pid").open('r') as f:
        return int(f.read().strip())


if __name__ == '__main__':
    if get_lock('open.py'):
        signal.signal(signal.SIGUSR1, reset_timer)
        daemon()
    else:
        pid = get_daemon_pid()
        send_signal(pid)
