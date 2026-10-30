# Convenciones

**Versión:** 1.0.0
**Fecha:** 30 de octubre de 2026
**Autor:** Danild Pérez

---

Resumen único de las convenciones de todos los proyectos. Aquí solo se resume: el
detalle vive en `plantilla/` y cada sección dice dónde. Si este archivo y la plantilla
no coinciden, manda la plantilla y se corrige este archivo.

## 1. Idiomas

| Elemento                                    | Idioma o formato                              |
| ------------------------------------------- | --------------------------------------------- |
| Documentación, comentarios e interfaz       | Español                                       |
| Nombres de `describe` e `it` en las pruebas | Español                                       |
| Código, identificadores, commits y ramas    | Inglés                                        |
| Tablas y columnas                           | Inglés, `snake_case`, singular                |
| Fechas                                      | `timestamptz` en BD; `dd/mm/aaaa` en interfaz |

Detalle en: `plantilla/AGENTS.md` §1.

## 2. Documentación

| Elemento          | Convención                                                   |
| ----------------- | ------------------------------------------------------------ |
| Nombre de archivo | `docs/NN-kebab-case.md`, prefijo numérico de dos dígitos     |
| Encabezado        | Título, **Versión**, **Fecha**, **Autor**                    |
| Secciones         | Numeradas (`## 1.`, `## 2.`, …)                              |
| Cierre            | Tabla `## Historial`; cada cambio agrega una fila            |
| Identificadores   | `RF-nn`, `RNF-nn`, `HU-nn`, `RN-nn`; casos de prueba `PT-nn` |
| Estados           | `PENDIENTE` · `EN CURSO` · `IMPLEMENTADO` · `DESPLEGADO`     |
| Emojis            | No se usan                                                   |

Numeración canónica: `00` estado, `01` definición, `02` PRD, `03` backlog, `04` plan
Scrum, `05` versionado, commits y ramas, `08` plan de desarrollo, `09` trazabilidad,
`10` base de datos, `11` despliegue, `12` pruebas, `13` glosario, `14` arquitectura,
`15` UAT por sprint, `16` diseño, `17` revisión de código, `adr/`. **`06` y `07`
quedan reservados** y no se reutilizan. Cuándo se escribe cada uno:
`METODOLOGIA.md` §10.

Detalle en: `plantilla/docs/README.md`.

## 3. Commits

```text
<tipo>(<alcance>): <descripción en inglés, minúsculas, imperativo>
```

- Conventional Commits 1.0.0, validado por commitlint en el hook y en CI.
- Tipos: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`,
  `chore`, `revert`.
- **Alcance obligatorio**, en `kebab-case`: uno por módulo del dominio más los
  transversales `api`, `web`, `mobile`, `ui`, `db`, `deps`, `deps-dev`, `docker`,
  `docs`, `cicd`, `repo`.
- Cabecera de 100 caracteres como máximo.
- Trazabilidad en el cuerpo: `Refs: HU-XX / RF-YY`.

Detalle en: `plantilla/docs/05-versionado-commits-y-ramas.md` §2, `plantilla/commitlint.config.mjs`.

## 4. Ramas y flujo

- Permanentes: `main` (producción, con tags) y `develop` (integración). Ambas
  protegidas; solo entran PR con CI en verde.
- Prefijos: `feature/`, `fix/`, `refactor/`, `chore/`, `build/`, `docs/`, `hotfix/`.
  En inglés y `kebab-case`: `feature/hu-11-approve-request`.
- Una rama corta por historia, desde `develop` actualizado. Nunca una rama por sprint.
- Ciclo: issue → rama → commits → PR → revisión + CI → squash merge → issue cerrado.
- PR de menos de ~400 líneas; el título sigue el formato de commit.
- No apilar ramas: si B depende de A, primero se mergea A.
- Hotfix: desde `main`, PR a `main`, versión PATCH, merge de `main` a `develop`.

Detalle en: `plantilla/docs/05-versionado-commits-y-ramas.md` §3, `plantilla/CONTRIBUTING.md` §2.

## 5. Versionado

- Semantic Versioning 2.0.0 (`MAJOR.MINOR.PATCH`).
- Cada sprint cerrado sube un MINOR; `1.0.0` es el primer despliegue en producción.
- Antes de `1.0.0` rige `bump-minor-pre-major`: un cambio incompatible también sube
  MINOR.
- release-please calcula la versión, abre el PR de release, escribe el `CHANGELOG.md`
  y crea el tag `vX.Y.Z`. Nadie edita versiones ni el CHANGELOG a mano.

Detalle en: `plantilla/docs/05-versionado-commits-y-ramas.md` §1, `plantilla/release-please-config.json`.

## 6. Código TypeScript

- Comillas simples, punto y coma, 2 espacios, 100 columnas (Prettier y EditorConfig).
- `interface` sobre `type` cuando no se necesita unión.
- `unknown` sobre `any`; un `any` necesario se justifica con un comentario.
- El prefijo `_` marca parámetros no usados a propósito.
- Sin `console.log` en código que se entrega.
- Backend: archivos en `kebab-case` (`user-role.entity.ts`), clases en `PascalCase`.
- Frontend: componentes y vistas en `PascalCase`; hooks y utilidades en `camelCase`;
  alias `@/` hacia `src/`.

Detalle en: `plantilla/.prettierrc`, `plantilla/.editorconfig`, `plantilla/AGENTS.md`.

## 7. Pruebas

- Vitest (backend y frontend); Supertest para e2e; Testing Library en la interfaz.
- Unitarias junto al código (`*.spec.ts`, `*.test.tsx`); e2e en `test/`.
- Nombres de `describe` e `it` en español, describiendo el comportamiento.
- Toda regla de negocio lleva prueba, empezando por el caso crítico.
- Antes de dar algo por terminado: `pnpm lint && pnpm typecheck && pnpm test`.

Detalle en: `plantilla/docs/12-plan-pruebas.md`.

## 8. Uso de IA

- El asistente lee `AGENTS.md` antes de escribir o modificar código.
- Trabaja en la rama de una sola historia.
- Commits locales sí; `git push` y PR los hace la persona responsable.
- Su código se revisa igual que cualquier otro (`docs/17` §4).
- Quien abre el PR responde por todo su contenido.

Detalle en: `plantilla/AGENTS.md`, `plantilla/CONTRIBUTING.md` §5.

## 9. Planes de agentes

- Los planes no van dentro de los repos: viven en `/data/development/planes/`.
- Plan de un repositorio: `planes/<repo>/AAAA-MM-DD-<slug>.md`.
- Plan que abarca varios repos o la máquina: `planes/general/`.
- Encabezado: título, **Versión**, **Fecha**, **Estado** (`vigente` · `terminado` ·
  `descartado`).
- Un plan terminado no se borra: se marca `terminado` y queda como historial.

Detalle en: `/data/development/planes/README.md`, `plantilla/AGENTS.md` §5.

## 10. Cambiar estas convenciones

- Las convenciones cambian en el playbook, no en un proyecto suelto.
- Cualquier persona o agente puede proponer un cambio siguiendo el proceso de
  `AGENTS.md` del playbook, sección "Mejorar el playbook".
- Un cambio aceptado actualiza la plantilla, este archivo y su historial en el mismo
  commit, y `tests/run.sh` debe seguir en verde.

Detalle en: `/data/development/playbook/AGENTS.md`.

## Historial

| Versión | Fecha       | Autor        | Cambio                         |
| ------- | ----------- | ------------ | ------------------------------ |
| 1.0.0   | 30 oct 2026 | Danild Pérez | Creación inicial del documento |
