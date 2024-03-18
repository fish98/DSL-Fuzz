from pathlib import *
import subprocess, time
import shutil
import os
import json
# import argparse

def run_command(command):
    start = time.time()
    process = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True, encoding='latin-1')

    wall_time = time.time() - start
    proc_stdout = process.stdout
    proc_stderr = process.stderr
    result_code = process.returncode
    return proc_stdout + '\n' + proc_stderr, result_code, wall_time

if __name__ == '__main__':

    # parser = argparse.ArgumentParser(description='Postprocess for AFL Results')
    # parser.add_argument('testcase_path', type=str, help='Specify the path to the candidate testcases (e.g., path/to/hang/)')
    # args = parser.parse_args()

    # Import config
    config_path = 'config.json'
    try:
        with open(config_path, 'r') as file:
            config = json.load(file)
    except FileNotFoundError:
        print(f"Config.json Not Found")
    timeout_time = config['timeout']
    project_name = config['project_name']
    analysis_type = config["analysis_type"] # crashes
    afl_output_dir = config["afl_output_dir"]
    root_path = config["root_path"]
    # End of config

    bin_path = f"{root_path}/gawk" # location for bin
    save_path = f"{root_path}/manual_testcases"
    parse_file_path = f"{root_path}/list.log"
    candidate_path = [f"{root_path}/sorted-{afl_output_dir}/{analysis_type}"] # location for testcases
    tools = [f'timeout {timeout_time} {bin_path} -f'] # reproduce command
    
    pathList = []
    # all_result = []

    # Check if save_path exist
    if not os.path.exists(save_path):
        os.makedirs(save_path)
    else:
        print("Saved Dir Not Empty. Go and Have a Check.")

    for p in candidate_path:
        case = Path(p)
        for subP in case.rglob("*"):
            pathList.append(subP)

    print("Start Running")
    idx = 0
    for p in pathList:
        for t in tools:
            cmd = f"{t} {str(p)} {parse_file_path}"
            print(cmd)
            out_lines, result_code, wall_time = run_command(cmd)
            print(result_code) # print code
            shutil.copy(p, f"{save_path}/{result_code}-{project_name}-{idx}")
            idx += 1
            # 139 might be relevant to non-termination loop 