# Reglas de Negocio — ContractAI

Las reglas de negocio son **políticas y restricciones** que el sistema debe respetar siempre, independientemente de quién lo use. Definen los límites del comportamiento del sistema desde el punto de vista organizacional, legal u operativo.

**Proyecto:** ContractAI | **Empresa:** NexaOps  
**Docente:** Gloria Amparo Lora Patiño | **Uniremington · 2026**

> **Formato:** SI [condición que se cumple] → ENTONCES [lo que el sistema debe hacer o impedir]

---

## RN-001 — Acceso privado a contratos

| Campo | Descripción |
|-------|-------------|
| **ID** | RN-001 |
| **Título** | Acceso privado a contratos |
| **Descripción** | **SI** el usuario no ha iniciado sesión en la plataforma, **ENTONCES** el sistema no debe permitirle generar, guardar, editar ni consultar ningún contrato. Todos los contratos son privados por defecto. |
| **Origen** | HU-21, HU-03 — Política de privacidad de la plataforma |

---

## RN-002 — Alerta por riesgo alto

| Campo | Descripción |
|-------|-------------|
| **ID** | RN-002 |
| **Título** | Alerta por nivel de riesgo alto |
| **Descripción** | **SI** el análisis de inteligencia artificial asigna al contrato un puntaje de riesgo superior a 70 sobre 100, **ENTONCES** el sistema debe mostrar una advertencia visual destacada al usuario antes de que pueda guardarlo o firmarlo, indicando que el contrato tiene cláusulas potencialmente perjudiciales. |
| **Origen** | HU-02 — Política de protección al usuario |

---

## RN-003 — Confirmación para eliminar contratos firmados

| Campo | Descripción |
|-------|-------------|
| **ID** | RN-003 |
| **Título** | Confirmación obligatoria para eliminar contratos firmados |
| **Descripción** | **SI** el usuario intenta eliminar un contrato que ya fue firmado digitalmente, **ENTONCES** el sistema debe solicitar una confirmación explícita (escribir "ELIMINAR" o hacer doble confirmación) antes de proceder, ya que este es un documento con validez legal. |
| **Origen** | HU-05, HU-03 — Prevención de pérdida de documentos legales |

---

## RN-004 — Confirmación para eliminar firmas guardadas

| Campo | Descripción |
|-------|-------------|
| **ID** | RN-004 |
| **Título** | Confirmación para eliminar firmas de la biblioteca |
| **Descripción** | **SI** el usuario intenta eliminar una firma guardada en su biblioteca personal, **ENTONCES** el sistema debe pedir confirmación antes de borrarla definitivamente, ya que la firma podría estar siendo usada en contratos existentes. |
| **Origen** | HU-06 |

---

## RN-005 — Contratos compartidos en modo solo lectura

| Campo | Descripción |
|-------|-------------|
| **ID** | RN-005 |
| **Título** | Enlace compartido en modo solo lectura |
| **Descripción** | **SI** un contrato es compartido mediante un enlace generado por la plataforma, **ENTONCES** cualquier persona que acceda al enlace solo podrá ver y firmar el contrato, pero no podrá editar ni descargar el documento original. El propietario mantiene el control exclusivo de edición. |
| **Origen** | HU-07 |

---

## RN-006 — Correo electrónico único por cuenta

| Campo | Descripción |
|-------|-------------|
| **ID** | RN-006 |
| **Título** | Correo electrónico único por cuenta |
| **Descripción** | **SI** un usuario intenta registrarse con un correo electrónico que ya existe en el sistema, **ENTONCES** el sistema debe rechazar el registro e informar al usuario que ese correo ya está asociado a una cuenta, ofreciendo la opción de recuperar su contraseña. |
| **Origen** | HU-04 |

---

## RN-007 — Cláusulas de riesgo siempre visibles

| Campo | Descripción |
|-------|-------------|
| **ID** | RN-007 |
| **Título** | Cláusulas de riesgo siempre destacadas |
| **Descripción** | **SI** el análisis de IA detecta cláusulas peligrosas o desfavorables en un contrato, **ENTONCES** estas deben mostrarse siempre resaltadas visualmente (por ejemplo, en rojo para alto riesgo, amarillo para medio) con su nivel de riesgo, descripción del problema y sugerencia de mejora. No pueden ocultarse. |
| **Origen** | HU-02 — Principio de transparencia hacia el usuario |

---

## RN-008 — Límite de caracteres para el análisis de riesgo

| Campo | Descripción |
|-------|-------------|
| **ID** | RN-008 |
| **Título** | Límite de tamaño para análisis de contratos |
| **Descripción** | **SI** el texto del contrato a analizar supera los **50.000 caracteres** (equivalente a aproximadamente 7.000 palabras), **ENTONCES** el sistema debe rechazar el análisis, informar al usuario del límite y sugerirle dividir el documento o reducir su extensión antes de volver a intentarlo. |
| **Origen** | Restricción técnica del motor de IA |

---

## RN-009 — Respaldo local cuando la IA no está disponible

| Campo | Descripción |
|-------|-------------|
| **ID** | RN-009 |
| **Título** | Modo de respaldo sin conexión a la IA |
| **Descripción** | **SI** el servicio de inteligencia artificial no está disponible en ese momento (por falla o mantenimiento), **ENTONCES** el sistema debe continuar funcionando usando las plantillas locales predefinidas para la generación de contratos, y notificar claramente al usuario que la IA no está disponible y que el documento fue generado con la plantilla base. |
| **Origen** | Política de continuidad del servicio |

---

## RN-010 — Enlace de recuperación de contraseña de un solo uso

| Campo | Descripción |
|-------|-------------|
| **ID** | RN-010 |
| **Título** | Enlace de recuperación temporal y de un solo uso |
| **Descripción** | **SI** un usuario solicita recuperar su contraseña, **ENTONCES** el sistema debe enviar un enlace único a su correo registrado que expire en 24 horas y que solo pueda usarse una vez. Después de usarlo o de que expire, el enlace debe quedar inválido automáticamente. |
| **Origen** | HU-16 — Política de seguridad de acceso |

---

## RN-011 — Restricción de contratos internos

| Campo | Descripción |
|-------|-------------|
| **ID** | RN-011 |
| **Título** | Compartir contratos internos solo entre mismo dominio |
| **Descripción** | **SI** un contrato es clasificado como **interno**, **ENTONCES** el sistema solo debe permitir compartirlo y firmarlo con usuarios que tengan el mismo dominio de correo organizacional (por ejemplo, si el contrato es creado por alguien de `@empresa.com`, solo puede firmarlo otro `@empresa.com`). |
| **Origen** | HU-11 — Política de confidencialidad organizacional |

---

## RN-012 — Alerta automática de vencimiento próximo

| Campo | Descripción |
|-------|-------------|
| **ID** | RN-012 |
| **Título** | Notificación automática antes del vencimiento |
| **Descripción** | **SI** la fecha de vencimiento de un contrato activo está a 7 días o menos, **ENTONCES** el sistema debe enviar automáticamente una notificación de alerta al usuario propietario del contrato, indicando el nombre del contrato y la fecha exacta de vencimiento. |
| **Origen** | HU-14, HU-15 |

---

## RN-013 — Registro inmutable de firma digital

| Campo | Descripción |
|-------|-------------|
| **ID** | RN-013 |
| **Título** | Constancia de firma no modificable |
| **Descripción** | **SI** un contrato es firmado digitalmente, **ENTONCES** el sistema debe registrar de forma permanente e inmutable: la hora exacta del firmado (sello UTC), la dirección IP del firmante y el hash SHA-256 del documento (huella digital única del archivo). Esta información no puede editarse ni eliminarse después del firmado. |
| **Origen** | HU-17 — Validez probatoria legal |

---

## RN-014 — Acciones exclusivas del Administrador

| Campo | Descripción |
|-------|-------------|
| **ID** | RN-014 |
| **Título** | Funciones exclusivas del rol Administrador |
| **Descripción** | **SI** un usuario tiene rol de **Administrador de plataforma**, **ENTONCES** puede gestionar plantillas del sistema, acceder a estadísticas globales y modificar roles de otros usuarios. **SI** un usuario tiene rol de Freelancer o PYME, **ENTONCES** el sistema debe impedir que realice cualquiera de estas acciones, sin importar cómo intente acceder a ellas. |
| **Origen** | HU-19, HU-20 — Política de control de acceso |

---

> **Total: 14 reglas de negocio**
