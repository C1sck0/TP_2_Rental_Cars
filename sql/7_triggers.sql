-- SECCIÓN 5: Disparadores de auditoría y negocio
USE RENTAL_CARS;

-- Tabla de auditoría exigida
CREATE TABLE IF NOT EXISTS AUDITORIA_ALQUILERES (
    id_auditoria INT AUTO_INCREMENT,
    id_alquiler INT NOT NULL,
    id_cliente INT NOT NULL,
    id_vehiculo INT NOT NULL,
    fecha_registro DATETIME NOT NULL,
    accion VARCHAR(50) NOT NULL,
    CONSTRAINT PK_AUDITORIA_ALQUILER PRIMARY KEY (id_auditoria)
);

DELIMITER $$

-- Trigger 1: Auditoría posterior a la inserción de alquileres
CREATE TRIGGER TR_AUDITAR_ALQUILER
AFTER INSERT ON ALQUILERES
FOR EACH ROW
BEGIN
    INSERT INTO AUDITORIA_ALQUILERES (id_alquiler, id_cliente, id_vehiculo, fecha_registro, accion)
    VALUES (NEW.id_alquiler, NEW.id_cliente, NEW.id_vehiculo, NOW(), 'NUEVO ALQUILER');
END$$

-- Trigger 2: Desactivar disponibilidad del vehículo si el alquiler entra activo
CREATE TRIGGER TR_ACTUALIZAR_ESTADO_VEHICULO
AFTER INSERT ON ALQUILERES
FOR EACH ROW
BEGIN
    IF NEW.estado = 'activo' THEN
        UPDATE VEHICULOS 
        SET estado = 0 
        WHERE id = NEW.id_vehiculo;
    END IF;
END$$

DELIMITER ;