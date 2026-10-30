# Cómo contribuir a {{PROYECTO}}

Guía corta para trabajar en el proyecto. El detalle de cada tema está en `docs/`.

## 1. Puesta en marcha

Requisitos: Node 22+, pnpm.

```bash
# ajustar por proyecto
pnpm install
pnpm dev
```

## 2. De la idea al merge

```
issue ──▶ rama ──▶ commits ──▶ PR ──▶ revisión + CI ──▶ squash merge ──▶ issue cerrado
```

1. **Issue.** Todo trabajo empieza con un issue (plantillas: historia, error, tarea). Se
   asigna al milestone del sprint y aparece en el tablero del proyecto.
2. **Rama** desde `develop` actualizado, una por issue: `feature/hu-11-export-report`,
   `fix/login-redirect`, `build/…`, `docs/…` (`docs/05` §3). Sin ramas por sprint y
   sin ramas encima de otras sin mergear.
3. **Commits** con Conventional Commits y alcance obligatorio:
   `feat(auth): lock account after repeated failed logins`. Los hooks corren
   Prettier (y ESLint donde esté configurado) y commitlint en cada commit.
4. **Antes del PR**, en local:
   ```bash
   pnpm format:check && pnpm lint && pnpm typecheck && pnpm test
   ```
5. **PR hacia `develop`** con la plantilla. El título es el commit final, en el mismo
   formato que un commit (`feat(auth): …`): el check de calidad lo valida, y
   corregirlo lo vuelve a validar. La descripción incluye `Closes #N` para cerrar el
   issue; `Refs #N` lo menciona sin cerrarlo.
   Tamaño ideal: menos de ~400 líneas sin contar pruebas ni lockfile.
6. **Revisión** (`docs/17-revision-de-codigo.md`) y **CI en verde**: calidad y checks.
7. **Squash merge** y borrar la rama.

Al cerrar el sprint, `develop → main` y release-please prepara la versión
(`docs/05` §1.1).

## 3. Reglas que no se negocian

Las de `AGENTS.md` §3.

## 4. Decisiones de arquitectura

Una decisión que cambia cómo se construye el sistema (una librería central, un patrón,
un compromiso de seguridad) se registra como ADR en `docs/adr/` **antes** de
implementarla, con el contexto y las alternativas descartadas.

## 5. Trabajar con asistentes de IA

Se usan asistentes de código (Claude, Copilot…). Reglas:

- El asistente lee `AGENTS.md` y trabaja en la rama de **un** issue.
- Hace commits locales; **el push y los PR los hace la persona responsable**.
- Su código se revisa igual que cualquier otro, con atención especial a lo que
  `docs/17` §4 señala para código generado.
- Quien abre el PR responde por todo lo que contiene, lo haya escrito quien lo haya escrito.

## 6. Seguridad

Las vulnerabilidades se reportan por el canal privado (`SECURITY.md`), nunca en un issue.
