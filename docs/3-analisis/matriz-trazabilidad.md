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
| HU-16 — Recuperación y 2FA | RF-020 | RNF-004 | RN-010 |
| HU-17 — Constancia de firma | RF-021 | RNF-004, RNF-002 | RN-013 |
| HU-18 — Búsqueda y filtrado | RF-022 | RNF-001, RNF-003 | RN-001 |
| HU-19 — Gestión de roles | RF-023, RF-025 | RNF-004, RNF-006 | RN-001, RN-014 |
| HU-20 — Admin. plantillas | RF-024 | RNF-001, RNF-006, RNF-008 | RN-009, RN-014 |
| HU-21 — Inicio de sesión | RF-002 | RNF-004, RNF-006 | RN-001, RN-006, RN-010 |

---

## Resumen de cobertura

| Artefacto | Cantidad |
|-----------|----------|
| Historias de Usuario (HU) | 21 |
| Requisitos Funcionales (RF) | 25 |
| Requisitos No Funcionales (RNF) | 9 |
| Reglas de Negocio (RN) | 14 |
| Casos de Uso (CU) | 10 |
| Actores del sistema | 5 |

---

> Todos los RF tienen al menos una HU asociada.  
> Todos los RNF aplican a al menos tres casos de uso.  
> Todas las RN están referenciadas desde al menos un RF y una HU.
