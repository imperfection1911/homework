#!/usr/bin/python3
import os
import time
import sys
from subprocess import CalledProcessError, check_call, DEVNULL,STDOUT

# Скрипт для загрузки процессора с разным nice. Выводит время работы

class Nicetime:

    def __init__(self):
        self.parent_nice = -19
        self.child_nice = 10
        self.block = 1024
        self.count = 10
        pid = self.fork()
        if self.check_child(pid):
            nice = self.child_nice
        else:
            nice = self.parent_nice
        print("time - {0} nice - {1}".format(self.load_cpu(nice), nice))

    def fork(self):
        pid = os.fork()
        return pid

    def check_child(self, pid):
        if pid == 0:
            return True
        return False

    def load_cpu(self, nice):
        start_time = time.time()
        cmd = 'nice -n {0} dd if=/dev/zero of=/dev/null bs={1}M count={2}'.format(nice, self.block, self.count)
        try:
            check_call(cmd, shell=True, stdout=DEVNULL, stderr=DEVNULL)
        except CalledProcessError as e:
            print(e)
            sys.exit(1)
        finish_time = start_time - time.time()
        return finish_time

nicetime = Nicetime()