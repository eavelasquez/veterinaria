CREATE DATABASE db_veterinaria;
USE db_veterinaria;

CREATE TABLE tbl_especie(
    codigo_e VARCHAR(12) PRIMARY KEY,
    nombre_e VARCHAR(16) NOT NULL
);

CREATE TABLE tbl_raza(
    codigo_r VARCHAR(12) PRIMARY KEY,
    nombre_r VARCHAR(32) NOT NULL
);

CREATE TABLE tbl_cliente(
    id_c VARCHAR(16) PRIMARY KEY,
    nombre_c VARCHAR(32) NOT NULL,
    apellido_c VARCHAR(32) NOT NULL,
    edad_c CHAR(3) NOT NULL,
    fecha_nacimiento_c DATE NOT NULL
);

CREATE TABLE tbl_mascotas(
    id_m VARCHAR(16) PRIMARY KEY,
    nombre_m VARCHAR(24) NOT NULL,
    descripcion_m VARCHAR(max),
    edad_m CHAR(3) NOT NULL,
    sexo_m CHAR(6) NOT NULL,
    fecha_nacimiento_m DATE NOT NULL,
    codigo_e VARCHAR(12) NOT NULL ,
    id_c VARCHAR(16) NOT NULL,
    codigo_r VARCHAR(12) NOT NULL,
    FOREIGN KEY (codigo_r) REFERENCES tbl_raza(codigo_r),
    FOREIGN KEY (codigo_e) REFERENCES tbl_especie(codigo_e),
    FOREIGN KEY (id_c) REFERENCES tbl_cliente(id_c)
);

CREATE TABLE tbl_profesional(
   codigo_pfl VARCHAR(12) PRIMARY KEY,
   nombre_pfl VARCHAR(32) NOT NULL,
   apellido_pfl VARCHAR(32) NOT NULL,
   telefono_pfl VARCHAR(12) NOT NULL,
   celular_pfl VARCHAR(16)
);

CREATE TABLE tbl_tipo_producto(
   codigo_tp VARCHAR(16) PRIMARY KEY,
   nombre_tp VARCHAR(32) NOT NULL
);

CREATE TABLE tbl_productos(
   codigo_pd VARCHAR(8) PRIMARY KEY,
   nombre_pd VARCHAR(24) NOT NULL,
   precio_pd FLOAT NOT NULL,
   codigo_tp VARCHAR(16) NOT NULL,
   FOREIGN KEY (codigo_tp) REFERENCES tbl_tipo_producto(codigo_tp)
);

CREATE TABLE tbl_servicio(
   codigo_s VARCHAR(16) PRIMARY KEY,
   nombre_s VARCHAR(32) NOT NULL,
   descripcion_s VARCHAR(max),
   precio_s FLOAT NOT NULL
);

CREATE TABLE tbl_factura(
    codigo_f VARCHAR(16) PRIMARY KEY,
    fecha_f DATE NOT NULL,
    id_m VARCHAR(16) NOT NULL,
    codigo_pfl VARCHAR(12) NOT NULL,
    FOREIGN KEY (id_m) REFERENCES tbl_mascotas(id_m),
    FOREIGN KEY (codigo_pfl) REFERENCES tbl_profesional(codigo_pfl)
);

CREATE TABLE tbl_factura_producto(
   codigo_f VARCHAR(16) NOT NULL,
   codigo_pd VARCHAR(8) NOT NULL,
   FOREIGN KEY (codigo_f) REFERENCES tbl_factura(codigo_f),
   FOREIGN KEY (codigo_pd) REFERENCES tbl_productos(codigo_pd)
);

CREATE TABLE tbl_factura_servicio(
   codigo_f VARCHAR(16) NOT NULL,
   codigo_s VARCHAR(16) NOT NULL,
   FOREIGN KEY (codigo_f) REFERENCES tbl_factura(codigo_f),
   FOREIGN KEY (codigo_s) REFERENCES tbl_servicio(codigo_s)
);

-- Procedimientos almacenados tbl_mascota
GO

CREATE PROCEDURE pa_select_mascota
AS
BEGIN
    SELECT * FROM tbl_mascotas;
END; 
GO

CREATE PROCEDURE pa_insert_mascota(
    @pa_id VARCHAR(16),
    @pa_nombre VARCHAR(24),
    @pa_descripcion VARCHAR(max),
    @pa_edad CHAR(3),
    @pa_sexo CHAR(6),
    @pa_fecha_nacimiento DATE,
    @pa_codigo_e VARCHAR(12),
    @pa_id_c VARCHAR(16),
    @pa_codigo_r VARCHAR(12)
)
AS
BEGIN
    INSERT INTO tbl_mascotas(id_m, nombre_m, descripcion_m, edad_m, sexo_m, fecha_nacimiento_m, codigo_e, id_c, codigo_r) VALUES (@pa_id, @pa_nombre, @pa_descripcion, @pa_edad, @pa_sexo, @pa_fecha_nacimiento, @pa_codigo_e, @pa_id_c, @pa_codigo_r);
END; 
 GO

CREATE PROCEDURE pa_delete_mascota(
    @pa_id VARCHAR(16)
)
AS
BEGIN
    DELETE FROM tbl_factura WHERE id_m = @pa_id;
    DELETE FROM tbl_mascotas WHERE id_m = @pa_id;
END; 
 GO

CREATE PROCEDURE pa_update_mascota(
    @pa_id VARCHAR(16),
    @pa_nombre VARCHAR(24),
    @pa_descripcion VARCHAR(max),
    @pa_edad CHAR(3),
    @pa_sexo CHAR(6),
    @pa_fecha_nacimiento DATE,
    @pa_codigo VARCHAR(12),
    @pa_id_c VARCHAR(16),
    @pa_codigo_r VARCHAR(12)
)
AS
BEGIN
    UPDATE tbl_mascotas SET
                            nombre_m = @pa_nombre,
                            descripcion_m = @pa_descripcion,
                            edad_m = @pa_edad,
                            sexo_m = @pa_sexo,
                            fecha_nacimiento_m = @pa_fecha_nacimiento,
                            codigo_e = @pa_codigo,
                            id_c = @pa_id_c,
                            codigo_r = @pa_codigo_r
    WHERE id_m = @pa_id;
END; 
 GO

-- Procedimientos almacenados tbl_especie

CREATE PROCEDURE pa_select_especie
AS
BEGIN
    SELECT * FROM tbl_especie;
END; 
 GO

CREATE PROCEDURE pa_insert_especie(
    @pa_codigo VARCHAR(12),
    @pa_nombre VARCHAR(16)
)
AS
BEGIN
    INSERT INTO tbl_especie(codigo_e, nombre_e) VALUES (@pa_codigo, @pa_nombre);
END; 
 GO

CREATE PROCEDURE pa_delete_especie(
    @pa_codigo VARCHAR(12)
)
AS
BEGIN
    DELETE FROM tbl_mascotas WHERE codigo_e = @pa_codigo;
    DELETE FROM tbl_especie WHERE codigo_e = @pa_codigo;
END; 
 GO

CREATE PROCEDURE pa_update_especie(
    @pa_codigo VARCHAR(12),
    @pa_nombre VARCHAR(16)
)
AS
BEGIN
    UPDATE tbl_especie SET nombre_e = @pa_nombre WHERE codigo_e = @pa_codigo;
END; 
 GO

-- Procedimientos almacenados tbl_raza

CREATE PROCEDURE pa_select_raza
AS
BEGIN
    SELECT * FROM tbl_raza;
END; 
 GO

CREATE PROCEDURE pa_insert_raza(
    @pa_codigo VARCHAR(12),
    @pa_nombre VARCHAR(32)
)
AS
BEGIN
    INSERT INTO tbl_raza(codigo_r, nombre_r) VALUES (@pa_codigo, @pa_nombre);
END; 
 GO

CREATE PROCEDURE pa_delete_raza(
    @pa_codigo VARCHAR(12)
)
AS
BEGIN
    DELETE FROM tbl_mascotas WHERE id_m = @pa_codigo;
    DELETE FROM tbl_raza WHERE codigo_r = @pa_codigo;
END; 
 GO

CREATE PROCEDURE pa_update_raza(
    @pa_codigo VARCHAR(12),
    @pa_nombre VARCHAR(32)
)
AS
BEGIN
    UPDATE tbl_raza SET nombre_r = @pa_nombre WHERE codigo_r = @pa_codigo;
END; 
 GO

-- Procedimientos almacenados tbl_cliente

CREATE PROCEDURE pa_select_cliente
AS
BEGIN
    SELECT * FROM tbl_cliente;
END; 
 GO

CREATE PROCEDURE pa_insert_cliente(
    @pa_id VARCHAR(16),
    @pa_nombre VARCHAR(32),
    @pa_apellido VARCHAR(32),
    @pa_edad CHAR(3),
    @pa_fecha_nacimiento DATE
)
AS
BEGIN
    INSERT INTO tbl_cliente(id_c, nombre_c, apellido_c, edad_c, fecha_nacimiento_c) VALUES (@pa_id, @pa_nombre, @pa_apellido, @pa_edad, @pa_fecha_nacimiento);
END; 
 GO

CREATE PROCEDURE pa_delete_cliente(
    @pa_id VARCHAR(16)
)
AS
BEGIN
    DELETE FROM tbl_mascotas WHERE id_c = @pa_id;
    DELETE FROM tbl_cliente WHERE id_c = @pa_id;
END; 
 GO

CREATE PROCEDURE pa_update_cliente(
    @pa_id VARCHAR(16),
    @pa_nombre VARCHAR(32),
    @pa_apellido VARCHAR(32),
    @pa_edad CHAR(3),
    @pa_fecha_nacimiento DATE
)
AS
BEGIN
    UPDATE tbl_cliente SET
                           nombre_c = @pa_nombre,
                           apellido_c = @pa_apellido,
                           edad_c = @pa_edad,
                           fecha_nacimiento_c = @pa_fecha_nacimiento
    WHERE id_c = @pa_id;
END; 
 GO

-- Procedimientos almacenados tbl_profesional

CREATE PROCEDURE pa_select_profesional
AS
BEGIN
    SELECT * FROM tbl_profesional;
END; 
 GO

CREATE PROCEDURE pa_insert_profesional(
    @pa_codigo VARCHAR(12),
    @pa_nombre VARCHAR(32),
    @pa_apellido VARCHAR(32),
    @pa_telefono VARCHAR(12),
    @pa_celular VARCHAR(16)
)
AS
BEGIN
    INSERT INTO tbl_profesional(codigo_pfl, nombre_pfl, apellido_pfl, telefono_pfl, celular_pfl) VALUES (@pa_codigo, @pa_nombre, @pa_apellido, @pa_telefono, @pa_celular);
END; 
 GO

CREATE PROCEDURE pa_delete_profesional(
    @pa_codigo VARCHAR(12)
)
AS
BEGIN
    DELETE FROM tbl_factura WHERE codigo_pfl = @pa_codigo;
    DELETE FROM tbl_profesional WHERE codigo_pfl = @pa_codigo;
END; 
 GO

CREATE PROCEDURE pa_update_profesional(
    @pa_codigo VARCHAR(12),
    @pa_nombre VARCHAR(32),
    @pa_apellido VARCHAR(32),
    @pa_telefono VARCHAR(12),
    @pa_celular VARCHAR(16)
)
AS
BEGIN
    UPDATE tbl_profesional SET
                               nombre_pfl = @pa_nombre,
                               apellido_pfl = @pa_apellido,
                               telefono_pfl = @pa_telefono,
                               celular_pfl = @pa_celular
    WHERE codigo_pfl = @pa_codigo;
END; 
 GO

-- Procedimientos almacenados tbl_productos

CREATE PROCEDURE pa_select_productos
AS
BEGIN
    SELECT * FROM tbl_productos;
END; 
 GO

CREATE PROCEDURE pa_insert_productos(
    @pa_codigo VARCHAR(8),
    @pa_nombre VARCHAR(24),
    @pa_precio FLOAT,
    @pa_codigo_tp VARCHAR(16)
)
AS
BEGIN
    INSERT INTO tbl_productos(codigo_pd, nombre_pd, precio_pd, codigo_tp) VALUES (@pa_codigo, @pa_nombre, @pa_precio, @pa_codigo_tp);
END; 
 GO

CREATE PROCEDURE pa_delete_productos(
    @pa_codigo VARCHAR(8)
)
AS
BEGIN
    DELETE FROM tbl_factura_producto WHERE codigo_pd = @pa_codigo;
    DELETE FROM tbl_productos WHERE codigo_pd = @pa_codigo;
END; 
 GO

CREATE PROCEDURE pa_update_productos(
    @pa_codigo VARCHAR(8),
    @pa_nombre VARCHAR(24),
    @pa_precio FLOAT,
    @pa_codigo_tp VARCHAR(16)
)
AS
BEGIN 
    UPDATE tbl_productos SET
                             codigo_pd = @pa_codigo,
                             nombre_pd = @pa_nombre,
                             precio_pd = @pa_precio,
                             codigo_tp = @pa_codigo_tp
    WHERE codigo_pd = @pa_codigo;
END; 
 GO

-- Procedimientos almacenados tbl_tipo_producto

CREATE PROCEDURE pa_select_tipo_producto
AS
BEGIN
    SELECT * FROM tbl_tipo_producto;
END; 
 GO

CREATE PROCEDURE pa_insert_tipo_producto(
    @pa_codigo VARCHAR(16),
    @pa_nombre VARCHAR(32)
)
AS
BEGIN
    INSERT INTO tbl_tipo_producto(codigo_tp, nombre_tp) VALUES (@pa_codigo, @pa_nombre);
END; 
 GO

CREATE PROCEDURE pa_delete_tipo_producto(
    @pa_codigo VARCHAR(16)
)
AS
BEGIN
    DELETE FROM tbl_productos WHERE codigo_tp = @pa_codigo;
    DELETE FROM tbl_tipo_producto WHERE codigo_tp = @pa_codigo;
END; 
 GO

CREATE PROCEDURE pa_update_tipo_producto( 
    @pa_codigo VARCHAR(16),
    @pa_nombre VARCHAR(32)
)
AS
BEGIN 
    UPDATE tbl_tipo_producto SET
                                 codigo_tp = @pa_codigo,
                                 nombre_tp = @pa_nombre
    WHERE codigo_tp = @pa_codigo;
END; 
 GO

-- Procedimientos almacenados tbl_servicio

CREATE PROCEDURE pa_select_servicio
AS
BEGIN
    SELECT * FROM tbl_servicio;
END; 
 GO

CREATE PROCEDURE pa_insert_servicio(
    @pa_codigo VARCHAR(16),
    @pa_nombre VARCHAR(32),
    @pa_descripcion VARCHAR(max),
    @pa_precio FLOAT
)
AS
BEGIN
    INSERT INTO tbl_servicio(codigo_s, nombre_s, descripcion_s, precio_s) VALUES (@pa_codigo, @pa_nombre, @pa_descripcion, @pa_precio);
END; 
 GO

CREATE PROCEDURE pa_delete_servicio(
    @pa_codigo VARCHAR(16)
)
AS
BEGIN
    DELETE FROM tbl_factura_servicio WHERE codigo_s = @pa_codigo;
    DELETE FROM tbl_servicio WHERE codigo_s = @pa_codigo;
END; 
 GO

CREATE PROCEDURE pa_update_servicio(
    @pa_codigo VARCHAR(16),
    @pa_nombre VARCHAR(32),
    @pa_descripcion VARCHAR(max),
    @pa_precio FLOAT
)
AS
BEGIN
    UPDATE tbl_servicio SET
                            nombre_s = @pa_nombre,
                            descripcion_s = @pa_descripcion,
                            precio_s = @pa_precio
    WHERE codigo_s = @pa_codigo;
END; 
 GO

-- Procedimientos almacenados tbl_factura

CREATE PROCEDURE pa_select_factura
AS
BEGIN
    SELECT * FROM tbl_factura;
END; 
 GO

CREATE PROCEDURE pa_insert_factura(
    @pa_codigo VARCHAR(16),
    @pa_fecha DATE,
    @pa_id_m VARCHAR(16),
    @pa_codigo_pfl VARCHAR(12)
)
AS
BEGIN
    INSERT INTO tbl_factura(codigo_f, fecha_f, id_m, codigo_pfl) VALUES (@pa_codigo, @pa_fecha, @pa_id_m, @pa_codigo_pfl);
END; 
 GO

CREATE PROCEDURE pa_delete_factura(
    @pa_codigo VARCHAR(16)
)
AS
BEGIN
    DELETE FROM tbl_factura_servicio WHERE codigo_f = @pa_codigo;
    DELETE FROM tbl_factura_producto WHERE codigo_f = @pa_codigo;
    DELETE FROM tbl_factura WHERE codigo_f = @pa_codigo;
END; 
 GO

CREATE PROCEDURE pa_update_factura(
    @pa_codigo VARCHAR(16),
    @pa_fecha DATE,
    @pa_id_m VARCHAR(16),
    @pa_codigo_pfl VARCHAR(12)
)
AS
BEGIN
    UPDATE tbl_factura SET
                           codigo_f = @pa_codigo,
                           fecha_f = @pa_fecha,
                           id_m = @pa_id_m,
                           codigo_pfl = @pa_codigo_pfl
    WHERE codigo_f = @pa_codigo;
end; 
 GO

-- -----------------------------------------------
-- Procedimientos almacenados tbl_factura_producto
-- -----------------------------------------------

CREATE PROCEDURE pa_select_factura_producto
AS
BEGIN
    SELECT * FROM tbl_factura_producto;
END; 
 GO

CREATE PROCEDURE pa_insert_factura_producto(
    @pa_codigo_f VARCHAR(16),
    @pa_codigo_pd VARCHAR(8)
)
AS
BEGIN
    INSERT INTO tbl_factura_producto(codigo_f, codigo_pd) VALUES (@pa_codigo_f, @pa_codigo_pd);
END; 
 GO

CREATE PROCEDURE pa_delete_factura_producto(
    @pa_codigo_f VARCHAR(16)
)
AS
BEGIN
    DELETE FROM tbl_factura_producto WHERE codigo_f = @pa_codigo_f;
END; 
 GO

CREATE PROCEDURE pa_update_factura_producto(
    @pa_codigo_f VARCHAR(16),
    @pa_codigo_pd VARCHAR(8)
)
AS
BEGIN
    UPDATE tbl_factura_producto SET
                                    codigo_f = @pa_codigo_f,
                                    codigo_pd = @pa_codigo_pd
    WHERE codigo_f = @pa_codigo_f;
END; 
 GO


-- -----------------------------------------------
-- Procedimientos almacenados tbl_factura_servicio
-- -----------------------------------------------

CREATE PROCEDURE pa_select_factura_servicio
AS
BEGIN
    SELECT * FROM tbl_factura_servicio;
END; 
 GO

CREATE PROCEDURE pa_insert_factura_servicio(
    @pa_codigo_f VARCHAR(16),
    @pa_codigo_s VARCHAR(16)
)
AS
BEGIN
    INSERT INTO tbl_factura_servicio(codigo_f, codigo_s) VALUES (@pa_codigo_f, @pa_codigo_s);
END; 
 GO

CREATE PROCEDURE pa_delete_factura_servicio(
    @pa_codigo_f VARCHAR(16)
)
AS
BEGIN
    DELETE FROM tbl_factura_servicio WHERE codigo_f = @pa_codigo_f;
END; 
 GO

CREATE PROCEDURE pa_update_factura_servicio(
    @pa_codigo_f VARCHAR(16),
    @pa_codigo_s VARCHAR(16)
)
AS
BEGIN
    UPDATE tbl_factura_servicio SET
                                    codigo_f = @pa_codigo_f,
                                    codigo_s = @pa_codigo_s
    WHERE codigo_f = @pa_codigo_f;
END;

-- Datos tbl_tipo_producto
    EXECUTE pa_insert_tipo_producto '01', 'Juegos';
    EXECUTE pa_insert_tipo_producto '02', 'Alimento';
    EXECUTE pa_insert_tipo_producto '03', 'Artículos de limpieza';
    EXECUTE pa_insert_tipo_producto '04', 'Medicina';
    EXECUTE pa_insert_tipo_producto '05', 'Accesorios';

-- Datos tbl_servicio
    EXECUTE pa_insert_servicio '01', 'Vacuna', 'Aplicación de vacunas necesarias que protegen a la mascota.', 20000.0;
    EXECUTE pa_insert_servicio '02', 'Limpieza', 'Se le dará un baño a la mascota, se cepillarán sus dientes y se le cortará sus uñas.', 16000.0;
    EXECUTE pa_insert_servicio '03', 'Revisión', 'Se hará un chequeo sobre la condición de la mascota a nivel general.', 12000.0;

-- Datos tbl_profesional
    EXECUTE pa_insert_profesional '01', 'Kana', 'Tachibana', '263-1426', '300-6984513';
    EXECUTE pa_insert_profesional '02', 'Light', 'Yagami', '', '312-8473654';

-- Datos tbl_productos
    EXECUTE pa_insert_productos '001', 'Moño', 4500.0, '05';
    EXECUTE pa_insert_productos '002', 'Cabano', 18000.0, '02';
    EXECUTE pa_insert_productos '003', 'Cepillo', 3200.0, '03';
    EXECUTE pa_insert_productos '004', 'Pelota', 12500.0, '01';
    EXECUTE pa_insert_productos '005', 'Apetil', 28000.0, '04';
    EXECUTE pa_insert_productos '006', 'Pañoleta', 6000.0, '05';

-- Datos tbl_especie
    EXECUTE pa_insert_especie '01', 'Gato';

-- Datos tbl_raza
    EXECUTE pa_insert_raza '01', 'Inglés';

-- Datos tbl_cliente
    EXECUTE pa_insert_cliente '80265475', 'Sora', 'Shionji', '18', '2000-07-03';

-- Datos tbl_mascotas
    EXECUTE pa_insert_mascota '001', 'Shiro', 'Es un gatito tierno con colores blanco y negro.', '1', 'Macho', '2017-12-16', '01', '80265475', '01';

-- Consultas
    -- Obtener los datos de la tabla Profesional.
    EXECUTE pa_select_profesional;
    -- Obtener los datos de la tabla Productos.
    EXECUTE pa_select_productos;
    SELECT * FROM tbl_productos tpd INNER JOIN tbl_tipo_producto ttp on tpd.codigo_tp = ttp.codigo_tp;
    -- Obtener los datos de la tabla Servicios.
    EXECUTE pa_select_servicio;
    -- Obtener los datos de la tabla Mascotas.
    EXECUTE pa_select_mascota;
    SELECT * FROM tbl_mascotas tm
        INNER JOIN tbl_especie te on tm.codigo_e = te.codigo_e
        INNER JOIN tbl_cliente tc on tm.id_c = tc.id_c
        INNER JOIN tbl_raza tr on tm.codigo_r = tr.codigo_r;
    -- Obtener los datos de la tabla Cliente.
    EXECUTE pa_select_cliente;
    -- Obtener el nombre, la raza, el sexo de las mascotas con el nombre de su dueño, y la fecha de nacimiento.
    SELECT tm.nombre_m, tr.nombre_r, tm.sexo_m, tc.nombre_c, tm.fecha_nacimiento_m FROM tbl_mascotas tm
        INNER JOIN tbl_raza tr on tm.codigo_r = tr.codigo_r
        INNER JOIN tbl_cliente tc on tm.id_c = tc.id_c;
    -- Obtener los juegos, los artículos de limpieza y la medicina de los productos, además, obtener el nombre del dueño y su edad.
    EXECUTE pa_insert_factura '01', '2019-04-04', '001', '01';
    EXECUTE pa_insert_factura_producto '01', '001';
    SELECT  tpd.nombre_pd, tpd.precio_pd, ttp.nombre_tp, tc.nombre_c, tc.edad_c FROM tbl_factura tf
        INNER JOIN tbl_factura_producto tfp on tf.codigo_f = tfp.codigo_f
        INNER JOIN tbl_productos tpd on tfp.codigo_pd = tpd.codigo_pd
        INNER JOIN tbl_mascotas tm on tf.id_m = tm.id_m
        INNER JOIN tbl_cliente tc on tm.id_c = tc.id_c
        INNER JOIN tbl_tipo_producto ttp on tpd.codigo_tp = ttp.codigo_tp
    WHERE ttp.codigo_tp IN ('01', '03', '04');
    -- Obtener el nombre de la mascota motita, la raza Frespuder, sexo hembra.
    EXECUTE pa_insert_especie '02', 'Perro';
    EXECUTE pa_insert_raza '02', 'Frespuder';
    EXECUTE pa_insert_mascota '002', 'Motita', 'Es una perra suave y juguetea mucho.', '2', 'Hembra', '2016-07-12', '02', '80265475', '02';
    SELECT tm.nombre_m, tm.sexo_m, tr.nombre_r from tbl_mascotas tm
        INNER JOIN tbl_raza tr on tm.codigo_r = tr.codigo_r
    WHERE tm.nombre_m = 'Motita' AND tm.sexo_m = 'Hembra' AND tr.nombre_r = 'Frespuder';
    -- Obtener el accesorio pañoleta de la tabla profesional, además obtener el nombre del cliente y su edad.
    EXECUTE pa_insert_productos '007', 'Pañoleta', 6000.0, '05';
    EXECUTE pa_insert_factura '002', '2019-04-04', '002', '01';
    EXECUTE pa_insert_factura_producto '002', '007';
    SELECT tpfl.nombre_pfl, tp.nombre_pd, tp.precio_pd, tc.nombre_c, tc.edad_c FROM tbl_factura tf
        INNER JOIN tbl_factura_producto tfp on tf.codigo_f = tfp.codigo_f
        INNER JOIN tbl_productos tp on tfp.codigo_pd = tp.codigo_pd
        INNER JOIN tbl_mascotas tm on tf.id_m = tm.id_m
        INNER JOIN tbl_cliente tc on tm.id_c = tc.id_c
        INNER JOIN tbl_profesional tpfl on tf.codigo_pfl = tpfl.codigo_pfl
    WHERE (tp.nombre_pd = 'Pañoleta');
    -- Obtener la edad del cliente entre 18 y 40.
    EXECUTE pa_insert_cliente '1000247589', 'Alice', 'Yuuko', '17', '2001-04-22';
    SELECT * FROM tbl_cliente WHERE edad_c BETWEEN 18 AND 40;
    -- Obtener la información del cliente Pedro.
    EXECUTE pa_insert_cliente '87499852', 'Pedro', 'Sánchez', '30', '1989-02-21';
    SELECT * FROM tbl_cliente WHERE nombre_c = 'Pedro';
    -- Obtener el servicio limpieza, el nombre del cliente, y el nombre de la mascota.
    EXECUTE pa_insert_factura '003', '2019-04-08', '001', '01';
    EXECUTE pa_insert_factura_servicio '003', '02';
    SELECT ts.nombre_s, ts.precio_s, tc.nombre_c, tm.nombre_m FROM tbl_factura tf
        INNER JOIN tbl_factura_servicio tfs on tf.codigo_f = tfs.codigo_f
        INNER JOIN tbl_mascotas tm on tf.id_m = tm.id_m
        INNER JOIN tbl_cliente tc on tm.id_c = tc.id_c
        INNER JOIN tbl_servicio ts on tfs.codigo_s = ts.codigo_s
    WHERE ts.codigo_s = '02';
    -- Obtener la máxima edad del cliente con su nombre y apellido
    SELECT nombre_c, apellido_c, edad_c FROM tbl_cliente WHERE edad_c = (SELECT MAX(edad_c) FROM tbl_cliente);
    -- Ordenar la edad de las mascotas ascendente
    SELECT nombre_m, descripcion_m, edad_m FROM tbl_mascotas ORDER BY edad_m ASC;