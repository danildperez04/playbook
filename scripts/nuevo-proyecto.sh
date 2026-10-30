#!/usr/bin/env bash
# Crea un repositorio nuevo a partir de plantilla/.
# Uso: scripts/nuevo-proyecto.sh <destino> "<Nombre visible>" <slug-repo> "<Autor>" [usuario-github]
set -euo pipefail
destino="${1:?Uso: nuevo-proyecto.sh <destino> <nombre> <slug> <autor> [usuario-github]}"
nombre="${2:?Falta el nombre visible}"
slug="${3:?Falta el slug del repositorio}"
autor="${4:?Falta el autor}"
usuario="${5:-danildperez04}"
raiz="$(cd "$(dirname "$0")/.." && pwd)"

if [[ ! "$slug" =~ ^[a-z0-9]+(-[a-z0-9]+)*$ ]]; then
  echo "El slug debe ir en kebab-case: $slug" >&2
  exit 2
fi
if [[ -e "$destino" && -n "$(ls -A "$destino")" ]]; then
  echo "El destino no está vacío: $destino" >&2
  exit 2
fi

# Escapa \ / & | para usarlos como reemplazo en sed.
esc() { printf '%s' "$1" | sed -e 's/[\/&|]/\\&/g'; }

mkdir -p "$destino"
cp -a "$raiz/plantilla/." "$destino/"
fecha="$(date +%F)"
grep -rlZ -E '\{\{[A-Z_]+\}\}' "$destino" | xargs -0 -r sed -i \
  -e "s|{{PROYECTO}}|$(esc "$nombre")|g" \
  -e "s|{{REPO}}|$(esc "$slug")|g" \
  -e "s|{{AUTOR}}|$(esc "$autor")|g" \
  -e "s|{{FECHA}}|$fecha|g" \
  -e "s|{{GITHUB_USUARIO}}|$(esc "$usuario")|g"
chmod +x "$destino/.husky/commit-msg" "$destino/.husky/pre-commit"
echo "Proyecto creado en $destino"
echo "Siguiente: cd $destino && git init -b main && pnpm install"
