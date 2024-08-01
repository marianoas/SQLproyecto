DROP DATABASE IF EXISTS Banco;
CREATE DATABASE Banco;

USE Banco;

-- CREACION DE TABLA DE SEGMENTOS DE CLIENTES --
CREATE TABLE segmento_cliente (
    id_segmento_cliente INT NOT NULL AUTO_INCREMENT,
    nombre_segmento_cliente VARCHAR(50),
    PRIMARY KEY (id_segmento_cliente)
);

-- CREACION DE TABLA DE TIPOS DE TELEFONO --
CREATE TABLE tipo_telefono (
    id_tipo_telefono INT NOT NULL AUTO_INCREMENT,
    descripcion VARCHAR(50),
    PRIMARY KEY (id_tipo_telefono)
);

-- CREACION DE TABLA DE CLIENTES --
CREATE TABLE cliente (
    id_cliente INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    dni VARCHAR(20) UNIQUE, -- asume que el DNI es único
    fecha_nacimiento DATE,
    ciudad VARCHAR(50),
    telefono VARCHAR(20),
    correo_electronico VARCHAR(50),
    id_segmento_cliente INT,
    id_tipo_telefono INT,
    fecha_de_alta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_cliente),
    FOREIGN KEY (id_segmento_cliente) REFERENCES segmento_cliente(id_segmento_cliente),
    FOREIGN KEY (id_tipo_telefono) REFERENCES tipo_telefono(id_tipo_telefono)
);

-- CREACION DE TABLA DE AREA DE SUCURSAL --
CREATE TABLE area_sucursal (
    id_area_sucursal INT NOT NULL AUTO_INCREMENT,
    nombre_area VARCHAR(50),
    PRIMARY KEY (id_area_sucursal)
);

-- CREACION DE TABLA DE SUCURSAL --
CREATE TABLE sucursal (
    id_sucursal INT NOT NULL AUTO_INCREMENT,
    nombre_sucursal VARCHAR(50),
    ubicacion_sucursal VARCHAR(50),
    id_area_sucursal INT NOT NULL,
    PRIMARY KEY (id_sucursal),
    FOREIGN KEY (id_area_sucursal) REFERENCES area_sucursal(id_area_sucursal)
);

-- CREACION DE TABLA DE CUENTAS --
CREATE TABLE cuenta (
    numero_cuenta INT NOT NULL AUTO_INCREMENT,
    id_cliente INT,
    tipo_de_cuenta VARCHAR(50),
    saldo DECIMAL(15, 2),
    moneda VARCHAR(3),
    fecha_apertura DATE,
    id_sucursal INT,
    estado VARCHAR(20),
    PRIMARY KEY (numero_cuenta),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal)
);

-- CREACION DE TABLA DE TIPO DE PUESTO --
CREATE TABLE tipo_puesto (
    id_puesto INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(255),
    PRIMARY KEY (id_puesto)
);

-- CREACION DE TABLA DE EMPLEADOS --
CREATE TABLE empleados (
    id_empleado INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    cargo VARCHAR(50),
    id_sucursal INT NOT NULL,
    id_puesto INT NOT NULL,
    fecha_contratacion DATE,
    PRIMARY KEY (id_empleado),
    FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal),
    FOREIGN KEY (id_puesto) REFERENCES tipo_puesto(id_puesto)
);


-- CREACION DE TABLA DE PRESTAMOS --
CREATE TABLE prestamos (
    id_prestamos INT NOT NULL AUTO_INCREMENT,
    id_cuenta INT,
    monto DECIMAL(15, 2),
    tasa_interes DECIMAL(3, 2),
    fecha_otorgamiento DATE,
    estado VARCHAR(20),
    plazo INT,
    id_empleado INT,
    PRIMARY KEY (id_prestamos),
    FOREIGN KEY (id_cuenta) REFERENCES cuenta(numero_cuenta),
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado)
);

-- CREACION DE TABLA DE TIPO DE TRANSFERENCIA --
CREATE TABLE tipo_transferencia (
    id_tipo_transferencia INT NOT NULL AUTO_INCREMENT,
    nombre_tipo_transferencia VARCHAR(50),
    PRIMARY KEY (id_tipo_transferencia)
);

-- CREACION DE TABLA DE TRANSFERENCIAS --
CREATE TABLE transferencia (
    id_transferencia INT NOT NULL AUTO_INCREMENT,
    cuenta_origen INT,
    cuenta_destino INT,
    monto DECIMAL(15, 2),
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_tipo_transferencia INT,
    PRIMARY KEY (id_transferencia),
    FOREIGN KEY (cuenta_origen) REFERENCES cuenta(numero_cuenta),
    FOREIGN KEY (cuenta_destino) REFERENCES cuenta(numero_cuenta),
    FOREIGN KEY (id_tipo_transferencia) REFERENCES tipo_transferencia(id_tipo_transferencia)
);

-- CREACION DE TABLA DE TIPO DE TARJETAS --
CREATE TABLE tipo_tarjetas (
    id_tipo_tarjeta INT NOT NULL AUTO_INCREMENT,
    nombre_tipo_tarjeta VARCHAR(20),
    PRIMARY KEY (id_tipo_tarjeta)
);

-- CREACION DE TABLA DE MORA --
CREATE TABLE mora (
    id_mora INT NOT NULL AUTO_INCREMENT,
    dias_mora INT,
    monto_mora DECIMAL(15, 2),
    estado_mora VARCHAR(50),
    PRIMARY KEY (id_mora)
);

-- CREACION DE TABLA DE TARJETAS --
CREATE TABLE tarjetas (
    id_tarjeta INT NOT NULL AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    numero_tarjeta BIGINT,
    id_tipo_tarjeta INT NOT NULL,
    fecha_vencimiento DATE,
    limite_tarjeta DECIMAL(15, 2),
    mora_tarjetas INT NOT NULL,
    PRIMARY KEY (id_tarjeta),
    FOREIGN KEY (id_tipo_tarjeta) REFERENCES tipo_tarjetas(id_tipo_tarjeta),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (mora_tarjetas) REFERENCES mora(id_mora)
);

-- CREACION DE TABLA DE TIPO DE INVERSION --
CREATE TABLE tipo_inversion (
    id_tipo_inversion INT NOT NULL AUTO_INCREMENT,
    nombre_inversion VARCHAR(50),
    PRIMARY KEY (id_tipo_inversion)
);

-- CREACION DE TABLA DE INVERSION --
CREATE TABLE inversion (
    id_inversion INT NOT NULL AUTO_INCREMENT,
    id_cuenta INT NOT NULL,
    id_tipo_inversion INT NOT NULL,
    monto DECIMAL(15, 2),
    fecha_inicio DATE,
    fecha_fin DATE,
    mora_inversion INT NOT NULL,
    PRIMARY KEY (id_inversion),
    FOREIGN KEY (id_cuenta) REFERENCES cuenta(numero_cuenta),
    FOREIGN KEY (id_tipo_inversion) REFERENCES tipo_inversion(id_tipo_inversion),
    FOREIGN KEY (mora_inversion) REFERENCES mora(id_mora)
);

-- CREACION DE TABLA DE TIPO DE SEGUROS --
CREATE TABLE tipo_seguro (
    id_tipo_seguro INT NOT NULL AUTO_INCREMENT,
    nombre_seguro VARCHAR(50),
    PRIMARY KEY (id_tipo_seguro)
);

-- CREACION DE TABLA DE SEGUROS --
CREATE TABLE seguros (
    id_seguros INT NOT NULL AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    id_tipo_seguro INT,
    fecha_inicio DATE,
    fecha_fin DATE,
    PRIMARY KEY (id_seguros),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_tipo_seguro) REFERENCES tipo_seguro(id_tipo_seguro)
);


-- VISTAS  --

-- vista_clientes_con_cuentas  ----

CREATE VIEW vista_clientes_con_cuentas AS
SELECT 
    c.id_cliente, 
    c.nombre, 
    c.apellido, 
    c.dni, 
    c.ciudad, 
    cu.numero_cuenta, 
    cu.tipo_de_cuenta, 
    cu.saldo, 
    cu.moneda, 
    cu.fecha_apertura, 
    cu.estado
FROM 
    cliente c
JOIN 
    cuenta cu ON c.id_cliente = cu.id_cliente;

SELECT * FROM vista_clientes_con_cuentas ;

-- vista_prestamos_empleados --

CREATE VIEW vista_prestamos_empleados AS
SELECT 
    p.id_prestamos, 
    p.monto, 
    p.tasa_interes, 
    p.fecha_otorgamiento, 
    p.estado, 
    p.plazo, 
    e.nombre AS empleado_nombre, 
    e.apellido AS empleado_apellido, 
    e.cargo
FROM 
    prestamos p
JOIN 
    empleados e ON p.id_empleado = e.id_empleado;


SELECT * FROM vista_prestamos_empleados ;

-- VISTA transferencias --
CREATE VIEW vista_transferencias AS
SELECT 
    t.id_transferencia, 
    t.cuenta_origen, 
    co.tipo_de_cuenta AS tipo_cuenta_origen, 
    t.cuenta_destino, 
    cd.tipo_de_cuenta AS tipo_cuenta_destino, 
    t.monto, 
    t.fecha_hora, 
    tt.nombre_tipo_transferencia
FROM 
    transferencia t
JOIN 
    cuenta co ON t.cuenta_origen = co.numero_cuenta
JOIN 
    cuenta cd ON t.cuenta_destino = cd.numero_cuenta
JOIN 
    tipo_transferencia tt ON t.id_tipo_transferencia = tt.id_tipo_transferencia;
    
SELECT * FROM vista_transferencias;

-- FUNCIONES --

-- Función - calcular_edad --

DELIMITER // 
CREATE FUNCTION obtener_saldo_cuenta(p_numero_cuenta INT) 
RETURNS DECIMAL(15, 2) 
DETERMINISTIC
BEGIN
    DECLARE saldo DECIMAL(15, 2);
    SELECT c.saldo INTO saldo -- Elimina espacios extra
    FROM cuenta c
    WHERE c.numero_cuenta = p_numero_cuenta; 
    
    RETURN saldo; 
END //

DELIMITER ;

-- STORE PRECUDERE --

-- Store precudere - agregar clientes --

DELIMITER //
CREATE PROCEDURE agregar_cliente(
    IN p_nombre VARCHAR(50), 
    IN p_apellido VARCHAR(50), 
    IN p_dni VARCHAR(20), 
    IN p_fecha_nacimiento DATE, 
    IN p_ciudad VARCHAR(50), 
    IN p_telefono VARCHAR(20), 
    IN p_correo_electronico VARCHAR(50), 
    IN p_id_segmento_cliente INT, 
    IN p_id_tipo_telefono INT
)
BEGIN
    INSERT INTO cliente (nombre, apellido, dni, fecha_nacimiento, ciudad, telefono, correo_electronico, id_segmento_cliente, id_tipo_telefono) 
    VALUES (p_nombre, p_apellido, p_dni, p_fecha_nacimiento, p_ciudad, p_telefono, p_correo_electronico, p_id_segmento_cliente, p_id_tipo_telefono);
END //

DELIMITER ;


-- STORE PRECUDERE actualizar estado del prestamo --

DELIMITER //
CREATE PROCEDURE actualizar_estado_prestamo(
    IN p_id_prestamo INT, 
    IN p_nuevo_estado VARCHAR(20)
)
BEGIN
    UPDATE prestamos 
    SET estado = p_nuevo_estado 
    WHERE id_prestamos = p_id_prestamo;
END //
DELIMITER ;