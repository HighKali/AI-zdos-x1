const API = "http://127.0.0.1:8000";
const statusEl = document.getElementById("status");
const tbody = document.querySelector("#repos tbody");
const reportsEl = document.getElementById("reports");
async function fetchRepos() {
  const r = await fetch(`${API}/repos`);
  const data = await r.json();
  tbody.innerHTML = data.map(d => `<tr><td>${d.name}</td><td>${d.status}</td><td>${d.last_run}</td></tr>`).join("");
  reportsEl.innerHTML = data.map(d => `<div><a href="../reports/${d.name}.html" target="_blank">${d.name} report</a></div>`).join("");
}
document.getElementById("ingest").onclick = async () => {
  statusEl.textContent = "Ingest in corso...";
  await fetch(`${API}/ingest`, { method: "POST" });
  statusEl.textContent = "Ingest completato";
  fetchRepos();
};
document.getElementById("normalize").onclick = async () => {
  statusEl.textContent = "Normalize in corso...";
  await fetch(`${API}/normalize`, { method: "POST" });
  statusEl.textContent = "Normalize completato";
  fetchRepos();
};
fetchRepos().catch(()=>{});
