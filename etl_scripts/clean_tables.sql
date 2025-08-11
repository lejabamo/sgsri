-- Limpiar tabla de detalles tecnológicos
DELETE FROM activos_detalles_tecnologicos;

-- Limpiar tabla de activos
DELETE FROM activos;

-- Limpiar tabla de usuarios
DELETE FROM usuarios_sistema;

-- Reiniciar contadores auto_increment
ALTER TABLE activos_detalles_tecnologicos AUTO_INCREMENT = 1;
ALTER TABLE activos AUTO_INCREMENT = 1;
ALTER TABLE usuarios_sistema AUTO_INCREMENT = 1; 