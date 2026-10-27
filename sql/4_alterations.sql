-- SECCIÓN 3: Operaciones DML
USE RENTAL_CARS;

-- 1. Insertar nuevo cliente con licencia inventada y ciudad válida
INSERT INTO CLIENTES (nombre, email, telefono, ciudad, fecha_registro, licencia_conducir)
VALUES ('Gonzalo Monti', 'gonza.monti@gmail.com', '264-5998877', 'San Juan', CURDATE(), 'B1-123456');

-- 2. Actualizar salario a 200000.00 para Vendedor/Vendedora con ingreso anterior al 2021-01-01
UPDATE EMPLEADOS 
SET salario = 200000.00 
WHERE cargo IN ('Vendedor', 'Vendedora') 
  AND fecha_ingreso < '2021-01-01';

-- 3. Borrar vehículo sin dependencias (id = 10 no tiene alquileres, reservas ni mantenimientos)
DELETE FROM VEHICULOS 
WHERE id = 10;

-- 4. Cambio de sucursal: trasladar vehículo id = 9 a la sucursal 1
UPDATE VEHICULOS 
SET id_sucursal = 1 
WHERE id = 9;