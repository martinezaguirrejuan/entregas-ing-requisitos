# ContractAI — Ingenieria de Software II

**Corporacion Universitaria Remington · Facultad de Ingenieria**  
**Docente:** Gloria Amparo Lora Patino  
**Autor:** Juan Fernando Martinez Aguirre — Codigo: 100145688  
**Asignatura:** Ingenieria de Software II · 2026-2  
**Linea Base:** LB-1 — Documento completo Fases 0-3  

---

## Descripcion del proyecto

ContractAI es una plataforma web para la gestion, analisis y firma digital de contratos,
orientada a freelancers y representantes de PYME. Integra inteligencia artificial para
automatizar la redaccion y el analisis de riesgo contractual, y firma digital con
constancia inmutable (sello UTC + IP + hash SHA-256).

Este repositorio contiene la **documentacion de ingenieria completa (Fases 0-3)**
siguiendo la Ruta Oficial del curso. La implementacion (Fase 4) inicia el semestre 2027-1.

---

## Stack tecnologico definido

| Capa | Tecnologia | Version |
|---|---|---|
| Frontend | Next.js + React | 16.x / 19.x |
| Lenguaje | TypeScript | 5.x |
| Estilos | Tailwind CSS | 3.x |
| Backend / API | Next.js Route Handlers | 16.x |
| ORM | Prisma | 5.x |
| Base de datos | MySQL / MariaDB | 10.6+ |
| IA | API de Groq (Llama 3.3-70b) | — |
| Firma digital | Canvas API + SHA-256 | — |
| Autenticacion | NextAuth.js | 5.x |
| Despliegue | Vercel (frontend) + Railway (BD) | — |

---

## Estructura del repositorio

```
contractai-is2/
├── README.md
├── db/
│   └── contractai.sql              <- Script DDL completo (17 tablas + trigger)
├── diagramas/
│   ├── act_critico1_login.*        <- Actividades: 2 criticos
│   ├── act_critico2_firma.*
│   ├── act_nocritico1_consultar.*  <- Actividades: 2 no criticos
│   ├── act_nocritico2_descargar.*
│   ├── seq1_login.*                <- Secuencia: exactamente 4
│   ├── seq2_generar_contrato.*
│   ├── seq3_firma_digital.*
│   ├── seq4_inactivar_usuario.*
│   ├── est_contrato_v2.*           <- Estados: Contrato
│   ├── est_enlace_compartir.*      <- Estados: EnlaceCompartir
│   ├── est_firma_solicitada.*      <- Estados: FirmaSolicitada
│   ├── diagrama_clases_unificado.* <- Clases: 17 entidades
│   └── paquete_*.puml              <- DDA: paquetes MVC
├── docs/
│   ├── 1-contexto/
│   ├── 2-objetivos/
│   ├── 3-analisis/                 <- HU (25), RF (30), RN (26), CU, matriz
│   ├── 4-diseno/                   <- Diccionario 3FN, MER, actividades, secuencia
│   ├── 5-construccion/             <- DDL, vertical slice
│   └── 6-gcs/                      <- ECS, lineas base, CRF
├── src/
│   └── README.md                   <- Stack + arquitectura MVC (implementacion 2027-1)
└── assets/
    └── diagramas/                  <- Diagramas de entregas anteriores (IS1)
```

---

## Artefactos entregados — Linea Base LB-1

| Artefacto | Ubicacion | Estado |
|---|---|---|
| 25 Historias de Usuario | `docs/3-analisis/historias-de-usuario.md` | LB-1 |
| 26 Reglas de Negocio | `docs/3-analisis/reglas-de-negocio.md` | LB-1 |
| 30 Requisitos Funcionales | `docs/3-analisis/requisitos-funcionales.md` | LB-1 |
| Diccionario 3FN (17 entidades) | `docs/3-analisis/diccionario-de-datos.md` | LB-1 |
| Diagrama de Clases Unificado | `diagramas/diagrama_clases_unificado.png` | LB-1 |
| 4 Diagramas de Actividades | `diagramas/act_*.png` | LB-1 |
| 4 Diagramas de Secuencia | `diagramas/seq*.png` | LB-1 |
| 3 Diagramas de Estados | `diagramas/est_*.png` | LB-1 |
| Matriz de Trazabilidad (25 HU) | `docs/3-analisis/matriz-trazabilidad.md` | LB-1 |
| Script DDL completo | `db/contractai.sql` | LB-1 |

---

## Gestion de la Configuracion (GCS)

| Linea Base | Fecha | Tag | Contenido |
|---|---|---|---|
| LB-1 | 24/10/2026 | `v1.0-LB1` | Documento completo Fases 0-3 |

### CRF tramitados

| CRF | Descripcion | Estado |
|---|---|---|
| CRF-001 | Agregar LogAuditoria + HU-24 (inactivar usuario) | Aprobado |
| CRF-002 | Agregar FirmanteExterno, EnlaceCompartir; TipoContrato como FK | Aprobado |
| CRF-003 | UNIQUE dobles en FirmaSolicitada; trigger RN-3FN-08 | Aprobado |
| CRF-004 | Unificar 4 paquetes en diagrama de clases unico | Aprobado |

---

## Como usar el script DDL

```bash
mysql -u root -p < db/contractai.sql
```

## Como renderizar los diagramas PlantUML

```bash
plantuml diagramas/*.puml
```
