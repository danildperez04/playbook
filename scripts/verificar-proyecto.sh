#!/usr/bin/env bash
# Verifica que un repositorio cumple las convenciones de CONVENCIONES.md.
# Uso: scripts/verificar-proyecto.sh <ruta-del-repo>
# Sale con 0 si cumple; con 1 y la lista de fallos si no.
set -uo pipefail
repo="${1:?Uso: verificar-proyecto.sh <ruta-del-repo>}"
raiz="$(cd "$(dirname "$0")/.." && pwd)"
fallos=0
falla() {
  printf 'FALLA  %s\n' "$1"
  fallos=$((fallos + 1))
}

requeridos=(
  AGENTS.md CONTRIBUTING.md SECURITY.md README.md
  .editorconfig .prettierrc commitlint.config.mjs
  .husky/commit-msg .husky/pre-commit
  release-please-config.json .release-please-manifest.json
  .github/pull_request_template.md .github/CODEOWNERS .github/dependabot.yml
  .github/ISSUE_TEMPLATE/config.yml .github/ISSUE_TEMPLATE/historia.yml
  .github/ISSUE_TEMPLATE/bug.yml .github/ISSUE_TEMPLATE/tarea-tecnica.yml
  .github/workflows/ci.yml
  docs/README.md docs/00-estado-del-proyecto.md docs/01-definicion-de-la-solucion.md
  docs/02-prd-mvp-moscow.md docs/03-backlog-del-producto.md docs/04-plan-scrum.md
  docs/05-versionado-commits-y-ramas.md docs/12-plan-pruebas.md
  docs/14-arquitectura.md docs/17-revision-de-codigo.md
  docs/adr/README.md docs/adr/plantilla.md
)
for f in "${requeridos[@]}"; do
  [[ -e "$repo/$f" ]] || falla "falta $f"
done

for f in .editorconfig .prettierrc; do
  if [[ -e "$repo/$f" ]] && ! cmp -s "$repo/$f" "$raiz/plantilla/$f"; then
    falla "$f difiere de plantilla/$f"
  fi
done

if [[ -e "$repo/commitlint.config.mjs" ]] &&
  ! grep -q "'scope-empty': \[2, 'never'\]" "$repo/commitlint.config.mjs"; then
  falla "commitlint.config.mjs no exige alcance ('scope-empty': [2, 'never'])"
fi

if [[ -d "$repo/docs" ]]; then
  while IFS= read -r f; do
    nombre="$(basename "$f")"
    [[ "$nombre" == README.md ]] && continue
    [[ "$nombre" =~ ^[0-9]{2}-[a-z0-9]+(-[a-z0-9]+)*\.md$ ]] ||
      falla "docs/$nombre no sigue NN-kebab-case.md"
  done < <(find "$repo/docs" -maxdepth 1 -type f -name '*.md' | sort)
fi

echo
if ((fallos == 0)); then
  echo "Cumple las convenciones: $repo"
  exit 0
fi
echo "$fallos incumplimiento(s) en $repo"
exit 1
