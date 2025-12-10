import os, time, json
from dotenv import load_dotenv
load_dotenv()
INTERVAL = int(os.getenv("AGENT_INTERVAL_SECONDS", "60"))
def loop():
    while True:
        job = {"type": "scan_and_fix", "timestamp": time.time()}
        with open("agent/queue.json", "w") as f: json.dump(job, f)
        time.sleep(INTERVAL)
if __name__ == "__main__":
    print("[Berzerk] Scheduler avviato"); loop()
