# Plan Scrum — {{PROYECTO}}

**Versión:** 0.1.0
**Fecha:** {{FECHA}}
**Autor:** {{AUTOR}}

---

## 1. Marco de trabajo

<!-- Cómo se combinan Scrum y Kanban en este proyecto. -->

Scrum para planificar y Kanban para el día a día:

- Sprints de **2 semanas** con un objetivo y una versión cada uno.
- Tablero con límite de trabajo en curso (**WIP**): **un issue "En curso" por persona**
  a la vez. Se termina o se devuelve antes de empezar otro.
- El sprint es una unidad de planificación, no de código: no hay ramas por sprint
  (`05-versionado-commits-y-ramas.md` §3).

## 2. Roles

<!-- Una fila por rol con la persona que lo ocupa. -->

| Rol Scrum                           | Persona |
| ----------------------------------- | ------- |
| Product Owner                       |         |
| Scrum Master y equipo de desarrollo |         |
| Usuarios clave                      |         |

## 3. Artefactos

<!-- Dónde vive cada artefacto y cómo se gestiona en GitHub. -->

- **Backlog de producto:** `03-backlog-del-producto.md` (qué y por qué).
- **Estado general:** `00-estado-del-proyecto.md`.
- **Trabajo del día a día:** GitHub. Los issues son la unidad de trabajo (quién y cuándo).

| Elemento      | Uso                                                                                                                            |
| ------------- | ------------------------------------------------------------------------------------------------------------------------------ |
| **Issue**     | Una historia (`HU-XX: …`), un error o una tarea técnica, con su plantilla                                                      |
| **Etiquetas** | `tipo:` (historia, bug, tarea, deuda, seguridad) · `área:` (api, web, móvil, infra, docs) · `prioridad:` (must, should, could) |
| **Milestone** | Un sprint (`Sprint 1`…), con su fecha de cierre                                                                                |
| **Project**   | Tablero: Backlog → Sprint → En curso → En revisión → Hecho                                                                     |
| **PR**        | Una rama por issue; `Closes #N` en la descripción cierra el issue al mergear                                                   |

## 4. Eventos

<!-- Ritual del sprint: qué se hace en cada evento y qué se actualiza. -->

1. **Planificación:** se mueven al milestone del sprint los issues que caben, empezando
   por los `prioridad:must`; cada uno con criterios de aceptación claros.
2. **Durante el sprint:** el tablero refleja el estado real (un issue "En curso" por
   persona a la vez).
3. **Revisión:** demo con usuarios clave de lo que está en "Hecho"; lo no terminado
   vuelve a Backlog o pasa al siguiente milestone, nunca queda a medias en `develop`.
4. **Retrospectiva:** breve; qué mantener, qué cambiar, una acción concreta.
5. **Cierre:** `develop → main`, PR de release (`05-versionado-commits-y-ramas.md` §1.1)
   y actualización de `docs/00`, `docs/03` y `docs/09`.

Los errores encontrados en revisión o UAT se registran como issue `tipo:bug` antes de
corregirlos, para que quede constancia en el historial.

## 5. Definition of Done

<!-- Condiciones para que una historia pase a "Hecho". La plantilla de PR repite esta lista. -->

Una historia está terminada cuando:

1. Cumple todos sus criterios de aceptación.
2. Tiene pruebas (unitarias para reglas de negocio, e2e para endpoints).
3. CI en verde: calidad (formato, commits, título), lint, tipos y pruebas.
4. La documentación afectada está actualizada (esquema, backlog, matriz).
5. Tiene PR revisado según `17-revision-de-codigo.md` y _squash merge_ a `develop`, con
   su issue cerrado.

La plantilla de PR (`.github/pull_request_template.md`) repite esta lista.

## 6. Calendario de sprints y versión por sprint

<!-- Una fila por sprint. Cada sprint cerrado sube MINOR; 1.0.0 es el primer despliegue en producción. -->

| Sprint | Fechas (aprox.) | Objetivo | Versión |
| ------ | --------------- | -------- | ------- |

## 7. Métricas

<!-- Qué se mide cada sprint: historias terminadas vs. planificadas, bugs abiertos, tiempo de revisión de PR. -->

## 8. Comunicación

<!-- Canales, frecuencia y quién participa en cada reunión. -->

## Historial

| Versión | Fecha     | Autor     | Cambio           |
| ------- | --------- | --------- | ---------------- |
| 0.1.0   | {{FECHA}} | {{AUTOR}} | Creación inicial |
