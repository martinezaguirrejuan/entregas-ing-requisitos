-- ============================================================
-- ContractAI — Script DDL v1.0
-- Ingenieria de Software II — Corporacion Universitaria Remington
-- Autor: Juan Fernando Martinez Aguirre
-- Fecha: 24/10/2026
-- Linea Base: LB-1
-- Gestor: MySQL / MariaDB 10.6+
-- ============================================================

CREATE DATABASE IF NOT EXISTS contractai CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE contractai;

-- ── Catalogo de Roles ─────────────────────────────────────────────────────────
CREATE TABLE Rol (
    id_rol        CHAR(36)     PRIMARY KEY DEFAULT (UUID()),
    nombre_rol    VARCHAR(50)  NOT NULL UNIQUE,
    descripcion   VARCHAR(200) NULL
);

-- ── Catalogo de Tipos de Contrato ─────────────────────────────────────────────
CREATE TABLE TipoContrato (
    id_tipo       CHAR(36)     PRIMARY KEY DEFAULT (UUID()),
    nombre_tipo   VARCHAR(80)  NOT NULL UNIQUE,
    descripcion   VARCHAR(200) NULL
);

-- ── Usuarios ──────────────────────────────────────────────────────────────────
-- RN-006: correo unico | RN-015: hash de contrasena | RN-016: intentos fallidos
CREATE TABLE Usuario (
    id_usuario          CHAR(36)     PRIMARY KEY DEFAULT (UUID()),
    correo              VARCHAR(150) NOT NULL UNIQUE,                  -- RN-006
    hash_contrasena     VARCHAR(255) NOT NULL,                         -- RN-015: minimo 8 chars, 1 mayus, 1 num
    activo              BOOLEAN      NOT NULL DEFAULT TRUE,
    mfa_activado        BOOLEAN      NOT NULL DEFAULT FALSE,           -- HU-22
    intentos_fallidos   TINYINT      NOT NULL DEFAULT 0,               -- RN-016
    bloqueado_hasta     DATETIME     NULL,                             -- RN-016: bloqueo 15 min
    fecha_registro      DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_rol              CHAR(36)     NOT NULL,
    CONSTRAINT fk_usr_rol FOREIGN KEY (id_rol) REFERENCES Rol(id_rol)
);

-- ── Contratos ─────────────────────────────────────────────────────────────────
-- RN-001: solo accesible si autenticado | RN-3FN-05: estado Vencido por cron
CREATE TABLE Contrato (
    id_contrato          CHAR(36)     PRIMARY KEY DEFAULT (UUID()),
    titulo               VARCHAR(200) NOT NULL,
    estado               ENUM('Borrador','Activo','Firmado','Vencido') NOT NULL DEFAULT 'Borrador',
    clasificacion        ENUM('interno','externo') NOT NULL,           -- HU-11 / RN-011
    puntaje_riesgo       DECIMAL(5,2) NULL COMMENT 'Derivado: RN-3FN-02',
    fecha_creacion       DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion  DATETIME     NULL ON UPDATE CURRENT_TIMESTAMP,
    fecha_inicio         DATE         NULL,
    fecha_vencimiento    DATE         NULL,                            -- HU-15 / RN-3FN-05
    id_usuario           CHAR(36)     NOT NULL,
    id_tipo              CHAR(36)     NULL,
    CONSTRAINT fk_cont_usr  FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    CONSTRAINT fk_cont_tipo FOREIGN KEY (id_tipo)    REFERENCES TipoContrato(id_tipo),
    CONSTRAINT chk_fechas   CHECK (fecha_vencimiento IS NULL OR fecha_vencimiento >= fecha_inicio)
);

-- ── Versiones de Contrato ─────────────────────────────────────────────────────
-- HU-09, HU-13 | RF-007: versionar antes de editar
CREATE TABLE VersionContrato (
    id_version       CHAR(36)  PRIMARY KEY DEFAULT (UUID()),
    numero_version   INT       NOT NULL,
    contenido_texto  LONGTEXT  NOT NULL,
    fecha_creacion   DATETIME  NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_contrato      CHAR(36)  NOT NULL,
    id_usuario       CHAR(36)  NOT NULL,
    CONSTRAINT fk_ver_cont FOREIGN KEY (id_contrato) REFERENCES Contrato(id_contrato),
    CONSTRAINT fk_ver_usr  FOREIGN KEY (id_usuario)  REFERENCES Usuario(id_usuario),
    CONSTRAINT uq_ver      UNIQUE (id_contrato, numero_version)       -- RF-011
);

-- ── Plantillas de Contrato ────────────────────────────────────────────────────
-- RN-014: solo Admin puede gestionarlas | RN-3FN-08: trigger valida rol admin
CREATE TABLE Plantilla (
    id_plantilla    CHAR(36)     PRIMARY KEY DEFAULT (UUID()),
    nombre          VARCHAR(100) NOT NULL,
    contenido_base  LONGTEXT     NOT NULL,
    activa          BOOLEAN      NOT NULL DEFAULT TRUE,
    fecha_creacion  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_tipo         CHAR(36)     NULL,
    id_admin        CHAR(36)     NOT NULL COMMENT 'Debe referenciar usuario con rol administrador (RN-3FN-08)',
    CONSTRAINT fk_plt_tipo  FOREIGN KEY (id_tipo)  REFERENCES TipoContrato(id_tipo),
    CONSTRAINT fk_plt_admin FOREIGN KEY (id_admin) REFERENCES Usuario(id_usuario)
);

-- Trigger: RN-3FN-08 — Plantilla.id_admin debe tener rol administrador
DELIMITER //
CREATE TRIGGER trg_plantilla_admin_rol BEFORE INSERT ON Plantilla
FOR EACH ROW
BEGIN
    DECLARE v_rol VARCHAR(50);
    SELECT r.nombre_rol INTO v_rol
    FROM Usuario u JOIN Rol r ON u.id_rol = r.id_rol
    WHERE u.id_usuario = NEW.id_admin;
    IF v_rol != 'administrador' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'RN-3FN-08: id_admin debe referenciar un usuario con rol administrador';
    END IF;
END//
DELIMITER ;

-- ── Firmantes Externos ────────────────────────────────────────────────────────
-- HU-07: firmantes sin cuenta en el sistema
CREATE TABLE FirmanteExterno (
    id_firmante  CHAR(36)     PRIMARY KEY DEFAULT (UUID()),
    nombre       VARCHAR(150) NOT NULL,
    correo       VARCHAR(150) NOT NULL UNIQUE,
    telefono     VARCHAR(20)  NULL
);

-- ── Firmas ────────────────────────────────────────────────────────────────────
-- RN-3FN-01: XOR de autoria (id_usuario XOR id_firmante)
CREATE TABLE Firma (
    id_firma          CHAR(36)      PRIMARY KEY DEFAULT (UUID()),
    ruta_imagen_firma VARCHAR(500)  NOT NULL,
    en_biblioteca     BOOLEAN       NOT NULL DEFAULT FALSE,            -- HU-06
    fecha_creacion    DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_usuario        CHAR(36)      NULL,
    id_firmante       CHAR(36)      NULL,
    CONSTRAINT fk_fir_usr FOREIGN KEY (id_usuario)  REFERENCES Usuario(id_usuario),
    CONSTRAINT fk_fir_ext FOREIGN KEY (id_firmante) REFERENCES FirmanteExterno(id_firmante),
    CONSTRAINT chk_xor_autoria CHECK (                                -- RN-3FN-01
        (id_usuario IS NOT NULL AND id_firmante IS NULL) OR
        (id_usuario IS NULL     AND id_firmante IS NOT NULL)
    )
);

-- ── Firmas Solicitadas ────────────────────────────────────────────────────────
-- HU-23 / RF-030 | UNIQUE dobles: RN impide duplicados
CREATE TABLE FirmaSolicitada (
    id_solicitud     CHAR(36)  PRIMARY KEY DEFAULT (UUID()),
    orden            INT       NOT NULL,
    estado           ENUM('Pendiente','Firmado','Cancelado') NOT NULL DEFAULT 'Pendiente',
    fecha_solicitud  DATETIME  NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_contrato      CHAR(36)  NOT NULL,
    id_usuario       CHAR(36)  NULL,
    id_firmante      CHAR(36)  NULL,
    CONSTRAINT fk_fs_cont FOREIGN KEY (id_contrato) REFERENCES Contrato(id_contrato),
    CONSTRAINT fk_fs_usr  FOREIGN KEY (id_usuario)  REFERENCES Usuario(id_usuario),
    CONSTRAINT fk_fs_ext  FOREIGN KEY (id_firmante) REFERENCES FirmanteExterno(id_firmante),
    CONSTRAINT uq_fs_usr  UNIQUE (id_contrato, id_usuario),
    CONSTRAINT uq_fs_ext  UNIQUE (id_contrato, id_firmante),
    CONSTRAINT uq_fs_ord  UNIQUE (id_contrato, orden)
);

-- ── Enlaces Compartidos ───────────────────────────────────────────────────────
-- HU-07 / RF-015 | RN-005: valido solo si activo AND fecha_expiracion > NOW()
CREATE TABLE EnlaceCompartir (
    id_enlace         CHAR(36)     PRIMARY KEY DEFAULT (UUID()),
    token             VARCHAR(255) NOT NULL UNIQUE,
    estado            ENUM('activo','revocado','vencido') NOT NULL DEFAULT 'activo',
    fecha_expiracion  DATETIME     NOT NULL,
    correo_destino    VARCHAR(150) NOT NULL,
    fecha_creacion    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_contrato       CHAR(36)     NOT NULL,
    CONSTRAINT fk_enl_cont FOREIGN KEY (id_contrato) REFERENCES Contrato(id_contrato)
);

-- ── Accesos a Enlace ──────────────────────────────────────────────────────────
-- HU-25 / RF-040: registro automatico de cada apertura del enlace
CREATE TABLE AccesoEnlace (
    id_acceso     CHAR(36)     PRIMARY KEY DEFAULT (UUID()),
    fecha_acceso  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ip_acceso     VARCHAR(45)  NOT NULL,
    user_agent    VARCHAR(500) NULL,
    id_enlace     CHAR(36)     NOT NULL,
    CONSTRAINT fk_acc_enl FOREIGN KEY (id_enlace) REFERENCES EnlaceCompartir(id_enlace)
);

-- ── Constancias de Firma ──────────────────────────────────────────────────────
-- RN-013: INMUTABLE | FK RESTRICT: no se puede eliminar contrato ni firma con constancia
CREATE TABLE ConstanciaFirma (
    id_constancia  CHAR(36)     PRIMARY KEY DEFAULT (UUID()),
    sello_utc      DATETIME(3)  NOT NULL,
    ip_firmante    VARCHAR(45)  NOT NULL,
    hash_sha256    CHAR(64)     NOT NULL,
    id_contrato    CHAR(36)     NOT NULL,
    id_firma       CHAR(36)     NOT NULL,
    CONSTRAINT fk_cf_cont FOREIGN KEY (id_contrato) REFERENCES Contrato(id_contrato) ON DELETE RESTRICT, -- RN-003
    CONSTRAINT fk_cf_fir  FOREIGN KEY (id_firma)    REFERENCES Firma(id_firma)       ON DELETE RESTRICT  -- RN-004
);

-- ── Interacciones con IA ──────────────────────────────────────────────────────
-- HU-01, HU-02, HU-09, HU-12 | RN-009: timeout del servicio de IA
CREATE TABLE InteraccionIA (
    id_interaccion      CHAR(36)     PRIMARY KEY DEFAULT (UUID()),
    tipo_operacion      ENUM('generar','modificar','consultar','analizar') NOT NULL,
    origen_ia           ENUM('chatbot','ia_general') NOT NULL,
    entrada_usuario     LONGTEXT     NOT NULL,
    resultado_operacion TEXT         NULL,
    modelo_utilizado    VARCHAR(100) NULL,
    fecha               DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_usuario          CHAR(36)     NOT NULL,
    id_contrato         CHAR(36)     NULL,
    CONSTRAINT fk_ia_usr  FOREIGN KEY (id_usuario)  REFERENCES Usuario(id_usuario),
    CONSTRAINT fk_ia_cont FOREIGN KEY (id_contrato) REFERENCES Contrato(id_contrato)
);

-- ── Analisis de Riesgo ────────────────────────────────────────────────────────
-- HU-02 / RF-013, RF-014 | RN-002: alerta si puntaje > 70/100
CREATE TABLE AnalisisRiesgo (
    id_analisis     CHAR(36)  PRIMARY KEY DEFAULT (UUID()),
    clausula        TEXT      NOT NULL,
    nivel_riesgo    ENUM('bajo','medio','alto') NOT NULL,
    peso_riesgo     TINYINT   NOT NULL CHECK (peso_riesgo BETWEEN 1 AND 5),
    descripcion     TEXT      NOT NULL,
    sugerencia      TEXT      NULL,
    id_interaccion  CHAR(36)  NOT NULL,
    id_contrato     CHAR(36)  NOT NULL,
    CONSTRAINT fk_ar_ia   FOREIGN KEY (id_interaccion) REFERENCES InteraccionIA(id_interaccion),
    CONSTRAINT fk_ar_cont FOREIGN KEY (id_contrato)    REFERENCES Contrato(id_contrato)
);

-- ── Notificaciones ────────────────────────────────────────────────────────────
-- HU-14 / RF-021 | RN-012: alerta 7 dias antes del vencimiento
CREATE TABLE Notificacion (
    id_notificacion    CHAR(36)     PRIMARY KEY DEFAULT (UUID()),
    tipo_notificacion  VARCHAR(80)  NOT NULL,
    mensaje            TEXT         NOT NULL,
    canal              ENUM('correo','push','sistema') NOT NULL DEFAULT 'sistema',
    leida              BOOLEAN      NOT NULL DEFAULT FALSE,
    fecha_creacion     DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_lectura      DATETIME     NULL,
    id_usuario         CHAR(36)     NOT NULL,
    CONSTRAINT fk_noti_usr FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

-- ── Tokens de Recuperacion ────────────────────────────────────────────────────
-- HU-16 / RF-016 | RN-010: expira en 24h, de un solo uso
CREATE TABLE TokenRecuperacion (
    id_token          CHAR(36)     PRIMARY KEY DEFAULT (UUID()),
    token             VARCHAR(255) NOT NULL UNIQUE,
    usado             BOOLEAN      NOT NULL DEFAULT FALSE,
    fecha_expiracion  DATETIME     NOT NULL,
    fecha_creacion    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_usuario        CHAR(36)     NOT NULL,
    CONSTRAINT fk_tok_usr FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

-- ── Log de Auditoria ──────────────────────────────────────────────────────────
-- HU-21, HU-24 / RF-003, RF-026, RF-027 | RN-3FN-09: referencia polimorfica
CREATE TABLE LogAuditoria (
    id_log                CHAR(36)     PRIMARY KEY DEFAULT (UUID()),
    accion                VARCHAR(100) NOT NULL,
    entidad_afectada      VARCHAR(80)  NOT NULL COMMENT 'Nombre de la tabla — RN-3FN-09',
    id_registro_afectado  CHAR(36)     NULL      COMMENT 'UUID del registro; sin FK formal — RN-3FN-09',
    ip_origen             VARCHAR(45)  NULL,
    fecha                 DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_usuario            CHAR(36)     NOT NULL,
    CONSTRAINT fk_log_usr FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

-- ── Datos iniciales ───────────────────────────────────────────────────────────
INSERT INTO Rol (id_rol, nombre_rol, descripcion) VALUES
    (UUID(), 'freelancer',    'Usuario independiente que gestiona contratos propios'),
    (UUID(), 'pyme',          'Representante de pequena o mediana empresa'),
    (UUID(), 'administrador', 'Administrador de la plataforma con acceso total');

INSERT INTO TipoContrato (id_tipo, nombre_tipo) VALUES
    (UUID(), 'Prestacion de servicios'),
    (UUID(), 'Confidencialidad (NDA)'),
    (UUID(), 'Arrendamiento'),
    (UUID(), 'Compraventa'),
    (UUID(), 'Laboral'),
    (UUID(), 'Sociedad'),
    (UUID(), 'Consultoria'),
    (UUID(), 'Licencia de software'),
    (UUID(), 'Otro');
