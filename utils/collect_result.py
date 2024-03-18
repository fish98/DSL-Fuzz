import os
import shutil
import json


if __name__ == '__main__':

    # Import config
    config_path = 'config.json'
    try:
        with open(config_path, 'r') as file:
            config = json.load(file)
    except FileNotFoundError:
        print(f"Config.json Not Found")
    project_name = config['project_name']
    root_path = config["root_path"]
    afl_output_dir = config["afl_output_dir"]
    # End of config

    target_path = os.path.join(root_path, f"sorted-{afl_output_dir}")

    # Result Collection
    if not os.path.exists(target_path):
        os.makedirs(target_path)
    else:
        print("Sorted Dir Not Empty. Go and Have a Check.")

    # HANG
    hang_idx = 0

    hang_output_dir = os.path.join(target_path, 'hangs')
    if not os.path.exists(hang_output_dir):
        os.makedirs(hang_output_dir)

    for sub_afl in os.listdir(os.path.join(root_path, afl_output_dir)):
        sub_path = os.path.join(root_path, afl_output_dir, sub_afl)

        for item in os.listdir(sub_path):
            if item == 'hangs':
                hang_path = os.path.join(sub_path, 'hangs')
                # print(hang_path)
                for filename in os.listdir(hang_path):
                    file_path = os.path.join(hang_path, filename)
                    # print(file_path)
                    output_path = os.path.join(hang_output_dir, f'{project_name}-hangs-{hang_idx}')
                    shutil.copy(file_path, output_path)
                    hang_idx += 1

    print("Finish sorting hang result into {}".format(hang_output_dir))

    # # Crash

    # crash_output_dir = "crashes_collect_{}".format(package_name)
    # os.mkdir(os.path.join(root_path, crash_output_dir))


    # for sub_afl in os.listdir(os.path.join(root_path, target_dir)):
    #     sub_path = os.path.join(root_path, target_dir, sub_afl)
        
    #     os.mkdir(os.path.join(root_path, crash_output_dir, sub_afl))

    #     for item in os.listdir(sub_path):
    #         if item == 'crashes':
    #             crash_path = os.path.join(sub_path, 'crashes')
    #             for filename in os.listdir(crash_path):
    #                 file_path = os.path.join(crash_path, filename)
    #                 output_path = os.path.join(root_path, crash_output_dir, sub_afl, filename)
    #                 shutil.copy(file_path, output_path)

    #     print("Finish copy crash result for dir {}".format(sub_afl))

    # # QUEUE
        
    # queue_output_dir = "queue_collect_{}".format(package_name)
    # os.mkdir(os.path.join(root_path, queue_output_dir))


    # for sub_afl in os.listdir(os.path.join(root_path, target_dir)):
    #     sub_path = os.path.join(root_path, target_dir, sub_afl)
        
    #     os.mkdir(os.path.join(root_path, queue_output_dir, sub_afl))

    #     for item in os.listdir(sub_path):
    #         if item == 'queue':
    #             queue_path = os.path.join(sub_path, 'queue')
    #             for filename in os.listdir(queue_path):
    #                 file_path = os.path.join(queue_path, filename)
    #                 output_path = os.path.join(root_path, queue_output_dir, sub_afl, filename)
    #                 try:
    #                     shutil.copy(file_path, output_path)
    #                 except Exception as e:
    #                     print(e)
    #     print("Finish copy queue result for dir {}".format(sub_afl))