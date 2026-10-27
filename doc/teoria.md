# Sección 8 — Preguntas Teóricas

**1. ¿Por qué la tabla ALQUILERES tiene claves foráneas hacia SUCURSALES dos veces (id_sucursal_retiro e id_sucursal_devolucion)? ¿Qué tipo de relación representa esto?**
Porque en el negocio de alquiler de autos el cliente puede retirar el vehículo en una sede física y devolverlo en una sucursal distinta (por ejemplo, retiro en Aeropuerto y entrega en Centro). Cada una de estas columnas representa una relación independiente de **Uno a Muchos (1:N)** entre `SUCURSALES` y `ALQUILERES`: una sucursal puede ser origen de muchos alquileres y también destino de muchos alquileres.

**2. Si intentamos borrar una CATEGORIA que tiene vehículos asociados, ¿qué debería hacer la base de datos? ¿Por qué? Menciona al menos dos opciones (RESTRICT, CASCADE, SET NULL) y justifica cuál sería la más adecuada para este modelo.**
Por defecto la base de datos debe rechazar la eliminación para proteger la integridad referencial.
* **RESTRICT / NO ACTION:** Bloquea el borrado si hay vehículos vinculados a esa categoría.
* **CASCADE:** Borra la categoría y elimina en cadena todos los vehículos pertenecientes a ella (y potencialmente sus alquileres históricos).
* **SET NULL:** Borra la categoría y deja el campo `id_categoria` en `NULL` en los autos afectados.

La opción más adecuada es **RESTRICT**. Usar `CASCADE` sería catastrófico porque borraría vehículos y contratos activos por accidente, y `SET NULL` dejaría vehículos sin clasificación comercial ni precio de referencia. Con `RESTRICT` se obliga al administrador a reclasificar primero los vehículos antes de dar de baja la categoría.

**3. Observando la tabla VEHICULOS, ¿por qué la categoría está en una tabla separada (CATEGORIAS) y no directamente como un campo de texto en VEHICULOS?**
Para cumplir con las reglas de normalización (Tercera Forma Normal). Si fuera un campo de texto plano, se repetirían descripciones idénticas en cientos de autos, ocupando espacio innecesario y provocando errores de tipeo (por ejemplo, escribir "SUV", "suv" o "S.U.V."). Tener `CATEGORIAS` separada garantiza que cualquier modificación en la descripción se haga en un solo lugar y permite asociar atributos propios de la categoría.

**4. ¿Qué tipo de relación existe entre SUCURSALES y EMPLEADOS? (Uno a Muchos, Muchos a Muchos, etc.). Justifica.**
Es una relación de **Uno a Muchos (1:N)**. Cada empleado trabaja en una única sucursal física asignada a la vez (determinado por la clave foránea simple `id_sucursal` en la tabla `EMPLEADOS`), mientras que una misma sucursal cuenta con una plantilla de múltiples empleados.

**5. ¿Por qué la tabla CHECK_ALQUILER tiene un campo tipo con valores 'salida' o 'entrada' en lugar de tener dos tablas separadas? ¿Qué ventaja aporta este diseño?**
Porque las revisiones de salida y de entrada comparten exactamente la misma estructura de datos: fecha, kilometraje y nivel de combustible. Unificarlo en una sola tabla evita duplicar tablas con esquemas idénticos, simplifica el mantenimiento del modelo y permite consultar el estado del vehículo al inicio y al final en una misma consulta mediante un filtro por el campo `tipo`.