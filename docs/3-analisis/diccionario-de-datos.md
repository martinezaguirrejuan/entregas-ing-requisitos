# Diccionario de Datos — ContractAI

El diccionario de datos describe cada **entidad del sistema** (las "cosas" que el sistema guarda en la base de datos), sus atributos, el tipo de dato de cada uno, si es obligatorio y la regla de negocio que lo rige.

**Proyecto:** ContractAI | **Empresa:** NexaOps  
**Docente:** Gloria Amparo Lora Patiño | **Uniremington · 2026**

> **Glosario rápido de tipos de datos:**
> - **UUID**: código único generado automáticamente para identificar cada registro (ej: `a3f9-12bc-...`)
> - **VARCHAR(n)**: texto de longitud variable, máximo n caracteres
> - **TEXT**: texto largo sin límite fijo (para contenido de contratos)
> - **ENUM(...)**: lista cerrada de valores posibles; el sistema rechaza cualquier otro
> - **BOOLEAN**: solo puede ser `true` (sí) o `false` (no)
> - **DATETIME**: fecha y hora completa (ej: `2026-05-21 14:35:00`)
> - **DATE**: solo fecha sin hora (ej: `2026-06-30`)
> - **INT**: número entero
> - **TINYINT**: número entero pequeño (0–255)
> - **CHAR(n)**: texto de longitud fija exacta de n caracteres
> - **VARCHAR(45)**: usado para direcciones IP (IPv4 e IPv6)

---

## Entidad: Usuario

Representa a cada persona registrada en la plataforma.

| Atributo | Tipo de dato | ¿Obligatorio? | Descripción y regla de negocio |
|----------|-------------|:-------------:|-------------------------------|
| `id_usuario` | UUID | Sí — **PK** | Identificador único del usuario, generado automáticamente por el sistema al registrarse. Nunca se repite ni se reutiliza. |
| `nombre` | VARCHAR(100) | Sí | Nombre completo del usuario tal como lo ingresó al registrarse. |
| `correo` | VARCHAR(150) | Sí — **UNIQUE** | Correo electrónico del usuario. Debe ser único en todo el sistema: si ya existe, el registro es rechazado (RN-006). Se usa para iniciar sesión y recibir notificaciones. |
| `contrasena_hash` | VARCHAR(255) | Sí | Contraseña almacenada de forma cifrada con bcrypt. **Nunca se guarda la contraseña original en texto plano** (RNF-004). Si alguien accede a la base de datos, no puede leer la contraseña real. |
| `rol` | ENUM(`freelancer`, `pyme`, `administrador`) | Sí | Rol asignado al usuario, que determina qué funciones puede usar (RF-023, RN-014). Por defecto se asigna `freelancer` al registrarse. |
| `activo` | BOOLEAN | Sí | Indica si la cuenta está habilitada. `true` = puede iniciar sesión. `false` = cuenta suspendida. Por defecto `true`. |
| `2fa_activado` | BOOLEAN | Sí | Indica si el usuario activó la autenticación de dos factores (2FA) para mayor seguridad (RF-020). Por defecto `false`. |
| `fecha_registro` | DATETIME | Sí | Fecha y hora exacta en que se creó la cuenta. Se registra automáticamente, el usuario no la ingresa. |

---

## Entidad: Contrato

Representa cada contrato creado o guardado por un usuario en la plataforma.

| Atributo | Tipo de dato | ¿Obligatorio? | Descripción y regla de negocio |
|----------|-------------|:-------------:|-------------------------------|
| `id_contrato` | UUID | Sí — **PK** | Identificador único del contrato, generado automáticamente. |
| `id_usuario` | UUID | Sí — **FK** | Referencia al usuario propietario del contrato (tabla Usuario). Un contrato siempre pertenece a exactamente un usuario; ningún otro usuario puede verlo o editarlo (RN-001). |
| `titulo` | VARCHAR(200) | Sí | Nombre descriptivo que le da el usuario al contrato (ej: "Contrato diseño logo – Cliente X"). |
| `tipo` | ENUM(`servicios`, `nda`, `empleo`, `sociedad`, `arrendamiento`, `compraventa`, `terminos`, `privacidad`, `personalizado`) | Sí | Categoría del contrato. `personalizado` se asigna cuando fue generado desde descripción libre sin plantilla (RF-016). |
| `clasificacion` | ENUM(`interno`, `externo`) | Sí | Define si el contrato es entre personas de la misma organización (`interno`) o con terceros (`externo`). Afecta quién puede firmarlo (RN-011). |
| `contenido` | TEXT | Sí | Texto completo del contrato tal como fue generado o editado. Puede tener miles de palabras. |
| `estado` | ENUM(`borrador`, `activo`, `firmado`, `vencido`) | Sí | Estado actual del contrato en su ciclo de vida. `borrador`: en preparación. `activo`: listo o en proceso de firma. `firmado`: todas las partes firmaron. `vencido`: superó la fecha de vencimiento. |
| `puntaje_riesgo` | TINYINT (0–100) | No | Puntaje de riesgo calculado por la IA (RF-005). `NULL` si el contrato aún no ha sido analizado. Si supera 70, el sistema muestra una advertencia (RN-002). |
| `fecha_creacion` | DATETIME | Sí | Fecha y hora en que se creó el contrato. Automática. |
| `fecha_inicio` | DATE | No | Fecha de inicio de la vigencia del contrato. Opcional; si se registra, el sistema la usa para calcular el tiempo activo. |
| `fecha_vencimiento` | DATE | No | Fecha en que el contrato deja de estar vigente. Si quedan 7 días o menos, el sistema envía una alerta automática al propietario (RN-012). |
| `enlace_compartir` | VARCHAR(255) | No | Token único generado cuando el propietario decide compartir el contrato por enlace. `NULL` si nunca fue compartido. Permite acceso en modo lectura y firma a quien tenga el enlace (RN-005). |
| `id_plantilla` | UUID | No (FK) | Plantilla utilizada para generar el contrato. NULL si fue generado desde descripción libre (RF-016). |

---

## Entidad: Version\_Contrato

Cada vez que un contrato es editado, el sistema guarda una copia del estado anterior. Esta entidad almacena ese historial.

| Atributo | Tipo de dato | ¿Obligatorio? | Descripción y regla de negocio |
|----------|-------------|:-------------:|-------------------------------|
| `id_version` | UUID | Sí — **PK** | Identificador único de esta versión. |
| `id_contrato` | UUID | Sí — **FK** | Contrato al que pertenece esta versión (tabla Contrato). |
| `numero_version` | INT | Sí | Número correlativo de la versión: 1 es la original, 2 es después de la primera edición, y así sucesivamente. |
| `contenido` | TEXT | Sí | Texto completo del contrato tal como estaba en ese momento. Permite restaurar si se quiere volver atrás (RF-017). |
| `fecha_guardado` | DATETIME | Sí | Fecha y hora exacta en que se guardó esta versión. Automática. |

---

## Entidad: Firma

Almacena las firmas digitales dibujadas por los usuarios, tanto las guardadas en biblioteca como las usadas en contratos.

| Atributo | Tipo de dato | ¿Obligatorio? | Descripción y regla de negocio |
|----------|-------------|:-------------:|-------------------------------|
| `id_firma` | UUID | Sí — **PK** | Identificador único de la firma. |
| `id_usuario` | UUID | No — **FK** | Usuario propietario de la firma (tabla Usuario). `NULL` si la firma pertenece a una contraparte sin cuenta en la plataforma. |
| `imagen_firma` | TEXT (base64) | Sí | Imagen de la firma codificada en base64 (formato de texto que representa una imagen). Se almacena como texto para facilitar la portabilidad. |
| `nombre_firma` | VARCHAR(100) | No | Nombre que le da el usuario para identificarla en su biblioteca (ej: "Firma formal", "Iniciales"). Si no se le da nombre, se usa la fecha de creación. |
| `en_biblioteca` | BOOLEAN | Sí | `true` si el usuario la guardó en su biblioteca personal para reutilizarla. `false` si se usó una sola vez y no fue guardada. |
| `fecha_creacion` | DATETIME | Sí | Fecha y hora en que fue dibujada y guardada. Automática. |

---

## Entidad: Constancia\_Firma

Registro inmutable que certifica quién firmó un contrato, cuándo y desde dónde. Tiene valor probatorio legal.

| Atributo | Tipo de dato | ¿Obligatorio? | Descripción y regla de negocio |
|----------|-------------|:-------------:|-------------------------------|
| `id_constancia` | UUID | Sí — **PK** | Identificador único de la constancia. |
| `id_contrato` | UUID | Sí — **FK** | Contrato que fue firmado (tabla Contrato). |
| `id_firma` | UUID | Sí — **FK** | Firma digital utilizada en el acto de firma (tabla Firma). |
| `firmante_nombre` | VARCHAR(100) | Sí | Nombre de la persona que firmó. |
| `firmante_correo` | VARCHAR(150) | Sí | Correo electrónico del firmante al momento de la firma. |
| `ip_firmante` | VARCHAR(45) | Sí | Dirección IP del dispositivo desde donde se realizó la firma (RN-013). Se registra automáticamente; el usuario no la ingresa. Valor de VARCHAR(45) soporta tanto IPv4 como IPv6. |
| `sello_tiempo_utc` | DATETIME | Sí | Fecha y hora exacta del firmado en formato UTC (hora universal coordinada). **No puede modificarse** después de registrarse (RN-013). |
| `hash_sha256` | CHAR(64) | Sí | Huella digital única del documento al momento de la firma, calculada con el algoritmo SHA-256. Cualquier cambio posterior al documento haría que el hash no coincida, lo que probaría que fue alterado (RN-013). Siempre tiene exactamente 64 caracteres. |

---

## Entidad: Plantilla

Modelos de contratos predefinidos que el Administrador gestiona y los usuarios usan como punto de partida.

| Atributo | Tipo de dato | ¿Obligatorio? | Descripción y regla de negocio |
|----------|-------------|:-------------:|-------------------------------|
| `id_plantilla` | UUID | Sí — **PK** | Identificador único de la plantilla. |
| `nombre` | VARCHAR(150) | Sí | Nombre visible para los usuarios en el catálogo (ej: "Contrato de prestación de servicios"). |
| `categoria` | ENUM(`laboral`, `comercial`, `confidencialidad`, `arrendamiento`, `sociedad`, `otro`) | Sí | Categoría que agrupa plantillas similares para facilitar la búsqueda en el catálogo (RF-024). |
| `contenido_base` | TEXT | Sí | Texto base de la plantilla con marcadores de posición para los datos variables (ej: `{{nombre_contratante}}`, `{{valor_contrato}}`). La IA reemplaza estos marcadores con los datos del formulario. |
| `activa` | BOOLEAN | Sí | `true` = visible y disponible para todos los usuarios. `false` = desactivada por el administrador, no aparece en el catálogo. Por defecto `true`. |
| `fecha_creacion` | DATETIME | Sí | Fecha en que fue creada. Automática. |
| `id_admin` | UUID | Sí — **FK** | Administrador que creó o realizó la última modificación (tabla Usuario, donde `rol = administrador`). |

---

## Entidad: Notificacion

Mensajes automáticos que el sistema envía al usuario cuando ocurren eventos importantes en sus contratos.

| Atributo | Tipo de dato | ¿Obligatorio? | Descripción y regla de negocio |
|----------|-------------|:-------------:|-------------------------------|
| `id_notificacion` | UUID | Sí — **PK** | Identificador único de la notificación. |
| `id_usuario` | UUID | Sí — **FK** | Usuario destinatario de la notificación (tabla Usuario). |
| `id_contrato` | UUID | No — **FK** | Contrato relacionado con la notificación (tabla Contrato). `NULL` si la notificación no está ligada a un contrato específico. |
| `tipo` | ENUM(`firma_completada`, `vencimiento_proximo`, `riesgo_alto`) | Sí | Tipo de evento que generó la notificación (RF-018): `firma_completada` = la contraparte firmó; `vencimiento_proximo` = el contrato vence en 7 días o menos (RN-012); `riesgo_alto` = el análisis detectó riesgo > 70 (RN-002). |
| `mensaje` | TEXT | Sí | Texto de la notificación en lenguaje claro para el usuario (ej: "Tu contrato 'Diseño logo' vence el 30 de junio"). |
| `leida` | BOOLEAN | Sí | `true` si el usuario ya abrió o descartó la notificación. `false` si aún no la ha visto. Por defecto `false`. |
| `fecha_envio` | DATETIME | Sí | Fecha y hora en que fue generada y enviada. Automática. |

---

---

## Entidad: AnalisisRiesgo

Almacena el resultado del análisis de riesgo por cláusula generado por la IA (RF-006). Cada registro corresponde a una cláusula problemática detectada en un contrato.

| Atributo | Tipo de dato | ¿Obligatorio? | Regla de negocio |
|----------|-------------|:-------------:|-----------------|
| `id_analisis_clausula` | UUID | Sí (PK) | Identificador único del registro de análisis. |
| `id_contrato` | UUID | Sí (FK) | Contrato al que pertenece. Un contrato puede tener múltiples registros (uno por cláusula analizada). |
| `nivel_riesgo` | ENUM(bajo, medio, alto) | Sí | Nivel de riesgo asignado por la IA a esta cláusula (RF-006). |
| `titulo_clausula` | VARCHAR(200) | Sí | Nombre o encabezado de la cláusula problemática identificada. |
| `descripcion` | TEXT | Sí | Explicación del problema detectado por la IA en esta cláusula. |
| `sugerencia` | TEXT | Sí | Recomendación de la IA para mejorar o reemplazar esta cláusula. |
| `fecha_analisis` | DATETIME | Sí | Fecha y hora en que se realizó el análisis. Automática. |

---

## Entidad: TokenRecuperacion

Almacena los tokens temporales de recuperación de contraseña. Cada token es de un solo uso y expira en 24 horas (RN-010).

| Atributo | Tipo de dato | ¿Obligatorio? | Regla de negocio |
|----------|-------------|:-------------:|-----------------|
| `id_token` | UUID | Sí (PK) | Identificador único del token. |
| `id_usuario` | UUID | Sí (FK) | Usuario que solicitó la recuperación. |
| `token_hash` | CHAR(64) | Sí | Hash SHA-256 del token enviado al correo. Nunca se almacena en texto plano (RNF-011). |
| `usado` | BOOLEAN | Sí | true si el token ya fue utilizado. Al usarse, no puede reutilizarse (RN-010). Por defecto: false. |
| `fecha_expiracion` | DATETIME | Sí | Fecha y hora de expiración: 24 horas después de su creación (RN-010). |
| `fecha_creacion` | DATETIME | Sí | Fecha y hora de generación del token. Automática. |

---

## Resumen de entidades y relaciones

| Entidad | # Atributos | Clave primaria | Se relaciona con |
|---------|:-----------:|----------------|-----------------|
| Usuario | 8 | `id_usuario` | Contrato, Firma, Plantilla, Notificacion |
| Contrato | 13 | `id_contrato` | Usuario, Version_Contrato, Constancia_Firma, Notificacion, AnalisisRiesgo, Plantilla |
| Version_Contrato | 5 | `id_version` | Contrato |
| Firma | 6 | `id_firma` | Usuario, Constancia_Firma |
| Constancia_Firma | 8 | `id_constancia` | Contrato, Firma |
| Plantilla | 7 | `id_plantilla` | Usuario (administrador) |
| Notificacion | 7 | `id_notificacion` | Usuario, Contrato |
| AnalisisRiesgo | 7 | `id_analisis_clausula` | Contrato |
| TokenRecuperacion | 6 | `id_token` | Usuario |

> **Total: 9 entidades · 61 atributos definidos**
