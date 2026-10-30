# Documentación — {{PROYECTO}}

## Convenciones de esta documentación

| Elemento          | Convención                                                            |
| ----------------- | --------------------------------------------------------------------- |
| Nombre de archivo | `NN-kebab-case.md` con prefijo numérico de dos dígitos                |
| Idioma            | Español                                                               |
| Encabezado        | Título, **Versión**, **Fecha**, **Autor**                             |
| Secciones         | Numeradas (`## 1.`, `## 2.`, …)                                       |
| Cierre            | Tabla de historial de versiones del documento                         |
| Diagramas         | ASCII en bloque de código (legible sin herramientas) + fuente Mermaid |
| Requerimientos    | `RF-nn` funcional, `RNF-nn` no funcional, `HU-nn` historia de usuario |
| Emojis            | No se usan en `docs/`                                                 |

### Estados de implementación

| Marcador       | Significado                        |
| -------------- | ---------------------------------- |
| `PENDIENTE`    | No desarrollado                    |
| `EN CURSO`     | Desarrollado en el sprint actual   |
| `IMPLEMENTADO` | En código y verificado por pruebas |
| `DESPLEGADO`   | En producción                      |

---

## Índice

Los números `06` y `07` están reservados y no se reutilizan.

| #   | Documento                                                       | Contenido                                                 |
| --- | --------------------------------------------------------------- | --------------------------------------------------------- |
| 00  | [Estado del Proyecto](00-estado-del-proyecto.md)                | Dónde estamos hoy, avance por sprint, riesgos abiertos    |
| 01  | [Definición de la Solución](01-definicion-de-la-solucion.md)    | Problema, objetivos, alcance, stakeholders, restricciones |
| 02  | [PRD — MVP con MoSCoW](02-prd-mvp-moscow.md)                    | Reglas de negocio, RF, RNF y su prioridad                 |
| 03  | [Backlog del Producto](03-backlog-del-producto.md)              | Épicas e historias de usuario por sprint                  |
| 04  | [Plan Scrum](04-plan-scrum.md)                                  | Roles, cadencia, gestión en GitHub, Definition of Done    |
| 05  | [Versionado, Commits y Ramas](05-versionado-commits-y-ramas.md) | SemVer, Conventional Commits, flujo de ramas              |
| 08  | [Plan de Desarrollo](08-plan-desarrollo.md)                     | Hitos, Sprint 0 y dependencias entre sprints              |
| 09  | [Matriz de Trazabilidad](09-matriz-trazabilidad.md)             | RF ↔ HU ↔ Sprint ↔ Prueba ↔ Estado                        |
| 10  | [Esquema de Base de Datos](10-esquema-base-de-datos.md)         | Entidades, tablas, enums, migraciones                     |
| 11  | [Guía de Despliegue](11-guia-despliegue.md)                     | Servidor, configuración, despliegue y respaldos           |
| 12  | [Plan de Pruebas](12-plan-pruebas.md)                           | Estrategia, casos críticos, cobertura                     |
| 13  | [Glosario](13-glosario.md)                                      | Términos de negocio y técnicos                            |
| 14  | [Arquitectura](14-arquitectura.md)                              | Backend, frontend, seguridad, estructura del repositorio  |
| 15  | [Checklist UAT — Sprint 1](15-checklist-uat-s1.md)              | Pruebas de aceptación con usuarios del sprint             |
| 16  | [Sistema de Diseño](16-sistema-de-diseno.md)                    | Color, tipografía, componentes, principios                |
| 17  | [Revisión de Código](17-revision-de-codigo.md)                  | Qué mirar en un PR y cómo comentar                        |
| ADR | [Decisiones de arquitectura](adr/README.md)                     | Registro de decisiones y plantilla                        |
