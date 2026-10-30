# Metodología de trabajo

**Versión:** 1.0.0
**Fecha:** 30 de octubre de 2026
**Autor:** Danild Pérez

---

Cómo se construye un proyecto de software, de la idea al despliegue. Sale de la forma
en que ya se trabaja en los proyectos del equipo; no es teoría nueva. Cada sección
indica en qué archivo de `plantilla/` está el detalle. Las convenciones de nombres,
commits y código están resumidas en `CONVENCIONES.md`.

Los agentes de IA (Hermes, Claude, opencode, Copilot y similares) empiezan leyendo
`/data/development/playbook/AGENTS.md`, que les dice cómo aplicar este documento.

## 1. Marco de trabajo

- **Scrum con tablero Kanban.** Scrum da el ritmo (sprints, revisión, retrospectiva);
  el tablero muestra el estado real de cada tarea.
- **Sprints de 2 semanas.** Cada sprint cerrado produce una versión.
- **Equipo pequeño: de 1 a 5 personas.** Con una sola persona, los roles se
  concentran en ella, pero el proceso no cambia: los rituales se acortan, no se omiten.
- **Roles:** Product Owner (decide qué y en qué orden), Scrum Master (cuida el
  proceso) y equipo de desarrollo. Los usuarios clave validan en cada revisión.
- **La IA es opcional.** Si se usa, es un apoyo: lo que produce se revisa igual que
  cualquier otro cambio (§9).

Detalle en: `plantilla/docs/04-plan-scrum.md` §1–2.

## 2. Arranque del proyecto (Sprint 0)

El Sprint 0 no entrega funciones: deja listo el terreno. Lista de verificación:

1. **Repositorio desde la plantilla** con `scripts/nuevo-proyecto.sh` (§12).
2. **GitHub configurado:** ramas `main` y `develop` protegidas (sin force push, CI en
   verde obligatorio), permiso para que Actions abra PR y el secreto
   `RELEASE_PLEASE_TOKEN` (`plantilla/docs/05-versionado-commits-y-ramas.md` §1.2).
3. **Etiquetas** `tipo:`, `área:` y `prioridad:` (§3), un milestone por sprint y un
   tablero con las columnas Backlog → Sprint → En curso → En revisión → Hecho.
   Si se repite en varios proyectos, automatizarlo con un script y proponerlo al
   playbook (`AGENTS.md` §4).
4. **Documentos base** escritos antes de la primera historia:
   - `docs/01-definicion-de-la-solucion.md`: problema, objetivos, alcance.
   - `docs/02-prd-mvp-moscow.md`: reglas de negocio y requerimientos priorizados.
   - `docs/03-backlog-del-producto.md`: épicas e historias del primer sprint.
   - `docs/04-plan-scrum.md`: roles, calendario y versión por sprint.
   - `docs/14-arquitectura.md`: arquitectura general y estructura del repositorio.
5. **`AGENTS.md` del proyecto** completo: contexto, documentos obligatorios y reglas
   innegociables del dominio.
6. **Verificación:** `scripts/verificar-proyecto.sh <repo>` sale en 0.

Detalle en: `plantilla/docs/04-plan-scrum.md`, `plantilla/AGENTS.md`.

## 3. Unidad de trabajo

- **El issue es la unidad de trabajo** (quién y cuándo). `docs/03` es la referencia
  de producto (qué y por qué).
- Cada issue usa su plantilla: historia (`HU-XX: …`), bug o tarea técnica.
- Una historia del issue corresponde a una `HU-XX` en `docs/03`, con criterios de
  aceptación claros.
- **Etiquetas:**
  - `tipo:` historia, bug, tarea, deuda, seguridad.
  - `área:` api, web, móvil, infra, docs.
  - `prioridad:` must, should, could.
- **Límite de trabajo en curso (WIP):** un issue "En curso" por persona a la vez. Se
  termina antes de empezar otro.
- **Bloqueos visibles:** un issue bloqueado se comenta en el propio issue (qué lo
  bloquea y desde cuándo) y se menciona en la siguiente revisión. No se esconde
  empezando otra cosa.

Detalle en: `plantilla/.github/ISSUE_TEMPLATE/`, `plantilla/docs/03-backlog-del-producto.md`.

## 4. Ciclo de una historia

```text
issue ──▶ rama ──▶ commits ──▶ PR ──▶ revisión + CI ──▶ squash merge ──▶ issue cerrado
```

1. **Issue** asignado al milestone del sprint.
2. **Rama** desde `develop` actualizado, una por issue: `feature/hu-XX-<slug>`.
   Nunca una rama por sprint.
3. **Commits pequeños** con Conventional Commits y alcance obligatorio. Los hooks
   validan formato y mensaje.
4. **Antes del PR:** `pnpm lint && pnpm typecheck && pnpm test`. Si `develop` avanzó,
   `git rebase develop`.
5. **PR hacia `develop`** con la plantilla. El título es el commit final y sigue el
   mismo formato. La descripción incluye `Closes #N`. Tamaño ideal: menos de ~400
   líneas sin contar pruebas ni lockfile. La rama vive de 1 a 3 días.
6. **Revisión y CI en verde.**
7. **Squash merge**, borrar la rama y empezar la siguiente desde `develop`.

**No apilar ramas.** Si la historia B depende de A, primero se mergea A. Para no
esperar, se parte la historia en pasos que se mergean solos.

Detalle en: `plantilla/CONTRIBUTING.md` §2, `plantilla/docs/05-versionado-commits-y-ramas.md` §3.3–3.4.

## 5. Ritual del sprint

1. **Planificación.** Entran al milestone los issues que caben, empezando por
   `prioridad:must`. Cada uno con criterios de aceptación.
2. **Durante el sprint.** El tablero refleja el estado real. Los bloqueos se ven.
3. **Revisión.** Demo de lo que está en "Hecho" con los usuarios clave. Lo no
   terminado vuelve a Backlog o pasa al siguiente milestone; nunca queda a medias en
   `develop`.
4. **Retrospectiva.** Breve, tres preguntas: qué funcionó, qué no, qué se cambia.
   Incluye revisar si cada herramienta, también la IA, aporta o solo agrega trabajo.
   Lo que no aporta se quita. Los acuerdos se anotan en `docs/04-plan-scrum.md`.
5. **Cierre.** `develop → main`, PR de release generado por release-please y
   actualización de `docs/00-estado-del-proyecto.md`, `docs/03` y
   `docs/09-matriz-trazabilidad.md`.

Detalle en: `plantilla/docs/04-plan-scrum.md` §4, `plantilla/docs/05-versionado-commits-y-ramas.md` §3.5.

## 6. Definition of Done

Una historia está terminada cuando:

1. Cumple todos sus criterios de aceptación.
2. Tiene pruebas: unitarias para reglas de negocio, e2e para endpoints.
3. CI en verde: calidad (formato, commits, título del PR), lint, tipos y pruebas.
4. La documentación afectada está actualizada, con una fila nueva en su historial.
5. Tiene PR revisado según `docs/17-revision-de-codigo.md`, squash merge a `develop`
   e issue cerrado.

La plantilla de PR repite esta lista.

Detalle en: `plantilla/docs/04-plan-scrum.md` §5, `plantilla/.github/pull_request_template.md`.

## 7. Decisiones de arquitectura

- Una decisión que cambia cómo se construye el sistema (una librería central, un
  patrón, un compromiso de seguridad) se registra como ADR **antes** de implementarla.
- El ADR guarda el contexto y las alternativas descartadas.
- Archivo `docs/adr/NNNN-titulo-corto.md`, copiado de `docs/adr/plantilla.md`.
- Estados: `Propuesta` → `Aceptada` o `Rechazada`. Una decisión reemplazada pasa a
  `Reemplazada por NNNN`; no se borra.

Detalle en: `plantilla/docs/adr/README.md`, `plantilla/docs/adr/plantilla.md`.

## 8. Entrega y operación

- **Una versión por sprint.** Cada sprint cerrado sube MINOR; `1.0.0` es el primer
  despliegue en producción. release-please calcula la versión y escribe el
  `CHANGELOG.md`; nadie los edita a mano.
- **UAT.** Antes de una entrega a usuarios, se ejecuta la lista de
  `docs/15-checklist-uat-sN.md` del sprint y se anota el resultado.
- **Despliegue.** Según `docs/11-guia-despliegue.md`, escrita antes del primer
  despliegue. Si hubo cambios de esquema, las migraciones se prueban contra una copia
  de la base.
- **Hotfix.** Rama `hotfix/<slug>` desde `main`, PR a `main`, versión PATCH y merge de
  `main` a `develop`.
- **Retroalimentación.** Las observaciones de los usuarios en revisión y UAT se
  convierten en issues. Se priorizan en la siguiente planificación.
- **Incidencias.** Todo error encontrado en revisión, UAT o producción se registra
  como issue `tipo:bug` antes de corregirlo, para que quede constancia.

Detalle en: `plantilla/docs/05-versionado-commits-y-ramas.md` §1 y §3.5–3.6,
`plantilla/docs/11-guia-despliegue.md`.

## 9. Trabajo con IA

- El asistente lee `AGENTS.md` del repositorio antes de tocar código.
- Trabaja en la rama de **una** historia, creada desde `develop` actualizado.
- Hace commits locales. **El push y los PR los hace la persona responsable.**
- No crea ramas encima de otras sin mergear: si la historia depende de otra, avisa y
  espera.
- Sus resultados siempre se revisan. Atención especial a pruebas que confirman el
  código en vez de la historia, APIs inexistentes o de otra versión, cambios fuera
  del alcance y validaciones ausentes.
- Quien abre el PR responde por todo lo que contiene.
- Los planes de trabajo del agente no van en el repo:
  `/data/development/planes/<repo>/AAAA-MM-DD-<slug>.md`.

Detalle en: `plantilla/CONTRIBUTING.md` §5, `plantilla/docs/05-versionado-commits-y-ramas.md` §3.7,
`plantilla/docs/17-revision-de-codigo.md` §4.

## 10. Documentos y momento del proyecto

| #      | Documento                           | Cuándo se escribe o actualiza      | Obligatorio              |
| ------ | ----------------------------------- | ---------------------------------- | ------------------------ |
| 00     | `00-estado-del-proyecto.md`         | Cierre de cada sprint              | sí                       |
| 01     | `01-definicion-de-la-solucion.md`   | Sprint 0                           | sí                       |
| 02     | `02-prd-mvp-moscow.md`              | Sprint 0; al aparecer un requisito | sí                       |
| 03     | `03-backlog-del-producto.md`        | Sprint 0; planificación y cierre   | sí                       |
| 04     | `04-plan-scrum.md`                  | Sprint 0; retrospectivas           | sí                       |
| 05     | `05-versionado-commits-y-ramas.md`  | Sprint 0                           | sí                       |
| 06, 07 | reservados                          | —                                  | —                        |
| 08     | `08-plan-desarrollo.md`             | Sprint 0                           | no                       |
| 09     | `09-matriz-trazabilidad.md`         | Cierre de cada sprint              | no                       |
| 10     | `10-esquema-base-de-datos.md`       | Diseño; con cada migración         | si hay BD                |
| 11     | `11-guia-despliegue.md`             | Antes del primer despliegue        | antes del 1.º despliegue |
| 12     | `12-plan-pruebas.md`                | Sprint 0; con cada caso crítico    | sí                       |
| 13     | `13-glosario.md`                    | Sprint 0; al aparecer un término   | no                       |
| 14     | `14-arquitectura.md`                | Sprint 0; con cada ADR             | sí                       |
| 15     | `15-checklist-uat-sN.md`            | Sprint con UAT                     | por sprint con UAT       |
| 16     | `16-sistema-de-diseno.md`           | Antes de la primera pantalla       | si hay interfaz          |
| 17     | `17-revision-de-codigo.md`          | Sprint 0                           | sí                       |
| —      | `adr/README.md`, `adr/plantilla.md` | Sprint 0; con cada decisión        | sí                       |

Los números `06` y `07` no se reutilizan.

Detalle en: `plantilla/docs/README.md`.

## 11. Criterios mínimos de un proyecto operativo

Un proyecto se considera operativo cuando cumple todo lo siguiente:

| Criterio                                                 | Dónde se comprueba                                                  |
| -------------------------------------------------------- | ------------------------------------------------------------------- |
| Objetivo y alcance inicial definidos                     | `docs/01-definicion-de-la-solucion.md`                              |
| Requisitos priorizados                                   | `docs/02-prd-mvp-moscow.md`                                         |
| Tareas y prioridades visibles en un tablero              | `docs/04-plan-scrum.md` §3 y el tablero de GitHub                   |
| Código en un repositorio compartido con ramas protegidas | `docs/05-versionado-commits-y-ramas.md` §1.2 y §3.1                 |
| Cambios integrados por revisión adecuada al equipo       | `docs/17-revision-de-codigo.md`, `.github/pull_request_template.md` |
| Pruebas pertinentes y verificaciones automáticas         | `docs/12-plan-pruebas.md`, `.github/workflows/ci.yml`               |
| Secretos y datos sensibles protegidos                    | `SECURITY.md`, `.github/dependabot.yml`                             |
| Instalación, ejecución y despliegue documentados         | `README.md`, `CONTRIBUTING.md` §1, `docs/11-guia-despliegue.md`     |
| IA, si se usa, como apoyo y con resultados revisados     | `AGENTS.md`, `CONTRIBUTING.md` §5                                   |

Las rutas son relativas al repositorio del proyecto; el original de cada una está en
`plantilla/`. `scripts/verificar-proyecto.sh` comprueba que existan.

## 12. Cómo arrancar

Desde `/data/development/playbook/`:

```bash
scripts/nuevo-proyecto.sh ~/Dev/<slug> "<Nombre>" <slug> "Danild Pérez"
cd ~/Dev/<slug> && git init -b main && pnpm install
/data/development/playbook/scripts/verificar-proyecto.sh ~/Dev/<slug>
```

Después:

1. Completar `AGENTS.md` §1 y §3 con el contexto y las reglas del dominio.
2. Agregar los alcances del dominio en `commitlint.config.mjs`.
3. Seguir la lista del Sprint 0 (§2).

Un agente que arranca un proyecto lee primero `/data/development/playbook/AGENTS.md`
y luego este documento. Si detecta una mejora para el playbook, la propone según ese
mismo `AGENTS.md`; no la aplica por su cuenta en un proyecto.

## Historial

| Versión | Fecha       | Autor        | Cambio                         |
| ------- | ----------- | ------------ | ------------------------------ |
| 1.0.0   | 30 oct 2026 | Danild Pérez | Creación inicial del documento |
