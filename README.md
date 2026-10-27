# TP N.º 2 SQL — Sistema de Gestión RENTAL_CARS (MySQL 8)

## Estructura de Scripts
* `1_create.sql`: Creación de la base de datos `RENTAL_CARS` y definición de las 12 tablas relacionales con restricciones PK y FK.
* `2_insert.sql`: Inserción de datos iniciales en todas las entidades garantizando respuestas en cada consulta SELECT.
* `3_queries.sql`: Resolución completa de las 20 consultas requeridas.
* `4_alterations.sql`: Operaciones DML (alta de cliente, actualización de sueldos, baja de vehículo y traslado de sucursal).
* `5_indexes.sql`: Índices secundarios de optimización en campos de alta selectividad.
* `6_views.sql`: Creación de vistas de detalle, inventario por sucursal e ingresos por categoría.
* `7_triggers.sql`: Tabla de auditoría y disparadores automáticos (`TR_AUDITAR_ALQUILER` y `TR_ACTUALIZAR_ESTADO_VEHICULO`).
* `8_procedures.sql`: Procedimientos almacenados para registrar alquileres con cálculo dinámico y registro de multas.
* `9_users_grants.sql`: Administración de usuarios (`vendedor_user` y `admin_user`) con permisos específicos y revocación de borrado.
* `teoria.md`: Respuestas analíticas a las 5 preguntas conceptuales de la Sección 8.

## Secuencia de Ejecución
1. `1_create.sql`
2. `2_insert.sql`
3. `5_indexes.sql` (opcional)
4. `6_views.sql`
5. `7_triggers.sql`
6. `8_procedures.sql`
7. `3_queries.sql` (ejecutar antes de las modificaciones DML)
8. `4_alterations.sql`
9. `9_users_grants.sql` (ejecutar con usuario root)

## Prueba del Procedimiento Almacenado
```sql
-- Prueba de alquiler sobre vehículo disponible (ej. vehículo 1)
CALL SP_REGISTRAR_ALQUILER(1, 1, 1, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 4 DAY));
SELECT * FROM AUDITORIA_ALQUILERES;

-- Prueba de registro de multa
CALL SP_CALCULAR_MULTA(1, 'Rotura de espejo retrovisor', 12500.00);
SELECT * FROM MULTAS WHERE id_alquiler = 1;