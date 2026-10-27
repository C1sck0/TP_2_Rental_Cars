-- SECCIÓN 1.3: Carga de datos base
USE RENTAL_CARS;

-- 1. Categorías
INSERT INTO CATEGORIAS (id, nombre, descripcion) VALUES
(1, 'Compacto', 'Autos chicos para uso urbano'),
(2, 'SUV Mediana', 'Camionetas urbanas y familiares'), -- id=2 requerido en consultas
(3, 'Sedán Ejecutivo', 'Vehículos confortables de 4 puertas'),
(4, 'Pick-up 4x4', 'Vehículos de trabajo y carga'),
(5, 'Gama Alta', 'Autos de lujo y alto rendimiento');

-- 2. Sucursales (varias en la misma ciudad para la consulta 15)
INSERT INTO SUCURSALES (id, nombre, direccion, ciudad, telefono) VALUES
(1, 'Sede Aeropuerto', 'Ruta 20 km 12', 'San Juan', '264-4201100'),
(2, 'Sede Rivadavia', 'Av. Ignacio de la Roza 1240', 'San Juan', '264-4202200'),
(3, 'Sede Mendoza Capital', 'Av. San Martín 820', 'Mendoza', '261-4303300'),
(4, 'Sede Godoy Cruz', 'Belgrano 1150', 'Mendoza', '261-4304400'),
(5, 'Sede Córdoba Centro', 'Av. Colón 450', 'Córdoba', '351-4105500');

-- 3. Clientes (incluye registros dinámicos del mes anterior para la consulta 2)
INSERT INTO CLIENTES (id, nombre, email, telefono, ciudad, fecha_registro, licencia_conducir) VALUES
(1, 'Esteban Morales', 'esteban.m@gmail.com', '264-5110001', 'San Juan', DATE_SUB(CURDATE(), INTERVAL 1 MONTH), 'B1-998811'),
(2, 'Florencia Castro', 'flor.castro@gmail.com', '264-5110002', 'San Juan', DATE_SUB(CURDATE(), INTERVAL 1 MONTH), 'B1-998822'),
(3, 'Mariano Varela', 'marianov@hotmail.com', '261-5220003', 'Mendoza', DATE_SUB(CURDATE(), INTERVAL 3 MONTH), 'B2-887733'),
(4, 'Romina Rossi', 'romina.r@yahoo.com', '351-5330004', 'Córdoba', DATE_SUB(CURDATE(), INTERVAL 2 MONTH), 'B1-776644'),
(5, 'Lucas Benítez', 'lucas.b@gmail.com', '264-5110005', 'San Juan', DATE_SUB(CURDATE(), INTERVAL 5 MONTH), 'B1-665555'),
(6, 'Valeria Godoy', 'valeg@gmail.com', '261-5220006', 'Mendoza', CURDATE(), 'B1-554466');

-- 4. Empleados (variados: nombres con 'L', sueldo != 180000, cargos de Vendedor antes de 2021)
INSERT INTO EMPLEADOS (id, nombre, cargo, id_sucursal, fecha_ingreso, salario) VALUES
(1, 'Lautaro Cáceres', 'Vendedor', 1, '2020-04-10', 180000.00),
(2, 'Lorena Quiroga', 'Vendedora', 2, '2019-11-15', 178000.00),
(3, 'Leandro Silva', 'Encargado de Turno', 3, '2021-08-01', 250000.00),
(4, 'Gustavo Méndez', 'Vendedor', 4, '2022-03-20', 185000.00),
(5, 'Lucía Mercado', 'Supervisora', 5, '2018-06-12', 310000.00);

-- 5. Flota de Vehículos (con antigüedad, precios escalonados y uno sin alquilar)
INSERT INTO VEHICULOS (id, marca, modelo, anio, precio_dia, estado, id_categoria, id_sucursal, patente, km_actual) VALUES
(1, 'Volkswagen', 'Polo', 2021, 38000.00, 1, 1, 1, 'AF111AA', 42000),
(2, 'Chevrolet', 'Tracker', 2022, 62000.00, 1, 2, 2, 'AF222BB', 38000), -- Categoría 2
(3, 'Jeep', 'Compass', 2023, 71000.00, 1, 2, 3, 'AG333CC', 25000), -- Categoría 2
(4, 'Toyota', 'Corolla', 2020, 52000.00, 1, 3, 1, 'AE444DD', 75000),
(5, 'Ford', 'Ranger XLT', 2024, 98000.00, 1, 4, 4, 'AG555EE', 14000), -- Top precio
(6, 'Toyota', 'Hilux SRV', 2023, 105000.00, 1, 4, 5, 'AG666FF', 22000), -- Top precio
(7, 'Audi', 'A4', 2024, 145000.00, 1, 5, 2, 'AG777GG', 9000), -- Más caro
(8, 'Renault', 'Clio Mio', 2017, 26000.00, 1, 1, 1, 'AA888HH', 120000), -- Más antiguo
(9, 'Nissan', 'Versa', 2022, 44000.00, 1, 3, 3, 'AF999II', 31000), -- Vehículo para traslado DML
(10, 'Peugeot', '2008', 2023, 60000.00, 1, 2, 2, 'AG000JJ', 18000); -- Vehículo sin alquileres (para borrar)

-- 6. Alquileres (incluye retiro/devolución cruzada, activos en octubre 2024 y clientes con >1 alquiler)
INSERT INTO ALQUILERES (id_alquiler, id_cliente, id_vehiculo, fecha_inicio, fecha_fin, total, id_empleado, id_sucursal_retiro, id_sucursal_devolucion, estado) VALUES
(1, 1, 1, '2024-10-10', '2024-10-15', 190000.00, 1, 1, 2, 'activo'), -- Activo oct 2024
(2, 2, 2, '2024-10-18', '2024-10-22', 248000.00, 2, 2, 2, 'finalizado'),
(3, 1, 3, '2024-11-05', '2024-11-10', 355000.00, 1, 3, 3, 'finalizado'), -- Cliente 1 repite
(4, 3, 4, '2024-12-01', '2024-12-06', 260000.00, 3, 1, 1, 'finalizado'),
(5, 4, 5, '2025-01-15', '2025-01-20', 490000.00, 4, 4, 5, 'finalizado'),
(6, 2, 6, '2025-02-10', '2025-02-15', 525000.00, 2, 5, 5, 'finalizado'), -- Cliente 2 repite
(7, 5, 7, '2025-03-01', '2025-03-04', 435000.00, 5, 2, 1, 'finalizado');

-- 7. Reservas
INSERT INTO RESERVAS (id, id_cliente, id_vehiculo, fecha_reserva, fecha_inicio, fecha_fin, estado) VALUES
(1, 1, 2, '2026-10-01', '2026-11-15', '2026-11-20', 'confirmada'),
(2, 6, 4, '2026-10-05', '2026-11-25', '2026-11-30', 'pendiente');

-- 8. Pagos
INSERT INTO PAGOS (id, id_alquiler, fecha_pago, monto) VALUES
(1, 1, '2024-10-10', 190000.00),
(2, 2, '2024-10-22', 248000.00),
(3, 3, '2024-11-10', 355000.00),
(4, 4, '2024-12-06', 260000.00),
(5, 5, '2025-01-20', 490000.00),
(6, 6, '2025-02-15', 525000.00),
(7, 7, '2025-03-04', 435000.00);

-- 9. Multas (pagadas y pendientes para consulta 20)
INSERT INTO MULTAS (id, id_alquiler, fecha, motivo, monto, pagada) VALUES
(1, 2, '2024-10-22', 'Exceso de velocidad registrado por radar', 35000.00, 1),
(2, 3, '2024-11-10', 'Demora en horario de entrega pactado', 18000.00, 1),
(3, 4, '2024-12-06', 'Falta de combustible al retornar unidad', 22000.00, 0),
(4, 6, '2025-02-15', 'Estacionamiento en zona indebida', 15000.00, 1);

-- 10. Seguros
INSERT INTO SEGUROS (id, id_alquiler, compania, numero_poliza, cobertura, costo) VALUES
(1, 1, 'San Cristóbal Seguros', 'POL-7001', 'Todo Riesgo con Franquicia', 15000.00),
(2, 2, 'Mapfre Argentina', 'POL-7002', 'Responsabilidad Civil Ampliada', 11000.00),
(3, 3, 'Rivadavia Seguros', 'POL-7003', 'Todo Riesgo Premium', 19000.00),
(4, 5, 'Allianz', 'POL-7004', 'Todo Riesgo', 22000.00);

-- 11. Mantenimientos
INSERT INTO MANTENIMIENTOS (id, id_vehiculo, fecha, tipo, costo, observaciones) VALUES
(1, 1, '2026-02-10', 'Service Programado', 48000.00, 'Cambio de filtros y aceite'),
(2, 4, '2026-03-15', 'Frenos Delanteros', 65000.00, 'Reemplazo de pastillas'),
(3, 8, '2026-04-20', 'Alineación y Balanceo', 30000.00, 'Rotación de neumáticos');

-- 12. Check Alquiler
INSERT INTO CHECK_ALQUILER (id, id_alquiler, tipo, fecha, km, nivel_combustible) VALUES
(1, 1, 'salida', '2024-10-10 09:30:00', 41500, 100),
(2, 2, 'salida', '2024-10-18 10:00:00', 37500, 100),
(3, 2, 'entrada', '2024-10-22 19:00:00', 38200, 90),
(4, 3, 'salida', '2024-11-05 08:30:00', 24200, 100),
(5, 3, 'entrada', '2024-11-10 18:30:00', 25100, 100);