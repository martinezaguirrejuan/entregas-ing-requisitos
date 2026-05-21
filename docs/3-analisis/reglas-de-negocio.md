# Reglas de Negocio

| ID | SI… (condición) | ENTONCES… (acción / restricción) |
|----|-----------------|----------------------------------|
| RN-001 | el usuario no ha iniciado sesión | no puede generar, guardar ni acceder a sus contratos |
| RN-002 | el puntaje de riesgo de un contrato es mayor a 70 | el sistema debe alertar visualmente al usuario antes de guardar |
| RN-003 | el usuario intenta eliminar un contrato firmado | el sistema debe solicitar confirmación explícita |
| RN-004 | el usuario intenta eliminar una firma guardada | el sistema debe pedir confirmación antes de borrarla |
| RN-005 | un contrato es compartido mediante enlace | cualquier persona con el enlace puede verlo en modo lectura, sin poder editarlo |
| RN-006 | un correo electrónico ya está registrado | el sistema debe rechazar el nuevo registro y notificar el conflicto |
| RN-007 | el análisis de riesgo detecta cláusulas peligrosas | estas deben mostrarse resaltadas con su nivel de riesgo y sugerencia de mejora |
| RN-008 | el contenido del contrato a analizar supera los 50.000 caracteres | el sistema debe rechazar el análisis e informar el límite |
| RN-009 | la API de IA no está disponible | el sistema debe usar las plantillas locales como respaldo y notificar al usuario |
| RN-010 | un usuario desea recuperar su contraseña | debe solicitarlo por correo y recibir un enlace temporal único |
| RN-011 | el contrato es clasificado como interno | solo podrá ser compartido y firmado por usuarios del mismo dominio de correo organizacional |
| RN-012 | la fecha de vencimiento de un contrato es menor o igual a 7 días | el sistema debe enviar automáticamente una notificación de alerta al usuario propietario |
| RN-013 | un contrato es firmado digitalmente | el sistema debe registrar de forma inmutable el sello de tiempo UTC, la IP del firmante y el hash SHA-256 del documento |
| RN-014 | el usuario tiene rol de Administrador de plataforma | puede gestionar plantillas del sistema, acceder a estadísticas globales y administrar roles; ningún otro rol puede realizar estas acciones |
