# Requisitos Funcionales

| ID | Nombre | Descripción |
|----|--------|-------------|
| RF-001 | Registro de usuarios | El sistema debe permitir registrar nuevos usuarios con nombre, correo electrónico y contraseña. |
| RF-002 | Autenticación de usuarios | El sistema debe autenticar a los usuarios mediante correo y contraseña, manteniendo una sesión activa. |
| RF-003 | Generación por plantilla | El sistema debe permitir generar contratos a partir de 8 plantillas predefinidas: servicios, NDA, empleo, sociedad, arrendamiento, compraventa, términos y condiciones, y política de privacidad. |
| RF-004 | Personalización del contrato | El sistema debe permitir personalizar los datos del contrato (partes, objeto, valor, duración, ciudad, fecha) mediante un formulario por pasos. |
| RF-005 | Análisis de riesgo | El sistema debe analizar el texto de un contrato y calcular un puntaje de riesgo numérico de 0 a 100. |
| RF-006 | Identificación de cláusulas | El sistema debe identificar y mostrar las cláusulas de riesgo encontradas, indicando nivel, título, descripción, cita textual y sugerencia. |
| RF-007 | Gestión de contratos | El sistema debe permitir guardar, editar y eliminar contratos asociados al usuario autenticado. |
| RF-008 | Firma digital | El sistema debe permitir al usuario dibujar una firma digital y agregarla al contrato. |
| RF-009 | Biblioteca de firmas | El sistema debe permitir guardar firmas en una biblioteca personal reutilizable y eliminarlas. |
| RF-010 | Compartir por enlace | El sistema debe generar un enlace único para compartir un contrato con terceros en modo lectura. |
| RF-011 | Descarga en PDF | El sistema debe permitir descargar cualquier contrato en formato PDF. |
| RF-012 | Dashboard de estadísticas | El sistema debe mostrar un dashboard con el total de contratos, riesgo promedio y los últimos contratos creados. |
| RF-013 | Edición por lenguaje natural | El sistema debe permitir modificar un contrato existente enviando una instrucción en lenguaje natural a la IA. |
| RF-014 | Asistente IA | El sistema debe permitir consultar al asistente IA preguntas sobre un contrato cargado. |
| RF-015 | Clasificación interna/externa | El sistema debe permitir al usuario clasificar un contrato como interno o externo al momento de crearlo o editarlo. |
| RF-016 | Generación desde descripción libre | El sistema debe permitir generar un contrato completo a partir de una descripción libre en lenguaje natural, sin usar plantilla predefinida. |
| RF-017 | Versionamiento | El sistema debe guardar automáticamente una nueva versión del contrato cada vez que sea editado y permitir al usuario consultar y restaurar versiones anteriores. |
| RF-018 | Notificaciones | El sistema debe enviar notificaciones al usuario cuando la contraparte firme, cuando el contrato esté a 7 días o menos de vencer, y cuando el análisis detecte riesgo alto. |
| RF-019 | Gestión de vencimientos | El sistema debe permitir registrar fechas de inicio y vencimiento para cada contrato y generar alertas automáticas antes de su expiración. |
| RF-020 | Recuperación de contraseña y 2FA | El sistema debe permitir recuperar la contraseña mediante un enlace temporal enviado al correo y ofrecer activación de autenticación de dos factores (2FA). |
| RF-021 | Constancia de firma | El sistema debe generar una constancia de firma que incluya sello de tiempo UTC, dirección IP del firmante y hash SHA-256 del documento. |
| RF-022 | Búsqueda y filtrado | El sistema debe permitir buscar y filtrar contratos del repositorio personal por nombre, fecha de creación, tipo y estado. |
| RF-023 | Gestión de roles | El sistema debe distinguir tres roles (Freelancer, PYME, Administrador de plataforma) con permisos y vistas diferenciadas. |
| RF-024 | Administración de plantillas | El sistema debe permitir al Administrador de plataforma crear, editar, eliminar y categorizar las plantillas disponibles para todos los usuarios. |
