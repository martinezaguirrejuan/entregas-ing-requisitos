# Escenarios de Casos de Uso

> **Nota de revisión:** De acuerdo con la retroalimentación del docente, esta sección ha sido eliminada del documento unificado. Los flujos de los casos de uso (Sección 7) ya incluyen los escenarios. Este archivo se conserva en el repositorio como referencia histórica.

---

## Escenario: Registrar cuenta (CU-01)

- **Actor principal:** Empleado / Coordinador de NexaServicios S.A.S.
- **Precondiciones:**
  - El usuario no posee cuenta registrada.
  - El usuario dispone de un correo electrónico válido.
  - El sistema se encuentra disponible.
- **Flujo principal:**
  1. El usuario ingresa a la plataforma y selecciona *Registrarse*.
  2. El sistema presenta el formulario: nombre, correo y contraseña.
  3. El usuario completa el formulario y confirma.
  4. El sistema valida los datos y verifica que el correo no esté registrado.
  5. El sistema crea la cuenta y redirige al inicio de sesión.
- **Flujos alternativos:**
  - FA-01: El correo ya está registrado → el sistema muestra *"Este correo ya tiene una cuenta asociada"* y sugiere iniciar sesión.
  - FA-02: Campos vacíos o inválidos → el sistema resalta los errores e impide continuar.
- **Postcondiciones:**
  - La cuenta queda activa en el sistema.
  - El usuario puede iniciar sesión con las credenciales registradas.

---

## Escenario: Iniciar sesión (CU-02)

- **Actor principal:** Empleado / Coordinador de NexaServicios S.A.S.
- **Precondiciones:**
  - El usuario posee una cuenta registrada.
  - El sistema se encuentra disponible.
- **Flujo principal:**
  1. El usuario selecciona *Iniciar sesión*.
  2. El sistema presenta el formulario con correo y contraseña.
  3. El usuario ingresa sus credenciales y confirma.
  4. El sistema verifica las credenciales.
  5. El sistema concede acceso y redirige al Dashboard.
- **Flujos alternativos:**
  - FA-01: Credenciales incorrectas → el sistema muestra *"Correo o contraseña incorrectos"* y permite reintentar.
  - FA-02: El usuario no tiene cuenta → el sistema sugiere registrarse.
- **Postcondiciones:**
  - El usuario queda autenticado con acceso a todas las funcionalidades.

---

## Escenario: Generar contrato (CU-03)

- **Actor principal:** Empleado / Coordinador de NexaServicios S.A.S.
- **Precondiciones:**
  - El usuario está autenticado.
  - Existe al menos una plantilla disponible.
- **Flujo principal:**
  1. El usuario accede al módulo *Generar Contrato*.
  2. El sistema muestra los 8 tipos de contrato disponibles.
  3. El usuario selecciona el tipo de contrato.
  4. El sistema despliega el formulario con campos: partes, montos, duración, cláusulas adicionales.
  5. El usuario completa el formulario y confirma.
  6. El sistema procesa la información y genera el documento legal.
  7. El sistema presenta el contrato con opciones de copia y descarga en PDF.
  8. El sistema registra el contrato en el historial del usuario.
- **Flujos alternativos:**
  - FA-01: Campos obligatorios vacíos → el sistema resalta los pendientes y bloquea el avance.
  - FA-02: Error en la generación → el sistema notifica al usuario y conserva los datos.
- **Postcondiciones:**
  - El contrato queda almacenado en el historial.
  - El documento está disponible para descargar, copiar o reutilizar.

---

## Escenario: Analizar contrato existente (CU-04)

- **Actor principal:** Empleado / Coordinador de NexaServicios S.A.S.
- **Precondiciones:**
  - El usuario está autenticado.
  - El usuario dispone del texto del contrato a analizar.
- **Flujo principal:**
  1. El usuario accede al módulo *Analizar Contrato*.
  2. El sistema presenta un campo para pegar el texto.
  3. El usuario ingresa el texto y confirma el análisis.
  4. El sistema examina el contenido en busca de cláusulas de riesgo.
  5. El sistema calcula el score de seguridad de 0 a 100.
  6. El sistema presenta las cláusulas problemáticas con explicación y sugerencias.
  7. El sistema registra el resultado en el historial.
- **Flujos alternativos:**
  - FA-01: Campo vacío → el sistema solicita ingresar el texto.
  - FA-02: Sin cláusulas de riesgo → muestra *"No se encontraron cláusulas problemáticas"* con score alto.
- **Postcondiciones:**
  - El análisis queda guardado en el historial.
  - El usuario tiene información suficiente para decidir sobre el contrato.

---

## Escenario: Ver historial de contratos (CU-05)

- **Actor principal:** Empleado / Coordinador de NexaServicios S.A.S.
- **Precondiciones:**
  - El usuario está autenticado.
  - El usuario ha generado o analizado al menos un contrato.
- **Flujo principal:**
  1. El usuario accede al módulo *Historial*.
  2. El sistema presenta el listado ordenado por fecha (más reciente primero).
  3. El usuario selecciona un registro para ver su detalle.
  4. El sistema muestra el contenido completo con opción de copiarlo o descargarlo.
- **Flujos alternativos:**
  - FA-01: Historial vacío → muestra *"Aún no has generado ni analizado ningún contrato"* con acceso directo a los módulos.
- **Postcondiciones:**
  - El usuario puede consultar, copiar o descargar cualquier contrato de su historial.

---

## Escenario: Cerrar sesión (CU-06)

- **Actor principal:** Empleado / Coordinador de NexaServicios S.A.S.
- **Precondiciones:**
  - El usuario está autenticado en el sistema.
- **Flujo principal:**
  1. El usuario selecciona *Cerrar sesión* desde el menú.
  2. El sistema invalida la sesión activa.
  3. El sistema redirige al usuario a la pantalla de inicio de sesión.
- **Postcondiciones:**
  - La sesión queda cerrada; el usuario debe autenticarse nuevamente para acceder.
