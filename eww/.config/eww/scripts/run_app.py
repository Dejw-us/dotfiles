import sys
import subprocess
import json

def parse_apps(arg: str):
  apps = arg.removeprefix("[").removesuffix("]").replace(" ", "")
  return apps.split(",")

apps = parse_apps(sys.argv[1])

subprocess.run([apps[0]])