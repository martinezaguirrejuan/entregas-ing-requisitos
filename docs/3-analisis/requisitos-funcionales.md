# Requisitos Funcionales — ContractAI

Los requisitos funcionales describen **qué debe hacer el sistema**: cada acción concreta, verificable y medible que la plataforma debe realizar.

**Proyecto:** ContractAI | **Empresa:** NexaOps  
**Docente:** Gloria Amparo Lora Patiño | **Uniremington · 2026**

> **Correcciones aplicadas (revisión docente):**
> - IA nombrada explícitamente en todos los RF donde interviene (RF-003, RF-005, RF-013, RF-016).
> - RF de inicio de sesión agregado (RF-002), separado del registro.
> - RF-023 expandido con la **matriz de roles y permisos** diferenciados.
> - RF-025 agregado: control de acceso por rol en toda la plataforma.

---

## RF-001 — Registro de usuarios

| Campo | Descripción |
|-------|-------------|
| **ID** | RF-001 |
| **HU Relacionada** | HU-04 |
| **Descripción** | El sistema debe permitir registrar nuevos usuarios solicitando nombre, correo electrónico y contraseña. La contraseña debe cumplir un mínimo de seguridad (8 caracteres, al menos una mayúscula y un número). |

---

## RF-002 — Inicio de sesión

| Campo | Descripción |
|-------|-------------|
| **ID** | RF-002 |
| **HU Relacionada** | HU-21 |
| **Descripción** | El sistema debe permitir al usuario autenticarse ingresando su correo electrónico y contraseña registrados. Al autenticarse correctamente, el sistema debe iniciar una sesión activa y redirigir al usuario a su repositorio personal de contratos. |

---

## RF-003 — Generación de contratos desde plantilla con IA

| Campo | Descripción |
|-------|-------------|
| **ID** | RF-003 |
| **HU Relacionada** | HU-01 |
| **Descripción** | El sistema debe mostrar un catálogo de plantillas predefinidas (servicios, NDA, empleo, sociedad, arrendamiento, compraventa, términos y condiciones, política de privacidad) y usar **inteligencia artificial (IA)** para completar automáticamente el contrato con los datos ingresados por el usuario en el formulario, generando un texto legal coherente, completo y personalizado. |

---

## RF-004 — Formulario de personalización del contrato

| Campo | Descripción |
|-------|-------------|
| **ID** | RF-004 |
| **HU Relacionada** | HU-01 |
| **Descripción** | El sistema debe guiar al usuario por un formulario paso a paso para completar los datos variables del contrato: nombres de las partes, objeto del acuerdo, valor económico, duración, ciudad y fecha. Los campos obligatorios deben estar claramente señalados. |

---

## RF-005 — Análisis de riesgo con inteligencia artificial

| Campo | Descripción |
|-------|-------------|
| **ID** | RF-005 |
| **HU Relacionada** | HU-02 |
| **Descripción** | El sistema debe usar **inteligencia artificial (IA)** para leer el texto completo del contrato y calcular un puntaje de riesgo en una escala de 0 a 100, donde 0 es sin riesgo y 100 es riesgo máximo. La IA debe identificar cláusulas problemáticas y explicar por qué representan un riesgo para el usuario. |

---

## RF-006 — Reporte detallado de cláusulas de riesgo

| Campo | Descripción |
|-------|-------------|
| **ID** | RF-006 |
| **HU Relacionada** | HU-02 |
| **Descripción** | El sistema debe mostrar, por cada cláusula de riesgo detectada: el nivel de riesgo (bajo, medio o alto), el título de la cláusula, una descripción del problema, la cita textual del fragmento problemático y una sugerencia de cómo mejorarla o negociarla. |

---

## RF-007 — Guardado, edición y eliminación de contratos

| Campo | Descripción |
|-------|-------------|
| **ID** | RF-007 |
| **HU Relacionada** | HU-03 |
| **Descripción** | El sistema debe permitir al usuario guardar un contrato en su repositorio personal, editarlo posteriormente y eliminarlo si lo desea. Cada contrato debe estar asociado exclusivamente al usuario que lo creó. |

---

## RF-008 — Firma digital mediante dibujo en pantalla

| Campo | Descripción |
|-------|-------------|
| **ID** | RF-008 |
| **HU Relacionada** | HU-05 |
| **Descripción** | El sistema debe mostrar un área de dibujo donde el usuario pueda trazar su firma con el dedo o el cursor, y agregarla al contrato como firma digital válida. La firma debe quedar vinculada al documento. |

---

## RF-009 — Biblioteca de firmas reutilizables

| Campo | Descripción |
|-------|-------------|
| **ID** | RF-009 |
| **HU Relacionada** | HU-06 |
| **Descripción** | El sistema debe permitir guardar una o más firmas en una biblioteca personal del usuario para reutilizarlas en contratos futuros, y debe permitir eliminar firmas guardadas cuando ya no sean necesarias. |

---

## RF-010 — Generación de enlace seguro para compartir

| Campo | Descripción |
|-------|-------------|
| **ID** | RF-010 |
| **HU Relacionada** | HU-07 |
| **Descripción** | El sistema debe generar un enlace único y seguro para cada contrato que el usuario quiera compartir. Quien reciba el enlace podrá ver el contrato en modo lectura y firmarlo sin necesidad de tener una cuenta en la plataforma. |

---

## RF-011 — Descarga del contrato en PDF

| Campo | Descripción |
|-------|-------------|
| **ID** | RF-011 |
| **HU Relacionada** | HU-10 |
| **Descripción** | El sistema debe permitir descargar cualquier contrato en formato PDF, incluyendo las firmas digitales de todas las partes y los metadatos del documento (fecha, versión, estado). |

---

## RF-012 — Dashboard de estadísticas personales

| Campo | Descripción |
|-------|-------------|
| **ID** | RF-012 |
| **HU Relacionada** | HU-08 |
| **Descripción** | El sistema debe mostrar un panel de control con: total de contratos del usuario, distribución por estado (borrador, activo, firmado, vencido), nivel de riesgo promedio y los últimos contratos creados o modificados. |

---

## RF-013 — Edición de contratos mediante instrucción en lenguaje natural (IA)

| Campo | Descripción |
|-------|-------------|
| **ID** | RF-013 |
| **HU Relacionada** | HU-09 |
| **Descripción** | El sistema debe permitir al usuario escribir una instrucción en lenguaje cotidiano (por ejemplo: *"Agrega una cláusula de penalización por retraso del 2% mensual"*) y usar **inteligencia artificial (IA)** para interpretar esa instrucción y aplicar el cambio correspondiente sobre el texto del contrato, sin que el usuario deba editar el documento directamente. |

---

## RF-014 — Asistente de IA para consultas sobre el contrato

| Campo | Descripción |
|-------|-------------|
| **ID** | RF-014 |
| **HU Relacionada** | HU-09 |
| **Descripción** | El sistema debe ofrecer un asistente de **inteligencia artificial (IA)** al que el usuario pueda hacerle preguntas sobre el contrato cargado, por ejemplo: *"¿Qué pasa si el cliente no paga a tiempo?"* o *"¿Esta cláusula me protege como proveedor?"* El asistente debe responder en lenguaje simple. |

---

## RF-015 — Clasificación de contratos como internos o externos

| Campo | Descripción |
|-------|-------------|
| **ID** | RF-015 |
| **HU Relacionada** | HU-11 |
| **Descripción** | El sistema debe permitir al usuario clasificar cada contrato como **interno** (entre empleados o áreas de la misma organización) o **externo** (con clientes, proveedores o terceros), al momento de crearlo o editarlo. Esta clasificación determina las plantillas y reglas disponibles. |

---

## RF-016 — Generación de contratos personalizados desde descripción libre (IA generativa)

| Campo | Descripción |
|-------|-------------|
| **ID** | RF-016 |
| **HU Relacionada** | HU-12 |
| **Descripción** | El sistema debe permitir al usuario describir en sus propias palabras el tipo de acuerdo que necesita (por ejemplo: *"Necesito un contrato para que un diseñador me haga un logo y me entregue los archivos en 15 días a cambio de $500.000"*) y usar **inteligencia artificial generativa (IA)** para crear un contrato legal completo, sin necesidad de una plantilla predefinida. |

---

## RF-017 — Versionamiento automático de contratos

| Campo | Descripción |
|-------|-------------|
| **ID** | RF-017 |
| **HU Relacionada** | HU-13 |
| **Descripción** | El sistema debe guardar automáticamente una nueva versión del contrato cada vez que sea editado, registrando la fecha y hora del cambio. El usuario debe poder consultar el historial completo de versiones y restaurar cualquier versión anterior con un solo clic. |

---

## RF-018 — Notificaciones automáticas por eventos del contrato

| Campo | Descripción |
|-------|-------------|
| **ID** | RF-018 |
| **HU Relacionada** | HU-14 |
| **Descripción** | El sistema debe enviar notificaciones automáticas al usuario en los siguientes casos: (a) cuando la contraparte firma el contrato; (b) cuando un contrato está a 7 días o menos de su fecha de vencimiento; (c) cuando el análisis de riesgo detecta nivel alto en un contrato nuevo o editado. |

---

## RF-019 — Registro y alertas de fechas de vigencia

| Campo | Descripción |
|-------|-------------|
| **ID** | RF-019 |
| **HU Relacionada** | HU-15 |
| **Descripción** | El sistema debe permitir registrar una fecha de inicio y una fecha de vencimiento para cada contrato, y generar alertas automáticas cuando la fecha de vencimiento esté próxima (configurable entre 7 y 30 días de anticipación). |

---

## RF-020 — Recuperación de contraseña y autenticación de dos factores (2FA)

| Campo | Descripción |
|-------|-------------|
| **ID** | RF-020 |
| **HU Relacionada** | HU-16 |
| **Descripción** | El sistema debe: (a) permitir solicitar recuperación de contraseña enviando un enlace temporal al correo registrado, válido por 24 horas; (b) ofrecer la opción de activar autenticación de dos factores (2FA) mediante una aplicación de verificación o código por correo, como capa de seguridad adicional al iniciar sesión. |

---

## RF-021 — Constancia de firma con validez probatoria

| Campo | Descripción |
|-------|-------------|
| **ID** | RF-021 |
| **HU Relacionada** | HU-17 |
| **Descripción** | Al firmarse un contrato, el sistema debe generar automáticamente una constancia de firma que incluya: sello de tiempo UTC (fecha y hora exacta), dirección IP del firmante, y hash SHA-256 del documento (una "huella digital" única del archivo que prueba que no fue alterado después de la firma). Esta constancia tiene validez probatoria ante terceros. |

---

## RF-022 — Búsqueda y filtrado de contratos

| Campo | Descripción |
|-------|-------------|
| **ID** | RF-022 |
| **HU Relacionada** | HU-18 |
| **Descripción** | El sistema debe permitir al usuario buscar y filtrar su repositorio personal de contratos por: nombre del contrato, fecha de creación (rango), tipo de contrato (servicios, empleo, NDA, etc.) y estado (borrador, activo, firmado, vencido). Los resultados deben mostrarse en tiempo real mientras el usuario escribe. |

---

## RF-023 — Gestión de roles con matriz de permisos diferenciados

| Campo | Descripción |
|-------|-------------|
| **ID** | RF-023 |
| **HU Relacionada** | HU-19 |
| **Descripción** | El sistema debe gestionar tres roles con los siguientes permisos diferenciados: |

**Matriz de roles y permisos:**

| Funcionalidad | Freelancer | PYME | Administrador |
|---------------|:----------:|:----:|:-------------:|
| Crear contratos desde plantilla | ✓ | ✓ | ✓ |
| Generar contratos con IA libre | ✓ | ✓ | ✓ |
| Analizar riesgo de contratos | ✓ | ✓ | ✓ |
| Firmar digitalmente | ✓ | ✓ | ✓ |
| Compartir contratos por enlace | ✓ | ✓ | ✓ |
| Descargar en PDF | ✓ | ✓ | ✓ |
| Ver historial de versiones | ✓ | ✓ | ✓ |
| Gestionar múltiples usuarios internos | — | ✓ | ✓ |
| Acceder a análisis avanzado y plantillas premium | — | ✓ | ✓ |
| Gestionar roles y permisos de todos los usuarios | — | — | ✓ |
| Administrar el catálogo global de plantillas | — | — | ✓ |
| Ver estadísticas globales de la plataforma | — | — | ✓ |

---

## RF-024 — Administración del catálogo de plantillas

| Campo | Descripción |
|-------|-------------|
| **ID** | RF-024 |
| **HU Relacionada** | HU-20 |
| **Descripción** | El sistema debe permitir al Administrador de plataforma crear nuevas plantillas, editar las existentes, eliminarlas y organizarlas por categorías (laboral, comercial, confidencialidad, arrendamiento, etc.), de modo que todos los usuarios vean siempre un catálogo actualizado y bien clasificado. |

---

## RF-025 — Control de acceso por rol en toda la plataforma

| Campo | Descripción |
|-------|-------------|
| **ID** | RF-025 |
| **HU Relacionada** | HU-19 |
| **Descripción** | El sistema debe verificar el rol del usuario autenticado antes de permitir cualquier acción y bloquear el acceso a funcionalidades que no correspondan a su nivel de permisos, mostrando un mensaje claro si el usuario intenta acceder a algo que no le está permitido. Ningún usuario puede elevar sus propios permisos. |

---

> **Total: 25 requisitos funcionales**
>
> **Correcciones del docente aplicadas:**
> - RF-003: IA nombrada explícitamente en la generación de contratos.
> - RF-005: IA nombrada explícitamente en el análisis de riesgo.
> - RF-013: IA nombrada explícitamente en la edición por lenguaje natural.
> - RF-016: IA generativa nombrada explícitamente en la generación libre.
> - RF-002: Inicio de sesión agregado como RF independiente (antes solo existía registro).
> - RF-023: Matriz de roles y permisos definida con detalle por funcionalidad.
> - RF-025: Nuevo RF para el control de acceso por rol en toda la plataforma.
