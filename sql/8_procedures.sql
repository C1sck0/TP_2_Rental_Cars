-- SECCIÓN 6: Procedimientos Almacenados
USE RENTAL_CARS;

DELIMITER $$

-- Procedimiento 1: Registro formal de un alquiler con cálculo automático y validaciones
CREATE PROCEDURE SP_REGISTRAR_ALQUILER (
    IN p_id_cliente INT,
    IN p_id_vehiculo INT,
    IN p_id_empleado INT,
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE
)
BEGIN
    DECLARE v_disponible TINYINT(1);
    DECLARE v_precio_dia DECIMAL(9,2);
    DECLARE v_sucursal_actual INT;
    DECLARE v_dias INT;
    DECLARE v_total DECIMAL(9,2);

    -- Comprobar estado y precio del vehículo
    SELECT estado, precio_dia, id_sucursal 
    INTO v_disponible, v_precio_dia, v_sucursal_actual
    FROM VEHICULOS 
    WHERE id = p_id_vehiculo;

    IF v_disponible IS NULL THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Error: El vehículo solicitado no se encuentra en la base de datos.';
    ELSEIF v_disponible = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Error: El vehículo seleccionado no está disponible para alquiler.';
    ELSE
        -- Cálculo de duración e importe
        SET v_dias = DATEDIFF(p_fecha_fin, p_fecha_inicio);
        
        IF v_dias <= 0 THEN
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Error: La fecha de fin debe ser posterior a la fecha de inicio.';
        END IF;

        SET v_total = v_dias * v_precio_dia;

        -- Inserción del alquiler con estado 'activo'
        INSERT INTO ALQUILERES (
            id_cliente, id_vehiculo, fecha_inicio, fecha_fin, total,
            id_empleado, id_sucursal_retiro, id_sucursal_devolucion, estado
        ) VALUES (
            p_id_cliente, p_id_vehiculo, p_fecha_inicio, p_fecha_fin, v_total,
            p_id_empleado, v_sucursal_actual, v_sucursal_actual, 'activo'
        );

        SELECT 'Alquiler registrado correctamente' AS MENSAJE;
    END IF;
END$$

-- Procedimiento 2: Aplicación y registro de multas sobre alquileres existentes
CREATE PROCEDURE SP_CALCULAR_MULTA (
    IN p_id_alquiler INT,
    IN p_motivo VARCHAR(120),
    IN p_monto DECIMAL(9,2)
)
BEGIN
    DECLARE v_existe INT DEFAULT 0;

    -- Validar existencia del alquiler
    SELECT COUNT(*) INTO v_existe 
    FROM ALQUILERES 
    WHERE id_alquiler = p_id_alquiler;

    IF v_existe = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Error: El alquiler especificado no existe.';
    ELSE
        INSERT INTO MULTAS (id_alquiler, fecha, motivo, monto, pagada)
        VALUES (p_id_alquiler, CURDATE(), p_motivo, p_monto, 0);

        SELECT 'Multa registrada correctamente' AS MENSAJE;
    END IF;
END$$

DELIMITER ;