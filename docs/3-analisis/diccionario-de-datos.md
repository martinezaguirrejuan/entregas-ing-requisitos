# Diccionario de Datos — ContractAI

El diccionario describe cada **entidad del sistema** (las "cosas" que el sistema guarda en la base de datos), sus atributos, el tipo de dato, las restricciones de integridad y la regla de negocio que los rige. Este documento refleja el modelo en **Tercera Forma Normal (3FN)** aplicado durante el semestre.

**Proyecto:** ContractAI | **Empresa:** NexaOps  
**Docente:** Gloria Amparo Lora Patiño | **Uniremington · 2026**  
**Integrantes:** Juan Fernando Martínez Aguirre · Maddox Lasciche

> **Glosario rápido de tipos de datos:**
> - **UUID**: código único generado automáticamente (`a3f9-12bc-...`)
> - **VARCHAR(n)**: texto de longitud variable, máximo n caracteres
> - **CHAR(n)**: texto de longitud fija exacta de n caracteres
> - **TEXT**: texto largo sin límite fijo
> - **ENUM(...)**: lista cerrada de valores; el sistema rechaza cualquier otro valor
> - **BOOLEAN**: solo `true` o `false`
> - **DATETIME**: fecha y hora completa (`2026-05-21 14:35:00`)
> - **DATE**: solo fecha sin hora (`2026-06-30`)
> - **INT**: número entero
> - **TINYINT UNSIGNED**: entero pequeño sin signo (0–255)
> - **VARCHAR(45)**: usado para direcciones IP (soporta IPv4 e IPv6)

**Total de entidades: 17** (9 originales + 3 primera corrección: Rol, TipoContrato, InteraccionIA + 3 segunda corrección: FirmanteExterno, EnlaceCompartir, LogAuditoria + 2 tercera corrección: FirmaSolicitada, AccesoEnlace)

---

## Entidad: Rol

Catálogo extraído del campo `Usuario.rol` durante el análisis de 3FN. Antes era un ENUM embebido en Usuario; se separó para permitir descripciones y facilitar la extensión del sistema sin modificar la tabla principal.

| Atributo | Tipo | Long. | Restricciones | Valor por defecto | Índices | Descripción |
|----------|------|-------|---------------|-------------------|---------|-------------|
| `id_rol` | UUID | — | PK | — | PK (auto) | Identificador único del rol. |
| `nombre_rol` | VARCHAR | 30 | UNIQUE, NOT NULL | — | UNIQUE | Nombre del rol: `freelancer`, `pyme` o `administrador`. |
| `descripcion` | VARCHAR | 255 | NOT NULL | — | — | Qué puede hacer un usuario con este rol en la plataforma. |
| `fecha_creacion` | DATETIME | — | NOT NULL | CURRENT_TIMESTAMP | — | Fecha de creación del rol en el catálogo. |

---

## Entidad: Usuario

Representa a cada persona registrada en la plataforma.

| Atributo | Tipo | Long. | Restricciones | Valor por defecto | Índices | Descripción |
|----------|------|-------|---------------|-------------------|---------|-------------|
| `id_usuario` | UUID | — | PK | — | PK (auto) | Identificador único del usuario. |
| `nombre` | VARCHAR | 100 | NOT NULL | — | — | Nombre completo del usuario. |
| `correo` | VARCHAR | 150 | UNIQUE, NOT NULL | — | UNIQUE | Correo electrónico, usado para iniciar sesión. Si ya existe, el registro es rechazado (RN-006). |
| `contrasena_hash` | VARCHAR | 255 | NOT NULL | — | — | Hash de la contraseña; nunca se guarda en texto plano (bcrypt). |
| `id_rol` | UUID | — | FK → Rol.id_rol, NOT NULL, ON DELETE RESTRICT ON UPDATE CASCADE | — | idx_usuario_rol | Rol asignado al usuario (catálogo Rol). Reemplaza el ENUM anterior. |
| `activo` | BOOLEAN | — | NOT NULL | TRUE | — | Indica si la cuenta está activa. `false` = cuenta suspendida. |
| `mfa_activado` | BOOLEAN | — | NOT NULL | FALSE | — | Indica si el usuario activó la verificación en dos pasos. Renombrado de `2fa_activado` (un identificador SQL no puede comenzar por dígito). |
| `fecha_registro` | DATETIME | — | NOT NULL | CURRENT_TIMESTAMP | — | Fecha de creación de la cuenta. Se registra automáticamente. |

---

## Entidad: TipoContrato

Catálogo extraído del campo `Contrato.tipo` durante el análisis de 3FN. Solo `tipo` fue extraído porque tiene muchos valores con potencial de crecimiento (RF-003); `clasificacion` y `estado` permanecen como ENUM por ser estados simples de ciclo de vida.

| Atributo | Tipo | Long. | Restricciones | Valor por defecto | Índices | Descripción |
|----------|------|-------|---------------|-------------------|---------|-------------|
| `id_tipo_contrato` | UUID | — | PK | — | PK (auto) | Identificador único del tipo de contrato. |
| `nombre_tipo` | VARCHAR | 50 | UNIQUE, NOT NULL | — | UNIQUE | Nombre del tipo: servicios, NDA, laboral, sociedad, arrendamiento, compraventa, términos, privacidad, entre otros (RF-003). |
| `descripcion` | VARCHAR | 255 | NOT NULL | — | — | Para qué se usa este tipo de contrato. |
| `fecha_creacion` | DATETIME | — | NOT NULL | CURRENT_TIMESTAMP | — | Fecha de creación del tipo en el catálogo. |

---

## Entidad: Contrato

Representa cada contrato creado o guardado por un usuario en la plataforma.

| Atributo | Tipo | Long. | Restricciones | Valor por defecto | Índices | Descripción |
|----------|------|-------|---------------|-------------------|---------|-------------|
| `id_contrato` | UUID | — | PK | — | PK (auto) | Identificador único del contrato. |
| `id_usuario` | UUID | — | FK → Usuario.id_usuario, NOT NULL, ON DELETE RESTRICT ON UPDATE CASCADE | — | idx_contrato_usuario | Dueño del contrato. |
| `id_tipo_contrato` | UUID | — | FK → TipoContrato.id_tipo_contrato, NOT NULL, ON DELETE RESTRICT ON UPDATE CASCADE | — | idx_contrato_tipo | Tipo de contrato (catálogo TipoContrato). |
| `titulo` | VARCHAR | 200 | NOT NULL | — | — | Nombre dado al contrato por el usuario. |
| `clasificacion` | ENUM(`interno`,`externo`) | — | NOT NULL | — | — | Uso interno de la empresa o para terceros. |
| `contenido` | TEXT | — | NOT NULL | — | — | Texto completo del contrato. |
| `estado` | ENUM(`borrador`,`activo`,`firmado`,`vencido`) | — | NOT NULL | `'borrador'` | idx_contrato_estado | Estado del ciclo de vida. `vencido` lo actualiza un proceso programado (RN-05). |
| `/puntaje_riesgo` | TINYINT UNSIGNED | — | NULL — DERIVADO, CHECK(puntaje_riesgo BETWEEN 0 AND 100) | NULL | — | Caché del último puntaje de riesgo. Fórmula: `ROUND(SUM(peso_riesgo)/COUNT(*))*20` sobre la versión vigente. Se actualiza al finalizar cada AnalisisRiesgo (RN-02, RN-10). |
| `fecha_creacion` | DATETIME | — | NOT NULL | CURRENT_TIMESTAMP | — | Fecha de creación. |
| `fecha_inicio` | DATE | — | NULL | NULL | — | Fecha en que empieza a regir el contrato. |
| `fecha_vencimiento` | DATE | — | NULL, CHECK(fecha_vencimiento IS NULL OR fecha_vencimiento >= fecha_inicio) | NULL | idx_contrato_vencimiento | Fecha en que vence el contrato. |
| `id_plantilla` | UUID | — | FK → Plantilla.id_plantilla, NULL, ON DELETE SET NULL ON UPDATE CASCADE | NULL | — | Plantilla usada como base; nula si se generó desde cero por IA. |
| `fecha_actualizacion` | DATETIME | — | NULL, ON UPDATE CURRENT_TIMESTAMP | NULL | — | Fecha de la última modificación. La base de datos la actualiza automáticamente. |

---

## Entidad: EnlaceCompartir

Nueva (segunda corrección) — reemplaza el campo `enlace_compartir VARCHAR` de Contrato, que no tenía token único, estado ni fecha de expiración. Un contrato puede tener varios enlaces a lo largo del tiempo; el estado permite revocarlos sin borrar el contrato (RN-04).

| Atributo | Tipo | Long. | Restricciones | Valor por defecto | Índices | Descripción |
|----------|------|-------|---------------|-------------------|---------|-------------|
| `id_enlace` | UUID | — | PK | — | PK (auto) | Identificador único del enlace. |
| `id_contrato` | UUID | — | FK → Contrato.id_contrato, NOT NULL, ON DELETE RESTRICT ON UPDATE CASCADE | — | idx_enlace_contrato | Contrato al que da acceso. |
| `token` | CHAR | 64 | UNIQUE, NOT NULL | — | UNIQUE | Token aleatorio seguro que forma parte de la URL compartida. |
| `estado` | ENUM(`activo`,`revocado`,`vencido`) | — | NOT NULL | `'activo'` | idx_enlace_estado | Estado actual del enlace. Válido si `estado='activo' AND fecha_expiracion > NOW()`. |
| `fecha_creacion` | DATETIME | — | NOT NULL | CURRENT_TIMESTAMP | — | Fecha de generación del enlace. |
| `fecha_expiracion` | DATETIME | — | NOT NULL, CHECK(fecha_expiracion > fecha_creacion) | — | — | Momento en que el enlace deja de ser válido. |
| `correo_destino` | VARCHAR | 150 | NULL | — | idx_enlace_correo | Correo del destinatario al que se envió el enlace. |

---

## Entidad: VersionContrato

Copia del estado anterior de un contrato cada vez que se edita. Permite consultar el historial y restaurar versiones (RF-017).

| Atributo | Tipo | Long. | Restricciones | Valor por defecto | Índices | Descripción |
|----------|------|-------|---------------|-------------------|---------|-------------|
| `id_version` | UUID | — | PK | — | PK (auto) | Identificador único de la versión. |
| `id_contrato` | UUID | — | FK → Contrato.id_contrato, NOT NULL, ON DELETE RESTRICT ON UPDATE CASCADE | — | idx_version_contrato | Contrato al que pertenece la versión. |
| `numero_version` | INT | — | NOT NULL, CHECK(numero_version > 0) — UNIQUE(id_contrato, numero_version) | — | UNIQUE(id_contrato, numero_version) | Número correlativo de la versión dentro del contrato. |
| `id_usuario` | UUID | — | FK → Usuario.id_usuario, NULL, ON DELETE SET NULL ON UPDATE CASCADE | — | idx_version_usuario | Usuario que generó esta versión. NULL si la generó el sistema. |
| `contenido` | TEXT | — | NOT NULL | — | — | Texto completo del contrato en ese momento. |
| `fecha_guardado` | DATETIME | — | NOT NULL | CURRENT_TIMESTAMP | — | Fecha en que se guardó la versión. |

---

## Entidad: FirmanteExterno

Nueva (segunda corrección) — registra la identidad del firmante que llega por `EnlaceCompartir` y no tiene cuenta en la plataforma. `Firma.id_firmante` apunta aquí cuando el firmante no tiene cuenta; `ConstanciaFirma` conserva el snapshot inmutable independientemente.

| Atributo | Tipo | Long. | Restricciones | Valor por defecto | Índices | Descripción |
|----------|------|-------|---------------|-------------------|---------|-------------|
| `id_firmante` | UUID | — | PK | — | PK (auto) | Identificador único del firmante externo. |
| `nombre` | VARCHAR | 100 | NOT NULL | — | — | Nombre completo capturado antes de firmar. |
| `correo` | VARCHAR | 150 | NOT NULL | — | idx_firmante_correo | Correo capturado antes de firmar. Sin restricción UNIQUE: cada registro captura la identidad en un momento concreto. |
| `fecha_registro` | DATETIME | — | NOT NULL | CURRENT_TIMESTAMP | — | Fecha en que el firmante externo se identificó en el sistema. |

---

## Entidad: Firma

Firmas digitales dibujadas por los usuarios o firmantes externos. Una firma pertenece exactamente a un firmante: usuario registrado **o** firmante externo (regla XOR, RN-01).

| Atributo | Tipo | Long. | Restricciones | Valor por defecto | Índices | Descripción |
|----------|------|-------|---------------|-------------------|---------|-------------|
| `id_firma` | UUID | — | PK | — | PK (auto) | Identificador único de la firma. |
| `id_usuario` | UUID | — | FK → Usuario.id_usuario, NULL, ON DELETE RESTRICT ON UPDATE CASCADE | — | idx_firma_usuario | Usuario dueño de la firma; NULL cuando el firmante no tiene cuenta. |
| `id_firmante` | UUID | — | FK → FirmanteExterno.id_firmante, NULL, ON DELETE RESTRICT ON UPDATE CASCADE — CHECK((id_usuario IS NOT NULL AND id_firmante IS NULL) OR (id_usuario IS NULL AND id_firmante IS NOT NULL)) | NULL | idx_firma_firmante | Firmante externo; NULL cuando el firmante tiene cuenta. Regla XOR declarada como CHECK (RN-01). |
| `ruta_imagen_firma` | VARCHAR | 500 | NOT NULL | — | — | Ruta del archivo de imagen en el servidor. Reemplaza el campo TEXT base64 anterior. |
| `nombre_firma` | VARCHAR | 100 | NULL | NULL | — | Nombre dado a la firma al guardarla en biblioteca. |
| `en_biblioteca` | BOOLEAN | — | NOT NULL | FALSE | — | Indica si la firma se guardó para reutilizar. |
| `fecha_creacion` | DATETIME | — | NOT NULL | CURRENT_TIMESTAMP | — | Fecha de creación de la firma. |

---

## Entidad: ConstanciaFirma

Registro inmutable con valor probatorio legal de una firma aplicada a un contrato. Las FK tienen ON DELETE RESTRICT: no puede eliminarse bajo ninguna circunstancia (RN-06).

| Atributo | Tipo | Long. | Restricciones | Valor por defecto | Índices | Descripción |
|----------|------|-------|---------------|-------------------|---------|-------------|
| `id_constancia` | UUID | — | PK | — | PK (auto) | Identificador único de la constancia. |
| `id_contrato` | UUID | — | FK → Contrato.id_contrato, NOT NULL, ON DELETE RESTRICT ON UPDATE CASCADE | — | idx_constancia_contrato | Contrato firmado. |
| `id_firma` | UUID | — | FK → Firma.id_firma, NOT NULL, ON DELETE RESTRICT ON UPDATE CASCADE | — | idx_constancia_firma | Firma usada. |
| `firmante_nombre` | VARCHAR | 100 | NOT NULL | — | — | Nombre del firmante en el momento de firmar (snapshot inmutable). |
| `firmante_correo` | VARCHAR | 150 | NOT NULL | — | — | Correo del firmante en el momento de firmar (snapshot inmutable). |
| `ip_firmante` | VARCHAR | 45 | NOT NULL | — | — | Dirección IP desde la que se firmó. |
| `sello_tiempo_utc` | DATETIME | — | NOT NULL | CURRENT_TIMESTAMP | — | Marca de tiempo UTC de la firma. |
| `hash_sha256` | CHAR | 64 | NOT NULL | — | — | Huella criptográfica SHA-256 del documento firmado. |

---

## Entidad: Plantilla

Modelos de contratos predefinidos administrados por un Administrador. `Plantilla.categoria` fue eliminado durante el análisis 3FN (duplicaba `TipoContrato`) y reemplazado por FK a ese catálogo.

| Atributo | Tipo | Long. | Restricciones | Valor por defecto | Índices | Descripción |
|----------|------|-------|---------------|-------------------|---------|-------------|
| `id_plantilla` | UUID | — | PK | — | PK (auto) | Identificador único de la plantilla. |
| `nombre` | VARCHAR | 150 | NOT NULL | — | — | Nombre de la plantilla. |
| `id_tipo_contrato` | UUID | — | FK → TipoContrato.id_tipo_contrato, NOT NULL, ON DELETE RESTRICT ON UPDATE CASCADE | — | idx_plantilla_tipo | Categoría de la plantilla. Reemplaza el ENUM de 6 valores que duplicaba TipoContrato. |
| `contenido_base` | TEXT | — | NOT NULL | — | — | Texto base con marcadores que la IA reemplaza. |
| `activa` | BOOLEAN | — | NOT NULL | TRUE | — | Indica si la plantilla está disponible para usarse. |
| `fecha_creacion` | DATETIME | — | NOT NULL | CURRENT_TIMESTAMP | — | Fecha de creación. |
| `id_admin` | UUID | — | FK → Usuario.id_usuario, NOT NULL, ON DELETE RESTRICT ON UPDATE CASCADE | — | idx_plantilla_admin | Administrador que gestiona la plantilla. El usuario debe tener `rol='administrador'` (RN-08). |

---

## Entidad: Notificacion

Mensajes automáticos que el sistema envía al usuario ante eventos del contrato.

| Atributo | Tipo | Long. | Restricciones | Valor por defecto | Índices | Descripción |
|----------|------|-------|---------------|-------------------|---------|-------------|
| `id_notificacion` | UUID | — | PK | — | PK (auto) | Identificador único de la notificación. |
| `id_usuario` | UUID | — | FK → Usuario.id_usuario, NOT NULL, ON DELETE CASCADE ON UPDATE CASCADE | — | idx_notif_usuario | Usuario que recibe la notificación. |
| `id_contrato` | UUID | — | FK → Contrato.id_contrato, NULL, ON DELETE SET NULL ON UPDATE CASCADE | — | idx_notif_contrato | Contrato relacionado, si aplica. |
| `tipo` | ENUM(`contrato_firmado`,`contrato_por_vencer`,`riesgo_detectado`) | — | NOT NULL | — | idx_notif_tipo | Tipo de evento que originó la notificación. |
| `mensaje` | TEXT | — | NOT NULL | — | — | Texto de la notificación. |
| `leida` | BOOLEAN | — | NOT NULL | FALSE | — | Indica si el usuario ya la leyó. |
| `fecha_envio` | DATETIME | — | NOT NULL | CURRENT_TIMESTAMP | — | Fecha de envío. |
| `fecha_lectura` | DATETIME | — | NULL | NULL | — | Fecha en que el usuario leyó la notificación. NULL si aún no la ha leído. |
| `canal` | ENUM(`email`,`push`,`sistema`) | — | NOT NULL | `'sistema'` | — | Canal por el que se envió la notificación. |
| `estado_envio` | ENUM(`pendiente`,`enviado`,`fallido`) | — | NOT NULL | `'pendiente'` | — | Estado del envío. Permite detectar fallos en la entrega. |

---

## Entidad: InteraccionIA

Registra cada interacción del usuario con la IA (generar, modificar, consultar, analizar). Distingue si la operación es conversacional (`chatbot`) o de instrucción única (`ia_general`).

| Atributo | Tipo | Long. | Restricciones | Valor por defecto | Índices | Descripción |
|----------|------|-------|---------------|-------------------|---------|-------------|
| `id_interaccion` | UUID | — | PK | — | PK (auto) | Identificador único de la interacción. |
| `id_usuario` | UUID | — | FK → Usuario.id_usuario, NOT NULL, ON DELETE RESTRICT ON UPDATE CASCADE | — | idx_interaccion_usuario | Usuario que solicitó la interacción. |
| `id_contrato` | UUID | — | FK → Contrato.id_contrato, NULL, ON DELETE SET NULL ON UPDATE CASCADE | — | idx_interaccion_contrato | Contrato sobre el que aplica; nulo al generar uno nuevo. |
| `tipo_operacion` | ENUM(`generar`,`modificar`,`consultar`,`analizar`) | — | NOT NULL | — | — | Qué operación de IA se ejecutó (RF-004, RF-013, consulta, RF-005/006). |
| `origen_ia` | ENUM(`chatbot`,`ia_general`) | — | NOT NULL | — | — | `chatbot` = consulta conversacional; `ia_general` = instrucción única. |
| `entrada_usuario` | TEXT | — | NOT NULL | — | — | Instrucción o pregunta enviada a la IA. |
| `respuesta_texto` | TEXT | — | NULL | NULL | — | Texto producido por el LLM. NULL si la operación generó un archivo o falló. |
| `ruta_archivo_generado` | VARCHAR | 500 | NULL | NULL | — | Ruta al contrato generado cuando la operación es de tipo `generar`. NULL en operaciones conversacionales. |
| `modelo_utilizado` | VARCHAR | 100 | NULL | NULL | — | Nombre del modelo LLM invocado. Permite auditar cambios de modelo. |
| `resultado_operacion` | ENUM(`exito`,`error_modelo`,`timeout`) | — | NOT NULL | — | — | Estado del proceso. ENUM evita valores arbitrarios en base de datos. |
| `fecha` | DATETIME | — | NOT NULL | CURRENT_TIMESTAMP | — | Fecha y hora de la interacción. |

---

## Entidad: AnalisisRiesgo

Resultado del análisis de riesgo por cláusula, generado por IA. Cada registro representa una cláusula problemática encontrada en una versión concreta del contrato.

| Atributo | Tipo | Long. | Restricciones | Valor por defecto | Índices | Descripción |
|----------|------|-------|---------------|-------------------|---------|-------------|
| `id_analisis_clausula` | UUID | — | PK | — | PK (auto) | Identificador único del análisis de la cláusula. |
| `id_version` | UUID | — | FK → VersionContrato.id_version, NOT NULL, ON DELETE RESTRICT ON UPDATE CASCADE | — | idx_analisis_version | Versión específica del contrato analizada. Reemplaza `id_contrato`: los análisis de versiones anteriores permanecen ligados a su versión original (RN-02). |
| `id_interaccion` | UUID | — | FK → InteraccionIA.id_interaccion, NOT NULL, ON DELETE RESTRICT ON UPDATE CASCADE | — | idx_analisis_interaccion | Interacción de IA (tipo `analizar`) que generó este resultado. |
| `nivel_riesgo` | ENUM(`bajo`,`medio`,`alto`) | — | NOT NULL | — | idx_analisis_nivel | Nivel de riesgo detectado. |
| `peso_riesgo` | TINYINT UNSIGNED | — | NOT NULL, CHECK(peso_riesgo IN (1,3,5)) | — | — | Peso numérico: bajo=1, medio=3, alto=5. Usado para calcular `/puntaje_riesgo` (RN-02). |
| `titulo_clausula` | VARCHAR | 200 | NOT NULL | — | — | Título corto del hallazgo. |
| `numero_clausula` | INT | — | NULL, CHECK(numero_clausula > 0) | NULL | — | Número correlativo de la cláusula dentro del contrato. |
| `posicion_inicio` | INT | — | NULL | NULL | — | Desplazamiento de caracteres donde comienza la cláusula (para resaltado en pantalla). |
| `posicion_fin` | INT | — | NULL | NULL | — | Desplazamiento de caracteres donde termina la cláusula. |
| `descripcion` | TEXT | — | NOT NULL | — | — | Explicación del problema detectado. |
| `sugerencia` | TEXT | — | NOT NULL | — | — | Cómo mejorar la cláusula. |
| `fecha_analisis` | DATETIME | — | NOT NULL | CURRENT_TIMESTAMP | — | Fecha del análisis. |

---

## Entidad: TokenRecuperacion

Tokens temporales de recuperación de contraseña. Un token es válido únicamente si `usado=false` y `fecha_expiracion > NOW()` (RN-010).

| Atributo | Tipo | Long. | Restricciones | Valor por defecto | Índices | Descripción |
|----------|------|-------|---------------|-------------------|---------|-------------|
| `id_token` | UUID | — | PK | — | PK (auto) | Identificador único del token. |
| `id_usuario` | UUID | — | FK → Usuario.id_usuario, NOT NULL, ON DELETE CASCADE ON UPDATE CASCADE | — | idx_token_usuario | Usuario que solicitó la recuperación. |
| `token_hash` | CHAR | 64 | UNIQUE, NOT NULL | — | UNIQUE | Hash del token enviado por correo. |
| `usado` | BOOLEAN | — | NOT NULL | FALSE | — | Indica si el token ya se usó. |
| `fecha_expiracion` | DATETIME | — | NOT NULL, CHECK(fecha_expiracion > fecha_creacion) | fecha_creacion + 24h | — | Momento en que el token deja de ser válido. |
| `fecha_creacion` | DATETIME | — | NOT NULL | CURRENT_TIMESTAMP | — | Fecha de creación del token. |

---

## Entidad: LogAuditoria

Nueva (segunda corrección) — auditoría general de acciones del usuario más allá del versionado del contrato. `entidad_afectada` e `id_registro_afectado` forman una referencia polimórfica (RN-09): no se declara FK formal para soportar referencias a cualquier tabla.

| Atributo | Tipo | Long. | Restricciones | Valor por defecto | Índices | Descripción |
|----------|------|-------|---------------|-------------------|---------|-------------|
| `id_log` | UUID | — | PK | — | PK (auto) | Identificador único del registro. |
| `id_usuario` | UUID | — | FK → Usuario.id_usuario, NULL, ON DELETE SET NULL ON UPDATE CASCADE | — | idx_log_usuario | Usuario que ejecutó la acción; NULL si es acción del sistema. |
| `accion` | ENUM(`login`,`logout`,`crear_contrato`,`editar_contrato`,`inactivar_usuario`,`eliminar_plantilla`,`revocar_enlace`,`solicitar_firma`) | — | NOT NULL | — | — | Acción registrada. ENUM impide valores arbitrarios. |
| `detalle` | TEXT | — | NULL | NULL | — | Información adicional sobre la acción. |
| `entidad_afectada` | VARCHAR | 50 | NULL | NULL | idx_log_entidad | Nombre de la tabla sobre la que se actuó. Junto con `id_registro_afectado` forma la referencia polimórfica (RN-09). |
| `id_registro_afectado` | UUID | — | NULL — referencia polimórfica, no FK formal | NULL | — | UUID del registro afectado en la tabla indicada por `entidad_afectada`. |
| `ip_origen` | VARCHAR | 45 | NULL | NULL | — | Dirección IP desde la que se ejecutó la acción. |
| `fecha_accion` | DATETIME | — | NOT NULL | CURRENT_TIMESTAMP | — | Fecha y hora de la acción. |

---

## Entidad: FirmaSolicitada

Nueva (tercera corrección) — registra a cada firmante que debe firmar un contrato y el estado de su respuesta. Un contrato queda en estado `firmado` cuando todos sus registros tienen `estado='firmado'` (RN-03). Las restricciones UNIQUE garantizan que no se pueda solicitar la misma firma dos veces ni repetir posición en la secuencia.

| Atributo | Tipo | Long. | Restricciones | Valor por defecto | Índices | Descripción |
|----------|------|-------|---------------|-------------------|---------|-------------|
| `id_firma_solicitada` | UUID | — | PK | — | PK (auto) | Identificador único de la solicitud de firma. |
| `id_contrato` | UUID | — | FK → Contrato.id_contrato, NOT NULL, ON DELETE RESTRICT ON UPDATE CASCADE | — | idx_firma_sol_contrato | Contrato que debe firmarse. |
| `id_usuario` | UUID | — | FK → Usuario.id_usuario, NULL, ON DELETE RESTRICT ON UPDATE CASCADE — UNIQUE(id_contrato, id_usuario) | NULL | UNIQUE(id_contrato, id_usuario) | Usuario con cuenta al que se solicita firmar. NULL si el firmante es externo. |
| `id_firmante` | UUID | — | FK → FirmanteExterno.id_firmante, NULL, ON DELETE RESTRICT ON UPDATE CASCADE — UNIQUE(id_contrato, id_firmante) | NULL | UNIQUE(id_contrato, id_firmante) | Firmante externo al que se solicita. NULL si el firmante tiene cuenta. |
| `orden` | INT | — | NOT NULL, CHECK(orden > 0) — UNIQUE(id_contrato, orden) | — | UNIQUE(id_contrato, orden) | Posición en la secuencia de firma (1 = primero en firmar). |
| `estado` | ENUM(`pendiente`,`firmado`,`rechazado`) | — | NOT NULL | `'pendiente'` | idx_firma_sol_estado | Estado actual de la solicitud. |
| `fecha_solicitud` | DATETIME | — | NOT NULL | CURRENT_TIMESTAMP | — | Fecha en que se envió la solicitud al firmante. |
| `fecha_respuesta` | DATETIME | — | NULL | NULL | — | Fecha en que el firmante firmó o rechazó. NULL mientras no haya respondido. |

---

## Entidad: AccesoEnlace

Nueva (tercera corrección) — registra cada apertura de un `EnlaceCompartir`. Permite acreditar que el firmante abrió el enlace antes de firmar (evidencia con valor probatorio).

| Atributo | Tipo | Long. | Restricciones | Valor por defecto | Índices | Descripción |
|----------|------|-------|---------------|-------------------|---------|-------------|
| `id_acceso` | UUID | — | PK | — | PK (auto) | Identificador único del acceso. |
| `id_enlace` | UUID | — | FK → EnlaceCompartir.id_enlace, NOT NULL, ON DELETE CASCADE ON UPDATE CASCADE | — | idx_acceso_enlace | Enlace al que se accedió. |
| `fecha_acceso` | DATETIME | — | NOT NULL | CURRENT_TIMESTAMP | idx_acceso_fecha | Fecha y hora exacta del acceso. |
| `ip_origen` | VARCHAR | 45 | NOT NULL | — | — | Dirección IP desde la que se abrió el enlace. VARCHAR(45) soporta IPv4 e IPv6. |
| `user_agent` | VARCHAR | 500 | NULL | NULL | — | Cadena identificadora del navegador o cliente del firmante externo. |

---

## Reglas de Integridad del Modelo (3FN)

Las siguientes reglas complementan las restricciones declaradas en el diccionario. Algunas son verificables en la capa de base de datos (CHECK, FK); otras se delegan a la capa de aplicación.

| Código | Nombre | Descripción |
|--------|--------|-------------|
| RN-01 | XOR de Firma | Una Firma debe pertenecer exactamente a un firmante: o un Usuario registrado (`id_usuario NOT NULL, id_firmante NULL`) o un FirmanteExterno (`id_firmante NOT NULL, id_usuario NULL`). Declarada como CHECK en Firma. |
| RN-02 | Fórmula puntaje_riesgo | `/puntaje_riesgo` de Contrato = `ROUND(SUM(peso_riesgo)/COUNT(*))*20` sobre AnalisisRiesgo de la última versión vigente. Rango 0–100 garantizado por CHECK. |
| RN-03 | Estado 'firmado' del contrato | Un contrato pasa a `estado='firmado'` cuando todos sus registros FirmaSolicitada tienen `estado='firmado'`. Lo ejecuta la capa de aplicación al registrar cada firma. |
| RN-04 | Validez del enlace compartido | Un EnlaceCompartir es válido si y solo si `estado='activo' AND fecha_expiracion > NOW()`. Un enlace revocado o vencido no otorga acceso aunque el token sea correcto. |
| RN-05 | Vencimiento automático del contrato | `estado='vencido'` lo actualiza un proceso programado (job) que compara `fecha_vencimiento < NOW()`. No se actualiza en tiempo real. |
| RN-06 | Inmutabilidad de ConstanciaFirma | Las FK `id_contrato` e `id_firma` tienen ON DELETE RESTRICT. No es posible eliminar un contrato ni una firma que tengan constancias. |
| RN-07 | Inactivación de Firma | `Firma.inactivarFirma()` solo está permitida en firmas de biblioteca (`en_biblioteca=TRUE`) que no tengan ningún ConstanciaFirma asociado. |
| RN-08 | Restricción de rol en Plantilla.id_admin | `Plantilla.id_admin` debe referenciar un Usuario con `rol='administrador'`. Implementada como trigger BEFORE INSERT/UPDATE en Plantilla. |
| RN-09 | Referencia polimórfica en LogAuditoria | `id_registro_afectado` no es FK formal: `entidad_afectada` indica la tabla y `id_registro_afectado` contiene el UUID del registro afectado. |
| RN-10 | Caché /puntaje_riesgo solo de la versión vigente | El caché se recalcula solo al finalizar un AnalisisRiesgo sobre la versión vigente. Los análisis de versiones anteriores no modifican el caché. |

---

## Relaciones entre Entidades

| Entidad origen | Mult. | Relación | Mult. | Entidad destino | Descripción |
|----------------|-------|----------|-------|-----------------|-------------|
| Rol | 1 | clasifica | 0..* | Usuario | Un rol clasifica a cero o más usuarios. Un usuario tiene exactamente un rol. |
| Usuario | 1 | posee | 0..* | Contrato | Un usuario puede crear cero o más contratos. Cada contrato pertenece a un usuario. |
| Usuario | 1 | solicita | 0..* | TokenRecuperacion | Un usuario puede tener varios tokens de recuperación a lo largo del tiempo. |
| Usuario | 1 | registra | 0..* | LogAuditoria | Un usuario puede generar cero o más entradas de auditoría. NULL si la acción es del sistema. |
| Usuario | 1 | recibe | 0..* | Notificacion | Un usuario puede recibir cero o más notificaciones del sistema. |
| Usuario | 1 | administra | 0..* | Plantilla | Un administrador puede gestionar cero o más plantillas. |
| TipoContrato | 1 | tipifica | 0..* | Contrato | Un tipo de contrato puede aplicarse a cero o más contratos. |
| TipoContrato | 1 | categoriza | 0..* | Plantilla | Un tipo de contrato puede tener cero o más plantillas asociadas. |
| Plantilla | 0..1 | origina | 0..* | Contrato | Una plantilla puede ser base de cero o más contratos. Un contrato puede no tener plantilla. |
| Contrato | 1 | historial | 0..* | VersionContrato | Un contrato tiene cero o más versiones guardadas al editarse. |
| Contrato | 1 | genera | 0..* | EnlaceCompartir | Un contrato puede tener cero o más enlaces compartidos a lo largo del tiempo. |
| Contrato | 1 | certifica | 0..* | ConstanciaFirma | Un contrato puede tener cero o más constancias de firma (una por firmante). |
| Contrato | 0..1 | origina | 0..* | Notificacion | Un contrato puede originar cero o más notificaciones. |
| Contrato | 1 | solicita firmas | 0..* | FirmaSolicitada | Un contrato puede tener cero o más solicitudes de firma pendientes o resueltas. |
| EnlaceCompartir | 1 | registra accesos | 0..* | AccesoEnlace | Un enlace puede ser abierto cero o más veces; cada apertura genera un registro AccesoEnlace. |
| Usuario | 0..1 | dibuja | 0..* | Firma | Un usuario puede tener cero o más firmas en biblioteca. |
| FirmanteExterno | 0..1 | identifica | 0..* | Firma | Un firmante externo puede tener cero o más registros de firma. |
| Firma | 1 | respalda | 0..* | ConstanciaFirma | Una firma puede respaldar cero o más constancias. Cada constancia requiere exactamente una firma. |
| Usuario | 1 | solicita | 0..* | InteraccionIA | Un usuario puede tener cero o más interacciones con la IA. |
| Contrato | 0..1 | aplica sobre | 0..* | InteraccionIA | Una interacción puede estar ligada a un contrato o no (al generar uno nuevo es NULL). |
| InteraccionIA | 1 | genera | 0..* | AnalisisRiesgo | Una interacción de tipo `analizar` puede generar cero o más registros de cláusulas con riesgo. |
| VersionContrato | 1 | tiene | 0..* | AnalisisRiesgo | Una versión del contrato puede tener cero o más análisis de riesgo asociados. |
