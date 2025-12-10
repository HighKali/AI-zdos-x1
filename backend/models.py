import json, os
STATE_FILE = "backend/state.json"

def load_state():
    if not os.path.exists(STATE_FILE): return []
    with open(STATE_FILE) as f: return json.load(f)

def save_state(items):
    with open(STATE_FILE, "w") as f: json.dump(items, f, indent=2)
