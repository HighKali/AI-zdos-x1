import os, json, subprocess, datetime, time
def _now(): return datetime.datetime.utcnow().isoformat() + "Z"
def list_repos(root="repos"): return [d.path for d in os.scandir(root) if d.is_dir()]
def apply_templates(repo): subprocess.run(["bash","scripts/apply_templates.sh", repo], check=False)
def fix_dependencies(repo): subprocess.run(["bash","scripts/fix_dependencies.sh", repo], check=False)
def write_report(repo):
    name = os.path.basename(repo); os.makedirs("reports", exist_ok=True)
    with open(f"reports/{name}.html","w") as f: f.write(f"<html><body><h1>{name}</h1><p>Fixed: {_now()}</p></body></html>")
def process_all():
    repos = list_repos()
    for r in repos:
        print(f"[*] Berzerk fixing {os.path.basename(r)}")
        apply_templates(r); fix_dependencies(r); write_report(r)
if __name__ == "__main__":
    print("[Berzerk] Worker avviato")
    while True:
        if os.path.exists("agent/queue.json"):
            process_all(); os.remove("agent/queue.json")
        time.sleep(3)
