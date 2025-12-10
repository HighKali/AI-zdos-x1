import os
from fastapi import FastAPI
from fastapi.responses import JSONResponse
from dotenv import load_dotenv
from models import load_state
from jobs import ingest_local, normalize_all, generate_reports

load_dotenv()
app = FastAPI(title="Berzerk Orchestrator")

@app.get("/health")
def health():
    return {"status": "ok", "agent": "running"}

@app.get("/repos")
def list_repos():
    return JSONResponse(load_state())

@app.post("/ingest")
def ingest():
    ingest_local("repos")
    return {"ingest": "done"}

@app.post("/normalize")
def normalize():
    normalize_all("repos")
    generate_reports("repos", "reports")
    return {"normalize": "done", "reports": "generated"}

if __name__ == "__main__":
    import uvicorn
    port = int(os.getenv("PORT", "8000"))
    uvicorn.run(app, host="127.0.0.1", port=port)
