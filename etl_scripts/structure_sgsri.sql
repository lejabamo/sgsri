-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: sgri
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `activo_dependencias`
--

DROP TABLE IF EXISTS `activo_dependencias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activo_dependencias` (
  `id_dependencia` int NOT NULL AUTO_INCREMENT,
  `id_activo_principal` int NOT NULL,
  `id_activo_dependiente` int NOT NULL,
  `tipo_dependencia` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'No especificada',
  `descripcion_dependencia` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id_dependencia`),
  UNIQUE KEY `idx_dependencia_unica` (`id_activo_principal`,`id_activo_dependiente`,`tipo_dependencia`),
  KEY `activo_dependencias_ibfk_2` (`id_activo_dependiente`),
  CONSTRAINT `activo_dependencias_ibfk_1` FOREIGN KEY (`id_activo_principal`) REFERENCES `activos` (`ID_Activo`) ON DELETE CASCADE,
  CONSTRAINT `activo_dependencias_ibfk_2` FOREIGN KEY (`id_activo_dependiente`) REFERENCES `activos` (`ID_Activo`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `activos`
--

DROP TABLE IF EXISTS `activos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activos` (
  `ID_Activo` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Descripcion` text COLLATE utf8mb4_unicode_ci,
  `Tipo_Activo` enum('Hardware','Software','Datos','Servicios','Documentos','Recurso Humano','Intangible','Infraestructura Fisica','Plataforma','Aplicacion/Sistema','Otro') COLLATE utf8mb4_unicode_ci NOT NULL,
  `subtipo_activo` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ID_Propietario` int DEFAULT NULL,
  `ID_Custodio` int DEFAULT NULL,
  `Nivel_Clasificacion_Confidencialidad` enum('Publica','Uso Interno','Reservada','Secreta','Confidencial') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Uso Interno',
  `Nivel_Clasificacion_Integridad` enum('Alta','Media','Baja') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Media',
  `Nivel_Clasificacion_Disponibilidad` enum('Alta','Media','Baja') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Media',
  `justificacion_clasificacion_cia` text COLLATE utf8mb4_unicode_ci,
  `nivel_criticidad_negocio` enum('Muy Alto','Alto','Medio','Bajo','Muy Bajo') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Medio',
  `estado_activo` enum('En produccion','En desarrollo','Obsoleto','Retirado','En mantenimiento','Planificado','En stock','Dañado') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Planificado',
  `fuente_datos_principal` enum('SGSI_Manual','GLPI_Importado','InventarioSI_Importado','Otro_Sistema') COLLATE utf8mb4_unicode_ci DEFAULT 'SGSI_Manual',
  `id_externo_glpi` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_externo_inventario_si` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_adquisicion` date DEFAULT NULL,
  `version_general_activo` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `requiere_backup` tinyint(1) DEFAULT '1',
  `frecuencia_backup_general` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tiempo_retencion_general` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_proxima_revision_sgsi` date DEFAULT NULL,
  `procedimiento_eliminacion_segura_ref` text COLLATE utf8mb4_unicode_ci,
  `fecha_creacion_registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_ultima_actualizacion_sgsi` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID_Activo`),
  UNIQUE KEY `idx_id_externo_glpi_unique` (`id_externo_glpi`),
  UNIQUE KEY `idx_id_externo_inventario_si_unique` (`id_externo_inventario_si`),
  KEY `activos_ibfk_1` (`ID_Propietario`),
  KEY `activos_ibfk_2` (`ID_Custodio`),
  CONSTRAINT `activos_ibfk_1` FOREIGN KEY (`ID_Propietario`) REFERENCES `usuarios_sistema` (`id_usuario`) ON DELETE SET NULL,
  CONSTRAINT `activos_ibfk_2` FOREIGN KEY (`ID_Custodio`) REFERENCES `usuarios_sistema` (`id_usuario`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=420 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `activos_detalles_sistemas_informacion`
--

DROP TABLE IF EXISTS `activos_detalles_sistemas_informacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activos_detalles_sistemas_informacion` (
  `ID_Activo` int NOT NULL AUTO_INCREMENT,
  `url_acceso` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tecnologia_principal` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tipo_arquitectura` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_datos_principal_id` int DEFAULT NULL,
  `servidor_aplicaciones_id` int DEFAULT NULL,
  `objetivo_tiempo_recuperacion_rto` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `objetivo_punto_recuperacion_rpo` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `metodo_autenticacion_principal` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `maneja_datos_personales` tinyint(1) DEFAULT '0',
  `volumen_datos_estimado` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `frecuencia_actualizacion_datos` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `numero_usuarios_estimado` int DEFAULT NULL,
  `fecha_ultima_revision_seguridad` date DEFAULT NULL,
  `documentacion_tecnica_url` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `documentacion_usuario_url` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `proveedor_externo_si_aplica` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_sincronizacion_inventario_si` timestamp NULL DEFAULT NULL,
  `item` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nombre_oficina` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sigla` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nombre_sistema` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tipo_sistema` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `funcionalidad_principal` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `usuarios_principales` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `secretaria_uso` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contacto_responsable` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `infraestructura_tecnologica` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `integraciones` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nivel_criticidad` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID_Activo`),
  KEY `activos_detalles_sistemas_informacion_ibfk_2` (`base_datos_principal_id`),
  KEY `activos_detalles_sistemas_informacion_ibfk_3` (`servidor_aplicaciones_id`),
  CONSTRAINT `activos_detalles_sistemas_informacion_ibfk_1` FOREIGN KEY (`ID_Activo`) REFERENCES `activos` (`ID_Activo`) ON DELETE CASCADE,
  CONSTRAINT `activos_detalles_sistemas_informacion_ibfk_2` FOREIGN KEY (`base_datos_principal_id`) REFERENCES `activos` (`ID_Activo`) ON DELETE SET NULL,
  CONSTRAINT `activos_detalles_sistemas_informacion_ibfk_3` FOREIGN KEY (`servidor_aplicaciones_id`) REFERENCES `activos` (`ID_Activo`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `activos_detalles_tecnologicos`
--

DROP TABLE IF EXISTS `activos_detalles_tecnologicos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activos_detalles_tecnologicos` (
  `ID_Activo` int NOT NULL,
  `numero_serie` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modelo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fabricante` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tipo_glpi_raw` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sistema_operativo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `version_so` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `direccion_ip_principal` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `direccion_mac_principal` varchar(17) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ubicacion_fisica_tecnica` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `glpi_url_referencia` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_sincronizacion_glpi` timestamp NULL DEFAULT NULL,
  `memoria_ram_gb` int DEFAULT NULL,
  `almacenamiento_gb` int DEFAULT NULL,
  `licencia_so` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `licencia_software_instalado_clave` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`ID_Activo`),
  CONSTRAINT `activos_detalles_tecnologicos_ibfk_1` FOREIGN KEY (`ID_Activo`) REFERENCES `activos` (`ID_Activo`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `amenazaactivo`
--

DROP TABLE IF EXISTS `amenazaactivo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `amenazaactivo` (
  `ID_AmenazaActivo` int NOT NULL AUTO_INCREMENT,
  `ID_Amenaza` int NOT NULL,
  `ID_Activo` int NOT NULL,
  `justificacion_relacion` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`ID_AmenazaActivo`),
  UNIQUE KEY `idx_amenaza_activo_unique` (`ID_Amenaza`,`ID_Activo`),
  KEY `amenazaactivo_ibfk_2` (`ID_Activo`),
  CONSTRAINT `amenazaactivo_ibfk_1` FOREIGN KEY (`ID_Amenaza`) REFERENCES `amenazas` (`ID_Amenaza`) ON DELETE CASCADE,
  CONSTRAINT `amenazaactivo_ibfk_2` FOREIGN KEY (`ID_Activo`) REFERENCES `activos` (`ID_Activo`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `amenazas`
--

DROP TABLE IF EXISTS `amenazas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `amenazas` (
  `ID_Amenaza` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Descripcion` text COLLATE utf8mb4_unicode_ci,
  `Tipo_Amenaza` enum('Fisicas','Naturales','Fallas en Infraestructura','Fallas Tecnicas','Acciones Humanas','Compromiso de Funciones o Servicio','Amenazas a la Organizacion','Software Malicioso','Error Humano','Otro') COLLATE utf8mb4_unicode_ci NOT NULL,
  `ID_Nivel_Probabilidad_Estimada_Base` int DEFAULT NULL,
  `Degradacion_Estimada_Descripcion` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`ID_Amenaza`),
  UNIQUE KEY `idx_nombre_amenaza` (`Nombre`),
  KEY `amenazas_ibfk_1` (`ID_Nivel_Probabilidad_Estimada_Base`),
  CONSTRAINT `amenazas_ibfk_1` FOREIGN KEY (`ID_Nivel_Probabilidad_Estimada_Base`) REFERENCES `nivelesprobabilidad` (`ID_NivelProbabilidad`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auditorias`
--

DROP TABLE IF EXISTS `auditorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auditorias` (
  `id_auditoria` int NOT NULL AUTO_INCREMENT,
  `codigo_auditoria` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nombre_auditoria` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo_auditoria` enum('Interna ISO27001','Externa ISO27001','Cumplimiento MinTIC','Interna SGSI General','Especifica de Proceso','Otro') COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_inicio_planificada` date DEFAULT NULL,
  `fecha_fin_planificada` date DEFAULT NULL,
  `fecha_inicio_real` date DEFAULT NULL,
  `fecha_fin_real` date DEFAULT NULL,
  `alcance_auditoria` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `objetivos_auditoria` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `criterios_auditoria` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_auditor_lider` int DEFAULT NULL,
  `equipo_auditor_nombres` text COLLATE utf8mb4_unicode_ci,
  `estado_auditoria` enum('Planificada','En curso','Trabajo de campo finalizado','Informe preliminar','Informe final emitido','Seguimiento','Cerrada','Cancelada') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Planificada',
  `informe_auditoria_ref` text COLLATE utf8mb4_unicode_ci,
  `fecha_creacion_registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_ultima_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_auditoria`),
  UNIQUE KEY `codigo_auditoria` (`codigo_auditoria`),
  KEY `auditorias_ibfk_1` (`id_auditor_lider`),
  CONSTRAINT `auditorias_ibfk_1` FOREIGN KEY (`id_auditor_lider`) REFERENCES `usuarios_sistema` (`id_usuario`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calificacioneficaciacontrol`
--

DROP TABLE IF EXISTS `calificacioneficaciacontrol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `calificacioneficaciacontrol` (
  `ID_CalificacionEficacia` int NOT NULL AUTO_INCREMENT,
  `Nombre_Calificacion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Reduccion_Probabilidad_Puntos` int DEFAULT '0',
  `Reduccion_Impacto_Puntos` int DEFAULT '0',
  `Porcentaje_Reduccion_Probabilidad` decimal(5,2) DEFAULT '0.00',
  `Porcentaje_Reduccion_Impacto` decimal(5,2) DEFAULT '0.00',
  `Descripcion_Metodo` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`ID_CalificacionEficacia`),
  UNIQUE KEY `idx_nombre_calificacioneficacia` (`Nombre_Calificacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `controles`
--

DROP TABLE IF EXISTS `controles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `controles` (
  `ID_Control` int NOT NULL AUTO_INCREMENT,
  `codigo_control_iso` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Descripcion` text COLLATE utf8mb4_unicode_ci,
  `Tipo_Control` enum('Preventivo','Detectivo','Correctivo','Disuasorio','Recuperacion') COLLATE utf8mb4_unicode_ci NOT NULL,
  `Formalidad_Control` enum('Formal','Informal','Automatizado','Manual','Mixto') COLLATE utf8mb4_unicode_ci NOT NULL,
  `categoria_control_iso` enum('Organizacional','Personas','Fisico','Tecnologico','No Aplica ISO') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'No Aplica ISO',
  `estado_implementacion` enum('Implementado','No Implementado','Parcialmente Implementado','No Aplica','En Diseno','En Prueba','Obsoleto') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'No Implementado',
  `justificacion_no_aplicabilidad` text COLLATE utf8mb4_unicode_ci,
  `id_responsable_control` int DEFAULT NULL,
  `efectividad_control_evaluada` enum('Alta','Media','Baja','No evaluada','Ineficaz') COLLATE utf8mb4_unicode_ci DEFAULT 'No evaluada',
  `Eficacia_Evaluada_Descripcion` text COLLATE utf8mb4_unicode_ci,
  `Procedimiento_Revision_Regular` tinyint(1) DEFAULT '0',
  `Mecanismo_Monitoreo` tinyint(1) DEFAULT '0',
  `Fecha_Ultima_Revision` date DEFAULT NULL,
  `fecha_proxima_revision_control` date DEFAULT NULL,
  `documentacion_asociada_ref` text COLLATE utf8mb4_unicode_ci,
  `fecha_creacion_registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_ultima_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID_Control`),
  UNIQUE KEY `idx_nombre_control` (`Nombre`),
  UNIQUE KEY `codigo_control_iso` (`codigo_control_iso`),
  KEY `controles_ibfk_1` (`id_responsable_control`),
  CONSTRAINT `controles_ibfk_1` FOREIGN KEY (`id_responsable_control`) REFERENCES `usuarios_sistema` (`id_usuario`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `evaluacion_riesgo_activo`
--

DROP TABLE IF EXISTS `evaluacion_riesgo_activo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `evaluacion_riesgo_activo` (
  `id_evaluacion_riesgo_activo` int NOT NULL AUTO_INCREMENT,
  `ID_Riesgo` int NOT NULL,
  `ID_Activo` int NOT NULL,
  `id_nivel_probabilidad_inherente` int NOT NULL,
  `id_nivel_impacto_inherente` int NOT NULL,
  `id_nivel_riesgo_inherente_calculado` int DEFAULT NULL,
  `justificacion_evaluacion_inherente` text COLLATE utf8mb4_unicode_ci,
  `fecha_evaluacion_inherente` date NOT NULL DEFAULT (curdate()),
  `id_evaluador_inherente` int DEFAULT NULL,
  `id_nivel_probabilidad_residual` int DEFAULT NULL,
  `id_nivel_impacto_residual` int DEFAULT NULL,
  `id_nivel_riesgo_residual_calculado` int DEFAULT NULL,
  `justificacion_evaluacion_residual` text COLLATE utf8mb4_unicode_ci,
  `fecha_evaluacion_residual` date DEFAULT NULL,
  `id_evaluador_residual` int DEFAULT NULL,
  `fecha_creacion_registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_ultima_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_evaluacion_riesgo_activo`),
  UNIQUE KEY `idx_riesgo_activo_eval_unique` (`ID_Riesgo`,`ID_Activo`),
  KEY `evaluacion_riesgo_activo_ibfk_2` (`ID_Activo`),
  KEY `evaluacion_riesgo_activo_ibfk_3` (`id_nivel_probabilidad_inherente`),
  KEY `evaluacion_riesgo_activo_ibfk_4` (`id_nivel_impacto_inherente`),
  KEY `evaluacion_riesgo_activo_ibfk_5` (`id_nivel_riesgo_inherente_calculado`),
  KEY `evaluacion_riesgo_activo_ibfk_6` (`id_evaluador_inherente`),
  KEY `evaluacion_riesgo_activo_ibfk_7` (`id_nivel_probabilidad_residual`),
  KEY `evaluacion_riesgo_activo_ibfk_8` (`id_nivel_impacto_residual`),
  KEY `evaluacion_riesgo_activo_ibfk_9` (`id_nivel_riesgo_residual_calculado`),
  KEY `evaluacion_riesgo_activo_ibfk_10` (`id_evaluador_residual`),
  CONSTRAINT `evaluacion_riesgo_activo_ibfk_1` FOREIGN KEY (`ID_Riesgo`) REFERENCES `riesgos` (`ID_Riesgo`) ON DELETE CASCADE,
  CONSTRAINT `evaluacion_riesgo_activo_ibfk_10` FOREIGN KEY (`id_evaluador_residual`) REFERENCES `usuarios_sistema` (`id_usuario`),
  CONSTRAINT `evaluacion_riesgo_activo_ibfk_2` FOREIGN KEY (`ID_Activo`) REFERENCES `activos` (`ID_Activo`) ON DELETE CASCADE,
  CONSTRAINT `evaluacion_riesgo_activo_ibfk_3` FOREIGN KEY (`id_nivel_probabilidad_inherente`) REFERENCES `nivelesprobabilidad` (`ID_NivelProbabilidad`),
  CONSTRAINT `evaluacion_riesgo_activo_ibfk_4` FOREIGN KEY (`id_nivel_impacto_inherente`) REFERENCES `nivelesimpacto` (`ID_NivelImpacto`),
  CONSTRAINT `evaluacion_riesgo_activo_ibfk_5` FOREIGN KEY (`id_nivel_riesgo_inherente_calculado`) REFERENCES `nivelesriesgo` (`ID_NivelRiesgo`),
  CONSTRAINT `evaluacion_riesgo_activo_ibfk_6` FOREIGN KEY (`id_evaluador_inherente`) REFERENCES `usuarios_sistema` (`id_usuario`),
  CONSTRAINT `evaluacion_riesgo_activo_ibfk_7` FOREIGN KEY (`id_nivel_probabilidad_residual`) REFERENCES `nivelesprobabilidad` (`ID_NivelProbabilidad`),
  CONSTRAINT `evaluacion_riesgo_activo_ibfk_8` FOREIGN KEY (`id_nivel_impacto_residual`) REFERENCES `nivelesimpacto` (`ID_NivelImpacto`),
  CONSTRAINT `evaluacion_riesgo_activo_ibfk_9` FOREIGN KEY (`id_nivel_riesgo_residual_calculado`) REFERENCES `nivelesriesgo` (`ID_NivelRiesgo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `evaluacion_riesgo_activo_historico`
--

DROP TABLE IF EXISTS `evaluacion_riesgo_activo_historico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `evaluacion_riesgo_activo_historico` (
  `id_evaluacion_historico` int NOT NULL AUTO_INCREMENT,
  `id_evaluacion_riesgo_activo_origen` int DEFAULT NULL,
  `ID_Riesgo` int NOT NULL,
  `ID_Activo` int NOT NULL,
  `id_nivel_probabilidad_inherente` int NOT NULL,
  `id_nivel_impacto_inherente` int NOT NULL,
  `id_nivel_riesgo_inherente_calculado` int DEFAULT NULL,
  `justificacion_evaluacion_inherente` text COLLATE utf8mb4_unicode_ci,
  `fecha_evaluacion_inherente` date NOT NULL,
  `id_evaluador_inherente` int DEFAULT NULL,
  `id_nivel_probabilidad_residual` int DEFAULT NULL,
  `id_nivel_impacto_residual` int DEFAULT NULL,
  `id_nivel_riesgo_residual_calculado` int DEFAULT NULL,
  `justificacion_evaluacion_residual` text COLLATE utf8mb4_unicode_ci,
  `fecha_evaluacion_residual` date DEFAULT NULL,
  `id_evaluador_residual` int DEFAULT NULL,
  `fecha_registro_historico` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `comentario_historico` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'Evaluacion periodica',
  PRIMARY KEY (`id_evaluacion_historico`),
  KEY `idx_hist_riesgo_activo_fecha` (`ID_Riesgo`,`ID_Activo`,`fecha_evaluacion_inherente`),
  KEY `evaluacion_riesgo_activo_historico_ibfk_2` (`ID_Activo`),
  KEY `evaluacion_riesgo_activo_historico_ibfk_3` (`id_nivel_probabilidad_inherente`),
  KEY `evaluacion_riesgo_activo_historico_ibfk_4` (`id_nivel_impacto_inherente`),
  KEY `evaluacion_riesgo_activo_historico_ibfk_5` (`id_nivel_riesgo_inherente_calculado`),
  KEY `evaluacion_riesgo_activo_historico_ibfk_6` (`id_evaluador_inherente`),
  KEY `evaluacion_riesgo_activo_historico_ibfk_7` (`id_nivel_probabilidad_residual`),
  KEY `evaluacion_riesgo_activo_historico_ibfk_8` (`id_nivel_impacto_residual`),
  KEY `evaluacion_riesgo_activo_historico_ibfk_9` (`id_nivel_riesgo_residual_calculado`),
  KEY `evaluacion_riesgo_activo_historico_ibfk_10` (`id_evaluador_residual`),
  CONSTRAINT `evaluacion_riesgo_activo_historico_ibfk_1` FOREIGN KEY (`ID_Riesgo`) REFERENCES `riesgos` (`ID_Riesgo`) ON DELETE CASCADE,
  CONSTRAINT `evaluacion_riesgo_activo_historico_ibfk_10` FOREIGN KEY (`id_evaluador_residual`) REFERENCES `usuarios_sistema` (`id_usuario`),
  CONSTRAINT `evaluacion_riesgo_activo_historico_ibfk_2` FOREIGN KEY (`ID_Activo`) REFERENCES `activos` (`ID_Activo`) ON DELETE CASCADE,
  CONSTRAINT `evaluacion_riesgo_activo_historico_ibfk_3` FOREIGN KEY (`id_nivel_probabilidad_inherente`) REFERENCES `nivelesprobabilidad` (`ID_NivelProbabilidad`),
  CONSTRAINT `evaluacion_riesgo_activo_historico_ibfk_4` FOREIGN KEY (`id_nivel_impacto_inherente`) REFERENCES `nivelesimpacto` (`ID_NivelImpacto`),
  CONSTRAINT `evaluacion_riesgo_activo_historico_ibfk_5` FOREIGN KEY (`id_nivel_riesgo_inherente_calculado`) REFERENCES `nivelesriesgo` (`ID_NivelRiesgo`),
  CONSTRAINT `evaluacion_riesgo_activo_historico_ibfk_6` FOREIGN KEY (`id_evaluador_inherente`) REFERENCES `usuarios_sistema` (`id_usuario`),
  CONSTRAINT `evaluacion_riesgo_activo_historico_ibfk_7` FOREIGN KEY (`id_nivel_probabilidad_residual`) REFERENCES `nivelesprobabilidad` (`ID_NivelProbabilidad`),
  CONSTRAINT `evaluacion_riesgo_activo_historico_ibfk_8` FOREIGN KEY (`id_nivel_impacto_residual`) REFERENCES `nivelesimpacto` (`ID_NivelImpacto`),
  CONSTRAINT `evaluacion_riesgo_activo_historico_ibfk_9` FOREIGN KEY (`id_nivel_riesgo_residual_calculado`) REFERENCES `nivelesriesgo` (`ID_NivelRiesgo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hallazgos_auditoria`
--

DROP TABLE IF EXISTS `hallazgos_auditoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hallazgos_auditoria` (
  `id_hallazgo` int NOT NULL AUTO_INCREMENT,
  `id_auditoria` int NOT NULL,
  `codigo_hallazgo` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_activo_relacionado` int DEFAULT NULL,
  `id_control_relacionado` int DEFAULT NULL,
  `id_proceso_relacionado` int DEFAULT NULL,
  `clausula_norma_referencia` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `descripcion_hallazgo` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `evidencia_hallazgo` text COLLATE utf8mb4_unicode_ci,
  `tipo_hallazgo` enum('No Conformidad Mayor','No Conformidad Menor','Oportunidad de Mejora','Observacion','Fortaleza') COLLATE utf8mb4_unicode_ci NOT NULL,
  `causa_raiz_analisis` text COLLATE utf8mb4_unicode_ci,
  `id_responsable_accion` int DEFAULT NULL,
  `plan_accion_correctiva_mejora` text COLLATE utf8mb4_unicode_ci,
  `fecha_limite_implementacion_accion` date DEFAULT NULL,
  `fecha_implementacion_real_accion` date DEFAULT NULL,
  `estado_hallazgo` enum('Abierto','En progreso AC','AC Implementada','Verificado y Cerrado','Rechazado','Informacion Solicitada') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Abierto',
  `comentarios_verificacion_cierre` text COLLATE utf8mb4_unicode_ci,
  `fecha_verificacion_cierre` date DEFAULT NULL,
  `id_verificado_por` int DEFAULT NULL,
  `fecha_creacion_registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_ultima_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_hallazgo`),
  UNIQUE KEY `codigo_hallazgo` (`codigo_hallazgo`),
  KEY `hallazgos_auditoria_ibfk_1` (`id_auditoria`),
  KEY `hallazgos_auditoria_ibfk_2` (`id_activo_relacionado`),
  KEY `hallazgos_auditoria_ibfk_3` (`id_control_relacionado`),
  KEY `hallazgos_auditoria_ibfk_4` (`id_proceso_relacionado`),
  KEY `hallazgos_auditoria_ibfk_5` (`id_responsable_accion`),
  KEY `hallazgos_auditoria_ibfk_6` (`id_verificado_por`),
  CONSTRAINT `hallazgos_auditoria_ibfk_1` FOREIGN KEY (`id_auditoria`) REFERENCES `auditorias` (`id_auditoria`) ON DELETE CASCADE,
  CONSTRAINT `hallazgos_auditoria_ibfk_2` FOREIGN KEY (`id_activo_relacionado`) REFERENCES `activos` (`ID_Activo`) ON DELETE SET NULL,
  CONSTRAINT `hallazgos_auditoria_ibfk_3` FOREIGN KEY (`id_control_relacionado`) REFERENCES `controles` (`ID_Control`) ON DELETE SET NULL,
  CONSTRAINT `hallazgos_auditoria_ibfk_4` FOREIGN KEY (`id_proceso_relacionado`) REFERENCES `procesos` (`ID_Proceso`) ON DELETE SET NULL,
  CONSTRAINT `hallazgos_auditoria_ibfk_5` FOREIGN KEY (`id_responsable_accion`) REFERENCES `usuarios_sistema` (`id_usuario`) ON DELETE SET NULL,
  CONSTRAINT `hallazgos_auditoria_ibfk_6` FOREIGN KEY (`id_verificado_por`) REFERENCES `usuarios_sistema` (`id_usuario`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `incidente_activos_afectados`
--

DROP TABLE IF EXISTS `incidente_activos_afectados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `incidente_activos_afectados` (
  `id_incidente_activo` int NOT NULL AUTO_INCREMENT,
  `id_incidente` int NOT NULL,
  `ID_Activo` int NOT NULL,
  `detalle_afectacion` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id_incidente_activo`),
  UNIQUE KEY `idx_incidente_activo_unique` (`id_incidente`,`ID_Activo`),
  KEY `incidente_activos_afectados_ibfk_2` (`ID_Activo`),
  CONSTRAINT `incidente_activos_afectados_ibfk_1` FOREIGN KEY (`id_incidente`) REFERENCES `incidentes_seguridad` (`id_incidente`) ON DELETE CASCADE,
  CONSTRAINT `incidente_activos_afectados_ibfk_2` FOREIGN KEY (`ID_Activo`) REFERENCES `activos` (`ID_Activo`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `incidentes`
--

DROP TABLE IF EXISTS `incidentes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `incidentes` (
  `id_incidente` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `tipo_incidente` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `severidad` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ID_Activo` int DEFAULT NULL,
  `fecha_incidente` datetime DEFAULT NULL,
  `fecha_resolucion` datetime DEFAULT NULL,
  `responsable` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `acciones_correctivas` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id_incidente`),
  KEY `ID_Activo` (`ID_Activo`),
  CONSTRAINT `incidentes_ibfk_1` FOREIGN KEY (`ID_Activo`) REFERENCES `activos` (`ID_Activo`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `incidentes_seguridad`
--

DROP TABLE IF EXISTS `incidentes_seguridad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `incidentes_seguridad` (
  `id_incidente` int NOT NULL AUTO_INCREMENT,
  `codigo_incidente` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `titulo_incidente` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion_incidente` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_deteccion` datetime NOT NULL,
  `fecha_reporte` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_reportado_por` int DEFAULT NULL,
  `origen_reporte` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tipo_incidente` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `categoria_incidente` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado_incidente` enum('Reportado','En investigacion','Contenido','Erradicado','Recuperado','Cerrado','Leccion aprendida','Falso Positivo') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Reportado',
  `prioridad_incidente` enum('Critica','Alta','Media','Baja') COLLATE utf8mb4_unicode_ci DEFAULT 'Media',
  `impacto_negocio_estimado` text COLLATE utf8mb4_unicode_ci,
  `id_responsable_gestion` int DEFAULT NULL,
  `fecha_inicio_investigacion` datetime DEFAULT NULL,
  `fecha_resolucion_planificada` datetime DEFAULT NULL,
  `fecha_cierre_incidente` datetime DEFAULT NULL,
  `causa_raiz_identificada` text COLLATE utf8mb4_unicode_ci,
  `acciones_respuesta_inmediata` text COLLATE utf8mb4_unicode_ci,
  `acciones_correctivas_preventivas` text COLLATE utf8mb4_unicode_ci,
  `lecciones_aprendidas` text COLLATE utf8mb4_unicode_ci,
  `fecha_creacion_registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_ultima_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_incidente`),
  UNIQUE KEY `codigo_incidente` (`codigo_incidente`),
  KEY `incidentes_seguridad_ibfk_1` (`id_reportado_por`),
  KEY `incidentes_seguridad_ibfk_2` (`id_responsable_gestion`),
  CONSTRAINT `incidentes_seguridad_ibfk_1` FOREIGN KEY (`id_reportado_por`) REFERENCES `usuarios_sistema` (`id_usuario`) ON DELETE SET NULL,
  CONSTRAINT `incidentes_seguridad_ibfk_2` FOREIGN KEY (`id_responsable_gestion`) REFERENCES `usuarios_sistema` (`id_usuario`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `logs_sistema`
--

DROP TABLE IF EXISTS `logs_sistema`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logs_sistema` (
  `id_log` bigint NOT NULL AUTO_INCREMENT,
  `timestamp_evento` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `id_usuario_actor` int DEFAULT NULL,
  `email_usuario_actor` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tipo_evento` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `modulo_afectado` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_recurso_afectado` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `descripcion_detallada_evento` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `direccion_ip_origen` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `datos_anteriores` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `datos_nuevos` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `estado_evento` enum('Exitoso','Fallido','Informativo') COLLATE utf8mb4_unicode_ci DEFAULT 'Informativo',
  PRIMARY KEY (`id_log`),
  KEY `logs_sistema_ibfk_1` (`id_usuario_actor`),
  CONSTRAINT `logs_sistema_ibfk_1` FOREIGN KEY (`id_usuario_actor`) REFERENCES `usuarios_sistema` (`id_usuario`) ON DELETE SET NULL,
  CONSTRAINT `logs_sistema_chk_1` CHECK (json_valid(`datos_anteriores`)),
  CONSTRAINT `logs_sistema_chk_2` CHECK (json_valid(`datos_nuevos`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrizriesgodefinicion`
--

DROP TABLE IF EXISTS `matrizriesgodefinicion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `matrizriesgodefinicion` (
  `id_matriz_riesgo` int NOT NULL AUTO_INCREMENT,
  `ID_NivelProbabilidad` int NOT NULL,
  `ID_NivelImpacto_ValorNumerico` int NOT NULL,
  `ID_NivelRiesgo_Resultado` int NOT NULL,
  PRIMARY KEY (`id_matriz_riesgo`),
  UNIQUE KEY `idx_prob_imp_val_unico` (`ID_NivelProbabilidad`,`ID_NivelImpacto_ValorNumerico`),
  KEY `matrizriesgodefinicion_ibfk_2` (`ID_NivelRiesgo_Resultado`),
  CONSTRAINT `matrizriesgodefinicion_ibfk_1` FOREIGN KEY (`ID_NivelProbabilidad`) REFERENCES `nivelesprobabilidad` (`ID_NivelProbabilidad`) ON DELETE CASCADE,
  CONSTRAINT `matrizriesgodefinicion_ibfk_2` FOREIGN KEY (`ID_NivelRiesgo_Resultado`) REFERENCES `nivelesriesgo` (`ID_NivelRiesgo`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nivelesimpacto`
--

DROP TABLE IF EXISTS `nivelesimpacto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nivelesimpacto` (
  `ID_NivelImpacto` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Valor_Numerico` int NOT NULL,
  `Dimension_Impacto` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Descripcion_Cualitativa` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`ID_NivelImpacto`),
  UNIQUE KEY `idx_nombre_dimension_impacto` (`Nombre`,`Dimension_Impacto`),
  UNIQUE KEY `idx_valor_dimension_impacto` (`Valor_Numerico`,`Dimension_Impacto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nivelesprobabilidad`
--

DROP TABLE IF EXISTS `nivelesprobabilidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nivelesprobabilidad` (
  `ID_NivelProbabilidad` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Valor_Numerico` int DEFAULT NULL,
  `Descripcion` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`ID_NivelProbabilidad`),
  UNIQUE KEY `idx_nombre_probabilidad` (`Nombre`),
  UNIQUE KEY `idx_valor_numerico_probabilidad` (`Valor_Numerico`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nivelesriesgo`
--

DROP TABLE IF EXISTS `nivelesriesgo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nivelesriesgo` (
  `ID_NivelRiesgo` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Valor_Min` int NOT NULL,
  `Valor_Max` int NOT NULL,
  `Color_Representacion` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Acciones_Sugeridas` text COLLATE utf8mb4_unicode_ci,
  `Descripcion` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`ID_NivelRiesgo`),
  UNIQUE KEY `idx_nombre_nivelriesgo` (`Nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `objetivos_proceso`
--

DROP TABLE IF EXISTS `objetivos_proceso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `objetivos_proceso` (
  `id_objetivo_proceso` int NOT NULL AUTO_INCREMENT,
  `ID_Proceso` int NOT NULL,
  `descripcion_objetivo` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo_objetivo` enum('Principal','Detalle','Funcion','MetaEspecifica','Enlace','EncabezadoSeccion','PuntoClave','PreguntaFrecuente','ReferenciaNormativa','InformacionContacto','MetadatoFuente','Otro') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Detalle',
  `orden` int DEFAULT '0',
  `fecha_creacion_registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_objetivo_proceso`),
  KEY `idx_proceso_orden` (`ID_Proceso`,`orden`),
  CONSTRAINT `objetivos_proceso_ibfk_1` FOREIGN KEY (`ID_Proceso`) REFERENCES `procesos` (`ID_Proceso`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opcionestratamiento`
--

DROP TABLE IF EXISTS `opcionestratamiento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opcionestratamiento` (
  `ID_OpcionTratamiento` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Descripcion` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`ID_OpcionTratamiento`),
  UNIQUE KEY `idx_nombre_opciontratamiento` (`Nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `proceso_responsables`
--

DROP TABLE IF EXISTS `proceso_responsables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proceso_responsables` (
  `id_proceso_responsable` int NOT NULL AUTO_INCREMENT,
  `ID_Proceso` int NOT NULL,
  `id_usuario_responsable` int NOT NULL,
  `tipo_responsabilidad` enum('Dueño del Proceso','Gestor del Proceso','Participante Clave','Consultor') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Dueño del Proceso',
  `fecha_asignacion` date DEFAULT (curdate()),
  `notas_responsabilidad` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id_proceso_responsable`),
  UNIQUE KEY `idx_proceso_usuario_tipo_resp_unique` (`ID_Proceso`,`id_usuario_responsable`,`tipo_responsabilidad`),
  KEY `proceso_responsables_ibfk_2` (`id_usuario_responsable`),
  CONSTRAINT `proceso_responsables_ibfk_1` FOREIGN KEY (`ID_Proceso`) REFERENCES `procesos` (`ID_Proceso`) ON DELETE CASCADE,
  CONSTRAINT `proceso_responsables_ibfk_2` FOREIGN KEY (`id_usuario_responsable`) REFERENCES `usuarios_sistema` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `procesos`
--

DROP TABLE IF EXISTS `procesos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `procesos` (
  `ID_Proceso` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Descripcion` text COLLATE utf8mb4_unicode_ci,
  `fecha_creacion_registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_ultima_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID_Proceso`),
  UNIQUE KEY `idx_nombre_proceso` (`Nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `riesgo_activo`
--

DROP TABLE IF EXISTS `riesgo_activo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `riesgo_activo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_riesgo` int NOT NULL,
  `ID_Activo` int NOT NULL,
  `probabilidad` int DEFAULT NULL,
  `impacto` int DEFAULT NULL,
  `nivel_riesgo_calculado` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `medidas_mitigacion` text COLLATE utf8mb4_unicode_ci,
  `fecha_evaluacion` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_riesgo` (`id_riesgo`),
  KEY `ID_Activo` (`ID_Activo`),
  CONSTRAINT `riesgo_activo_ibfk_1` FOREIGN KEY (`id_riesgo`) REFERENCES `riesgos` (`ID_Riesgo`),
  CONSTRAINT `riesgo_activo_ibfk_2` FOREIGN KEY (`ID_Activo`) REFERENCES `activos` (`ID_Activo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `riesgocontrolaplicado`
--

DROP TABLE IF EXISTS `riesgocontrolaplicado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `riesgocontrolaplicado` (
  `id_riesgo_control_aplicado` int NOT NULL AUTO_INCREMENT,
  `id_evaluacion_riesgo_activo` int NOT NULL,
  `ID_Control` int NOT NULL,
  `Fecha_Aplicacion_Control` date NOT NULL DEFAULT (curdate()),
  `justificacion_aplicacion_control` text COLLATE utf8mb4_unicode_ci,
  `id_calificacion_eficacia_esperada` int DEFAULT NULL,
  `evaluacion_efectividad_real_fecha` date DEFAULT NULL,
  `efectividad_real_observada` enum('Alta','Media','Baja','Ineficaz','No Verificada') COLLATE utf8mb4_unicode_ci DEFAULT 'No Verificada',
  `comentarios_efectividad_real` text COLLATE utf8mb4_unicode_ci,
  `fecha_creacion_registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_riesgo_control_aplicado`),
  UNIQUE KEY `idx_eval_riesgo_control_unique` (`id_evaluacion_riesgo_activo`,`ID_Control`),
  KEY `riesgocontrolaplicado_ibfk_2` (`ID_Control`),
  KEY `riesgocontrolaplicado_ibfk_3` (`id_calificacion_eficacia_esperada`),
  CONSTRAINT `riesgocontrolaplicado_ibfk_1` FOREIGN KEY (`id_evaluacion_riesgo_activo`) REFERENCES `evaluacion_riesgo_activo` (`id_evaluacion_riesgo_activo`) ON DELETE CASCADE,
  CONSTRAINT `riesgocontrolaplicado_ibfk_2` FOREIGN KEY (`ID_Control`) REFERENCES `controles` (`ID_Control`) ON DELETE CASCADE,
  CONSTRAINT `riesgocontrolaplicado_ibfk_3` FOREIGN KEY (`id_calificacion_eficacia_esperada`) REFERENCES `calificacioneficaciacontrol` (`ID_CalificacionEficacia`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `riesgos`
--

DROP TABLE IF EXISTS `riesgos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `riesgos` (
  `ID_Riesgo` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Descripcion` text COLLATE utf8mb4_unicode_ci,
  `ID_Amenaza_General` int DEFAULT NULL,
  `ID_Vulnerabilidad_General` int DEFAULT NULL,
  `ID_Proceso_Principal_Afectado` int DEFAULT NULL,
  `tipo_riesgo` enum('Estrategico','Operacional','Financiero','Legal','Seguridad de la Informacion','Reputacional','Cumplimiento','Otro') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Seguridad de la Informacion',
  `Efectos_Materializacion` text COLLATE utf8mb4_unicode_ci,
  `Fecha_Identificacion` date NOT NULL DEFAULT (curdate()),
  `Estado_Riesgo_General` enum('Identificado','Analizado','En tratamiento','Mitigado','Cerrado','Aceptado','Escalado') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Identificado',
  `ID_Propietario_Riesgo_General` int DEFAULT NULL,
  `fecha_creacion_registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_ultima_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID_Riesgo`),
  UNIQUE KEY `idx_nombre_riesgo` (`Nombre`),
  KEY `riesgos_ibfk_1` (`ID_Amenaza_General`),
  KEY `riesgos_ibfk_2` (`ID_Vulnerabilidad_General`),
  KEY `riesgos_ibfk_3` (`ID_Proceso_Principal_Afectado`),
  KEY `riesgos_ibfk_4` (`ID_Propietario_Riesgo_General`),
  CONSTRAINT `riesgos_ibfk_1` FOREIGN KEY (`ID_Amenaza_General`) REFERENCES `amenazas` (`ID_Amenaza`) ON DELETE SET NULL,
  CONSTRAINT `riesgos_ibfk_2` FOREIGN KEY (`ID_Vulnerabilidad_General`) REFERENCES `vulnerabilidades` (`ID_Vulnerabilidad`) ON DELETE SET NULL,
  CONSTRAINT `riesgos_ibfk_3` FOREIGN KEY (`ID_Proceso_Principal_Afectado`) REFERENCES `procesos` (`ID_Proceso`) ON DELETE SET NULL,
  CONSTRAINT `riesgos_ibfk_4` FOREIGN KEY (`ID_Propietario_Riesgo_General`) REFERENCES `usuarios_sistema` (`id_usuario`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `riesgotratamiento`
--

DROP TABLE IF EXISTS `riesgotratamiento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `riesgotratamiento` (
  `id_riesgo_tratamiento` int NOT NULL AUTO_INCREMENT,
  `id_evaluacion_riesgo_activo` int NOT NULL,
  `ID_OpcionTratamiento` int NOT NULL,
  `descripcion_plan_tratamiento` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_inicio_plan` date DEFAULT (curdate()),
  `fecha_fin_estimada_plan` date DEFAULT NULL,
  `fecha_fin_real_plan` date DEFAULT NULL,
  `id_responsable_tratamiento` int NOT NULL,
  `estado_tratamiento` enum('Planificado','En progreso','Completado','Cancelado','En espera','Retrasado') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Planificado',
  `presupuesto_estimado` decimal(15,2) DEFAULT NULL,
  `costo_real` decimal(15,2) DEFAULT NULL,
  `justificacion_opcion_tratamiento` text COLLATE utf8mb4_unicode_ci,
  `fecha_aceptacion_riesgo_residual` date DEFAULT NULL,
  `fecha_creacion_registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_ultima_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_riesgo_tratamiento`),
  KEY `riesgotratamiento_ibfk_1` (`id_evaluacion_riesgo_activo`),
  KEY `riesgotratamiento_ibfk_2` (`ID_OpcionTratamiento`),
  KEY `riesgotratamiento_ibfk_3` (`id_responsable_tratamiento`),
  CONSTRAINT `riesgotratamiento_ibfk_1` FOREIGN KEY (`id_evaluacion_riesgo_activo`) REFERENCES `evaluacion_riesgo_activo` (`id_evaluacion_riesgo_activo`) ON DELETE CASCADE,
  CONSTRAINT `riesgotratamiento_ibfk_2` FOREIGN KEY (`ID_OpcionTratamiento`) REFERENCES `opcionestratamiento` (`ID_OpcionTratamiento`),
  CONSTRAINT `riesgotratamiento_ibfk_3` FOREIGN KEY (`id_responsable_tratamiento`) REFERENCES `usuarios_sistema` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id_rol` int NOT NULL AUTO_INCREMENT,
  `nombre_rol` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `permisos` text COLLATE utf8mb4_unicode_ci,
  `fecha_creacion` datetime DEFAULT NULL,
  `activo` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id_rol`),
  UNIQUE KEY `nombre_rol` (`nombre_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `roles_auth`
--

DROP TABLE IF EXISTS `roles_auth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles_auth` (
  `id_rol` int NOT NULL AUTO_INCREMENT,
  `nombre_rol` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `permisos` text COLLATE utf8mb4_unicode_ci,
  `fecha_creacion` datetime DEFAULT CURRENT_TIMESTAMP,
  `activo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id_rol`),
  UNIQUE KEY `nombre_rol` (`nombre_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `roles_sistema`
--

DROP TABLE IF EXISTS `roles_sistema`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles_sistema` (
  `id_rol_sistema` int NOT NULL AUTO_INCREMENT,
  `nombre_rol` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion_rol` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id_rol_sistema`),
  UNIQUE KEY `nombre_rol` (`nombre_rol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sesiones_usuario`
--

DROP TABLE IF EXISTS `sesiones_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sesiones_usuario` (
  `id_sesion` int NOT NULL AUTO_INCREMENT,
  `id_usuario_auth` int NOT NULL,
  `token` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `fecha_inicio` datetime DEFAULT NULL,
  `fecha_expiracion` datetime NOT NULL,
  `activa` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id_sesion`),
  KEY `id_usuario_auth` (`id_usuario_auth`),
  CONSTRAINT `sesiones_usuario_ibfk_1` FOREIGN KEY (`id_usuario_auth`) REFERENCES `usuarios_auth` (`id_usuario_auth`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tratamiento_controles_planificados`
--

DROP TABLE IF EXISTS `tratamiento_controles_planificados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tratamiento_controles_planificados` (
  `id_tratamiento_control` int NOT NULL AUTO_INCREMENT,
  `id_riesgo_tratamiento` int NOT NULL,
  `id_control_propuesto_o_existente` int NOT NULL,
  `detalle_implementacion_plan` text COLLATE utf8mb4_unicode_ci,
  `estado_implementacion_control_plan` enum('Pendiente','En curso','Implementado','Cancelado','Revisado') COLLATE utf8mb4_unicode_ci DEFAULT 'Pendiente',
  `fecha_objetivo_implementacion` date DEFAULT NULL,
  `fecha_real_implementacion` date DEFAULT NULL,
  PRIMARY KEY (`id_tratamiento_control`),
  UNIQUE KEY `idx_tratamiento_control_unique` (`id_riesgo_tratamiento`,`id_control_propuesto_o_existente`),
  KEY `tratamiento_controles_planificados_ibfk_2` (`id_control_propuesto_o_existente`),
  CONSTRAINT `tratamiento_controles_planificados_ibfk_1` FOREIGN KEY (`id_riesgo_tratamiento`) REFERENCES `riesgotratamiento` (`id_riesgo_tratamiento`) ON DELETE CASCADE,
  CONSTRAINT `tratamiento_controles_planificados_ibfk_2` FOREIGN KEY (`id_control_propuesto_o_existente`) REFERENCES `controles` (`ID_Control`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usuario_rol_asignado`
--

DROP TABLE IF EXISTS `usuario_rol_asignado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario_rol_asignado` (
  `id_usuario` int NOT NULL,
  `id_rol_sistema` int NOT NULL,
  `fecha_asignacion` date DEFAULT (curdate()),
  `fecha_fin_asignacion` date DEFAULT NULL,
  PRIMARY KEY (`id_usuario`,`id_rol_sistema`),
  KEY `usuario_rol_asignado_ibfk_2` (`id_rol_sistema`),
  CONSTRAINT `usuario_rol_asignado_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios_sistema` (`id_usuario`) ON DELETE CASCADE,
  CONSTRAINT `usuario_rol_asignado_ibfk_2` FOREIGN KEY (`id_rol_sistema`) REFERENCES `roles_sistema` (`id_rol_sistema`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usuarios_auth`
--

DROP TABLE IF EXISTS `usuarios_auth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios_auth` (
  `id_usuario_auth` int NOT NULL AUTO_INCREMENT,
  `id_usuario_sistema` int NOT NULL,
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_rol` int NOT NULL,
  `activo` tinyint(1) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `fecha_ultimo_login` datetime DEFAULT NULL,
  `intentos_fallidos` int DEFAULT NULL,
  `bloqueado_hasta` datetime DEFAULT NULL,
  PRIMARY KEY (`id_usuario_auth`),
  UNIQUE KEY `username` (`username`),
  KEY `id_usuario_sistema` (`id_usuario_sistema`),
  KEY `id_rol` (`id_rol`),
  CONSTRAINT `usuarios_auth_ibfk_1` FOREIGN KEY (`id_usuario_sistema`) REFERENCES `usuarios_sistema` (`id_usuario`),
  CONSTRAINT `usuarios_auth_ibfk_2` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usuarios_sistema`
--

DROP TABLE IF EXISTS `usuarios_sistema`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios_sistema` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nombre_completo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_institucional` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `puesto_organizacion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado_usuario` enum('Activo','Inactivo','Bloqueado','Pendiente_Activacion') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Pendiente_Activacion',
  `fecha_creacion_registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_ultima_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `fecha_ultimo_login` timestamp NULL DEFAULT NULL,
  `intentos_fallidos_login` int DEFAULT '0',
  `requiere_cambio_password` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `email_institucional` (`email_institucional`)
) ENGINE=InnoDB AUTO_INCREMENT=292 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `valoracion_activos_historico`
--

DROP TABLE IF EXISTS `valoracion_activos_historico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `valoracion_activos_historico` (
  `id_valoracion_historico` int NOT NULL AUTO_INCREMENT,
  `ID_Activo` int NOT NULL,
  `fecha_valoracion` date NOT NULL,
  `valor_confidencialidad_evaluado` enum('Publica','Uso Interno','Reservada','Secreta','Confidencial') COLLATE utf8mb4_unicode_ci NOT NULL,
  `valor_integridad_evaluado` enum('Alta','Media','Baja') COLLATE utf8mb4_unicode_ci NOT NULL,
  `valor_disponibilidad_evaluado` enum('Alta','Media','Baja') COLLATE utf8mb4_unicode_ci NOT NULL,
  `nivel_criticidad_negocio_evaluado` enum('Muy Alto','Alto','Medio','Bajo','Muy Bajo') COLLATE utf8mb4_unicode_ci NOT NULL,
  `valor_financiero_actualizado` decimal(15,2) DEFAULT NULL,
  `justificacion_valoracion` text COLLATE utf8mb4_unicode_ci,
  `id_evaluador` int NOT NULL,
  `fecha_creacion_registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_valoracion_historico`),
  KEY `valoracion_activos_historico_ibfk_1` (`ID_Activo`),
  KEY `valoracion_activos_historico_ibfk_2` (`id_evaluador`),
  CONSTRAINT `valoracion_activos_historico_ibfk_1` FOREIGN KEY (`ID_Activo`) REFERENCES `activos` (`ID_Activo`) ON DELETE CASCADE,
  CONSTRAINT `valoracion_activos_historico_ibfk_2` FOREIGN KEY (`id_evaluador`) REFERENCES `usuarios_sistema` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vulnerabilidadactivo`
--

DROP TABLE IF EXISTS `vulnerabilidadactivo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vulnerabilidadactivo` (
  `ID_VulnerabilidadActivo` int NOT NULL AUTO_INCREMENT,
  `ID_Vulnerabilidad` int NOT NULL,
  `ID_Activo` int NOT NULL,
  `justificacion_relacion` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`ID_VulnerabilidadActivo`),
  UNIQUE KEY `idx_vulnerabilidad_activo_unique` (`ID_Vulnerabilidad`,`ID_Activo`),
  KEY `vulnerabilidadactivo_ibfk_2` (`ID_Activo`),
  CONSTRAINT `vulnerabilidadactivo_ibfk_1` FOREIGN KEY (`ID_Vulnerabilidad`) REFERENCES `vulnerabilidades` (`ID_Vulnerabilidad`) ON DELETE CASCADE,
  CONSTRAINT `vulnerabilidadactivo_ibfk_2` FOREIGN KEY (`ID_Activo`) REFERENCES `activos` (`ID_Activo`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vulnerabilidades`
--

DROP TABLE IF EXISTS `vulnerabilidades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vulnerabilidades` (
  `ID_Vulnerabilidad` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Descripcion` text COLLATE utf8mb4_unicode_ci,
  `Tipo_Vulnerabilidad` enum('Tecnica','Fisica','Organizacional','Humana','Configuracion','Otro') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Tecnica',
  `Fuente_Informacion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Clasificacion_Normativa_Ref` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID_Vulnerabilidad`),
  UNIQUE KEY `idx_nombre_vulnerabilidad` (`Nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-22 11:49:48
