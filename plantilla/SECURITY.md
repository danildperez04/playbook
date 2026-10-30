# Seguridad — {{PROYECTO}}

## 1. Cómo reportar una vulnerabilidad

**No abras un issue público.** Usa el reporte privado de GitHub:
_Security → Report a vulnerability_ en el repositorio (o escribe a la persona
responsable del proyecto). Incluye qué encontraste, cómo reproducirlo y el impacto.

Respuesta inicial en un máximo de 5 días hábiles. Se avisa cuando haya una versión
corregida.

## 2. Versiones con soporte

Solo la última versión publicada (`main`) recibe correcciones de seguridad. Antes de
la `1.0.0` el sistema está en piloto y no hay versiones paralelas.

## 3. Controles automáticos

<!-- Agregar una fila por cada control nuevo (escaneo de secretos, auditoría de dependencias, análisis estático). -->

| Control                            | Herramienta | Dónde                    | Bloquea el merge |
| ---------------------------------- | ----------- | ------------------------ | ---------------- |
| Formato de commits y título del PR | commitlint  | `ci.yml`, job `quality`  | Sí               |
| Lint, tipos y pruebas              | CI          | `ci.yml`, job `checks`   | Sí               |
| Dependencias y acciones al día     | Dependabot  | `.github/dependabot.yml` | — (abre PR)      |

## 4. Excepciones vigentes de auditoría

Configuradas en `pnpm-workspace.yaml` (`auditConfig.ignoreGhsas`). Cada excepción debe
tener motivo y fecha de revisión; si no se puede justificar, no se ignora.

| Aviso | Paquete | Severidad | Vía | Motivo | Revisar |
| ----- | ------- | --------- | --- | ------ | ------- |

## 5. Medidas en la aplicación

<!-- Contraseñas, sesión, límites de intentos, cabeceras, validación de entrada, contenedores. Una viñeta por medida real. -->

- El rol se valida en el servidor en cada endpoint.
- Validación estricta de entrada: campos no declarados se rechazan.

## 6. Manejo de secretos

- Nunca en el repositorio: `.env`, `.env.production` y `.env.*.local` están en
  `.gitignore`.
- Secretos largos y aleatorios: `openssl rand -hex 32`.
- Si un secreto se filtra: **rotarlo primero** (un secreto en el historial de git sigue
  siendo público aunque se borre el archivo), luego limpiar el historial si hace falta.
- `RELEASE_PLEASE_TOKEN` (secreto de Actions): token de alcance mínimo, solo este
  repositorio y solo Contents / Pull requests / Issues; con vencimiento.
- Si hay un seeder con usuarios de ejemplo, se niega a correr con `NODE_ENV=production`.
