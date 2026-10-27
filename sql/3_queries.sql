-- SECCIÓN 2: Consultas SELECT
USE RENTAL_CARS;

-- 1. Marca, modelo y año de todos los vehículos (más antiguo al más nuevo)
SELECT marca, modelo, anio 
FROM VEHICULOS 
ORDER BY anio ASC;

-- 2. Nombre, email y ciudad de clientes registrados el mes anterior
SELECT nombre, email, ciudad 
FROM CLIENTES 
WHERE fecha_registro >= DATE_SUB(DATE_FORMAT(CURDATE(), '%Y-%m-01'), INTERVAL 1 MONTH)
  AND fecha_registro < DATE_FORMAT(CURDATE(), '%Y-%m-01');

-- 3. Marca, modelo y precio por día de vehículos en categoría id = 2
SELECT marca, modelo, precio_dia 
FROM VEHICULOS 
WHERE id_categoria = 2;

-- 4. Datos de empleados cuyo nombre comienza con 'L'
SELECT * 
FROM EMPLEADOS 
WHERE nombre LIKE 'L%';

-- 5. Nombre y cargo de empleados con salario distinto a 180000.00
SELECT nombre, cargo 
FROM EMPLEADOS 
WHERE salario <> 180000.00;

-- 6. Marca y modelo del vehículo con el nombre de su categoría
SELECT 
    v.marca, 
    v.modelo, 
    c.nombre AS categoria
FROM VEHICULOS v
INNER JOIN CATEGORIAS c ON v.id_categoria = c.id;

-- 7. Detalle de fecha de inicio, cliente, vehículo y empleado
SELECT 
    a.fecha_inicio,
    c.nombre AS cliente,
    CONCAT(v.marca, ' ', v.modelo) AS vehiculo,
    e.nombre AS empleado
FROM ALQUILERES a
INNER JOIN CLIENTES c ON a.id_cliente = c.id
INNER JOIN VEHICULOS v ON a.id_vehiculo = v.id
INNER JOIN EMPLEADOS e ON a.id_empleado = e.id;

-- 8. Nombre del cliente, ciudad y fecha de registro
SELECT nombre, ciudad, fecha_registro 
FROM CLIENTES;

-- 9. Marca y modelo del vehículo junto con sucursal y ciudad actual
SELECT 
    v.marca, 
    v.modelo, 
    s.nombre AS sucursal, 
    s.ciudad
FROM VEHICULOS v
INNER JOIN SUCURSALES s ON v.id_sucursal = s.id;

-- 10. Alquiler y nombres de sucursal de retiro y devolución
SELECT 
    a.id_alquiler,
    sr.nombre AS sucursal_retiro,
    sd.nombre AS sucursal_devolucion
FROM ALQUILERES a
INNER JOIN SUCURSALES sr ON a.id_sucursal_retiro = sr.id
INNER JOIN SUCURSALES sd ON a.id_sucursal_devolucion = sd.id;

-- 11. Conteo de vehículos por categoría
SELECT 
    c.nombre AS categoria, 
    COUNT(v.id) AS cantidad_vehiculos
FROM CATEGORIAS c
LEFT JOIN VEHICULOS v ON c.id = v.id_categoria
GROUP BY c.id, c.nombre;

-- 12. Precio promedio por día agrupado por categoría
SELECT 
    c.nombre AS categoria, 
    ROUND(AVG(v.precio_dia), 2) AS precio_promedio_dia
FROM CATEGORIAS c
INNER JOIN VEHICULOS v ON c.id = v.id_categoria
GROUP BY c.id, c.nombre;

-- 13. Empleados y cantidad de alquileres gestionados (descendente)
SELECT 
    e.nombre AS empleado, 
    COUNT(a.id_alquiler) AS total_alquileres
FROM EMPLEADOS e
LEFT JOIN ALQUILERES a ON e.id = a.id_empleado
GROUP BY e.id, e.nombre
ORDER BY total_alquileres DESC;

-- 14. Clientes con más de un alquiler registrado
SELECT 
    c.nombre AS cliente, 
    COUNT(a.id_alquiler) AS total_alquileres
FROM CLIENTES c
INNER JOIN ALQUILERES a ON c.id = a.id_cliente
GROUP BY c.id, c.nombre
HAVING COUNT(a.id_alquiler) > 1;

-- 15. Cantidad de sucursales por ciudad
SELECT 
    ciudad, 
    COUNT(id) AS total_sucursales
FROM SUCURSALES
GROUP BY ciudad;

-- 16. Vehículo más antiguo de la flota
SELECT marca, modelo, anio 
FROM VEHICULOS 
WHERE anio = (SELECT MIN(anio) FROM VEHICULOS);

-- 17. Vehículos que nunca han sido alquilados
SELECT v.id, v.marca, v.modelo, v.patente 
FROM VEHICULOS v
LEFT JOIN ALQUILERES a ON v.id = a.id_vehiculo
WHERE a.id_vehiculo IS NULL;

-- 18. Alquileres activos iniciados en octubre de 2024
SELECT * 
FROM ALQUILERES 
WHERE estado = 'activo' 
  AND fecha_inicio >= '2024-10-01' 
  AND fecha_inicio <= '2024-10-31';

-- 19. Los 3 vehículos con el precio por día más alto
SELECT marca, modelo, precio_dia 
FROM VEHICULOS 
ORDER BY precio_dia DESC 
LIMIT 3;

-- 20. Total de multas pagadas y recaudación acumulada
SELECT 
    COUNT(*) AS total_multas_pagadas,
    COALESCE(SUM(monto), 0.00) AS total_recaudado
FROM MULTAS 
WHERE pagada = 1;