# Playbook de desarrollo

**Versión:** 1.0.0
**Fecha:** 30 de octubre de 2026
**Autor:** Danild Pérez

---

## 1. Qué es

Forma única de trabajar en los proyectos de software: la metodología, las
convenciones y una plantilla de repositorio lista para copiar. Sale de cómo se trabaja
en medios-aea, generalizado para cualquier proyecto.

Lo usan personas y agentes de IA (Hermes, Claude, opencode, Copilot y similares) para
crear proyectos nuevos y para proponer mejoras al propio playbook. Los agentes
empiezan por [`AGENTS.md`](AGENTS.md).

Es un repositorio git local, sin remoto.

## 2. Contenido

```text
playbook/
├── README.md                     este índice
├── AGENTS.md                     instrucciones para agentes; cómo mejorar el playbook
├── METODOLOGIA.md                cómo se trabaja, del Sprint 0 al despliegue
├── CONVENCIONES.md               resumen de convenciones; enlaza a la plantilla
├── plantilla/                    se copia tal cual a un repo nuevo
│   ├── AGENTS.md  CONTRIBUTING.md  SECURITY.md  README.md
│   ├── .editorconfig  .prettierrc  commitlint.config.mjs  package.json
│   ├── .husky/commit-msg  .husky/pre-commit
│   ├── release-please-config.json  .release-please-manifest.json
│   ├── .github/{pull_request_template.md,CODEOWNERS,dependabot.yml}
│   ├── .github/ISSUE_TEMPLATE/{config,historia,bug,tarea-tecnica}.yml
│   ├── .github/workflows/{ci.yml,release.yml}
│   └── docs/{README.md,00…05,08…17,adr/{README.md,plantilla.md}}
├── scripts/
│   ├── nuevo-proyecto.sh         crea un repo desde plantilla/
│   └── verificar-proyecto.sh     comprueba que un repo cumple las convenciones
└── tests/
    └── run.sh                    pruebas de los dos scripts
```

## 3. Comandos

Crear un proyecto nuevo:

```bash
scripts/nuevo-proyecto.sh <destino> "<Nombre>" <slug> "<Autor>" [usuario-github]
# ejemplo
scripts/nuevo-proyecto.sh ~/Dev/demo-app "Demo App" demo-app "Danild Pérez"
```

- `<slug>` en `kebab-case`; se usa como nombre del repositorio.
- `[usuario-github]` es opcional (por defecto `danildperez04`).
- El destino debe no existir o estar vacío.

Verificar que un repositorio cumple las convenciones (sale con 0 si cumple):

```bash
scripts/verificar-proyecto.sh <repo>
```

Probar los scripts después de cambiar la plantilla o los scripts:

```bash
tests/run.sh
```

## 4. Documentos

| Documento                                                | Para qué                                             |
| -------------------------------------------------------- | ---------------------------------------------------- |
| [`METODOLOGIA.md`](METODOLOGIA.md)                       | Marco de trabajo, ciclo de una historia, sprint, DoD |
| [`CONVENCIONES.md`](CONVENCIONES.md)                     | Idiomas, docs, commits, ramas, versionado, código    |
| [`AGENTS.md`](AGENTS.md)                                 | Cómo deben usar y mejorar el playbook los agentes    |
| [`/data/development/planes/`](/data/development/planes/) | Planes de trabajo de los agentes, fuera de los repos |

## Historial

| Versión | Fecha       | Autor        | Cambio                         |
| ------- | ----------- | ------------ | ------------------------------ |
| 1.0.0   | 30 oct 2026 | Danild Pérez | Creación inicial del documento |
