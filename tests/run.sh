#!/usr/bin/env bash
# Pruebas de los scripts del playbook. Uso: tests/run.sh
set -uo pipefail
raiz="$(cd "$(dirname "$0")/.." && pwd)"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
pasos=0
fallos=0

# espera <descripción> <código-de-salida-esperado> <comando...>
espera() {
  local desc="$1" esperado="$2"
  shift 2
  "$@" >"$tmp/salida" 2>&1
  local real=$?
  pasos=$((pasos + 1))
  if [[ "$real" == "$esperado" ]]; then
    echo "ok   $desc"
  else
    echo "MAL  $desc (esperado $esperado, real $real)"
    sed 's/^/     /' "$tmp/salida"
    fallos=$((fallos + 1))
  fi
}

V="$raiz/scripts/verificar-proyecto.sh"
N="$raiz/scripts/nuevo-proyecto.sh"

mkdir "$tmp/vacio"
espera "un repo vacío no cumple" 1 "$V" "$tmp/vacio"
espera "la plantilla cumple" 0 "$V" "$raiz/plantilla"
espera "nuevo-proyecto crea el repo" 0 "$N" "$tmp/demo" "Demo App" demo-app "Ana Pérez"
espera "el repo generado cumple" 0 "$V" "$tmp/demo"
espera "no quedan marcadores {{X}}" 1 grep -rEq '\{\{[A-Z_]+\}\}' "$tmp/demo"
espera "el nombre se sustituyó en AGENTS.md" 0 grep -q 'Demo App' "$tmp/demo/AGENTS.md"
espera "los \${{ }} de Actions siguen intactos" 0 grep -q '\${{ env.NODE_VERSION }}' "$tmp/demo/.github/workflows/ci.yml"
espera "los hooks son ejecutables" 0 test -x "$tmp/demo/.husky/commit-msg"
espera "un slug inválido se rechaza" 2 "$N" "$tmp/x" "X" "Mal_Slug" "Ana"
espera "un destino no vacío se rechaza" 2 "$N" "$tmp/demo" "Demo" demo "Ana"
cp -a "$tmp/demo" "$tmp/malnombre"
touch "$tmp/malnombre/docs/Plan_de_Desarrollo.md"
espera "un doc fuera de NN-kebab-case no cumple" 1 "$V" "$tmp/malnombre"
cp -a "$tmp/demo" "$tmp/sinalcance"
sed -i "/'scope-empty'/d" "$tmp/sinalcance/commitlint.config.mjs"
espera "commitlint sin alcance obligatorio no cumple" 1 "$V" "$tmp/sinalcance"

echo
echo "$pasos pruebas, $fallos fallos"
((fallos == 0))
