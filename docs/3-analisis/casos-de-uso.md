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
| RF-007 Gestión de contratos | CU-05 | Consultar repositorio de contratos |
| RF-008 Firma digital | CU-06 | Firmar contrato digitalmente |
| RF-009 Biblioteca de firmas | CU-06 | Firmar contrato digitalmente |
| RF-010 Enlace seguro | CU-07 | Compartir contrato con contraparte |
| RF-011 Descarga en PDF | CU-19 | Descargar contrato en PDF |
| RF-012 Dashboard | CU-11 | Ver dashboard de contratos |
| RF-013 Edición en lenguaje natural | CU-08 | Editar contrato con IA |
| RF-014 Asistente IA | CU-08 | Editar contrato con IA |
| RF-015 Clasificación interna/externa | CU-03 | Generar contrato desde plantilla |
| RF-016 Generación libre con IA | CU-09 | Generar contrato desde descripción libre |
| RF-017 Versionamiento | CU-12 | Gestionar historial de versiones |
| RF-018 Notificaciones | CU-18 | Gestionar notificaciones automáticas |
| RF-019 Fechas de vigencia | CU-13 | Registrar vigencia de contrato |
| RF-020 Recuperación de contraseña | CU-16 | Recuperar contraseña |
| RF-021 Constancia de firma | CU-06 | Firmar contrato digitalmente |
| RF-022 Búsqueda y filtrado | CU-14 | Buscar y filtrar contratos |
| RF-023 Gestión de roles | CU-10 | Gestionar roles de usuarios |
| RF-024 Administración de plantillas | CU-15 | Administrar catálogo de plantillas |
| RF-025 Control de acceso por rol | CU-10 | Gestionar roles de usuarios |
| RF-026 Activación 2FA | CU-17 | Activar autenticación 2FA |

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

| Campo | Descripción |
|-------|-------------|
| FA-01 | Si el usuario ya tiene cuenta: el sistema muestra un mensaje "Este correo ya está registrado" y ofrece el enlace para iniciar sesión o recuperar contraseña. |

**Flujos de excepción:**

| Campo | Descripción |
|-------|-------------|
| FE-01 | Si la contraseña no cumple los requisitos mínimos (menos de 8 caracteres, sin mayúscula o sin número): el sistema muestra un mensaje explicativo sin borrar los demás campos. |
| FE-02 | Si hay un error de conexión al guardar: el sistema muestra un mensaje de error y conserva los datos ingresados para que el usuario no tenga que escribirlos de nuevo. |

| Campo | Descripción |
|-------|-------------|
| **Prioridad** | Alta |
| **Frecuencia de uso** | Ocasional (solo al crear la cuenta) |
| **RN Relacionadas** | RN-006 |
| **RNF Relacionados** | RNF-004, RNF-006 |
| **Notas / Observaciones** | El rol por defecto al registrarse es Freelancer. Si el usuario necesita rol PYME o Administrador, debe solicitarlo al administrador de la plataforma. |

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

| Campo | Descripción |
|-------|-------------|
| FA-01 | Si el usuario tiene 2FA activado: después de ingresar la contraseña correcta, el sistema solicita el código de verificación. El usuario lo ingresa y el sistema completa el acceso. |
| FA-02 | Si el usuario no recuerda su contraseña: hace clic en "¿Olvidaste tu contraseña?" e inicia el flujo de recuperación por correo. |

**Flujos de excepción:**

| Campo | Descripción |
|-------|-------------|
| FE-01 | Si las credenciales son incorrectas: el sistema muestra "Correo o contraseña incorrectos" sin indicar cuál de los dos está mal (por seguridad). Permite reintentar. |
| FE-02 | Si hay 5 intentos fallidos consecutivos: el sistema bloquea temporalmente el acceso por 15 minutos y notifica al usuario. |

| Campo | Descripción |
|-------|-------------|
| **Prioridad** | Alta |
| **Frecuencia de uso** | Diaria |
| **RN Relacionadas** | RN-001, RN-010 |
| **RNF Relacionados** | RNF-004, RNF-006 |
| **Notas / Observaciones** | El sistema no debe indicar cuál campo (correo o contraseña) es incorrecto para evitar que alguien intente adivinar datos de otros usuarios. |

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

| Campo | Descripción |
|-------|-------------|
| FA-01 | Si el usuario quiere modificar algo del contrato generado: puede editarlo usando instrucciones en lenguaje natural (CU-08). |

**Flujos de excepción:**

| Campo | Descripción |
|-------|-------------|
| FE-01 | Si la IA no está disponible: el sistema genera el contrato usando la plantilla base predefinida y avisa al usuario que la personalización avanzada no está disponible en este momento (RN-009). |
| FE-02 | Si el usuario no completa todos los campos obligatorios del formulario: el sistema resalta en rojo los campos vacíos y no avanza al siguiente paso. |

| Campo | Descripción |
|-------|-------------|
| **Prioridad** | Alta |
| **Frecuencia de uso** | Diaria |
| **RN Relacionadas** | RN-001, RN-004, RN-008, RN-009 |
| **RNF Relacionados** | RNF-001, RNF-006, RNF-008, RNF-009 |
| **Notas / Observaciones** | La clasificación interno/externo del contrato debe hacerse en este paso, ya que determina qué reglas de compartir y firma aplican (RN-011). |

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

| Campo | Descripción |
|-------|-------------|
| FA-01 | Si el puntaje de riesgo supera 70: el sistema muestra una advertencia prominente antes de permitir guardar o firmar (RN-002). |

**Flujos de excepción:**

| Campo | Descripción |
|-------|-------------|
| FE-01 | Si el contrato supera los 50.000 caracteres: el sistema rechaza el análisis e informa al usuario del límite (RN-008). |
| FE-02 | Si la IA no está disponible: el sistema informa que el análisis no está disponible en este momento y ofrece reintentar más tarde. |

| Campo | Descripción |
|-------|-------------|
| **Prioridad** | Alta |
| **Frecuencia de uso** | Frecuente |
| **RN Relacionadas** | RN-001, RN-002, RN-007, RN-008 |
| **RNF Relacionados** | RNF-001, RNF-006, RNF-009 |
| **Notas / Observaciones** | El análisis es una recomendación de la IA, no una decisión legal definitiva. El usuario siempre puede optar por firmar aunque el riesgo sea alto, pero debe hacerlo con confirmación explícita. |

---

## CU-05 — Consultar repositorio de contratos

| Campo | Descripción |
|-------|-------------|
| **ID** | CU-05 |
| **Nombre** | Consultar repositorio de contratos |
| **HU Relacionada** | HU-03 |
| **Actor(es)** | Freelancer, PYME |
| **Descripción** | El usuario accede a su repositorio personal y visualiza la lista de sus contratos guardados con su información básica. |
| **Precondiciones** | El usuario está autenticado y tiene al menos un contrato guardado. |
| **Postcondiciones** | El usuario visualiza su lista de contratos y puede navegar a cualquiera de ellos. |

**Flujo principal:**

| Paso | Actor | Acción |
|------|-------|--------|
| 1 | Usuario | Accede a su repositorio personal desde el menú principal. |
| 2 | Sistema | Muestra la lista de contratos con nombre, estado, fecha de creación y nivel de riesgo. |
| 3 | Usuario | Selecciona un contrato para abrirlo y ver su detalle. |
| 4 | Sistema | Muestra el contenido del contrato seleccionado. |

**Flujos de excepción:**

| Campo | Descripción |
|-------|-------------|
| FE-01 | Si el usuario no tiene contratos guardados: el sistema muestra el mensaje "Aún no tienes contratos" con un enlace directo para crear el primero. |

| Campo | Descripción |
|-------|-------------|
| **Prioridad** | Alta |
| **Frecuencia de uso** | Diaria |
| **RN Relacionadas** | RN-001 |
| **RNF Relacionados** | RNF-001, RNF-003, RNF-007 |
| **Notas / Observaciones** | Desde la vista de detalle de un contrato el usuario puede acceder a otras funcionalidades: buscar (CU-14), descargar PDF (CU-19), ver historial (CU-12), firmar (CU-06) o editar con IA (CU-08). |

---

## CU-06 — Firmar contrato digitalmente

| Campo | Descripción |
|-------|-------------|
| **ID** | CU-06 |
| **Nombre** | Firmar contrato digitalmente |
| **HU Relacionada** | HU-05, HU-06, HU-17 |
| **Actor(es)** | Freelancer, PYME, Contraparte |
| **Descripción** | El usuario firma un contrato dibujando su firma en pantalla o seleccionando una firma guardada. El sistema genera automáticamente una constancia de firma con validez probatoria. |
| **Precondiciones** | El contrato existe en la plataforma. El usuario está autenticado (o accede por enlace como contraparte). Si el contrato fue analizado por IA, el puntaje de riesgo debe estar calculado previamente antes de proceder a firmar. |
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

| Campo | Descripción |
|-------|-------------|
| FA-01 | Si el usuario prefiere usar una firma guardada: selecciona una de la biblioteca, la previsualiza sobre el contrato y confirma. |

**Flujos de excepción:**

| Campo | Descripción |
|-------|-------------|
| FE-01 | Si el contrato tiene puntaje de riesgo mayor a 70 calculado previamente: el sistema muestra advertencia y solicita confirmación explícita (RN-002). |
| FE-02 | Si el área de firma queda vacía: el sistema no permite continuar y muestra "Debes dibujar tu firma para continuar". |

| Campo | Descripción |
|-------|-------------|
| **Prioridad** | Alta |
| **Frecuencia de uso** | Frecuente |
| **RN Relacionadas** | RN-003, RN-013 |
| **RNF Relacionados** | RNF-001, RNF-003, RNF-004 |
| **Notas / Observaciones** | La constancia de firma (sello UTC, IP, hash SHA-256) se genera de forma inmutable e irrefutable. Una vez creada no puede modificarse, garantizando su valor probatorio legal. |

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

| Campo | Descripción |
|-------|-------------|
| FA-01 | Si el contrato es interno: el sistema verifica que la contraparte tenga el mismo dominio de correo organizacional antes de permitir el firmado (RN-011). |

**Flujos de excepción:**

| Campo | Descripción |
|-------|-------------|
| FE-01 | Si el enlace expira: la contraparte ve un mensaje "Este enlace ya no está activo" con instrucciones para pedir uno nuevo al propietario. |
| FE-02 | Si el servicio de correo falla: el sistema notifica al propietario que el correo no pudo enviarse y le muestra el enlace para que lo comparta manualmente. |

| Campo | Descripción |
|-------|-------------|
| **Prioridad** | Alta |
| **Frecuencia de uso** | Frecuente |
| **RN Relacionadas** | RN-005, RN-011, RN-012 |
| **RNF Relacionados** | RNF-002, RNF-005 |
| **Notas / Observaciones** | La contraparte (ACT-04) no necesita cuenta registrada para firmar. Solo necesita el enlace. Si el contrato es interno, el sistema valida el dominio de correo antes de permitir la firma (RN-011). |

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

| Campo | Descripción |
|-------|-------------|
| FA-01 | Si el usuario no está satisfecho con el cambio: puede rechazarlo, y el sistema restaura automáticamente la versión anterior. |

**Flujos de excepción:**

| Campo | Descripción |
|-------|-------------|
| FE-01 | Si la IA no puede interpretar la instrucción: muestra un mensaje "No pude entender la instrucción, ¿puedes reformularla?" y da ejemplos de cómo escribirla. |
| FE-02 | Si la IA no está disponible: el sistema informa al usuario y sugiere editar el texto directamente. |

| Campo | Descripción |
|-------|-------------|
| **Prioridad** | Media |
| **Frecuencia de uso** | Frecuente |
| **RN Relacionadas** | RN-001, RN-009 |
| **RNF Relacionados** | RNF-001, RNF-009 |
| **Notas / Observaciones** | Cada edición genera automáticamente una nueva versión en el historial, por lo que el usuario puede deshacer cualquier cambio hecho por la IA si no queda satisfecho. |

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

| Campo | Descripción |
|-------|-------------|
| FE-01 | Si la descripción es demasiado corta o ambigua: la IA solicita más detalles antes de generar el contrato. |
| FE-02 | Si la IA no está disponible: el sistema informa y redirige al usuario a la opción de usar plantillas predefinidas. |

| Campo | Descripción |
|-------|-------------|
| **Prioridad** | Alta |
| **Frecuencia de uso** | Frecuente |
| **RN Relacionadas** | RN-001, RN-008, RN-009 |
| **RNF Relacionados** | RNF-001, RNF-006, RNF-008, RNF-009 |
| **Notas / Observaciones** | Este caso de uso es el diferenciador principal de ContractAI: permite crear contratos legales completos sin conocimientos jurídicos, solo describiendo la situación en lenguaje cotidiano. |

---

## CU-10 — Gestionar roles de usuarios

| Campo | Descripción |
|-------|-------------|
| **ID** | CU-10 |
| **Nombre** | Gestionar roles de usuarios |
| **HU Relacionada** | HU-19 |
| **Actor(es)** | Administrador de plataforma |
| **Descripción** | El administrador asigna y modifica los roles de los usuarios de la plataforma, controlando los niveles de acceso a las funcionalidades del sistema. |
| **Precondiciones** | El usuario está autenticado con rol de Administrador de plataforma. |
| **Postcondiciones** | Los cambios de rol quedan aplicados inmediatamente para los usuarios afectados. |

**Flujo principal:**

| Paso | Actor | Acción |
|------|-------|--------|
| 1 | Administrador | Accede al panel de administración desde el menú. |
| 2 | Administrador | Busca al usuario cuyo rol desea cambiar por nombre o correo. |
| 3 | Administrador | Selecciona el nuevo rol: Freelancer, PYME o Administrador. |
| 4 | Sistema | Aplica el cambio de rol inmediatamente y ajusta los permisos del usuario. |
| 5 | Sistema | Registra la acción en el log de auditoría. |

**Flujos de excepción:**

| Campo | Descripción |
|-------|-------------|
| FE-01 | Si el administrador intenta eliminarse su propio rol de administrador: el sistema rechaza la acción con el mensaje "No puedes modificar tu propio rol". |

| Campo | Descripción |
|-------|-------------|
| **Prioridad** | Media |
| **Frecuencia de uso** | Ocasional |
| **RN Relacionadas** | RN-014 |
| **RNF Relacionados** | RNF-004, RNF-006 |
| **Notas / Observaciones** | Todas las acciones del administrador quedan registradas en un log de auditoría para trazabilidad. El administrador no puede modificar su propio rol (protección contra bloqueo accidental). |

---

---

## CU-11 — Ver dashboard de contratos

| Campo | Descripción |
|-------|-------------|
| **ID** | CU-11 |
| **Nombre** | Ver dashboard de contratos |
| **HU Relacionada** | HU-08 |
| **Actor(es)** | Freelancer, PYME |
| **Descripción** | El usuario visualiza un panel de control con estadísticas agregadas de sus contratos: totales, distribución por estado y nivel de riesgo promedio. |
| **Precondiciones** | Autenticado, tiene al menos un contrato. |
| **Postcondiciones** | Dashboard con estadísticas actualizadas visible. |

**Flujo principal:**

| Paso | Actor | Acción |
|------|-------|--------|
| 1 | Usuario | Accede al dashboard desde el menú. |
| 2 | Sistema | Consulta contratos y calcula estadísticas. |
| 3 | Sistema | Muestra: total, distribución por estado y riesgo promedio. |

**Flujos de excepción:**

| Campo | Descripción |
|-------|-------------|
| FE-01 | Sin contratos: "Aún no tienes contratos. ¡Crea el primero!" |

---

## CU-12 — Gestionar historial de versiones

| Campo | Descripción |
|-------|-------------|
| **ID** | CU-12 |
| **Nombre** | Gestionar historial de versiones |
| **HU Relacionada** | HU-13 |
| **Actor(es)** | Freelancer, PYME |
| **Descripción** | El usuario consulta el historial de cambios de un contrato y restaura versiones anteriores. |
| **Precondiciones** | Autenticado, contrato con mínimo 2 versiones. |
| **Postcondiciones** | Usuario puede previsualizar versión o restaurarla (crea nueva versión en historial). |

**Flujo principal:**

| Paso | Actor | Acción |
|------|-------|--------|
| 1 | Usuario | Abre contrato → "Ver historial". |
| 2 | Sistema | Lista versiones con número, fecha y autor. |
| 3 | Usuario | Selecciona versión. |
| 4 | Usuario | Confirma restauración. |
| 5 | Sistema | Crea nueva versión con el contenido anterior. |

**Flujos alternativos:**

| Campo | Descripción |
|-------|-------------|
| FA-01 | Solo previsualizar sin restaurar no genera cambios. |

**Flujos de excepción:**

| Campo | Descripción |
|-------|-------------|
| FE-01 | Si contrato está firmado, el sistema advierte antes de restaurar. |

---

## CU-13 — Registrar vigencia de contrato

| Campo | Descripción |
|-------|-------------|
| **ID** | CU-13 |
| **Nombre** | Registrar vigencia de contrato |
| **HU Relacionada** | HU-15 |
| **Actor(es)** | Freelancer, PYME |
| **Descripción** | El usuario registra fechas de inicio y vencimiento para gestionar la vigencia del contrato. |
| **Precondiciones** | Autenticado, contrato en estado borrador o activo. |
| **Postcondiciones** | Fechas guardadas, alertas automáticas programadas (RN-012). |

**Flujo principal:**

| Paso | Actor | Acción |
|------|-------|--------|
| 1 | Usuario | Abre contrato → sección de vigencia. |
| 2 | Usuario | Ingresa fechas de inicio y vencimiento. |
| 3 | Sistema | Valida que inicio < vencimiento. |
| 4 | Sistema | Guarda y programa alerta a 7 días del vencimiento. |

**Flujos de excepción:**

| Campo | Descripción |
|-------|-------------|
| FE-01 | Si vencimiento < inicio: error, no guarda. |
| FE-02 | Si vencimiento ya pasó: advierte y cambia estado a "vencido". |

---

## CU-14 — Buscar y filtrar contratos

| Campo | Descripción |
|-------|-------------|
| **ID** | CU-14 |
| **Nombre** | Buscar y filtrar contratos |
| **HU Relacionada** | HU-18 |
| **Actor(es)** | Freelancer, PYME |
| **Descripción** | El usuario busca y filtra contratos en su repositorio por nombre, fecha, tipo, clasificación o estado. |
| **Precondiciones** | Autenticado, al menos un contrato. |
| **Postcondiciones** | Lista filtrada mostrada. |

**Flujo principal:**

| Paso | Actor | Acción |
|------|-------|--------|
| 1 | Usuario | Accede al repositorio. |
| 2 | Usuario | Usa barra de búsqueda o filtros. |
| 3 | Sistema | Filtra en tiempo real. |
| 4 | Usuario | Selecciona el contrato deseado. |

**Flujos de excepción:**

| Campo | Descripción |
|-------|-------------|
| FE-01 | Sin resultados: "No se encontraron contratos con estos criterios" + opción limpiar filtros. |

---

## CU-15 — Administrar catálogo de plantillas

| Campo | Descripción |
|-------|-------------|
| **ID** | CU-15 |
| **Nombre** | Administrar catálogo de plantillas |
| **HU Relacionada** | HU-20 |
| **Actor(es)** | Administrador de plataforma |
| **Descripción** | El Administrador crea, edita, organiza y elimina plantillas del catálogo global. |
| **Precondiciones** | Autenticado con rol Administrador. |
| **Postcondiciones** | Catálogo actualizado y visible para todos los usuarios. |

**Flujo principal:**

| Paso | Actor | Acción |
|------|-------|--------|
| 1 | Administrador | Accede al módulo de plantillas. |
| 2 | Administrador | Elige acción (crear/editar/desactivar/eliminar). |
| 3 | Administrador | Completa campos (nombre, categoría, contenido base con marcadores {{campo}}). |
| 4 | Sistema | Valida y guarda. |
| 5 | Sistema | Actualiza catálogo en tiempo real. |

**Flujos de excepción:**

| Campo | Descripción |
|-------|-------------|
| FE-01 | Eliminar plantilla con contratos activos: advertencia con cantidad de contratos afectados. |
| FE-02 | Contenido base vacío: no permite guardar. |

| Campo | Descripción |
|-------|-------------|
| **RN Relacionadas** | RN-014 |

---

## CU-16 — Recuperar contraseña

| Campo | Descripción |
|-------|-------------|
| **ID** | CU-16 |
| **Nombre** | Recuperar contraseña |
| **HU Relacionada** | HU-16 |
| **Actor(es)** | Cualquier usuario registrado, Sistema de Correo Electrónico |
| **Descripción** | El usuario que olvidó su contraseña solicita un enlace temporal para establecer una nueva. |
| **Precondiciones** | Usuario con cuenta y correo registrado. |
| **Postcondiciones** | Nueva contraseña guardada, token invalidado. |

**Flujo principal:**

| Paso | Actor | Acción |
|------|-------|--------|
| 1 | Usuario | Clic en "¿Olvidaste tu contraseña?". |
| 2 | Usuario | Ingresa correo. |
| 3 | Sistema | Genera token único y lo almacena. |
| 4 | Sistema de correo | Envía enlace. |
| 5 | Usuario | Abre enlace e ingresa nueva contraseña. |
| 6 | Sistema | Valida RN-015, guarda cifrada y desactiva token. |

**Flujos alternativos:**

| Campo | Descripción |
|-------|-------------|
| FA-01 | Desde configuración con sesión activa, sin este flujo. |

**Flujos de excepción:**

| Campo | Descripción |
|-------|-------------|
| FE-01 | Correo no registrado: "Si el correo está registrado, recibirás el enlace en breve" (por seguridad, no confirma existencia). |
| FE-02 | Enlace expirado o usado: "Este enlace ya no es válido" + solicitar uno nuevo. |
| FE-03 | Fallo en correo: informar al usuario e invitar a reintentar. |

| Campo | Descripción |
|-------|-------------|
| **RN Relacionadas** | RN-010, RN-015 |

---

## CU-17 — Activar autenticación 2FA

| Campo | Descripción |
|-------|-------------|
| **ID** | CU-17 |
| **Nombre** | Activar autenticación 2FA |
| **HU Relacionada** | HU-22 |
| **Actor(es)** | Freelancer, PYME, Administrador |
| **Descripción** | El usuario activa o desactiva la autenticación de dos factores (2FA) en su cuenta. |
| **Precondiciones** | Usuario autenticado. |
| **Postcondiciones** | Estado de 2FA actualizado. Próximos inicios de sesión exigen o no código adicional. |

**Flujo principal:**

| Paso | Actor | Acción |
|------|-------|--------|
| 1 | Usuario | Accede a Configuración → Seguridad / 2FA. |
| 2 | Sistema | Muestra estado actual. |
| 3 | Sistema | Para activar: genera código QR para app autenticadora (TOTP). |
| 4 | Usuario | Escanea QR y confirma con primer código. |
| 5 | Sistema | Verifica, activa y guarda estado. |

**Flujos alternativos:**

| Campo | Descripción |
|-------|-------------|
| FA-01 | Para desactivar: confirma contraseña e ingresa código activo. Sistema desactiva. |

**Flujos de excepción:**

| Campo | Descripción |
|-------|-------------|
| FE-01 | Código de confirmación incorrecto: no activa, solicita reintentar. |

---

## CU-18 — Gestionar notificaciones automáticas

| Campo | Descripción |
|-------|-------------|
| **ID** | CU-18 |
| **Nombre** | Gestionar notificaciones automáticas |
| **HU Relacionada** | HU-14 |
| **Actor(es)** | Sistema (proceso interno), Sistema de Correo, Usuario (receptor) |
| **Descripción** | El sistema detecta eventos contractuales y genera notificaciones automáticas. |
| **Precondiciones** | Contratos activos en el sistema. Eventos disparadores configurados (RN-002, RN-012, firma completada). |
| **Postcondiciones** | Notificación almacenada en entidad Notificacion. Usuario notificado por correo y en plataforma. |

**Flujo principal:**

| Paso | Actor | Acción |
|------|-------|--------|
| 1 | Sistema | Detecta evento: (a) firma completada por contraparte, (b) contrato a 7 días de vencer, (c) riesgo IA > 70. |
| 2 | Sistema | Crea registro en Notificacion. |
| 3 | Sistema de correo | Envía aviso. |
| 4 | Sistema | Muestra notificación en panel de avisos. |
| 5 | Usuario | Lee y marca como leída. |

**Flujos de excepción:**

| Campo | Descripción |
|-------|-------------|
| FE-01 | Si falla el correo: reintenta 3 veces. Notificación en plataforma disponible independientemente. |

| Campo | Descripción |
|-------|-------------|
| **RN Relacionadas** | RN-002, RN-012 |

---

## CU-19 — Descargar contrato en PDF

| Campo | Descripción |
|-------|-------------|
| **ID** | CU-19 |
| **Nombre** | Descargar contrato en PDF |
| **HU Relacionada** | HU-10 |
| **Actor(es)** | Freelancer, PYME |
| **Descripción** | El usuario descarga una copia del contrato en formato PDF para imprimirla o compartirla fuera de la plataforma. |
| **Precondiciones** | El usuario está autenticado y tiene abierto un contrato guardado. |
| **Postcondiciones** | El archivo PDF se descarga al dispositivo del usuario con el contenido actual del contrato. |

**Flujo principal:**

| Paso | Actor | Acción |
|------|-------|--------|
| 1 | Usuario | Abre el contrato que desea descargar. |
| 2 | Usuario | Hace clic en "Descargar PDF". |
| 3 | Sistema | Genera el documento PDF con el contenido actual del contrato y los datos de las partes. |
| 4 | Sistema | Inicia la descarga automática del archivo en el navegador del usuario. |

**Flujos de excepción:**

| Campo | Descripción |
|-------|-------------|
| FE-01 | Si el contrato tiene contenido vacío o incompleto: el sistema advierte al usuario antes de generar el PDF. |
| FE-02 | Si falla la generación del PDF: el sistema muestra un mensaje de error y sugiere intentarlo de nuevo. |

| Campo | Descripción |
|-------|-------------|
| **Prioridad** | Alta |
| **Frecuencia de uso** | Frecuente |
| **RN Relacionadas** | RN-001 |
| **RNF Relacionados** | RNF-001, RNF-008 |
| **Notas / Observaciones** | El PDF generado incluye el contenido del contrato con formato profesional. Si el contrato está firmado, el PDF incluye también la constancia de firma con sello UTC, IP y hash SHA-256. |

---

> **Total: 19 casos de uso**
