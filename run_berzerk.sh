#!/data/data/com.termux/files/usr/bin/bash

echo "⚡ Avvio Berzerk Fix + Deploy + Dashboard..."

# 1. Rigenerazione repo
bash berzerk_fix.sh

# 2. Commit automatico di modifiche/untracked
git add -A
git commit -m "Sync Berzerk IDE and workflows" || echo "Nessuna modifica da committare"

# 3. Aggiornamento gh-pages
git checkout gh-pages || { echo "Errore checkout gh-pages"; exit 1; }
git add webapp/templates/index.html
git commit -m "Update GitHub Pages with Berzerk IDE dashboard" || echo "Nessuna modifica alla dashboard"
git push origin gh-pages
git checkout main

# 4. Avvio Flask IDE dalla cartella corretta
cd ~/berzerk/webapp
python app.py
