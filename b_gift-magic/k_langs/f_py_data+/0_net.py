import platform
import os
import shutil
import socket

def hardware_info():
    print("=== Hardware Information ===")
    print(f"System: {platform.system()}")
    print(f"Node Name: {platform.node()}")
    print(f"Release: {platform.release()}")
    print(f"Version: {platform.version()}")
    print(f"Machine: {platform.machine()}")
    print(f"Processor: {platform.processor()}")

    # CPU count
    try:
        print(f"CPU Cores: {os.cpu_count()}")
    except:
        print("CPU Cores: Unknown")

    # RAM (if available via os.sysconf on Unix)
    if hasattr(os, "sysconf"):
        if "SC_PAGE_SIZE" in os.sysconf_names and "SC_PHYS_PAGES" in os.sysconf_names:
            pagesize = os.sysconf("SC_PAGE_SIZE")
            num_pages = os.sysconf("SC_PHYS_PAGES")
            ram_bytes = pagesize * num_pages
            print(f"Total RAM: {ram_bytes / (1024**3):.2f} GB")

    # Disk storage
    total, used, free = shutil.disk_usage("/")
    print(f"Total Storage: {total / (1024**3):.2f} GB")

    # Basic network info (hostname and IP)
    hostname = socket.gethostname()
    ip_address = socket.gethostbyname(hostname)
    print(f"Hostname: {hostname}")
    print(f"IP Address: {ip_address}")

if __name__ == "__main__":
    hardware_info()
