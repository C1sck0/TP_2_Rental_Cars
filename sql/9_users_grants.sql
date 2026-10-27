-- SECCIÓN 7: Administración de usuarios y privilegios
-- Ejecutar en sesión con privilegios administrativos (root)
USE RENTAL_CARS;

-- 1. Crear usuario para el vendedor con credencial segura
CREATE USER IF NOT EXISTS 'vendedor_user'@'localhost' 
IDENTIFIED BY 'Vendedor_Seguro_2026!';

-- 2. Asignar Solo Lectura (SELECT) en VEHICULOS, CATEGORIAS y SUCURSALES
GRANT SELECT ON RENTAL_CARS.VEHICULOS TO 'vendedor_user'@'localhost';
GRANT SELECT ON RENTAL_CARS.CATEGORIAS TO 'vendedor_user'@'localhost';
GRANT SELECT ON RENTAL_CARS.SUCURSALES TO 'vendedor_user'@'localhost';

-- 3. Asignar Lectura y Escritura (SELECT, INSERT, UPDATE, DELETE) en ALQUILERES y PAGOS
GRANT SELECT, INSERT, UPDATE, DELETE ON RENTAL_CARS.ALQUILERES TO 'vendedor_user'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON RENTAL_CARS.PAGOS TO 'vendedor_user'@'localhost';

-- 4. Crear superusuario administrativo con control total
CREATE USER IF NOT EXISTS 'admin_user'@'localhost' 
IDENTIFIED BY 'SuperAdmin_Rental_2026!';

GRANT ALL PRIVILEGES ON RENTAL_CARS.* TO 'admin_user'@'localhost' WITH GRANT OPTION;

-- 5. Revocar permiso DELETE sobre ALQUILERES al vendedor
REVOKE DELETE ON RENTAL_CARS.ALQUILERES FROM 'vendedor_user'@'localhost';

FLUSH PRIVILEGES;