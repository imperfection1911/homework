#!/usr/bin/python3
# скрипт эмулирует работу утилиты ps c ключами ax
import os
import sys
import platform
import re


class Proc:

    def __init__(self):
        try:
            # проверка ос
            self.check_linux()
            # получение директорий процессов
            process_dirs = self.list_proc()
            # сортировка
            sorted = self.sort_processes(process_dirs)
            self.output = []
            for process in sorted:
                display = []
                process_status = self.read_status_file(process)
                display.append(process_status['Pid'])
                tty = self.get_tty(process)
                display.append(tty)
                display.append(process_status['State'])
                time = self.get_time(process)
                display.append(str(time))
                cmd = self.get_cmd_line(process)
                if not cmd:
                    display.append(process_status['Name'])
                else:
                    display.append(cmd)
                self.output.append(display)
        except ValueError as e:
            print(e)
            sys.exit(1)


# проверка ос
    def check_linux(self):
        if not platform.system() == 'Linux':
            raise ValueError('this os is not Linux. I\'m very dissapointed')

# листинг директории proc
    def list_proc(self):
        if os.path.exists('/proc'):
            proc_contents = os.listdir('/proc')
            # фильтр процессов в proc
            process_dirs = []
            for dir in proc_contents:
                if os.path.isdir('/proc/' + dir):
                    if re.match(r'\d+', dir):
                        process_dirs.append(dir)
            return process_dirs
        else:
            raise ValueError('no proc! How can it be possible?!')

# просто пузырь. Не знаю зачем
    def sort_processes(self, process_dirs):
        n = 1
        while n < len(process_dirs):
            for i in range(0, len(process_dirs) - n):
                if int(process_dirs[i]) > int(process_dirs[i+1]):
                    process_dirs[i], process_dirs[i+1] = int(process_dirs[i+1]), int(process_dirs[i])
            n += 1
        return process_dirs

# чтение status файла
    def read_status_file(self, dir):
        process_status = {}
        with open('/proc/' + dir + '/status', 'r') as status_file:
            for line in status_file:
                splitted = line.split(':')
                process_status[splitted[0].strip()] = splitted[1].strip()
        return process_status

# получение tty
    def get_tty(self, dir):
        if os.path.exists('/proc/' + dir + '/fd/0'):
            tty = os.readlink('/proc/' + dir + '/fd/0')
            if re.search(r'(pts)|(tty)', tty):
                return tty
        return '?'

# получение cmd
    def get_cmd_line(self, dir):
        with open('/proc/' + dir + '/cmdline') as cmd_file:
            cmd = cmd_file.read().strip()
            if not cmd:
                return False
        return cmd

# получение Time
    def get_time(self, dir):
        with open('/proc/' + dir + '/stat') as stat_file:
            time = 0
            stat = stat_file.read().strip()
            splited = stat.split(' ')
            for i in 13, 14:
                time += int(splited[i])
            return time // 100


class Display:

    def __init__(self):
        self.proc = Proc()
        display = self.proc.output
        max_len = [0, 0, 0, 0, 0]
        for process in display:
            for i in range(0, len(process)):
                if len(process[i]) > max_len[i]:
                    max_len[i] = len(process[i])
        print(self.header(max_len))
        for process in display:
            row = ""
            for i in range(0, len(process)):
                subrow = process[i]
                while len(subrow) < max_len[i]:
                    subrow += " "
                subrow += "   "
                row += subrow
            print(row)


# генерация заголовка
    def header(self, max_len):
        ident = "   "
        headers = ["PID", "TTY", "STAT", "TIME", "COMMAND"]
        for i in range(0, len(headers)):
            while len(headers[i]) < max_len[i]:
                headers[i] += " "
        return ident.join(headers)


# погнали
display = Display()
