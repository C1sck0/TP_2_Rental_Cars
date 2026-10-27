-- SECCIÓN 4: Vistas del Sistema
USE RENTAL_CARS;

-- 1. Detalle descriptivo de los alquileres
CREATE OR REPLACE VIEW VW_ALQUILERES_DETALLE AS
SELECT 
    a.fecha_inicio,
    a.fecha_fin,
    c.nombre AS cliente,
    CONCAT(v.marca, ' ', v.modelo) AS vehiculo,
    e.nombre AS empleado_atencion,
    sr.nombre AS sucursal_retiro,
    sd.nombre AS sucursal_devolucion,
    a.total
FROM ALQUILERES a
INNER JOIN CLIENTES c ON a.id_cliente = c.id
INNER JOIN VEHICULOS v ON a.id_vehiculo = v.id
INNER JOIN EMPLEADOS e ON a.id_empleado = e.id
INNER JOIN SUCURSALES sr ON a.id_sucursal_retiro = sr.id
INNER JOIN SUCURSALES sd ON a.id_sucursal_devolucion = sd.id;

-- 2. Distribución y conteo de vehículos por sede física
CREATE OR REPLACE VIEW VW_VEHICULOS_POR_SUCURSAL AS
SELECT 
    s.nombre AS sucursal,
    s.ciudad,
    COUNT(v.id) AS total_vehiculos
FROM SUCURSALES s
LEFT JOIN VEHICULOS v ON s.id = v.id_sucursal
GROUP BY s.id, s.nombre, s.ciudad;

-- 3. Reporte de facturación y alquileres finalizados por categoría
CREATE OR REPLACE VIEW VW_INGRESOS_POR_CATEGORIA AS
SELECT 
    c.nombre AS categoria,
    COUNT(a.id_alquiler) AS total_alquileres_finalizados,
    COALESCE(SUM(a.total), 0.00) AS total_facturado
FROM CATEGORIAS c
LEFT JOIN VEHICULOS v ON c.id = v.id_categoria
LEFT JOIN ALQUILERES a ON v.id = a.id_vehiculo AND a.estado = 'finalizado'
GROUP BY c.id, c.nombre;