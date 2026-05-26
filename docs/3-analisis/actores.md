# Actores del Sistema — ContractAI

Los actores son todas las personas, roles o sistemas externos que **interactúan con ContractAI**. Identificarlos correctamente es fundamental para saber quién puede hacer qué dentro de la plataforma.

**Proyecto:** ContractAI | **Empresa:** NexaOps  
**Docente:** Gloria Amparo Lora Patiño | **Uniremington · 2026**

> **Tipos de actor:**
> - **Primario**: inicia acciones directamente en el sistema (el usuario principal de un caso de uso).
> - **Secundario**: apoya o es notificado por el sistema, pero no lo inicia.
> - **Sistema externo**: otro sistema o servicio con el que ContractAI se integra.

---

## ACT-01 — Freelancer

| Campo | Descripción |
|-------|-------------|
| **ID Actor** | ACT-01 |
| **Nombre del Actor** | Freelancer |
| **Tipo** | Primario |
| **Descripción** | Profesional independiente (diseñador, desarrollador, consultor, fotógrafo, etc.) que trabaja por cuenta propia y necesita contratos para formalizar sus acuerdos con clientes sin contratar un abogado. Puede no tener conocimientos legales. |
| **Responsabilidades** | Crear contratos de prestación de servicios, analizarlos antes de firmarlos, compartirlos con clientes y administrar su repositorio personal. |
| **Permisos / Rol** | Solicitante — puede crear, editar, firmar, descargar y compartir sus propios contratos. |
| **CU Relacionados** | CU-01, CU-02, CU-03, CU-04, CU-05, CU-06, CU-07, CU-08 |
| **HU Relacionadas** | HU-01, HU-02, HU-03, HU-05, HU-07, HU-08, HU-09, HU-10, HU-12 |
| **Restricciones** | No puede gestionar roles de otros usuarios ni administrar plantillas del sistema. No puede acceder a los contratos de otros usuarios. |

---

## ACT-02 — PYME

| Campo | Descripción |
|-------|-------------|
| **ID Actor** | ACT-02 |
| **Nombre del Actor** | PYME (Pequeña y Mediana Empresa) |
| **Tipo** | Primario |
| **Descripción** | Representante o empleado de una empresa pequeña o mediana que gestiona múltiples contratos con proveedores, clientes y socios. Puede tener varios usuarios bajo la misma cuenta organizacional. |
| **Responsabilidades** | Gestionar contratos internos y externos de la organización, analizar riesgos, gestionar usuarios internos y mantener un repositorio centralizado de acuerdos. |
| **Permisos / Rol** | Aprobador — todo lo que puede hacer el Freelancer, más: análisis de riesgo avanzado, gestión de múltiples usuarios internos y acceso a plantillas especializadas. |
| **CU Relacionados** | CU-01, CU-02, CU-03, CU-04, CU-05, CU-06, CU-07, CU-08, CU-09 |
| **HU Relacionadas** | HU-01 a HU-18 |
| **Restricciones** | No puede gestionar roles de toda la plataforma ni modificar el catálogo global de plantillas. |

---

## ACT-03 — Administrador de plataforma

| Campo | Descripción |
|-------|-------------|
| **ID Actor** | ACT-03 |
| **Nombre del Actor** | Administrador de plataforma |
| **Tipo** | Primario |
| **Descripción** | Usuario con acceso total a la plataforma. Responsable de mantener el catálogo de plantillas actualizado, gestionar los roles de todos los usuarios y supervisar el funcionamiento general del sistema. Generalmente es personal interno de NexaOps. |
| **Responsabilidades** | Crear, editar y eliminar plantillas del sistema; asignar y modificar roles de usuarios; consultar estadísticas globales; garantizar la integridad y disponibilidad de la plataforma. |
| **Permisos / Rol** | Administrador — acceso total, incluyendo funciones exclusivas de gestión de roles y plantillas. |
| **CU Relacionados** | CU-01, CU-02, CU-09, CU-10 |
| **HU Relacionadas** | HU-19, HU-20 |
| **Restricciones** | Sus acciones de administración quedan registradas en el sistema para auditoría. |

---

## ACT-04 — Contraparte

| Campo | Descripción |
|-------|-------------|
| **ID Actor** | ACT-04 |
| **Nombre del Actor** | Contraparte |
| **Tipo** | Secundario |
| **Descripción** | Tercero externo (cliente, proveedor, socio) que recibe un enlace compartido para revisar y firmar un contrato. **No necesita tener cuenta registrada en ContractAI** para firmar. |
| **Responsabilidades** | Revisar el contrato recibido por enlace y firmarlo digitalmente si está de acuerdo con los términos. |
| **Permisos / Rol** | Solo lectura y firma — no puede editar, descargar ni acceder al repositorio del propietario. |
| **CU Relacionados** | CU-06 |
| **HU Relacionadas** | HU-07, HU-05 |
| **Restricciones** | Solo puede acceder al contrato específico del enlace recibido. El enlace puede tener fecha de expiración. |

---

## ACT-05 — Sistema de correo electrónico

| Campo | Descripción |
|-------|-------------|
| **ID Actor** | ACT-05 |
| **Nombre del Actor** | Sistema de correo electrónico |
| **Tipo** | Sistema externo |
| **Descripción** | Servicio de envío de correos electrónicos (como SendGrid, Mailgun o similar) que ContractAI usa para enviar notificaciones automáticas, enlace de recuperación de contraseña, alertas de vencimiento y confirmaciones de firma. |
| **Responsabilidades** | Recibir solicitudes de envío de correo desde ContractAI y entregar los mensajes a los destinatarios. |
| **Permisos / Rol** | Solo recibe instrucciones de envío desde el sistema. No inicia acciones por sí mismo. |
| **CU Relacionados** | CU-07 |
| **HU Relacionadas** | HU-14, HU-15, HU-16 |
| **Restricciones** | Si el servicio de correo falla, el sistema debe reintentar el envío y notificar al usuario mediante la interfaz. |

---

## Tabla resumen de actores

| ID | Nombre | Tipo | Permisos | CU Relacionados |
|----|--------|------|----------|-----------------|
| ACT-01 | Freelancer | Primario | Solicitante | CU-01 al CU-08 |
| ACT-02 | PYME | Primario | Aprobador | CU-01 al CU-09 |
| ACT-03 | Administrador de plataforma | Primario | Administrador | CU-01, CU-02, CU-09, CU-10 |
| ACT-04 | Contraparte | Secundario | Solo lectura y firma | CU-06 |
| ACT-05 | Sistema de correo | Sistema externo | Envío de mensajes | CU-07 |
