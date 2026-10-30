# Versionado, Commits y Ramas — {{PROYECTO}}

**Versión:** 0.1.0
**Fecha:** {{FECHA}}
**Autor:** {{AUTOR}}

---

## 1. Versionado

**Semantic Versioning 2.0.0** (`MAJOR.MINOR.PATCH`). Cada sprint cerrado sube MINOR
(ver tabla en `04-plan-scrum.md`); `1.0.0` es el primer despliegue en producción.
Todos los paquetes del repositorio comparten versión. Si hay API, se publica bajo
`/api/v1`; un cambio incompatible de contrato exige `/api/v2`.

### 1.1 Cómo sale una versión (automatizado)

Las versiones las calcula **release-please** a partir de los Conventional Commits; nadie
edita versiones ni el `CHANGELOG.md` a mano.

1. Al cerrar el sprint se mergea `develop → main` (§3.5).
2. El workflow `Release` (`.github/workflows/release.yml`) abre o actualiza el PR
   `chore(repo): release X.Y.Z` con la versión siguiente en los `package.json` y el
   `CHANGELOG.md` (secciones en español).
3. Se revisa ese PR (¿el CHANGELOG cuenta bien el sprint?) y se mergea.
4. release-please crea la etiqueta `vX.Y.Z` y el GitHub Release.

Antes de la `1.0.0`, un `feat` sube MINOR y un cambio incompatible (`feat!:` o
`BREAKING CHANGE:`) también sube MINOR (`bump-minor-pre-major`). Configuración:
`release-please-config.json` y `.release-please-manifest.json`.

### 1.2 Configuración única en GitHub

1. **Permitir que Actions abra PR:** _Settings → Actions → General → Workflow
   permissions_ → marcar _Allow GitHub Actions to create and approve pull requests_.
2. **Token para release-please** (para que su PR dispare CI y pase los checks
   requeridos de `main`): crear un _fine-grained personal access token_ con acceso
   **solo a este repositorio** y permisos _Contents_, _Pull requests_ e _Issues_ en
   lectura y escritura (_Metadata_ de solo lectura se agrega solo). Guardarlo en
   _Settings → Secrets and variables → Actions_ como `RELEASE_PLEASE_TOKEN`.
   Fijarle vencimiento (p. ej. 1 año) y anotar la fecha para renovarlo.

Sin el secreto el workflow usa `GITHUB_TOKEN`: el PR de release se crea igual, pero
CI no corre sobre él y hay que mergearlo marcando _bypass_ como administrador.

## 2. Commits

**Conventional Commits 1.0.0**, validados con commitlint en tres puntos:

- **Hook `commit-msg`** (husky): cada commit local.
- **Hook `pre-commit`**: lint-staged corre Prettier (y `eslint --fix` donde esté
  configurado) sobre los archivos preparados (configuración en `package.json`); un
  error de ESLint bloquea el commit.
- **CI, job `quality`**: los commits del PR y el **título del PR**, que es el mensaje
  del commit que queda en `develop` tras el _squash merge_.

El alcance es obligatorio:

```
<tipo>(<alcance>): <descripción en inglés, minúsculas, imperativo>
```

| Tipos | `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `revert` |
| ----- | -------------------------------------------------------------------------------------------- |

Los alcances válidos están en `commitlint.config.mjs`.

| Alcance                                | Uso                                         |
| -------------------------------------- | ------------------------------------------- |
| <!-- dominio -->                       | Un alcance por módulo del dominio           |
| `auth`, `users`                        | Acceso y usuarios                           |
| `api`, `web`, `mobile`, `ui`           | Transversal a una aplicación                |
| `db`, `deps`, `docker`, `docs`, `cicd` | Infraestructura                             |
| `repo`                                 | Configuración del repositorio y del release |
| `deps-dev`                             | Dependabot (dependencias de dev.)           |

Ejemplos:

```
feat(auth): lock account after repeated failed logins
fix(users): reject duplicated emails ignoring case
docs(db): document migration naming
```

## 3. Ramas y flujo de trabajo

Se trabaja con **ramas cortas por historia de usuario** que vuelven rápido a
`develop` (GitHub Flow sobre `develop`). El sprint es una unidad de planificación,
no de código: **nunca hay una rama por sprint**.

### 3.1 Ramas permanentes

| Rama      | Contenido                                 | Quién escribe                                              |
| --------- | ----------------------------------------- | ---------------------------------------------------------- |
| `main`    | Lo que está (o puede estar) en producción | Solo merges desde `develop` o `hotfix/*`, con tag `vX.Y.Z` |
| `develop` | Historias terminadas e integradas         | Solo PR con CI en verde                                    |

### 3.2 Ramas de trabajo

| Prefijo             | Cuándo                                                                    | Ejemplo                       |
| ------------------- | ------------------------------------------------------------------------- | ----------------------------- |
| `feature/`          | Una historia de usuario                                                   | `feature/hu-11-export-report` |
| `fix/`              | Corrección de un bug en `develop`                                         | `fix/login-redirect`          |
| `refactor/`         | Cambio interno sin comportamiento nuevo                                   | `refactor/extract-validation` |
| `chore/` · `build/` | Trabajo transversal sin historia (despliegue, herramientas, dependencias) | `build/deployment-containers` |
| `docs/`             | Solo documentación                                                        | `docs/branching-workflow`     |
| `hotfix/`           | Corrección urgente de producción, sale de `main`                          | `hotfix/login-500`            |

Nombres en inglés, `kebab-case`, con el número de historia cuando lo hay.

### 3.3 Ciclo de una historia

1. **Actualizar `develop`** (`git switch develop && git pull`).
2. **Crear la rama** desde `develop`: `git switch -c feature/hu-09-create-report`.
3. **Commits pequeños** con Conventional Commits (§2). Hooks de husky: Prettier y commitlint.
4. **Antes del PR**: `pnpm lint && pnpm typecheck && pnpm test` (y `pnpm test:e2e` si
   toca la API). Si `develop` avanzó, `git rebase develop`.
5. **Push y PR hacia `develop`** con la plantilla `.github/pull_request_template.md`.
   La rama vive idealmente **1 a 3 días**; el PR, **menos de ~400 líneas** sin contar
   pruebas ni lockfile.
6. **Revisión + CI en verde → _squash merge_**. En `develop` cada historia queda como
   un solo commit, con el título del PR en formato Conventional Commits.
7. **Borrar la rama** (local y remota) y empezar la siguiente desde `develop` actualizado.

### 3.4 Dependencias entre historias: no apilar ramas

Si la historia B necesita código de la historia A, **primero se mergea A** y luego B
sale de `develop`. No se crean ramas encima de otras ramas sin mergear: el PR de la
de arriba arrastra el código de todas las de abajo, y un cambio pedido en la revisión
de la primera hay que propagarlo a mano por las demás.

Si de verdad no se puede esperar, la excepción es un **PR apilado declarado**: el PR
de B apunta a la rama de A (no a `develop`), lo dice en su descripción y, cuando A se
mergea, B se rebasa sobre `develop` y se cambia su destino. Es una excepción, no la
forma normal de trabajar.

Para avanzar sin esperar: partir la historia en pasos que se pueden mergear solos
(primero la API con sus pruebas, después la pantalla) u ocultar lo incompleto detrás
de una ruta que todavía no aparece en el menú.

### 3.5 Cierre de sprint y versiones

1. Todas las historias del sprint mergeadas en `develop`, CI en verde.
2. Actualizar `docs/00-estado-del-proyecto.md`, el backlog y la matriz de trazabilidad.
3. PR `develop → main` titulado `release: vX.Y.0`; después del merge, release-please
   prepara la versión y la etiqueta `vX.Y.0` en `main` (§1.1).
4. Si en el sprint hubo cambios de esquema, verificar las migraciones contra una copia
   de la base antes de desplegar (`docs/11-guia-despliegue.md`).

### 3.6 Correcciones urgentes

Rama `hotfix/<slug>` desde `main` → PR a `main` → tag PATCH (`vX.Y.Z+1`) → merge de
`main` a `develop` para que la corrección no se pierda.

### 3.7 Asistentes de código (IA)

- Trabajan en la rama de **una** historia, creada desde `develop` actualizado.
- Hacen commits locales; **el push y los PR los hace la persona responsable**.
- No crean una rama nueva encima de otra que todavía no está mergeada (§3.4): si la
  siguiente historia depende de la anterior, avisan y esperan el merge.

## Historial

| Versión | Fecha     | Autor     | Cambio           |
| ------- | --------- | --------- | ---------------- |
| 0.1.0   | {{FECHA}} | {{AUTOR}} | Creación inicial |
