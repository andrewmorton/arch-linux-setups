#!/usr/bin/env python

# Find all scripts within the user bin
# Link everything here to $HOME/bin if it doesn't already exist

import os
import copy
import platform
import sys

def create_filelist (path):
    results = os.listdir(path)
    return results


def remove_filetypes(root_path, install_script_name):
    working_set = create_filelist(copy.deepcopy(root_path))
    target = []
    print(install_script_name.strip("./"))  
    for item in working_set:
        if install_script_name.strip("./") in item:
            continue
        else:
            target.append((os.path.abspath(item), item))

    return target


def symlink_file(path, link_path):
    if os.path.isfile(link_path):
        print(f"{link_path} found in dst")
        print("Forcing creation")
        os.remove(link_path)
    os.symlink(path, link_path)
    print(f"linked {path} to {link_path}.")


def create_dir_if_missing(target_dir):
    """
    Tests if a given directory exists and creates if missing
    """

    if os.path.isdir(target_dir):
        print(f"{target_dir} is found on this machine.")
        print("Skipping creation.")
        return False
    else:
        print(f"{target_dir} not found on this machine.")
        print(f"Creating {target_dir}")
        os.mkdir(target_dir)
        return True


def install_bin_scripts(bin_scripts_dir, target=f"{os.environ['HOME']}/bin"):
    """
    Installs bin scripts to User HOME by default

    Sets assuming Unix environment but updates in Windows
    """
    
    working_path_set = copy.deepcopy(
            remove_filetypes(bin_scripts_dir, sys.argv[0]))

    create_dir_if_missing(target)

    for path in working_path_set:
        symlink_file(path[0], f"{target}/{path[1]}")


install_bin_scripts(".")
