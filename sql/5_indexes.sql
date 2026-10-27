-- Índices complementarios para optimizar consultas de altas frecuencias
USE RENTAL_CARS;

CREATE INDEX IDX_VEHICULOS_PRECIO ON VEHICULOS(precio_dia);
CREATE INDEX IDX_ALQUILERES_ESTADO_FECHA ON ALQUILERES(estado, fecha_inicio);
CREATE INDEX IDX_CLIENTES_FECHA ON CLIENTES(fecha_registro);