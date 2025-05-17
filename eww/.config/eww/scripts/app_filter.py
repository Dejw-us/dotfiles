import subprocess
import json
import sys

def echo(out):
  subprocess.run(["echo", str(out)])

if len(sys.argv) != 2:
  echo("[]")
  exit(0)

filter = sys.argv[1].lower()

result = subprocess.run(
  ["/home/json/.config/eww/scripts/compgen_json.sh"],
  capture_output=True,
  text=True
)

if result.returncode != 0:
  echo("[]")
  exit(0)

apps = json.loads(result.stdout)

filtered_apps = [app for app in apps if filter in app.lower()]

sorted_apps = sorted(
  filtered_apps,
  key=lambda app: (not app.lower().startswith(filter), app)
)

echo(json.dumps(sorted_apps[0:15]))
