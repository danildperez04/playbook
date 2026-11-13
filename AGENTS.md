# AGENTS.md — Playbook

Instrucciones para asistentes de código (Hermes, Claude, Cursor, Copilot, opencode y
similares). Este repositorio define **cómo se crean y se trabajan todos los proyectos**
bajo `~/Dev`. Léelo antes de crear un proyecto o de cambiar el playbook.

**Versión:** 1.0.0
**Fecha:** 30 de octubre de 2026
**Autor:** Danild Pérez

---

## 1. Qué hay aquí

| Archivo / carpeta | Para qué                                                                   |
| ----------------- | -------------------------------------------------------------------------- |
| `METODOLOGIA.md`  | Cómo se trabaja: sprints, issues, ciclo de una historia, entregas          |
| `CONVENCIONES.md` | Resumen de todas las convenciones; enlaza al detalle en `plantilla/`       |
| `plantilla/`      | Repositorio base que se copia a cada proyecto nuevo                        |
| `scripts/`        | `nuevo-proyecto.sh` (genera un repo) y `verificar-proyecto.sh` (lo audita) |
| `tests/run.sh`    | Pruebas de los scripts y de la plantilla                                   |
| `CHANGELOG.md`    | Cambios del playbook por versión                                           |

Los planes de trabajo no viven aquí: van en `~/Dev/planes/<repo>/`.

## 2. Crear un proyecto nuevo

```bash
~/Dev/playbook/scripts/nuevo-proyecto.sh \
  ~/Dev/<slug> "<Nombre visible>" <slug> "Danild Pérez"
cd ~/Dev/<slug> && git init -b main
~/Dev/playbook/scripts/verificar-proyecto.sh .   # debe decir "Cumple las convenciones"
```

Después, en el repo nuevo:

1. Completar `AGENTS.md` §1 y §3 (contexto y reglas innegociables del dominio).
2. Agregar los alcances del dominio en `commitlint.config.mjs`.
3. Escribir `docs/01`, `docs/02`, `docs/03`, `docs/04` y `docs/14` antes de la primera
   historia (`METODOLOGIA.md`, arranque del proyecto).
4. Los documentos opcionales que no apliquen (p. ej. `16-sistema-de-diseno.md` sin
   interfaz) se borran; los números no se reutilizan.

## 3. Trabajar en un proyecto existente

- Manda el `AGENTS.md` del repo. Si contradice este playbook, gana el repo: los
  proyectos anteriores al playbook (medios-aea, storecore, web-store, salud-movil…)
  **no se alinean** salvo que el usuario lo pida.
- Si falta una convención en el repo, aplica la de `CONVENCIONES.md`.

## 4. Mejorar el playbook

El playbook mejora con lo que se aprende en los proyectos. Cualquier agente puede
proponer un cambio siguiendo este proceso:

1. **Origen real.** La mejora nace de un problema o acierto concreto en un proyecto.
   Cítalo en el cuerpo del commit (`Origen: <repo> <commit|PR|plan>`). Nada de cambios
   "por si acaso".
2. **Rama propia** desde `main` actualizado: `feat/<slug>` (capacidad nueva en scripts o
   plantilla), `fix/<slug>`, `docs/<slug>` (solo texto). Una mejora por rama.
3. **Cambiar todo junto, en la misma rama:**
   - la regla en `CONVENCIONES.md` (o el proceso en `METODOLOGIA.md`);
   - su implementación en `plantilla/` (el detalle vive ahí, no en dos lugares);
   - `scripts/verificar-proyecto.sh` y `tests/run.sh` si la regla es verificable;
   - una entrada en `CHANGELOG.md` bajo `## [Sin publicar]`;
   - una fila en la tabla de historial de cada documento tocado.
4. **Verificar:** `tests/run.sh` debe terminar en `N pruebas, 0 fallos`.
5. **Commits** en Conventional Commits, en inglés, con alcance:
   `scripts`, `plantilla`, `docs`, `repo`.
   Ejemplo: `feat(plantilla): add codeql workflow to template`.
6. **No mergear.** El agente deja la rama con commits locales y avisa con un resumen
   (qué cambia, por qué, origen). El usuario revisa, mergea a `main` y fija la versión.
7. **Propuestas grandes** (cambiar el flujo de ramas, la numeración de docs, una
   herramienta central): primero un plan en
   `~/Dev/planes/playbook/AAAA-MM-DD-<slug>.md` y esperar aprobación.

Versionado del playbook (SemVer): MAJOR si un repo generado antes deja de cumplir el
verificador; MINOR para reglas o archivos nuevos; PATCH para correcciones y redacción.

## 5. Reglas innegociables

1. **Nada específico de un dominio** en `plantilla/`, `METODOLOGIA.md` ni
   `CONVENCIONES.md`. Antes de commitear:
   `grep -rniE 'medios|aea|storecore|vehícul|fundaci|abarrotes' plantilla METODOLOGIA.md CONVENCIONES.md`
   no debe devolver nada.
2. **Marcadores de plantilla solo en mayúsculas:** `{{PROYECTO}}`, `{{REPO}}`,
   `{{AUTOR}}`, `{{FECHA}}`, `{{GITHUB_USUARIO}}`. Uno nuevo se agrega también a
   `scripts/nuevo-proyecto.sh`. Los `${{ }}` de GitHub Actions no se tocan.
3. **YAGNI.** La plantilla trae lo que comparten todos los proyectos; lo particular
   (Docker, Postgres en CI, Expo, CodeQL…) lo agrega cada proyecto.
4. **Idiomas:** documentación en español; código, commits y ramas en inglés.
5. **Nunca** se modifican repos de proyectos desde una tarea del playbook.

## Historial

| Versión | Fecha       | Autor        | Cambio                              |
| ------- | ----------- | ------------ | ----------------------------------- |
| 1.0.0   | 30 oct 2026 | Danild Pérez | Creación inicial del documento      |
| 1.0.1   | 12 nov 2026 | Danild Pérez | Rutas `/data/development` → `~/Dev` |
