USE Banco;

-- 1 Inserción de datos en la tabla segmento_cliente --
INSERT INTO segmento_cliente (nombre_segmento_cliente) VALUES 
('Premium'), 
('Regular'), 
('Básico');

--  2 Inserción de datos en la tabla tipo_telefono --
INSERT INTO tipo_telefono (descripcion) VALUES 
INSERT INTO tipo_telefono (descripcion) VALUES 
INSERT INTO tipo_telefono (descripcion) VALUES 
('Móvil'), 
('Fijo');

-- 3 Inserción de datos en la tabla cliente --
INSERT INTO cliente (nombre, apellido, dni, fecha_nacimiento, ciudad, telefono, correo_electronico, id_segmento_cliente, id_tipo_telefono) VALUES 
('Juan', 'Pérez', '12345678', '1980-01-01', 'Berazategui', '01112345678', 'juan.perez@example.com', 1, 1),
('Ana', 'García', '87654321', '1990-05-05', 'Florencio Varela', '03511234567', 'ana.garcia@example.com', 2, 2);

-- 4  Inserción de datos en la tabla area_sucursal --
INSERT INTO area_sucursal (nombre_area) VALUES 
('Zona Sur'), 
('Zona Suroeste');

-- 5 Inserción de datos en la tabla sucursal --
INSERT INTO sucursal (nombre_sucursal, ubicacion_sucursal, id_area_sucursal) VALUES 
('Sucursal Quilmes', 'Av. Siempre Viva 123', 1), 
('Sucursal Berazategui', 'Calle Falsa 456', 2);

-- 6  Inserción de datos en la tabla tipo_puesto --
INSERT INTO tipo_puesto (nombre) VALUES 
('Cajero'), 
('Gerente');

-- 7 Inserción de datos en la tabla empleados --
INSERT INTO empleados (nombre, apellido, cargo, id_sucursal, id_puesto, fecha_contratacion) VALUES 
('Pedro', 'López', 'Cajero', 1, 1, '2020-01-01'), 
('María', 'Martínez', 'Gerente', 2, 2, '2018-01-01');

-- 8 Inserción de datos en la tabla cuenta --
INSERT INTO cuenta (id_cliente, tipo_de_cuenta, saldo, moneda, fecha_apertura, id_sucursal, estado) VALUES 
(1, 'Ahorro', 10000.00, 'ARS', '2022-01-01', 1, 'Activa'), 
(2, 'Corriente', 20000.00, 'ARS', '2021-01-01', 2, 'Activa');

-- 9 Inserción de datos en la tabla prestamos --
INSERT INTO prestamos (id_cuenta, monto, tasa_interes, fecha_otorgamiento, estado, plazo, id_empleado) VALUES 
(1, 50000.00, 5.00, '2023-01-01', 'Activo', 24, 1), 
(2, 30000.00, 3.50, '2022-06-01', 'Activo', 36, 2);

-- 10 Inserción de datos en la tabla tipo_transferencia --
INSERT INTO tipo_transferencia (nombre_tipo_transferencia) VALUES 
('Interna'), 
('Externa');

-- 11 Inserción de datos en la tabla transferencia --
INSERT INTO transferencia (cuenta_origen, cuenta_destino, monto, id_tipo_transferencia) VALUES 
(1, 2, 55540, 1), 
(2, 1, 165000, 2);

-- 12 Inserción de datos en la tabla tipo_tarjetas --
INSERT INTO tipo_tarjetas (nombre_tipo_tarjeta) VALUES 
('Débito'), 
('Crédito');

-- 13 Inserción de datos en la tabla mora --
INSERT INTO mora (dias_mora, monto_mora, estado_mora) VALUES 
(30, 100.00, 'Pendiente'), 
(60, 200.00, 'Pendiente');

-- 14  Inserción de datos en la tabla tarjetas --
INSERT INTO tarjetas (id_cliente, numero_tarjeta, id_tipo_tarjeta, fecha_vencimiento, limite_tarjeta, mora_tarjetas) VALUES 
(1, 1234567890123456, 1, '2025-01-01', 10000.00, 1), 
(2, 6543210987654321, 2, '2024-06-01', 20000.00, 2);

-- 15 Inserción de datos en la tabla tipo_inversion --
INSERT INTO tipo_inversion (nombre_inversion) VALUES 
('Plazo Fijo'), 
('Fondo Común');

-- 16 Inserción de datos en la tabla inversion --
INSERT INTO inversion (id_cuenta, id_tipo_inversion, monto, fecha_inicio, fecha_fin, mora_inversion) VALUES 
(1, 1, 5000.00, '2023-01-01', '2024-01-01', 1), 
(2, 2, 7000.00, '2023-02-01', '2024-02-01', 2);

-- 17 Inserción de datos en la tabla tipo_seguro --
INSERT INTO tipo_seguro (nombre_seguro) VALUES 
('Vida'), 
('Hogar');

--  18 Inserción de datos en la tabla seguros --
INSERT INTO seguros (id_cliente, id_tipo_seguro, fecha_inicio, fecha_fin) VALUES 
(1, 1, '2023-01-01', '2024-01-01'), 
(2, 2, '2023-02-01', '2024-02-01');
