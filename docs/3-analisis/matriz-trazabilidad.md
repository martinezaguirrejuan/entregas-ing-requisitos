# Matriz de Trazabilidad — ContractAI

La matriz de trazabilidad conecta cada Historia de Usuario con los Requisitos Funcionales, No Funcionales y Reglas de Negocio que la implementan. Sirve para verificar que ninguna necesidad del usuario quede sin cobertura en el sistema.

**Proyecto:** ContractAI | **Empresa:** NexaOps  
**Docente:** Gloria Amparo Lora Patiño | **Uniremington · 2026**

---

| HU | RF asociados | RNF aplicables | RN aplicables |
|----|-------------|----------------|---------------|
| HU-01 — Generación desde plantilla | RF-003, RF-004 | RNF-001, RNF-008, RNF-009 | RN-001, RN-009 |
| HU-02 — Análisis de riesgo | RF-005, RF-006 | RNF-001, RNF-006 | RN-002, RN-007, RN-008 |
| HU-03 — Guardado y gestión | RF-007 | RNF-004, RNF-007 | RN-001, RN-003 |
| HU-04 — Registro de cuenta | RF-001 | RNF-004 | RN-006 |
| HU-05 — Firma digital | RF-008 | RNF-001, RNF-003 | RN-003 |
| HU-06 — Biblioteca de firmas | RF-009 | RNF-007 | RN-004 |
| HU-07 — Compartir por enlace | RF-010 | RNF-002, RNF-005 | RN-005, RN-011 |
| HU-08 — Dashboard | RF-012 | RNF-001, RNF-003 | RN-001 |
| HU-09 — Edición lenguaje natural | RF-013, RF-014 | RNF-001, RNF-009 | RN-001, RN-009 |
| HU-10 — Descarga en PDF | RF-011 | RNF-005 | — |
| HU-11 — Clasificación interna/externa | RF-015 | RNF-001, RNF-006 | RN-001, RN-011 |
| HU-12 — Generación libre con IA | RF-016 | RNF-001, RNF-008, RNF-009 | RN-001, RN-009 |
| HU-13 — Historial y restauración | RF-017 | RNF-001, RNF-007 | RN-001, RN-003 |
| HU-14 — Notificaciones automáticas | RF-018 | RNF-002, RNF-006 | RN-002, RN-012 |
| HU-15 — Fechas de vigencia | RF-019 | RNF-001, RNF-002 | RN-012 |
| HU-16 — Recuperación de contraseña | RF-020 | RNF-004 | RN-010 |
| HU-17 — Constancia de firma | RF-021 | RNF-004, RNF-002 | RN-013 |
| HU-18 — Búsqueda y filtrado | RF-022 | RNF-001, RNF-003 | RN-001 |
| HU-19 — Gestión de roles | RF-023, RF-025 | RNF-004, RNF-006 | RN-001, RN-014 |
| HU-20 — Admin. plantillas | RF-024 | RNF-001, RNF-006, RNF-008 | RN-009, RN-014 |
| HU-21 — Inicio de sesión | RF-002 | RNF-004, RNF-006 | RN-001, RN-006, RN-010 |
| HU-22 — Activación 2FA | RF-026 | RNF-004, RNF-010 | — |

---

## Trazabilidad RF → Caso de Uso

| RF | HU Relacionada | CU |
|----|---------------|-----|
| RF-001 | HU-04 — Registro de cuenta | CU-01 — Registrar cuenta |
| RF-002 | HU-21 — Inicio de sesión | CU-02 — Iniciar sesión |
| RF-003 | HU-01 — Generación desde plantilla | CU-03 — Generar contrato desde plantilla |
| RF-004 | HU-01 — Generación desde plantilla | CU-03 — Generar contrato desde plantilla |
| RF-005 | HU-02 — Análisis de riesgo | CU-04 — Analizar riesgo de contrato |
| RF-006 | HU-02 — Análisis de riesgo | CU-04 — Analizar riesgo de contrato |
| RF-007 | HU-03 — Guardado y gestión | CU-05 — Consultar repositorio de contratos |
| RF-008 | HU-05 — Firma digital | CU-06 — Firmar contrato digitalmente |
| RF-009 | HU-06 — Biblioteca de firmas | CU-06 — Firmar contrato digitalmente |
| RF-010 | HU-07 — Compartir por enlace | CU-07 — Compartir contrato con contraparte |
| RF-011 | HU-10 — Descarga en PDF | CU-05 — Consultar repositorio de contratos |
| RF-012 | HU-08 — Dashboard | CU-11 — Ver dashboard de contratos |
| RF-013 | HU-09 — Edición lenguaje natural | CU-08 — Editar contrato con IA |
| RF-014 | HU-09 — Edición lenguaje natural | CU-08 — Editar contrato con IA |
| RF-015 | HU-11 — Clasificación interna/externa | CU-03 — Generar contrato desde plantilla |
| RF-016 | HU-12 — Generación libre con IA | CU-09 — Generar contrato desde descripción libre |
| RF-017 | HU-13 — Historial y restauración | CU-12 — Gestionar historial de versiones |
| RF-018 | HU-14 — Notificaciones automáticas | CU-18 — Gestionar notificaciones automáticas |
| RF-019 | HU-15 — Fechas de vigencia | CU-13 — Registrar vigencia de contrato |
| RF-020 | HU-16 — Recuperación de contraseña | CU-16 — Recuperar contraseña |
| RF-021 | HU-17 — Constancia de firma | CU-06 — Firmar contrato digitalmente |
| RF-022 | HU-18 — Búsqueda y filtrado | CU-14 — Buscar y filtrar contratos |
| RF-023 | HU-19 — Gestión de roles | CU-10 — Gestionar roles de usuarios |
| RF-024 | HU-20 — Admin. plantillas | CU-15 — Administrar catálogo de plantillas |
| RF-025 | HU-19 — Gestión de roles | CU-10 — Gestionar roles de usuarios |
| RF-026 | HU-22 — Activación 2FA | CU-17 — Activar autenticación 2FA |

---

## Resumen de cobertura

| Artefacto | Cantidad |
|-----------|----------|
| Historias de Usuario (HU) | 22 |
| Requisitos Funcionales (RF) | 26 |
| Requisitos No Funcionales (RNF) | 12 |
| Reglas de Negocio (RN) | 16 |
| Casos de Uso (CU) | 18 |
| Actores del sistema | 5 |

---

> Todos los RF tienen al menos una HU asociada.  
> Todos los RNF aplican a al menos tres casos de uso.  
> Todas las RN están referenciadas desde al menos un RF y una HU.
