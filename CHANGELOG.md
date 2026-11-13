# Changelog del playbook

Formato: [Keep a Changelog](https://keepachangelog.com/es-ES/1.1.0/). Versionado:
SemVer según `AGENTS.md` §4.

## [Sin publicar]

### Cambiado

- Rutas de trabajo: `/data/development` pasa a `~/Dev` (la partición `/data` ya no existe).

## [1.0.0] — 2026-10-30

### Agregado

- `METODOLOGIA.md` y `CONVENCIONES.md`, destilados de la forma de trabajo de medios-aea.
- `plantilla/`: repo base con `AGENTS.md`, `CONTRIBUTING.md`, `SECURITY.md`,
  commitlint con alcance obligatorio, husky, lint-staged, Prettier, EditorConfig,
  release-please, `.github/` (CI, release, plantillas de issue y PR, Dependabot,
  CODEOWNERS) y esqueletos de `docs/00…17` y `docs/adr/`.
- `scripts/nuevo-proyecto.sh` y `scripts/verificar-proyecto.sh`, con `tests/run.sh`.
- Proceso para que los agentes propongan mejoras (`AGENTS.md` §4).
