import socket
import shutil


def main():
    print("Equipo:", socket.gethostname())
    total, used, free = shutil.disk_usage("/")
    print("Disco usado:", used / total * 100, "%")
    with open("/proc/meminfo") as f:
        for line in f:
            if line.startswith("MemFree"):
                kb = int(line.split()[1])
                print("Memoria libre:", kb / 1024 / 1024, "GB")


main()

