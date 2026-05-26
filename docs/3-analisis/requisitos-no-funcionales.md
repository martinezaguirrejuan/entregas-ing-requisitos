# Requisitos No Funcionales — ContractAI

Los requisitos no funcionales describen **cómo debe comportarse el sistema**: su rendimiento, seguridad, disponibilidad y calidad. No definen qué hace el sistema, sino qué tan bien lo hace.

**Proyecto:** ContractAI | **Empresa:** NexaOps  
**Docente:** Gloria Amparo Lora Patiño | **Uniremington · 2026**

---

## RNF-001 — Rendimiento

| Campo | Descripción |
|-------|-------------|
| **ID** | RNF-001 |
| **Categoría** | Rendimiento |
| **Descripción** | El sistema debe responder a cualquier acción del usuario (cargar una página, guardar un contrato, aplicar un filtro) en el menor tiempo posible bajo condiciones normales de uso. |
| **Métrica** | Tiempo de respuesta máximo: **2 segundos** para el 95% de las solicitudes. |

---

## RNF-002 — Disponibilidad

| Campo | Descripción |
|-------|-------------|
| **ID** | RNF-002 |
| **Categoría** | Disponibilidad |
| **Descripción** | El sistema debe estar disponible y accesible las 24 horas del día, los 7 días de la semana, minimizando interrupciones no planificadas que impidan a los usuarios acceder a sus contratos. |
| **Métrica** | Disponibilidad mínima: **99% del tiempo** medido mensualmente (máximo 7.2 horas de caída al mes). |

---

## RNF-003 — Responsividad (adaptación a distintos dispositivos)

| Campo | Descripción |
|-------|-------------|
| **ID** | RNF-003 |
| **Categoría** | Usabilidad / Portabilidad |
| **Descripción** | La interfaz del sistema debe adaptarse y funcionar correctamente en dispositivos de distintos tamaños: teléfonos móviles, tabletas y computadores de escritorio, sin perder funcionalidad ni legibilidad. |
| **Métrica** | Compatible con pantallas desde **320px** (móvil pequeño) hasta **1920px** (monitor de escritorio). |

---

## RNF-004 — Seguridad de contraseñas

| Campo | Descripción |
|-------|-------------|
| **ID** | RNF-004 |
| **Categoría** | Seguridad |
| **Descripción** | El sistema nunca debe guardar las contraseñas de los usuarios en texto plano. Deben almacenarse usando un algoritmo de cifrado seguro e irreversible, de modo que incluso si alguien accede a la base de datos no pueda leer las contraseñas originales. |
| **Métrica** | Contraseñas almacenadas con **bcrypt** (mínimo 10 rondas de hashing). |

---

## RNF-005 — Compatibilidad con navegadores

| Campo | Descripción |
|-------|-------------|
| **ID** | RNF-005 |
| **Categoría** | Compatibilidad |
| **Descripción** | El sistema debe funcionar correctamente en las versiones más recientes de los navegadores más utilizados, sin errores visuales ni de funcionamiento. |
| **Métrica** | Compatible con las versiones actuales de **Chrome, Firefox, Safari y Microsoft Edge**. |

---

## RNF-006 — Usabilidad (facilidad de uso)

| Campo | Descripción |
|-------|-------------|
| **ID** | RNF-006 |
| **Categoría** | Usabilidad |
| **Descripción** | El sistema debe presentar su interfaz en español, con lenguaje claro y sin jerga legal o técnica innecesaria. Una persona sin conocimientos legales ni informáticos debe poder usarlo sin ayuda externa. |
| **Métrica** | Un usuario nuevo sin experiencia previa debe completar su primer contrato en menos de **10 minutos** desde el registro. |

---

## RNF-007 — Acceso sin conexión

| Campo | Descripción |
|-------|-------------|
| **ID** | RNF-007 |
| **Categoría** | Disponibilidad offline |
| **Descripción** | El sistema debe permitir al usuario consultar contratos previamente guardados incluso cuando no tenga conexión a internet, garantizando acceso a documentos importantes en todo momento. |
| **Métrica** | Contratos guardados accesibles en modo offline sin pérdida de contenido. |

---

## RNF-008 — Calidad mínima del contrato generado

| Campo | Descripción |
|-------|-------------|
| **ID** | RNF-008 |
| **Categoría** | Calidad del contenido |
| **Descripción** | Los contratos generados por el sistema deben cumplir con un estándar mínimo de extensión y estructura para tener validez formal. Un contrato de pocas líneas o sin cláusulas numeradas no es aceptable. |
| **Métrica** | Mínimo **900 palabras** y al menos **10 cláusulas numeradas** por contrato. |

---

## RNF-009 — Transmisión progresiva del contenido de IA (streaming)

| Campo | Descripción |
|-------|-------------|
| **ID** | RNF-009 |
| **Categoría** | Rendimiento / Experiencia de usuario |
| **Descripción** | Cuando la IA esté generando o editando un contrato, el sistema debe mostrar el texto progresivamente en tiempo real (palabra por palabra) sin esperar a que termine por completo. Esto evita que el usuario vea una pantalla en blanco durante el proceso. |
| **Métrica** | El primer texto generado por IA debe aparecer en pantalla en menos de **3 segundos** desde que el usuario hace la solicitud. |

---

> **Total: 9 requisitos no funcionales**
