# Reglas de Negocio — ContractAI

Las reglas de negocio son **políticas y restricciones** que el sistema debe respetar siempre, independientemente de quién lo use. Definen los límites del comportamiento del sistema desde el punto de vista organizacional, legal u operativo.

**Proyecto:** ContractAI | **Empresa:** NexaOps  
**Docente:** Gloria Amparo Lora Patiño | **Uniremington · 2026**  
**Integrantes:** Juan Fernando Martínez Aguirre · Maddox Lasciche

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
| **Descripción** | **SI** el análisis de inteligencia artificial asigna al contrato un `/puntaje_riesgo` superior a 70 sobre 100, **ENTONCES** el sistema debe mostrar una advertencia visual destacada al usuario antes de que pueda guardarlo o firmarlo, indicando que el contrato tiene cláusulas potencialmente perjudiciales. |
| **Origen** | HU-02 — Política de protección al usuario |

---

## RN-003 — Confirmación para eliminar contratos firmados

| Campo | Descripción |
|-------|-------------|
| **ID** | RN-003 |
| **Título** | Confirmación obligatoria para eliminar contratos firmados |
| **Descripción** | **SI** el usuario intenta eliminar un contrato que ya fue firmado digitalmente (tiene registros en ConstanciaFirma), **ENTONCES** el sistema debe rechazar la operación porque la FK ON DELETE RESTRICT lo impide, e informar al usuario que el contrato posee constancias de firma con valor probatorio. |
| **Origen** | HU-05, HU-03 — Prevención de pérdida de documentos legales |

---

## RN-004 — Confirmación para eliminar firmas guardadas

| Campo | Descripción |
|-------|-------------|
| **ID** | RN-004 |
| **Título** | Confirmación para eliminar firmas de la biblioteca |
| **Descripción** | **SI** el usuario intenta eliminar una firma guardada en su biblioteca personal, **ENTONCES** el sistema debe pedir confirmación antes de proceder; si la firma tiene ConstanciaFirma asociada, la FK RESTRICT impide la eliminación y el sistema debe informarlo. |
| **Origen** | HU-06 |

---

## RN-005 — Enlace compartido con estado y expiración

| Campo | Descripción |
|-------|-------------|
| **ID** | RN-005 |
| **Título** | Enlace compartido válido solo si activo y no vencido |
| **Descripción** | **SI** alguien intenta acceder a un contrato por enlace, **ENTONCES** el sistema debe verificar que `EnlaceCompartir.estado = 'activo'` y `fecha_expiracion > NOW()`. Si el enlace está revocado o vencido, el acceso debe denegarse. El propietario puede revocar el enlace en cualquier momento cambiando el estado a `'revocado'`. |
| **Origen** | HU-07 |

---

## RN-006 — Correo electrónico único por cuenta

| Campo | Descripción |
|-------|-------------|
| **ID** | RN-006 |
| **Título** | Correo electrónico único por cuenta |
| **Descripción** | **SI** un usuario intenta registrarse con un correo electrónico que ya existe en el sistema (restricción UNIQUE en Usuario.correo), **ENTONCES** el sistema debe rechazar el registro e informar al usuario que ese correo ya está asociado a una cuenta, ofreciendo la opción de recuperar su contraseña. |
| **Origen** | HU-04 |

---

## RN-007 — Cláusulas de riesgo siempre visibles

| Campo | Descripción |
|-------|-------------|
| **ID** | RN-007 |
| **Título** | Cláusulas de riesgo siempre destacadas |
| **Descripción** | **SI** el análisis de IA detecta cláusulas problemáticas en un contrato, **ENTONCES** estas deben mostrarse siempre resaltadas visualmente (rojo para alto riesgo, amarillo para medio) con su nivel de riesgo, descripción del problema y sugerencia de mejora. No pueden ocultarse. |
| **Origen** | HU-02 — Principio de transparencia hacia el usuario |

---

## RN-008 — Límite de caracteres para el análisis de riesgo

| Campo | Descripción |
|-------|-------------|
| **ID** | RN-008 |
| **Título** | Límite de tamaño para análisis de contratos |
| **Descripción** | **SI** el texto del contrato a analizar supera los **50.000 caracteres** (aprox. 7.000 palabras), **ENTONCES** el sistema debe rechazar el análisis, informar al usuario del límite y sugerirle reducir la extensión antes de reintentar. |
| **Origen** | Restricción técnica del motor de IA |

---

## RN-009 — Respaldo local cuando la IA no está disponible

| Campo | Descripción |
|-------|-------------|
| **ID** | RN-009 |
| **Título** | Modo de respaldo sin conexión a la IA |
| **Descripción** | **SI** el servicio de inteligencia artificial no está disponible, **ENTONCES** el sistema debe continuar funcionando usando las plantillas locales predefinidas y notificar claramente al usuario que la IA no está disponible. |
| **Origen** | Política de continuidad del servicio |

---

## RN-010 — Enlace de recuperación de contraseña de un solo uso

| Campo | Descripción |
|-------|-------------|
| **ID** | RN-010 |
| **Título** | Enlace de recuperación temporal y de un solo uso |
| **Descripción** | **SI** un usuario solicita recuperar su contraseña, **ENTONCES** el sistema debe enviar un enlace único a su correo registrado que expire en 24 horas (`fecha_expiracion = fecha_creacion + 24h`) y que solo pueda usarse una vez (`usado = true` al usarlo). Después de usarlo o de que expire, el enlace queda inválido automáticamente. |
| **Origen** | HU-16 — Política de seguridad de acceso |

---

## RN-011 — Restricción de contratos internos

| Campo | Descripción |
|-------|-------------|
| **ID** | RN-011 |
| **Título** | Compartir contratos internos solo entre mismo dominio |
| **Descripción** | **SI** un contrato tiene `clasificacion = 'interno'`, **ENTONCES** el sistema solo debe permitir compartirlo y firmarlo con usuarios que tengan el mismo dominio de correo organizacional. |
| **Origen** | HU-11 — Política de confidencialidad organizacional |

---

## RN-012 — Alerta automática de vencimiento próximo

| Campo | Descripción |
|-------|-------------|
| **ID** | RN-012 |
| **Título** | Notificación automática antes del vencimiento |
| **Descripción** | **SI** la `fecha_vencimiento` de un contrato activo está a 7 días o menos de `NOW()`, **ENTONCES** el sistema debe enviar automáticamente una notificación al usuario propietario indicando el nombre del contrato y la fecha exacta de vencimiento. |
| **Origen** | HU-14, HU-15 |

---

## RN-013 — Registro inmutable de firma digital

| Campo | Descripción |
|-------|-------------|
| **ID** | RN-013 |
| **Título** | Constancia de firma no modificable |
| **Descripción** | **SI** un contrato es firmado digitalmente, **ENTONCES** el sistema debe registrar de forma permanente e inmutable en ConstanciaFirma: sello de tiempo UTC, IP del firmante y hash SHA-256 del documento. Las FK ON DELETE RESTRICT impiden eliminar el contrato o la firma asociada. Esta información no puede editarse ni eliminarse. |
| **Origen** | HU-17 — Validez probatoria legal |

---

## RN-014 — Acciones exclusivas del Administrador

| Campo | Descripción |
|-------|-------------|
| **ID** | RN-014 |
| **Título** | Funciones exclusivas del rol Administrador |
| **Descripción** | **SI** un usuario tiene `rol = 'administrador'` (catálogo Rol), **ENTONCES** puede gestionar plantillas del sistema, acceder a estadísticas globales, modificar roles de otros usuarios e inactivar cuentas. **SI** un usuario tiene rol de Freelancer o PYME, **ENTONCES** el sistema debe impedir estas acciones. |
| **Origen** | HU-19, HU-20, HU-24 — Política de control de acceso |

---

## RN-015 — Requisitos mínimos de contraseña

| Campo | Descripción |
|-------|-------------|
| **ID** | RN-015 |
| **Título** | Requisitos mínimos de contraseña |
| **Descripción** | **SI** un usuario crea o cambia su contraseña, **ENTONCES** debe tener mínimo 8 caracteres, al menos una letra mayúscula y al menos un número. Contraseñas que no cumplan estos criterios serán rechazadas. |
| **Origen** | HU-04, RF-001 |

---

## RN-016 — Bloqueo temporal por intentos fallidos

| Campo | Descripción |
|-------|-------------|
| **ID** | RN-016 |
| **Título** | Bloqueo temporal por intentos fallidos |
| **Descripción** | **SI** un usuario realiza 5 intentos de inicio de sesión fallidos consecutivos, **ENTONCES** el sistema bloqueará el acceso a esa cuenta por 15 minutos e informará al usuario del bloqueo y su duración. |
| **Origen** | HU-21, RF-002 |

---

## Reglas de Integridad del Modelo (3FN)

Las siguientes reglas se derivan directamente del análisis de Tercera Forma Normal realizado sobre el diccionario de datos. Algunas se implementan como restricciones en base de datos (CHECK, FK); otras en la capa de aplicación.

---

## RN-3FN-01 — XOR de Firma

| Campo | Descripción |
|-------|-------------|
| **ID** | RN-3FN-01 |
| **Título** | XOR de Firma: usuario registrado o firmante externo, nunca ambos |
| **Descripción** | **SI** se inserta o actualiza un registro en Firma, **ENTONCES** exactamente uno de `id_usuario` o `id_firmante` debe ser NOT NULL. Tener ambos NULL o ambos NOT NULL es un error de integridad. Implementada como restricción CHECK en la tabla Firma. |
| **Origen** | Análisis 3FN — entidades Firma, FirmanteExterno |

---

## RN-3FN-02 — Fórmula del puntaje de riesgo

| Campo | Descripción |
|-------|-------------|
| **ID** | RN-3FN-02 |
| **Título** | Cálculo del atributo derivado /puntaje_riesgo |
| **Descripción** | El campo `/puntaje_riesgo` de Contrato es un atributo derivado (caché). Su valor = `ROUND(SUM(peso_riesgo) / COUNT(*)) * 20` sobre los registros de AnalisisRiesgo de la versión vigente. El resultado siempre está entre 0 y 100 (CHECK). Se recalcula al finalizar cada análisis sobre la versión vigente; análisis de versiones anteriores no lo modifican. |
| **Origen** | Análisis 3FN — entidades Contrato, AnalisisRiesgo |

---

## RN-3FN-03 — Estado 'firmado' del contrato

| Campo | Descripción |
|-------|-------------|
| **ID** | RN-3FN-03 |
| **Título** | Transición a estado 'firmado' |
| **Descripción** | **SI** todos los registros de FirmaSolicitada asociados a un contrato tienen `estado = 'firmado'`, **ENTONCES** la capa de aplicación debe actualizar `Contrato.estado = 'firmado'`. Esta transición no ocurre automáticamente en la base de datos; es responsabilidad del servicio de firma. |
| **Origen** | Análisis 3FN — entidad FirmaSolicitada |

---

## RN-3FN-04 — Validez del enlace compartido

| Campo | Descripción |
|-------|-------------|
| **ID** | RN-3FN-04 |
| **Título** | Enlace válido solo si activo y no vencido |
| **Descripción** | Un EnlaceCompartir otorga acceso únicamente si `estado = 'activo'` AND `fecha_expiracion > NOW()`. Un token correcto en un enlace revocado o vencido no debe otorgar acceso. La validación debe hacerse en cada petición, no solo al generar el enlace. |
| **Origen** | Análisis 3FN — entidad EnlaceCompartir |

---

## RN-3FN-05 — Vencimiento automático de contratos

| Campo | Descripción |
|-------|-------------|
| **ID** | RN-3FN-05 |
| **Título** | Estado 'vencido' actualizado por proceso programado |
| **Descripción** | El estado `'vencido'` de Contrato lo actualiza un proceso programado (job) que compara `fecha_vencimiento < NOW()` sobre contratos en estado `'activo'`. No se actualiza en tiempo real al momento de la consulta. |
| **Origen** | Análisis 3FN — entidad Contrato |

---

## RN-3FN-06 — Inmutabilidad de ConstanciaFirma

| Campo | Descripción |
|-------|-------------|
| **ID** | RN-3FN-06 |
| **Título** | ConstanciaFirma no puede eliminarse |
| **Descripción** | Las FK `id_contrato` e `id_firma` de ConstanciaFirma tienen ON DELETE RESTRICT. No es posible eliminar un Contrato ni una Firma que tengan constancias asociadas. Esta restricción garantiza la inmutabilidad del registro probatorio legal. |
| **Origen** | Análisis 3FN — entidad ConstanciaFirma |

---

## RN-3FN-07 — Inactivación de Firma

| Campo | Descripción |
|-------|-------------|
| **ID** | RN-3FN-07 |
| **Título** | Restricción para inactivar firmas de biblioteca |
| **Descripción** | La operación `inactivarFirma()` solo está permitida sobre firmas con `en_biblioteca = TRUE` que no tengan ningún registro de ConstanciaFirma asociado. Si existe una constancia, la FK RESTRICT impide la eliminación y la inactivación lógica tampoco debe permitirse. |
| **Origen** | Análisis 3FN — entidad Firma |

---

## RN-3FN-08 — Restricción de rol en Plantilla

| Campo | Descripción |
|-------|-------------|
| **ID** | RN-3FN-08 |
| **Título** | Plantilla.id_admin debe referenciar un administrador |
| **Descripción** | `Plantilla.id_admin` debe referenciar un Usuario con `rol = 'administrador'`. La FK no puede validar esta condición por sí sola. La restricción se implementa en un único punto: un trigger BEFORE INSERT / BEFORE UPDATE en la tabla Plantilla que rechaza la operación si el usuario referenciado no tiene rol de administrador. No debe repetirse en los controladores. |
| **Origen** | Análisis 3FN — entidades Plantilla, Usuario, Rol |

---

## RN-3FN-09 — Referencia polimórfica en LogAuditoria

| Campo | Descripción |
|-------|-------------|
| **ID** | RN-3FN-09 |
| **Título** | Referencia polimórfica: entidad_afectada + id_registro_afectado |
| **Descripción** | `LogAuditoria.id_registro_afectado` no es una FK formal. El campo `entidad_afectada` indica la tabla (contratos, usuarios, plantillas, enlaces) y `id_registro_afectado` contiene el UUID del registro afectado. No se declara FK para soportar referencias a cualquier tabla sin romper la integridad referencial. |
| **Origen** | Análisis 3FN — entidad LogAuditoria |

---

## RN-3FN-10 — Caché de puntaje_riesgo solo de la versión vigente

| Campo | Descripción |
|-------|-------------|
| **ID** | RN-3FN-10 |
| **Título** | /puntaje_riesgo refleja solo la versión vigente |
| **Descripción** | El caché `/puntaje_riesgo` en Contrato se recalcula únicamente al finalizar un AnalisisRiesgo sobre la versión vigente del contrato. Los análisis ligados a versiones anteriores (referenciados por `id_version` anterior) no modifican el caché, porque ya no representan el estado actual del documento. |
| **Origen** | Análisis 3FN — entidades Contrato, AnalisisRiesgo, VersionContrato |

---

> **Total: 16 reglas de negocio + 10 reglas de integridad del modelo (3FN)**
