#!/data/data/com.termux/files/usr/bin/bash

echo "🔍 Avvio analisi Berzerk su tutti i repo..."

# 1. Analizza ogni repo
for dir in repos/*; do
  [ -d "$dir" ] || continue
  echo "📁 Analizzando $dir..."

  # 2. Rimuove file doppi
  fdupes -rdN "$dir"

  # 3. Rimuove file corrotti (zero byte o non leggibili)
  find "$dir" -type f -size 0 -delete
  find "$dir" -type f ! -readable -delete

  # 4. Rimuove cache e log temporanei
  rm -rf "$dir/__pycache__" "$dir/.cache" "$dir/.pytest_cache" "$dir/logs" "$dir/tmp"

  # 5. Esegue fix automatici se presenti
  if [ -f "$dir/fix.sh" ]; then
    echo "🛠️ Eseguendo fix.sh in $dir..."
    bash "$dir/fix.sh"
  fi
done

# 6. Pulizia globale
rm -rf agent-worker.log agent/queue.json .cache .pytest_cache

echo "✅ Berzerk ha completato la rigenerazione dei repo."
