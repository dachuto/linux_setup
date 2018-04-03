import getpass
import os
import subprocess
import sys

#TODO: test this in fresh VM (deb based)

def install_package(package_name, password):
	try:
		sudo_process = subprocess.Popen(["sudo", "--stdin", "apt-get", "--assume-yes", "install", package_name], stdin = subprocess.PIPE, stdout = subprocess.PIPE, universal_newlines = True)
		stdout, stderr = sudo_process.communicate(input = (password + "\n"), timeout = 120)
	except TimeoutExpired:
		sudo_process.kill()
		stdout, stderr = proc.communicate()
	return sudo_process.returncode, stdout, stderr

if __name__ == "__main__":
	password = getpass.getpass("sudo password:")

	basic_packages = [
		"cmake",
		"gdb",
		"git",
		"screen",
		"valgrind",
		"vim",
	]
#TODO: FROM STDIN!!!!!!!!!!!!!!!! GI T SETUP AND SCREEN RC AND PROPT!!
	dev_packages = [
		"libglew-dev",
		"libgtest-dev",
		"zlib1g-dev",
	]
	for package_name in basic_packages + dev_packages:
		stream = sys.stdout
		stream.write("Install " + package_name)
		stream.flush()

		returncode, stdout, stderr = install_package(package_name, password)

		stream.write(" .\n")
		if returncode != 0:
			stream.write(stdout)
			stream.write(stderr)
			sys.exit(1)

