# AGENTS.md

Instrucciones para asistentes de código (Claude, Cursor, Copilot, opencode y similares)
que trabajen en este repositorio. **Léelas antes de escribir o modificar código.**

## 1. Contexto

{{PROYECTO}}: <!-- qué hace el sistema y para quién, en dos líneas -->

| Carpeta | Aplicación | Tecnología |
| ------- | ---------- | ---------- |
|         |            |            |

| Dato                                               | Valor                                         |
| -------------------------------------------------- | --------------------------------------------- |
| Idioma de la documentación, comentarios e interfaz | Español                                       |
| Idioma del código, identificadores y commits       | Inglés                                        |
| Tablas y columnas                                  | Inglés, `snake_case`, singular                |
| Fechas                                             | `timestamptz` en BD; `dd/mm/aaaa` en interfaz |

## 2. Documentos obligatorios

| Voy a trabajar en…           | Debo leer                                             |
| ---------------------------- | ----------------------------------------------------- |
| Cualquier cosa               | `docs/14-arquitectura.md` y `docs/12-plan-pruebas.md` |
| Base de datos o migraciones  | `docs/10-esquema-base-de-datos.md`                    |
| Reglas de negocio            | `docs/02-prd-mvp-moscow.md` §2                        |
| Commits o ramas              | `docs/05-versionado-commits-y-ramas.md`               |
| Abrir o revisar un PR        | `CONTRIBUTING.md` y `docs/17-revision-de-codigo.md`   |
| Una decisión de arquitectura | `docs/adr/` (registrar un ADR antes de implementarla) |

## 3. Reglas innegociables

<!-- Numeradas. Las del dominio (invariantes de datos) primero. Estas tres aplican siempre: -->

1. **El esquema cambia solo por migración.** `synchronize` siempre `false`; una
   migración ya aplicada no se edita.
2. **La autorización es del servidor.** Ocultar una opción en la interfaz no es seguridad.
3. **Mensajes de error en español y accionables**; nunca SQL ni trazas al cliente.

## 4. Comandos

```bash
pnpm install
pnpm lint && pnpm typecheck && pnpm test   # antes de dar algo por terminado
```

## 5. Git

Detalle en `docs/05-versionado-commits-y-ramas.md` §3. En corto:

- Una rama corta por historia (`feature/hu-XX-<slug>`) desde `develop` actualizado.
- No apilar ramas: si la historia depende de otra sin mergear, avisa y espera.
- Conventional Commits con los alcances de `commitlint.config.mjs` (alcance obligatorio).
- Commits locales sí; `git push` y PR no: los hace la persona responsable.
- Los planes de trabajo no van en el repo: se guardan en
  `/data/development/planes/{{REPO}}/AAAA-MM-DD-<slug>.md`.

## 6. Documentación

Si el cambio altera el comportamiento, actualiza el `docs/NN-*.md` correspondiente en
el mismo commit y agrega una fila a su tabla de historial.

## 7. Convenciones comunes

Este repo sigue el playbook en `/data/development/playbook` (`CONVENCIONES.md` y
`METODOLOGIA.md`). Si detectas una mejora que aplica a todos los proyectos, propónla en
el playbook (ver su `AGENTS.md`) en lugar de desviarte aquí.
