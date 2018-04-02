#!/usr/bin/env python3
import shlex
import subprocess

def run(command):
	return subprocess.run(command, check=True, stdout=subprocess.PIPE).stdout.decode("utf-8").rstrip()

def echo(command):
	print(" ".join(map(shlex.quote, command)))
