# Casos de Uso — ContractAI

Un caso de uso describe una **secuencia de pasos** entre un actor y el sistema para lograr un objetivo específico. Es más detallado que una historia de usuario: incluye el flujo normal, las variaciones posibles y los errores que pueden ocurrir.

**Proyecto:** ContractAI | **Empresa:** NexaOps  
**Docente:** Gloria Amparo Lora Patiño | **Uniremington · 2026**

---

## Matriz de trazabilidad RF → CU

| Requerimiento Funcional | ID Caso de Uso | Nombre del Caso de Uso |
|------------------------|----------------|------------------------|
| RF-001 Registro de usuarios | CU-01 | Registrar cuenta |
| RF-002 Inicio de sesión | CU-02 | Iniciar sesión |
| RF-003 Generación por plantilla | CU-03 | Generar contrato desde plantilla |
| RF-004 Formulario de personalización | CU-03 | Generar contrato desde plantilla |
| RF-005 Análisis de riesgo | CU-04 | Analizar riesgo de contrato |
| RF-006 Reporte de cláusulas | CU-04 | Analizar riesgo de contrato |
| RF-007 Gestión de contratos | CU-05 | Gestionar repositorio de contratos |
| RF-008 Firma digital | CU-06 | Firmar contrato digitalmente |
| RF-009 Biblioteca de firmas | CU-06 | Firmar contrato digitalmente |
| RF-010 Enlace seguro | CU-07 | Compartir contrato con contraparte |
| RF-011 Descarga en PDF | CU-05 | Gestionar repositorio de contratos |
| RF-012 Dashboard | CU-05 | Gestionar repositorio de contratos |
| RF-013 Edición en lenguaje natural | CU-08 | Editar contrato con IA |
| RF-014 Asistente IA | CU-08 | Editar contrato con IA |
| RF-015 Clasificación interna/externa | CU-03 | Generar contrato desde plantilla |
| RF-016 Generación libre con IA | CU-09 | Generar contrato desde descripción libre |
| RF-017 Versionamiento | CU-05 | Gestionar repositorio de contratos |
| RF-018 Notificaciones | CU-07 | Compartir contrato con contraparte |
| RF-019 Fechas de vigencia | CU-05 | Gestionar repositorio de contratos |
| RF-020 Recuperación y 2FA | CU-02 | Iniciar sesión |
| RF-021 Constancia de firma | CU-06 | Firmar contrato digitalmente |
| RF-022 Búsqueda y filtrado | CU-05 | Gestionar repositorio de contratos |
| RF-023 Gestión de roles | CU-10 | Gestionar roles y usuarios |
| RF-024 Administración de plantillas | CU-10 | Gestionar roles y usuarios |
| RF-025 Control de acceso por rol | CU-10 | Gestionar roles y usuarios |

---

## CU-01 — Registrar cuenta

| Campo | Descripción |
|-------|-------------|
| **ID** | CU-01 |
| **Nombre** | Registrar cuenta |
| **HU Relacionada** | HU-04 |
| **Actor(es)** | Freelancer, PYME (usuario nuevo) |
| **Descripción** | El usuario crea una cuenta nueva en ContractAI ingresando sus datos básicos para acceder a todas las funcionalidades de la plataforma. |
| **Precondiciones** | El usuario no tiene una cuenta registrada. Tiene acceso a internet y a su correo electrónico. |
| **Postcondiciones** | La cuenta queda creada y activa. El usuario puede iniciar sesión inmediatamente. |

**Flujo principal (camino normal):**

| Paso | Actor | Acción |
|------|-------|--------|
| 1 | Usuario | Accede a la pantalla de registro de ContractAI. |
| 2 | Usuario | Ingresa su nombre completo, correo electrónico y contraseña. |
| 3 | Sistema | Valida que el correo no esté registrado y que la contraseña cumpla los requisitos mínimos. |
| 4 | Sistema | Crea la cuenta con rol **Freelancer** por defecto y guarda los datos de forma segura. |
| 5 | Sistema | Redirige al usuario a su repositorio personal vacío, listo para usar. |

**Flujos alternativos:**

| Código | Descripción |
|--------|-------------|
| FA-01 | Si el usuario ya tiene cuenta: el sistema muestra un mensaje "Este correo ya está registrado" y ofrece el enlace para iniciar sesión o recuperar contraseña. |

**Flujos de excepción:**

| Código | Descripción |
|--------|-------------|
| FE-01 | Si la contraseña no cumple los requisitos mínimos (menos de 8 caracteres, sin mayúscula o sin número): el sistema muestra un mensaje explicativo sin borrar los demás campos. |
| FE-02 | Si hay un error de conexión al guardar: el sistema muestra un mensaje de error y conserva los datos ingresados para que el usuario no tenga que escribirlos de nuevo. |

| Campo | Descripción |
|-------|-------------|
| **Prioridad** | Alta |
| **Frecuencia de uso** | Ocasional (solo al crear la cuenta) |
| **RN Relacionadas** | RN-006 |
| **RNF Relacionados** | RNF-004, RNF-006 |

---

## CU-02 — Iniciar sesión

| Campo | Descripción |
|-------|-------------|
| **ID** | CU-02 |
| **Nombre** | Iniciar sesión |
| **HU Relacionada** | HU-21 |
| **Actor(es)** | Freelancer, PYME, Administrador |
| **Descripción** | El usuario ingresa sus credenciales para autenticarse y acceder a sus contratos y funcionalidades según su rol. |
| **Precondiciones** | El usuario tiene una cuenta registrada y activa en ContractAI. |
| **Postcondiciones** | El usuario queda autenticado y tiene acceso a las funcionalidades correspondientes a su rol. |

**Flujo principal:**

| Paso | Actor | Acción |
|------|-------|--------|
| 1 | Usuario | Accede a la pantalla de inicio de sesión. |
| 2 | Usuario | Ingresa su correo electrónico y contraseña. |
| 3 | Sistema | Verifica que las credenciales sean correctas. |
| 4 | Sistema | Inicia la sesión activa y redirige al usuario a su dashboard según su rol. |

**Flujos alternativos:**

| Código | Descripción |
|--------|-------------|
| FA-01 | Si el usuario tiene 2FA activado: después de ingresar la contraseña correcta, el sistema solicita el código de verificación. El usuario lo ingresa y el sistema completa el acceso. |
| FA-02 | Si el usuario no recuerda su contraseña: hace clic en "¿Olvidaste tu contraseña?" e inicia el flujo de recuperación por correo. |

**Flujos de excepción:**

| Código | Descripción |
|--------|-------------|
| FE-01 | Si las credenciales son incorrectas: el sistema muestra "Correo o contraseña incorrectos" sin indicar cuál de los dos está mal (por seguridad). Permite reintentar. |
| FE-02 | Si hay 5 intentos fallidos consecutivos: el sistema bloquea temporalmente el acceso por 15 minutos y notifica al usuario. |

| Campo | Descripción |
|-------|-------------|
| **Prioridad** | Alta |
| **Frecuencia de uso** | Diaria |
| **RN Relacionadas** | RN-001, RN-010 |
| **RNF Relacionados** | RNF-004, RNF-006 |

---

## CU-03 — Generar contrato desde plantilla

| Campo | Descripción |
|-------|-------------|
| **ID** | CU-03 |
| **Nombre** | Generar contrato desde plantilla |
| **HU Relacionada** | HU-01, HU-11 |
| **Actor(es)** | Freelancer, PYME |
| **Descripción** | El usuario selecciona una plantilla del catálogo, completa los datos del contrato mediante un formulario guiado y la IA genera automáticamente el documento legal completo. |
| **Precondiciones** | El usuario está autenticado. Existen plantillas disponibles en el sistema. |
| **Postcondiciones** | El contrato generado queda guardado en el repositorio del usuario con estado "borrador". |

**Flujo principal:**

| Paso | Actor | Acción |
|------|-------|--------|
| 1 | Usuario | Hace clic en "Nuevo contrato" y selecciona "Usar plantilla". |
| 2 | Usuario | Elige una plantilla del catálogo (servicios, NDA, empleo, etc.) y clasifica el contrato como interno o externo. |
| 3 | Usuario | Completa el formulario paso a paso: nombre de las partes, objeto del contrato, valor, duración, ciudad y fecha. |
| 4 | Sistema | Envía los datos a la IA. |
| 5 | Sistema | La IA genera el contrato completo en tiempo real (streaming), mostrando el texto progresivamente. |
| 6 | Usuario | Revisa el contrato generado. |
| 7 | Sistema | Guarda el contrato automáticamente como "borrador" en el repositorio del usuario. |

**Flujos alternativos:**

| Código | Descripción |
|--------|-------------|
| FA-01 | Si el usuario quiere modificar algo del contrato generado: puede editarlo usando instrucciones en lenguaje natural (CU-08). |

**Flujos de excepción:**

| Código | Descripción |
|--------|-------------|
| FE-01 | Si la IA no está disponible: el sistema genera el contrato usando la plantilla base predefinida y avisa al usuario que la personalización avanzada no está disponible en este momento (RN-009). |
| FE-02 | Si el usuario no completa todos los campos obligatorios del formulario: el sistema resalta en rojo los campos vacíos y no avanza al siguiente paso. |

| Campo | Descripción |
|-------|-------------|
| **Prioridad** | Alta |
| **Frecuencia de uso** | Diaria |
| **RN Relacionadas** | RN-001, RN-004, RN-008, RN-009 |
| **RNF Relacionados** | RNF-001, RNF-006, RNF-008, RNF-009 |

---

## CU-04 — Analizar riesgo de contrato

| Campo | Descripción |
|-------|-------------|
| **ID** | CU-04 |
| **Nombre** | Analizar riesgo de contrato |
| **HU Relacionada** | HU-02 |
| **Actor(es)** | Freelancer, PYME |
| **Descripción** | El usuario carga o pega el texto de un contrato y la IA lo analiza para identificar cláusulas peligrosas o desfavorables, asignando un puntaje de riesgo. |
| **Precondiciones** | El usuario está autenticado. El contrato tiene menos de 50.000 caracteres. |
| **Postcondiciones** | El sistema muestra el puntaje de riesgo y el listado detallado de cláusulas problemáticas con sugerencias. |

**Flujo principal:**

| Paso | Actor | Acción |
|------|-------|--------|
| 1 | Usuario | Selecciona un contrato de su repositorio o pega el texto directamente. |
| 2 | Usuario | Hace clic en "Analizar riesgo". |
| 3 | Sistema | Envía el texto completo a la IA para análisis. |
| 4 | Sistema | La IA calcula el puntaje de riesgo (0–100) e identifica las cláusulas problemáticas. |
| 5 | Sistema | Muestra el resultado: puntaje general, y por cada cláusula de riesgo: nivel (bajo/medio/alto), descripción del problema, cita textual y sugerencia de mejora. |
| 6 | Usuario | Revisa los resultados y decide si procede a firmar o pide modificaciones. |

**Flujos alternativos:**

| Código | Descripción |
|--------|-------------|
| FA-01 | Si el puntaje de riesgo supera 70: el sistema muestra una advertencia prominente antes de permitir guardar o firmar (RN-002). |

**Flujos de excepción:**

| Código | Descripción |
|--------|-------------|
| FE-01 | Si el contrato supera los 50.000 caracteres: el sistema rechaza el análisis e informa al usuario del límite (RN-008). |
| FE-02 | Si la IA no está disponible: el sistema informa que el análisis no está disponible en este momento y ofrece reintentar más tarde. |

| Campo | Descripción |
|-------|-------------|
| **Prioridad** | Alta |
| **Frecuencia de uso** | Frecuente |
| **RN Relacionadas** | RN-001, RN-002, RN-007, RN-008 |
| **RNF Relacionados** | RNF-001, RNF-006, RNF-009 |

---

## CU-05 — Gestionar repositorio de contratos

| Campo | Descripción |
|-------|-------------|
| **ID** | CU-05 |
| **Nombre** | Gestionar repositorio de contratos |
| **HU Relacionada** | HU-03, HU-08, HU-13, HU-15, HU-18 |
| **Actor(es)** | Freelancer, PYME |
| **Descripción** | El usuario consulta, busca, filtra, descarga, versiona y administra todos sus contratos desde un repositorio personal centralizado. |
| **Precondiciones** | El usuario está autenticado y tiene al menos un contrato guardado. |
| **Postcondiciones** | Según la acción realizada: el contrato es encontrado, descargado, restaurado a versión anterior o eliminado. |

**Flujo principal:**

| Paso | Actor | Acción |
|------|-------|--------|
| 1 | Usuario | Accede a su repositorio personal desde el menú principal. |
| 2 | Sistema | Muestra la lista de contratos con nombre, estado, fecha de creación y nivel de riesgo. |
| 3 | Usuario | Usa los filtros disponibles (por nombre, fecha, tipo o estado) para encontrar el contrato deseado. |
| 4 | Usuario | Selecciona un contrato y elige la acción: ver, editar, descargar PDF, ver historial de versiones, o eliminar. |
| 5 | Sistema | Ejecuta la acción seleccionada y confirma el resultado al usuario. |

**Flujos alternativos:**

| Código | Descripción |
|--------|-------------|
| FA-01 | Si el usuario quiere restaurar una versión anterior: accede al historial, selecciona la versión deseada y confirma la restauración. El sistema crea una nueva versión con el contenido anterior. |
| FA-02 | Si el usuario quiere ver el dashboard general: el sistema muestra el total de contratos, distribución por estado y riesgo promedio. |

**Flujos de excepción:**

| Código | Descripción |
|--------|-------------|
| FE-01 | Si el usuario intenta eliminar un contrato firmado: el sistema solicita confirmación explícita antes de proceder (RN-003). |
| FE-02 | Si no hay contratos que coincidan con el filtro aplicado: el sistema muestra "No se encontraron contratos con estos criterios" y sugiere ampliar la búsqueda. |

| Campo | Descripción |
|-------|-------------|
| **Prioridad** | Alta |
| **Frecuencia de uso** | Diaria |
| **RN Relacionadas** | RN-001, RN-003 |
| **RNF Relacionados** | RNF-001, RNF-003, RNF-007 |

---

## CU-06 — Firmar contrato digitalmente

| Campo | Descripción |
|-------|-------------|
| **ID** | CU-06 |
| **Nombre** | Firmar contrato digitalmente |
| **HU Relacionada** | HU-05, HU-06, HU-17 |
| **Actor(es)** | Freelancer, PYME, Contraparte |
| **Descripción** | El usuario firma un contrato dibujando su firma en pantalla o seleccionando una firma guardada. El sistema genera automáticamente una constancia de firma con validez probatoria. |
| **Precondiciones** | El contrato existe en la plataforma. El usuario está autenticado (o accede por enlace como contraparte). |
| **Postcondiciones** | El contrato queda marcado como firmado. Se genera la constancia con sello de tiempo, IP y hash SHA-256. |

**Flujo principal:**

| Paso | Actor | Acción |
|------|-------|--------|
| 1 | Usuario / Contraparte | Abre el contrato que desea firmar. |
| 2 | Usuario | Elige entre dibujar una nueva firma o seleccionar una de su biblioteca personal. |
| 3 | Usuario | Confirma la firma y acepta los términos del documento. |
| 4 | Sistema | Registra la firma, captura la hora UTC, la IP del firmante y calcula el hash SHA-256 del documento. |
| 5 | Sistema | Genera la constancia de firma y actualiza el estado del contrato a "Firmado". |
| 6 | Sistema | Notifica al propietario del contrato que la firma fue completada. |

**Flujos alternativos:**

| Código | Descripción |
|--------|-------------|
| FA-01 | Si el usuario prefiere usar una firma guardada: selecciona una de la biblioteca, la previsualiza sobre el contrato y confirma. |

**Flujos de excepción:**

| Código | Descripción |
|--------|-------------|
| FE-01 | Si el contrato tiene un puntaje de riesgo mayor a 70: el sistema muestra una advertencia y solicita que el usuario confirme explícitamente que acepta los riesgos antes de firmar (RN-002). |
| FE-02 | Si el área de firma queda vacía: el sistema no permite continuar y muestra "Debes dibujar tu firma para continuar". |

| Campo | Descripción |
|-------|-------------|
| **Prioridad** | Alta |
| **Frecuencia de uso** | Frecuente |
| **RN Relacionadas** | RN-003, RN-013 |
| **RNF Relacionados** | RNF-001, RNF-003, RNF-004 |

---

## CU-07 — Compartir contrato con la contraparte

| Campo | Descripción |
|-------|-------------|
| **ID** | CU-07 |
| **Nombre** | Compartir contrato con la contraparte |
| **HU Relacionada** | HU-07, HU-14 |
| **Actor(es)** | Freelancer/PYME (propietario), Contraparte, Sistema de correo |
| **Descripción** | El propietario genera un enlace seguro para que la otra parte pueda revisar y firmar el contrato sin necesitar una cuenta en la plataforma. |
| **Precondiciones** | El contrato existe y tiene estado "borrador" o "activo". El usuario está autenticado. |
| **Postcondiciones** | La contraparte recibe el enlace y puede acceder al contrato en modo lectura y firma. |

**Flujo principal:**

| Paso | Actor | Acción |
|------|-------|--------|
| 1 | Usuario | Abre el contrato que quiere compartir y hace clic en "Compartir". |
| 2 | Sistema | Genera un enlace único y seguro para ese contrato. |
| 3 | Usuario | Copia el enlace o ingresa el correo de la contraparte para enviárselo directamente. |
| 4 | Sistema de correo | Envía el enlace al correo de la contraparte (si el usuario eligió envío directo). |
| 5 | Contraparte | Abre el enlace, revisa el contrato en modo lectura. |
| 6 | Contraparte | Firma el contrato si está de acuerdo. |
| 7 | Sistema | Notifica al propietario que la contraparte ha firmado. |

**Flujos alternativos:**

| Código | Descripción |
|--------|-------------|
| FA-01 | Si el contrato es interno: el sistema verifica que la contraparte tenga el mismo dominio de correo organizacional antes de permitir el firmado (RN-011). |

**Flujos de excepción:**

| Código | Descripción |
|--------|-------------|
| FE-01 | Si el enlace expira: la contraparte ve un mensaje "Este enlace ya no está activo" con instrucciones para pedir uno nuevo al propietario. |
| FE-02 | Si el servicio de correo falla: el sistema notifica al propietario que el correo no pudo enviarse y le muestra el enlace para que lo comparta manualmente. |

| Campo | Descripción |
|-------|-------------|
| **Prioridad** | Alta |
| **Frecuencia de uso** | Frecuente |
| **RN Relacionadas** | RN-005, RN-011, RN-012 |
| **RNF Relacionados** | RNF-002, RNF-005 |

---

## CU-08 — Editar contrato con instrucción de IA

| Campo | Descripción |
|-------|-------------|
| **ID** | CU-08 |
| **Nombre** | Editar contrato mediante instrucción en lenguaje natural |
| **HU Relacionada** | HU-09 |
| **Actor(es)** | Freelancer, PYME |
| **Descripción** | El usuario escribe en sus propias palabras qué cambio quiere hacer en el contrato, y la IA interpreta la instrucción y aplica el cambio automáticamente. |
| **Precondiciones** | El usuario está autenticado y tiene abierto un contrato en estado "borrador" o "activo". |
| **Postcondiciones** | El contrato refleja el cambio solicitado. Se guarda automáticamente una nueva versión en el historial. |

**Flujo principal:**

| Paso | Actor | Acción |
|------|-------|--------|
| 1 | Usuario | Abre el contrato que desea modificar. |
| 2 | Usuario | Escribe la instrucción en el campo de edición (ej: *"Agrega una penalización del 3% mensual por retraso en el pago"*). |
| 3 | Sistema | Envía la instrucción y el texto actual del contrato a la IA. |
| 4 | Sistema | La IA aplica el cambio solicitado y muestra el resultado en tiempo real. |
| 5 | Usuario | Revisa el cambio. Si está conforme, lo acepta. |
| 6 | Sistema | Guarda la nueva versión del contrato con registro en el historial. |

**Flujos alternativos:**

| Código | Descripción |
|--------|-------------|
| FA-01 | Si el usuario no está satisfecho con el cambio: puede rechazarlo, y el sistema restaura automáticamente la versión anterior. |

**Flujos de excepción:**

| Código | Descripción |
|--------|-------------|
| FE-01 | Si la IA no puede interpretar la instrucción: muestra un mensaje "No pude entender la instrucción, ¿puedes reformularla?" y da ejemplos de cómo escribirla. |
| FE-02 | Si la IA no está disponible: el sistema informa al usuario y sugiere editar el texto directamente. |

| Campo | Descripción |
|-------|-------------|
| **Prioridad** | Media |
| **Frecuencia de uso** | Frecuente |
| **RN Relacionadas** | RN-001, RN-009 |
| **RNF Relacionados** | RNF-001, RNF-009 |

---

## CU-09 — Generar contrato desde descripción libre

| Campo | Descripción |
|-------|-------------|
| **ID** | CU-09 |
| **Nombre** | Generar contrato desde descripción libre con IA |
| **HU Relacionada** | HU-12 |
| **Actor(es)** | Freelancer, PYME |
| **Descripción** | El usuario describe en sus propias palabras el acuerdo que necesita, y la IA generativa crea un contrato completo sin necesidad de plantilla. |
| **Precondiciones** | El usuario está autenticado. El servicio de IA está disponible. |
| **Postcondiciones** | El contrato generado se guarda como "borrador" en el repositorio del usuario. |

**Flujo principal:**

| Paso | Actor | Acción |
|------|-------|--------|
| 1 | Usuario | Hace clic en "Nuevo contrato" y selecciona "Describir lo que necesito". |
| 2 | Usuario | Escribe su descripción (ej: *"Necesito un contrato para que un diseñador me entregue un logo en 15 días a cambio de $800.000, con derechos de uso exclusivos para mi empresa"*). |
| 3 | Sistema | Envía la descripción a la IA generativa. |
| 4 | Sistema | La IA genera el contrato completo en tiempo real, incluyendo todas las cláusulas necesarias según la descripción. |
| 5 | Usuario | Revisa el contrato generado, puede editarlo con instrucciones adicionales. |
| 6 | Sistema | Guarda el contrato como "borrador". |

**Flujos de excepción:**

| Código | Descripción |
|--------|-------------|
| FE-01 | Si la descripción es demasiado corta o ambigua: la IA solicita más detalles antes de generar el contrato. |
| FE-02 | Si la IA no está disponible: el sistema informa y redirige al usuario a la opción de usar plantillas predefinidas. |

| Campo | Descripción |
|-------|-------------|
| **Prioridad** | Alta |
| **Frecuencia de uso** | Frecuente |
| **RN Relacionadas** | RN-001, RN-008, RN-009 |
| **RNF Relacionados** | RNF-001, RNF-006, RNF-008, RNF-009 |

---

## CU-10 — Gestionar roles y catálogo de plantillas

| Campo | Descripción |
|-------|-------------|
| **ID** | CU-10 |
| **Nombre** | Gestionar roles y catálogo de plantillas |
| **HU Relacionada** | HU-19, HU-20 |
| **Actor(es)** | Administrador de plataforma |
| **Descripción** | El administrador gestiona los roles de los usuarios de la plataforma y mantiene actualizado el catálogo de plantillas disponibles para todos. |
| **Precondiciones** | El usuario está autenticado con rol de Administrador de plataforma. |
| **Postcondiciones** | Los cambios de rol o de plantilla quedan aplicados inmediatamente para todos los usuarios afectados. |

**Flujo principal — Gestión de roles:**

| Paso | Actor | Acción |
|------|-------|--------|
| 1 | Administrador | Accede al panel de administración desde el menú. |
| 2 | Administrador | Busca al usuario cuyo rol desea cambiar por nombre o correo. |
| 3 | Administrador | Selecciona el nuevo rol: Freelancer, PYME o Administrador. |
| 4 | Sistema | Aplica el cambio de rol inmediatamente y ajusta los permisos del usuario. |
| 5 | Sistema | Registra la acción en el log de auditoría. |

**Flujo principal — Gestión de plantillas:**

| Paso | Actor | Acción |
|------|-------|--------|
| 1 | Administrador | Accede al catálogo de plantillas desde el panel. |
| 2 | Administrador | Crea, edita o elimina una plantilla, asignándola a una categoría. |
| 3 | Sistema | Actualiza el catálogo y lo hace disponible para todos los usuarios en tiempo real. |

**Flujos de excepción:**

| Código | Descripción |
|--------|-------------|
| FE-01 | Si el administrador intenta eliminarse su propio rol de administrador: el sistema rechaza la acción con el mensaje "No puedes modificar tu propio rol". |
| FE-02 | Si se intenta eliminar una plantilla que tiene contratos activos basados en ella: el sistema advierte cuántos contratos la usan y solicita confirmación. |

| Campo | Descripción |
|-------|-------------|
| **Prioridad** | Media |
| **Frecuencia de uso** | Ocasional |
| **RN Relacionadas** | RN-014 |
| **RNF Relacionados** | RNF-004, RNF-006 |

---

> **Total: 10 casos de uso**
