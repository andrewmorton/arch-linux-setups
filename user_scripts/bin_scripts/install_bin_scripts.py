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
    #os.symlink(path, link_path)
    print(f"linked {path} to {link_path}.")


def install_bin_scripts(bin_scripts_dir, target=f"{os.environ['HOME']}/bin"):
    """
    Installs bin scripts to User HOME by default

    Sets assuming Unix environment but updates in Windows
    """
    
    if platform.system() == "Windows":
        target=f"{os.environ['HOMEPATH']}/bin"

    print(remove_filetypes(bin_scripts_dir, sys.argv[0]))

    

install_bin_scripts(".")

