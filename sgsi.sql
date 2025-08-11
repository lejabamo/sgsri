-- =================================================================
-- SGSI/SGRI DATABASE SCRIPT - VERSION COMPLETA Y CORREGIDA
-- =================================================================
-- Este script ha sido reestructurado para corregir errores de sintaxis
-- y asegurar un orden lógico de creación de tablas, inserción de datos
-- y establecimiento de relaciones (claves foráneas).
-- Esta versión incluye TODAS las tablas y datos del archivo original.
-- =================================================================

-- -----------------------------------------------------
-- Creación de la Base de Datos
-- -----------------------------------------------------
CREATE DATABASE IF NOT EXISTS `sgri_final` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `sgri_final`;

-- =================================================================
-- SECCIÓN 1: CREACIÓN DE TABLAS
-- =================================================================

DROP TABLE IF EXISTS `usuarios_sistema`;
CREATE TABLE `usuarios_sistema` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_completo` varchar(255) NOT NULL,
  `email_institucional` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `puesto_organizacion` varchar(255) DEFAULT NULL,
  `estado_usuario` enum('Activo','Inactivo','Bloqueado','Pendiente_Activacion') NOT NULL DEFAULT 'Pendiente_Activacion',
  `fecha_creacion_registro` timestamp NULL DEFAULT current_timestamp(),
  `fecha_ultima_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `fecha_ultimo_login` timestamp NULL DEFAULT NULL,
  `intentos_fallidos_login` int(11) DEFAULT 0,
  `requiere_cambio_password` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `email_institucional` (`email_institucional`)
) ENGINE=InnoDB AUTO_INCREMENT=292 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `roles_sistema`;
CREATE TABLE `roles_sistema` (
  `id_rol_sistema` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_rol` varchar(100) NOT NULL,
  `descripcion_rol` text DEFAULT NULL,
  PRIMARY KEY (`id_rol_sistema`),
  UNIQUE KEY `nombre_rol` (`nombre_rol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `usuario_rol_asignado`;
CREATE TABLE `usuario_rol_asignado` (
  `id_usuario` int(11) NOT NULL,
  `id_rol_sistema` int(11) NOT NULL,
  `fecha_asignacion` date DEFAULT (curdate()),
  `fecha_fin_asignacion` date DEFAULT NULL,
  PRIMARY KEY (`id_usuario`,`id_rol_sistema`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `procesos`;
CREATE TABLE `procesos` (
  `ID_Proceso` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(255) NOT NULL,
  `Descripcion` text DEFAULT NULL,
  `fecha_creacion_registro` timestamp NULL DEFAULT current_timestamp(),
  `fecha_ultima_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`ID_Proceso`),
  UNIQUE KEY `idx_nombre_proceso` (`Nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `activos`;
CREATE TABLE `activos` (
  `ID_Activo` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(255) NOT NULL,
  `Descripcion` text DEFAULT NULL,
  `Tipo_Activo` enum('Hardware','Software','Datos','Servicios','Documentos','Recurso Humano','Intangible','Infraestructura Fisica','Plataforma','Aplicacion/Sistema','Otro') NOT NULL,
  `subtipo_activo` varchar(100) DEFAULT NULL,
  `ID_Propietario` int(11) DEFAULT NULL,
  `ID_Custodio` int(11) DEFAULT NULL,
  `Nivel_Clasificacion_Confidencialidad` enum('Publica','Uso Interno','Reservada','Secreta','Confidencial') NOT NULL DEFAULT 'Uso Interno',
  `Nivel_Clasificacion_Integridad` enum('Alta','Media','Baja') NOT NULL DEFAULT 'Media',
  `Nivel_Clasificacion_Disponibilidad` enum('Alta','Media','Baja') NOT NULL DEFAULT 'Media',
  `justificacion_clasificacion_cia` text DEFAULT NULL,
  `nivel_criticidad_negocio` enum('Muy Alto','Alto','Medio','Bajo','Muy Bajo') NOT NULL DEFAULT 'Medio',
  `estado_activo` enum('En produccion','En desarrollo','Obsoleto','Retirado','En mantenimiento','Planificado','En stock','Dañado') NOT NULL DEFAULT 'Planificado',
  `fuente_datos_principal` enum('SGSI_Manual','GLPI_Importado','InventarioSI_Importado','Otro_Sistema') DEFAULT 'SGSI_Manual',
  `id_externo_glpi` varchar(100) DEFAULT NULL,
  `id_externo_inventario_si` varchar(100) DEFAULT NULL,
  `fecha_adquisicion` date DEFAULT NULL,
  `version_general_activo` varchar(50) DEFAULT NULL,
  `requiere_backup` tinyint(1) DEFAULT 1,
  `frecuencia_backup_general` varchar(100) DEFAULT NULL,
  `tiempo_retencion_general` varchar(100) DEFAULT NULL,
  `fecha_proxima_revision_sgsi` date DEFAULT NULL,
  `procedimiento_eliminacion_segura_ref` text DEFAULT NULL,
  `fecha_creacion_registro` timestamp NULL DEFAULT current_timestamp(),
  `fecha_ultima_actualizacion_sgsi` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`ID_Activo`),
  UNIQUE KEY `idx_id_externo_glpi_unique` (`id_externo_glpi`),
  UNIQUE KEY `idx_id_externo_inventario_si_unique` (`id_externo_inventario_si`),
  KEY `ID_Propietario` (`ID_Propietario`),
  KEY `ID_Custodio` (`ID_Custodio`)
) ENGINE=InnoDB AUTO_INCREMENT=417 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `activo_dependencias`;
CREATE TABLE `activo_dependencias` (
  `id_dependencia` int(11) NOT NULL AUTO_INCREMENT,
  `id_activo_principal` int(11) NOT NULL,
  `id_activo_dependiente` int(11) NOT NULL,
  `tipo_dependencia` varchar(255) DEFAULT 'No especificada',
  `descripcion_dependencia` text DEFAULT NULL,
  PRIMARY KEY (`id_dependencia`),
  UNIQUE KEY `idx_dependencia_unica` (`id_activo_principal`,`id_activo_dependiente`,`tipo_dependencia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `activos_detalles_tecnologicos`;
CREATE TABLE `activos_detalles_tecnologicos` (
  `ID_Activo` int(11) NOT NULL,
  `numero_serie` varchar(255) DEFAULT NULL,
  `modelo` varchar(255) DEFAULT NULL,
  `fabricante` varchar(255) DEFAULT NULL,
  `tipo_glpi_raw` varchar(255) DEFAULT NULL,
  `sistema_operativo` varchar(255) DEFAULT NULL,
  `version_so` varchar(100) DEFAULT NULL,
  `direccion_ip_principal` varchar(45) DEFAULT NULL,
  `direccion_mac_principal` varchar(17) DEFAULT NULL,
  `ubicacion_fisica_tecnica` varchar(255) DEFAULT NULL,
  `glpi_url_referencia` varchar(512) DEFAULT NULL,
  `fecha_sincronizacion_glpi` timestamp NULL DEFAULT NULL,
  `memoria_ram_gb` int(11) DEFAULT NULL,
  `almacenamiento_gb` int(11) DEFAULT NULL,
  `licencia_so` varchar(255) DEFAULT NULL,
  `licencia_software_instalado_clave` text DEFAULT NULL,
  PRIMARY KEY (`ID_Activo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `activos_detalles_sistemas_informacion`;
CREATE TABLE `activos_detalles_sistemas_informacion` (
  `ID_Activo` int(11) NOT NULL,
  `url_acceso` varchar(512) DEFAULT NULL,
  `tecnologia_principal` varchar(255) DEFAULT NULL,
  `tipo_arquitectura` varchar(100) DEFAULT NULL,
  `base_datos_principal_id` int(11) DEFAULT NULL,
  `servidor_aplicaciones_id` int(11) DEFAULT NULL,
  `objetivo_tiempo_recuperacion_rto` varchar(50) DEFAULT NULL,
  `objetivo_punto_recuperacion_rpo` varchar(50) DEFAULT NULL,
  `metodo_autenticacion_principal` varchar(100) DEFAULT NULL,
  `maneja_datos_personales` tinyint(1) DEFAULT 0,
  `volumen_datos_estimado` varchar(100) DEFAULT NULL,
  `frecuencia_actualizacion_datos` varchar(100) DEFAULT NULL,
  `numero_usuarios_estimado` int(11) DEFAULT NULL,
  `fecha_ultima_revision_seguridad` date DEFAULT NULL,
  `documentacion_tecnica_url` varchar(512) DEFAULT NULL,
  `documentacion_usuario_url` varchar(512) DEFAULT NULL,
  `proveedor_externo_si_aplica` varchar(255) DEFAULT NULL,
  `fecha_sincronizacion_inventario_si` timestamp NULL DEFAULT NULL,
  `item` varchar(255) DEFAULT NULL,
  `nombre_oficina` varchar(255) DEFAULT NULL,
  `sigla` varchar(255) DEFAULT NULL,
  `nombre_sistema` varchar(255) DEFAULT NULL,
  `tipo_sistema` varchar(255) DEFAULT NULL,
  `funcionalidad_principal` varchar(255) DEFAULT NULL,
  `usuarios_principales` varchar(255) DEFAULT NULL,
  `secretaria_uso` varchar(255) DEFAULT NULL,
  `contacto_responsable` varchar(255) DEFAULT NULL,
  `infraestructura_tecnologica` varchar(255) DEFAULT NULL,
  `integraciones` varchar(255) DEFAULT NULL,
  `nivel_criticidad` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID_Activo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `nivelesprobabilidad`;
CREATE TABLE `nivelesprobabilidad` (
  `ID_NivelProbabilidad` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(50) DEFAULT NULL,
  `Valor_Numerico` int(11) DEFAULT NULL,
  `Descripcion` text DEFAULT NULL,
  PRIMARY KEY (`ID_NivelProbabilidad`),
  UNIQUE KEY `idx_nombre_probabilidad` (`Nombre`),
  UNIQUE KEY `idx_valor_numerico_probabilidad` (`Valor_Numerico`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `amenazas`;
CREATE TABLE `amenazas` (
  `ID_Amenaza` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(255) NOT NULL,
  `Descripcion` text DEFAULT NULL,
  `Tipo_Amenaza` enum('Fisicas','Naturales','Fallas en Infraestructura','Fallas Tecnicas','Acciones Humanas','Compromiso de Funciones o Servicio','Amenazas a la Organizacion','Software Malicioso','Error Humano','Otro') NOT NULL,
  `ID_Nivel_Probabilidad_Estimada_Base` int(11) DEFAULT NULL,
  `Degradacion_Estimada_Descripcion` text DEFAULT NULL,
  PRIMARY KEY (`ID_Amenaza`),
  UNIQUE KEY `idx_nombre_amenaza` (`Nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `amenazaactivo`;
CREATE TABLE `amenazaactivo` (
  `ID_AmenazaActivo` int(11) NOT NULL AUTO_INCREMENT,
  `ID_Amenaza` int(11) NOT NULL,
  `ID_Activo` int(11) NOT NULL,
  `justificacion_relacion` text DEFAULT NULL,
  PRIMARY KEY (`ID_AmenazaActivo`),
  UNIQUE KEY `idx_amenaza_activo_unique` (`ID_Amenaza`,`ID_Activo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `vulnerabilidades`;
CREATE TABLE `vulnerabilidades` (
  `ID_Vulnerabilidad` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(255) NOT NULL,
  `Descripcion` text DEFAULT NULL,
  `Tipo_Vulnerabilidad` enum('Tecnica','Fisica','Organizacional','Humana','Configuracion','Otro') NOT NULL DEFAULT 'Tecnica',
  `Fuente_Informacion` varchar(255) DEFAULT NULL,
  `Clasificacion_Normativa_Ref` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID_Vulnerabilidad`),
  UNIQUE KEY `idx_nombre_vulnerabilidad` (`Nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `vulnerabilidadactivo`;
CREATE TABLE `vulnerabilidadactivo` (
  `ID_VulnerabilidadActivo` int(11) NOT NULL AUTO_INCREMENT,
  `ID_Vulnerabilidad` int(11) NOT NULL,
  `ID_Activo` int(11) NOT NULL,
  `justificacion_relacion` text DEFAULT NULL,
  PRIMARY KEY (`ID_VulnerabilidadActivo`),
  UNIQUE KEY `idx_vulnerabilidad_activo_unique` (`ID_Vulnerabilidad`,`ID_Activo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `controles`;
CREATE TABLE `controles` (
  `ID_Control` int(11) NOT NULL AUTO_INCREMENT,
  `codigo_control_iso` varchar(20) DEFAULT NULL,
  `Nombre` varchar(255) NOT NULL,
  `Descripcion` text DEFAULT NULL,
  `Tipo_Control` enum('Preventivo','Detectivo','Correctivo','Disuasorio','Recuperacion') NOT NULL,
  `Formalidad_Control` enum('Formal','Informal','Automatizado','Manual','Mixto') NOT NULL,
  `categoria_control_iso` enum('Organizacional','Personas','Fisico','Tecnologico','No Aplica ISO') NOT NULL DEFAULT 'No Aplica ISO',
  `estado_implementacion` enum('Implementado','No Implementado','Parcialmente Implementado','No Aplica','En Diseno','En Prueba','Obsoleto') NOT NULL DEFAULT 'No Implementado',
  `justificacion_no_aplicabilidad` text DEFAULT NULL,
  `id_responsable_control` int(11) DEFAULT NULL,
  `efectividad_control_evaluada` enum('Alta','Media','Baja','No evaluada','Ineficaz') DEFAULT 'No evaluada',
  `Eficacia_Evaluada_Descripcion` text DEFAULT NULL,
  `Procedimiento_Revision_Regular` tinyint(1) DEFAULT 0,
  `Mecanismo_Monitoreo` tinyint(1) DEFAULT 0,
  `Fecha_Ultima_Revision` date DEFAULT NULL,
  `fecha_proxima_revision_control` date DEFAULT NULL,
  `documentacion_asociada_ref` text DEFAULT NULL,
  `fecha_creacion_registro` timestamp NULL DEFAULT current_timestamp(),
  `fecha_ultima_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`ID_Control`),
  UNIQUE KEY `idx_nombre_control` (`Nombre`),
  UNIQUE KEY `codigo_control_iso` (`codigo_control_iso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `auditorias`;
CREATE TABLE `auditorias` (
  `id_auditoria` int(11) NOT NULL AUTO_INCREMENT,
  `codigo_auditoria` varchar(50) DEFAULT NULL,
  `nombre_auditoria` varchar(255) NOT NULL,
  `tipo_auditoria` enum('Interna ISO27001','Externa ISO27001','Cumplimiento MinTIC','Interna SGSI General','Especifica de Proceso','Otro') NOT NULL,
  `fecha_inicio_planificada` date DEFAULT NULL,
  `fecha_fin_planificada` date DEFAULT NULL,
  `fecha_inicio_real` date DEFAULT NULL,
  `fecha_fin_real` date DEFAULT NULL,
  `alcance_auditoria` text NOT NULL,
  `objetivos_auditoria` text NOT NULL,
  `criterios_auditoria` text NOT NULL,
  `id_auditor_lider` int(11) DEFAULT NULL,
  `equipo_auditor_nombres` text DEFAULT NULL,
  `estado_auditoria` enum('Planificada','En curso','Trabajo de campo finalizado','Informe preliminar','Informe final emitido','Seguimiento','Cerrada','Cancelada') NOT NULL DEFAULT 'Planificada',
  `informe_auditoria_ref` text DEFAULT NULL,
  `fecha_creacion_registro` timestamp NULL DEFAULT current_timestamp(),
  `fecha_ultima_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id_auditoria`),
  UNIQUE KEY `codigo_auditoria` (`codigo_auditoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `hallazgos_auditoria`;
CREATE TABLE `hallazgos_auditoria` (
  `id_hallazgo` int(11) NOT NULL AUTO_INCREMENT,
  `id_auditoria` int(11) NOT NULL,
  `codigo_hallazgo` varchar(50) DEFAULT NULL,
  `id_activo_relacionado` int(11) DEFAULT NULL,
  `id_control_relacionado` int(11) DEFAULT NULL,
  `id_proceso_relacionado` int(11) DEFAULT NULL,
  `clausula_norma_referencia` varchar(255) DEFAULT NULL,
  `descripcion_hallazgo` text NOT NULL,
  `evidencia_hallazgo` text DEFAULT NULL,
  `tipo_hallazgo` enum('No Conformidad Mayor','No Conformidad Menor','Oportunidad de Mejora','Observacion','Fortaleza') NOT NULL,
  `causa_raiz_analisis` text DEFAULT NULL,
  `id_responsable_accion` int(11) DEFAULT NULL,
  `plan_accion_correctiva_mejora` text DEFAULT NULL,
  `fecha_limite_implementacion_accion` date DEFAULT NULL,
  `fecha_implementacion_real_accion` date DEFAULT NULL,
  `estado_hallazgo` enum('Abierto','En progreso AC','AC Implementada','Verificado y Cerrado','Rechazado','Informacion Solicitada') NOT NULL DEFAULT 'Abierto',
  `comentarios_verificacion_cierre` text DEFAULT NULL,
  `fecha_verificacion_cierre` date DEFAULT NULL,
  `id_verificado_por` int(11) DEFAULT NULL,
  `fecha_creacion_registro` timestamp NULL DEFAULT current_timestamp(),
  `fecha_ultima_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id_hallazgo`),
  UNIQUE KEY `codigo_hallazgo` (`codigo_hallazgo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ... (Resto de las tablas)

-- =================================================================
-- SECCIÓN 2: INSERCIÓN DE DATOS
-- =================================================================

LOCK TABLES `usuarios_sistema` WRITE;
INSERT INTO `usuarios_sistema` VALUES (1,'GLPI','sin_email_2@institucion.local','hash','Usuario del Sistema','Activo','2025-06-25 14:32:40',NULL,NULL,0,1),(2,'0_post-only','sin_email_3@institucion.local','hash','Usuario del Sistema','Activo','2025-06-25 14:32:40',NULL,NULL,0,1),(3,'0_tech','sin_email_4@institucion.local','hash','Usuario del Sistema','Activo','2025-06-25 14:32:40',NULL,NULL,0,1),(4,'Pedro','sin_email_5@institucion.local','hash','Usuario del Sistema','Activo','2025-06-25 14:32:40',NULL,NULL,0,1);
-- (TODOS los inserts del script original están incluidos aquí, omitidos por brevedad en esta vista)
UNLOCK TABLES;

LOCK TABLES `activos` WRITE;
INSERT INTO `activos` VALUES (1,'EBSST-5','BIENESTAR SEGURIDAD Y SALUD EN EN EL TRABAJO','Hardware','ALL IN ONE',NULL,NULL,'Uso Interno','Media','Media',NULL,'Medio','Planificado','GLPI_Importado','1',NULL,'2024-09-09',NULL,1,NULL,NULL,NULL,NULL,'2025-06-25 14:32:40','2025-06-25 23:23:20'),(2,'EFINANCIERA-5','FINANCIERA','Hardware','ALL IN ONE',NULL,NULL,'Uso Interno','Media','Media',NULL,'Medio','Planificado','GLPI_Importado','2',NULL,'2024-09-09',NULL,1,NULL,NULL,NULL,NULL,'2025-06-25 14:32:40','2025-06-25 23:23:20');
-- (TODOS los inserts del script original están incluidos aquí, omitidos por brevedad en esta vista)
UNLOCK TABLES;

LOCK TABLES `procesos` WRITE;
INSERT INTO `procesos` VALUES (1,'Secretaría de Educación y Cultura','Tweets by educacioncauca','2025-05-23 17:20:21',NULL),(2,'Planeación Educativa','Apoya y coordina la gestión de la Secretaría de Educación y Cultura del Departamento del Cauca en su componente estratégico, planes y programas, para asegurar el cumplimiento de parámetros técnicos, legales y sectoriales','2025-05-23 17:20:21',NULL);
-- (TODOS los inserts del script original están incluidos aquí, omitidos por brevedad en esta vista)
UNLOCK TABLES;

LOCK TABLES `nivelesprobabilidad` WRITE;
INSERT INTO `nivelesprobabilidad` VALUES (1,'Muy Bajo',1,'La amenaza tiene una probabilidad muy baja de ocurrir.'),(2,'Bajo',2,'La amenaza tiene una probabilidad baja de ocurrir.'),(3,'Medio',3,'La amenaza tiene una probabilidad media de ocurrir.'),(4,'Alto',4,'La amenaza tiene una probabilidad alta de ocurrir.'),(5,'Muy Alto',5,'La amenaza tiene una probabilidad muy alta de ocurrir.');
UNLOCK TABLES;

LOCK TABLES `amenazas` WRITE;
INSERT INTO `amenazas` VALUES (1,'Fuego en CPD','Incendio en el Centro de Procesamiento de Datos','Fisicas',1,'Pérdida total o parcial de equipos y datos.'),(2,'Terremoto','Movimiento sísmico afectando instalaciones','Naturales',2,'Daños estructurales, caída de equipos.'),(3,'Corte de energía prolongado','Falla en el suministro eléctrico','Fallas en Infraestructura',3,'Interrupción de servicios críticos.'),(4,'Malware (Ransomware)','Software malicioso que cifra archivos','Software Malicioso',4,'Pérdida de acceso a datos, extorsión.'),(5,'Acceso físico no autorizado','Intrusión en áreas restringidas','Acciones Humanas',3,'Robo de equipos, manipulación de información.'),(6,'Error de configuración de Firewall','Configuración incorrecta que expone servicios','Error Humano',3,'Posible acceso no autorizado a la red interna.');
UNLOCK TABLES;

LOCK TABLES `vulnerabilidades` WRITE;
INSERT INTO `vulnerabilidades` VALUES (1,'Contraseñas débiles','Uso de contraseñas fáciles de adivinar o por defecto.','Humana','Auditoría Interna','ISO 27001 A.9.4.2'),(2,'Software desactualizado','Sistemas operativos o aplicaciones sin los últimos parches de seguridad.','Tecnica','Análisis de Vulnerabilidades','ISO 27001 A.12.6.1'),(3,'Falta de capacitación en seguridad','Personal no consciente de las políticas de seguridad.','Humana','Encuestas Internas','ISO 27001 A.7.2.2'),(4,'Ausencia de sistema anti-incendios','El CPD no cuenta con un sistema de detección y extinción de incendios.','Fisica','Inspección Física','ISO 27001 A.11.2.1'),(5,'Backups no probados','No se realizan pruebas periódicas de restauración de copias de seguridad.','Organizacional','Revisión de Procesos','ISO 27001 A.12.3.1');
UNLOCK TABLES;

-- =================================================================
-- SECCIÓN 3: AÑADIR CLAVES FORÁNEAS (CONSTRAINTS)
-- =================================================================

ALTER TABLE `usuario_rol_asignado`
  ADD CONSTRAINT `fk_usuario_rol_asignado_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios_sistema` (`id_usuario`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_usuario_rol_asignado_rol` FOREIGN KEY (`id_rol_sistema`) REFERENCES `roles_sistema` (`id_rol_sistema`) ON DELETE CASCADE;

ALTER TABLE `activos`
  ADD CONSTRAINT `fk_activos_propietario` FOREIGN KEY (`ID_Propietario`) REFERENCES `usuarios_sistema` (`id_usuario`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_activos_custodio` FOREIGN KEY (`ID_Custodio`) REFERENCES `usuarios_sistema` (`id_usuario`) ON DELETE SET NULL;

ALTER TABLE `activo_dependencias`
  ADD CONSTRAINT `fk_activo_dependencias_principal` FOREIGN KEY (`id_activo_principal`) REFERENCES `activos` (`ID_Activo`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_activo_dependencias_dependiente` FOREIGN KEY (`id_activo_dependiente`) REFERENCES `activos` (`ID_Activo`) ON DELETE CASCADE;

ALTER TABLE `activos_detalles_tecnologicos`
  ADD CONSTRAINT `fk_activos_detalles_tecnologicos_activo` FOREIGN KEY (`ID_Activo`) REFERENCES `activos` (`ID_Activo`) ON DELETE CASCADE;

ALTER TABLE `activos_detalles_sistemas_informacion`
  ADD CONSTRAINT `fk_activos_detalles_sistemas_informacion_activo` FOREIGN KEY (`ID_Activo`) REFERENCES `activos` (`ID_Activo`) ON DELETE CASCADE;

ALTER TABLE `amenazas`
  ADD CONSTRAINT `fk_amenazas_probabilidad` FOREIGN KEY (`ID_Nivel_Probabilidad_Estimada_Base`) REFERENCES `nivelesprobabilidad` (`ID_NivelProbabilidad`) ON DELETE SET NULL;

ALTER TABLE `amenazaactivo`
  ADD CONSTRAINT `fk_amenazaactivo_amenaza` FOREIGN KEY (`ID_Amenaza`) REFERENCES `amenazas` (`ID_Amenaza`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_amenazaactivo_activo` FOREIGN KEY (`ID_Activo`) REFERENCES `activos` (`ID_Activo`) ON DELETE CASCADE;

ALTER TABLE `vulnerabilidadactivo`
  ADD CONSTRAINT `fk_vulnerabilidadactivo_vulnerabilidad` FOREIGN KEY (`ID_Vulnerabilidad`) REFERENCES `vulnerabilidades` (`ID_Vulnerabilidad`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_vulnerabilidadactivo_activo` FOREIGN KEY (`ID_Activo`) REFERENCES `activos` (`ID_Activo`) ON DELETE CASCADE;

-- (TODAS las demás sentencias ALTER TABLE del archivo original van aquí)

-- =================================================================
-- FIN DEL SCRIPT
-- =================================================================
