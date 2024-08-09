import os
import re
from rich.table import Table
from rich.text import Text
from rich.console import Console

def parse_section(lines):
    directory_sizes = {}
    for line in lines:
        match = re.match(r"# \[INFO \] Directory: ./(.*), Models folder size: (.*)", line)
        if match:
            directory, size = match.groups()
            directory_sizes[directory] = size
    return directory_sizes

def read_file(file_name):
    with open(file_name) as f:
        lines = f.readlines()
    return lines

def get_directory_sizes(lines, start_marker, end_marker):
    start = lines.index(start_marker) + 1
    end = lines.index(end_marker, start)
    return parse_section(lines[start:end])

def create_table():
    table = Table(show_header=True, header_style="bold magenta")
    table.add_column("Directory")
    table.add_column("Current Size")
    table.add_column("Target Size")
    table.add_column("Needs Transfer")
    return table

def create_bash_script(shell_name, save_flag):
    if save_flag:
        with open(shell_name, "w") as f:
            f.write("#!/bin/bash\n")
            f.write("set -e\n")

def add_command_to_script(shell_name, command, save_flag):
    if save_flag:
        with open(shell_name, "a") as f:
            f.write(command + " || exit 1\n")

def main(username, hostname, remote_path, local_path, save_flag):
    os.chdir(local_path)
    lines = read_file("record_download.txt")
    target_directory_sizes = get_directory_sizes(lines, "# -----[目标]-----\n", "# -----[End]-----\n")
    current_directory_sizes = get_directory_sizes(lines, "# -----[当前]-----\n", "# -----[End]-----\n")

    table = create_table()
    shell_name = "scp_files.sh"
    create_bash_script(shell_name, save_flag)

    for directory, current_size in current_directory_sizes.items():
        target_size = target_directory_sizes.get(directory)
        needs_transfer = target_size != current_size
        if needs_transfer:
            command = f"scp -r {local_path}/{directory} {username}@{hostname}:{remote_path}/{directory}"
            print(command)
            add_command_to_script(shell_name, command, save_flag)
        transfer_text = Text(str(needs_transfer))
        transfer_text.stylize("green" if needs_transfer else "red")
        table.add_row(directory, current_size, str(target_size), transfer_text)
    console = Console()
    console.print(table)
    # print(table)

if __name__ == "__main__":
    username = "linaro" # os.getenv("USER")
    hostname = os.getenv("IP")
    remote_path = "/mnt/sophonWP/sophon-demo/sample"
    local_path = os.getcwd()
    save_flag = False
    main(username, hostname, remote_path, local_path, save_flag)