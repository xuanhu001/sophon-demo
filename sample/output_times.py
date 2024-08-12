import os
import subprocess
from rich.table import Table
from rich.console import Console

def run_tests(exclude=[], include=[]):
    # 创建一个表格
    table = Table(show_header=True, header_style="bold magenta")
    table.add_column("Folder Name")
    table.add_column("BModel File")
    table.add_column("Load Input Time(s)")
    table.add_column("Calculate Time(s)")
    table.add_column("Get Output Time(s)")
    table.add_column("Compare Time(s)")

    # 遍历指定目录
    for root, dirs, files in os.walk("/mnt/sophonWP/sophon-demo/sample"):
        # 检查路径是否满足条件
        if any(x in root for x in exclude) or not any(x in root for x in include):
            continue

        for file in files:
            if file.endswith(".bmodel"):
                # 执行测试命令并获取输出
                output = subprocess.check_output(["bmrt_test", "--bmodel", os.path.join(root, file)])
                print("RUNNING: bmrt_test --bmodel", os.path.join(root, file))
                output = output.decode("utf-8").split("\n")

                # 提取需要的信息
                load_input_time = output[-5].split(":")[-1].strip()
                calculate_time = output[-4].split(":")[-1].strip()
                get_output_time = output[-3].split(":")[-1].strip()
                compare_time = output[-2].split(":")[-1].strip()

                # 将信息添加到表格中
                # table.add_row(os.path.basename(root), file, load_input_time, calculate_time, get_output_time, compare_time)
                table.add_row(root.split("/sample/")[1].split(os.sep)[0], file, load_input_time, calculate_time, get_output_time, compare_time)

    # 显示表格
    console = Console()
    console.print(table)

# 调用函数
run_tests(exclude=["BM1684X", "CV186X", "BM1688"], include=["BM1684"])