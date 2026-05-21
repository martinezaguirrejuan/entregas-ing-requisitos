# Diccionario de Datos

> 🔄 **Entrega 3 — En progreso** (fecha: 23 de mayo de 2026)

| Entidad | Atributo | Tipo | Descripción | Restricciones | Ejemplo |
|---------|----------|------|-------------|---------------|---------|
| Usuario | id_usuario | INT | Identificador único del usuario | PK, autoincremental | 1 |
| Usuario | nombre | VARCHAR(100) | Nombre completo del usuario | Requerido, mín. 2 caracteres | Juan Pérez |
| Usuario | correo | VARCHAR(150) | Correo electrónico del usuario | Requerido, único, formato válido | juan@email.com |
| Usuario | contrasena_hash | VARCHAR(255) | Contraseña hasheada | Requerido, nunca texto plano | $2b$10$... |
| Usuario | rol | ENUM | Rol del usuario en la plataforma | Valores: Freelancer, PYME, Administrador | Freelancer |
| Contrato | id_contrato | INT | Identificador único del contrato | PK, autoincremental | 42 |
| Contrato | titulo | VARCHAR(200) | Nombre descriptivo del contrato | Requerido | Contrato de servicios - Mayo 2026 |
| Contrato | tipo | ENUM | Tipo de contrato | Valores: servicios, NDA, empleo, sociedad, arrendamiento, compraventa, términos, privacidad | servicios |
| Contrato | clasificacion | ENUM | Clasificación del contrato | Valores: interno, externo | externo |
| Contrato | contenido | TEXT | Cuerpo completo del contrato | Requerido, mín. 900 palabras | *texto legal...* |
| Contrato | fecha_creacion | DATETIME | Fecha y hora de creación | Automático | 2026-05-09 14:32:00 |
| Contrato | fecha_vencimiento | DATE | Fecha de expiración del contrato | Opcional | 2026-12-31 |
| Contrato | estado | ENUM | Estado actual del contrato | Valores: borrador, firmado, vencido | borrador |
| Contrato | score_riesgo | INT | Puntaje de riesgo de 0 a 100 | 0 = mayor riesgo, 100 = seguro | 78 |
| Firma | id_firma | INT | Identificador único de la firma | PK, autoincremental | 7 |
| Firma | imagen_base64 | TEXT | Imagen de la firma en base64 | Requerido | data:image/png;base64,... |
| Firma | sello_tiempo | DATETIME | Fecha y hora UTC de la firma | Automático | 2026-05-09 15:00:00 |
| Firma | ip_firmante | VARCHAR(45) | Dirección IP del firmante | Automático | 192.168.1.10 |
| Firma | hash_documento | VARCHAR(64) | Hash SHA-256 del contrato firmado | Automático | a3f2c1... |
