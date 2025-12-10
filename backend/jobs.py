import os, json, datetime, shutil

STATE_FILE = "backend/state.json"

def _now():
    return datetime.datetime.utcnow().isoformat() + "Z"

def ingest_local(repos_dir):
    os.makedirs(repos_dir, exist_ok=True)
    if not any(os.scandir(repos_dir)):
      demo = os.path.join(repos_dir, "demo-repo")
      os.makedirs(demo, exist_ok=True)
      with open(os.path.join(demo, "package.json"), "w") as f:
        f.write('{"name":"demo-repo","version":"0.1.0","scripts":{"lint":"echo lint","test":"echo test","sbom:generate":"echo sbom"}}')

def normalize_repo(repo_path, templates_dir="templates"):
    name = os.path.basename(repo_path)
    os.makedirs(os.path.join(repo_path, ".github", "workflows"), exist_ok=True)
    tpl = lambda x: os.path.join(templates_dir, x)
    out = lambda x: os.path.join(repo_path, x)

    shutil.copyfile(tpl("ci.yml"), out(".github/workflows/ci.yml"))
    for src, dst in [("README.md.tpl","README.md"),
                     ("SECURITY.md.tpl","SECURITY.md"),
                     ("CODEOWNERS.tpl","CODEOWNERS"),
                     ("LICENSE.tpl","LICENSE")]:
        if not os.path.exists(out(dst)): shutil.copyfile(tpl(src), out(dst))
    return {"name": name, "path": repo_path, "status": "normalized", "last_run": _now()}

def normalize_all(repos_dir):
    results = []
    for entry in os.scandir(repos_dir):
        if entry.is_dir(): results.append(normalize_repo(entry.path))
    with open(STATE_FILE, "w") as f: json.dump(results, f, indent=2)

def generate_reports(repos_dir, reports_dir):
    os.makedirs(reports_dir, exist_ok=True)
    for entry in os.scandir(repos_dir):
        if entry.is_dir():
            name = entry.name
            html = f"""<html><head><title>{name} report</title></head>
            <body><h1>{name}</h1><p>Status: normalized</p><p>Generated: {_now()}</p></body></html>"""
            with open(os.path.join(reports_dir, f"{name}.html"), "w") as f: f.write(html)
