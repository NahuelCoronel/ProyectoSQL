create schema `cristinasEmpanadas`;

use `cristinasEmpanadas`;

CREATE TABLE `Usuarios` (
  `id_usuario` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `nombre` VARCHAR(50) NOT NULL,
  `apellido` VARCHAR(50) NOT NULL,
  `dni` VARCHAR(50) NOT NULL UNIQUE,
  `email` VARCHAR(50) NOT NULL UNIQUE,
  `password` VARCHAR(255) NOT NULL,
  `telefono` VARCHAR(20) NULL,
  `direccion` VARCHAR(200) NULL
);

CREATE TABLE `Productos` (
  `id_producto` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `nombre` VARCHAR(100) NOT NULL UNIQUE,
  `descripcion` varchar(200) NULL,
  `precio` DECIMAL(10, 2) NOT NULL
);

CREATE TABLE `Pedidos` (
  `id_pedido` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `id_usuario` INT NOT NULL,
  `fecha_pedido` DATETIME NOT NULL,
  `estado_pedido` VARCHAR(50) NOT NULL,
  `total` DECIMAL(10, 2) NOT NULL,
  FOREIGN KEY (`id_usuario`) REFERENCES `Usuarios`(`id_usuario`)
);

CREATE TABLE `DetallePedidos` (
  `id_detalle` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `id_pedido` INT NOT NULL,
  `id_producto` INT NOT NULL,
  `cantidad` INT NOT NULL,
  `precio_unitario` DECIMAL(10, 2) NOT NULL,
  FOREIGN KEY (`id_pedido`) REFERENCES `Pedidos`(`id_pedido`),
  FOREIGN KEY (`id_producto`) REFERENCES `Productos`(`id_producto`)
);


INSERT INTO Usuarios (nombre, apellido, dni, email, password, telefono, direccion) VALUES
('Juan', 'Perez', '12345678', 'juan.perez@example.com', 'pass123', '11-1234-5678', 'Av. Rivadavia 123'),
('Maria', 'Gomez', '87654321', 'maria.gomez@example.com', 'pass456', '11-8765-4321', 'Calle Falsa 123'),
('Carlos', 'Lopez', '11223344', 'carlos.lopez@example.com', 'pass789', '11-1122-3344', 'Av. Corrientes 456'),
('Ana', 'Rodriguez', '55667788', 'ana.rodriguez@example.com', 'pass012', '11-5566-7788', 'Av. Santa Fe 789');


INSERT INTO Productos (nombre, descripcion, precio) VALUES
('Carne', 'Carne, Cebolla, Morron, Aceituna', 1500),
('Pollo', 'Pollo, Cebolla, Morron', 1500),
('Jamón y Queso', 'Jamón, Queso Mozzarella, Orégano', 1500),
('Verdura', 'Acelga, Salsa Blanca, Nuez Moscada', 1500),
('Humita', 'Choclo Cremoso, Cebolla, Pimentón', 1500);


-- =========================================================
-- PEDIDO 1
-- =========================================================
INSERT INTO Pedidos (id_usuario, fecha_pedido, estado_pedido, total) VALUES
(1, NOW(), 'Completado', 0.00);

SET @pedido_id_1 = LAST_INSERT_ID();

INSERT INTO DetallePedidos (id_pedido, id_producto, cantidad, precio_unitario) VALUES
(@pedido_id_1, 1, 2, 1500.00),
(@pedido_id_1, 3, 1, 1500.00);

UPDATE Pedidos SET total = (SELECT SUM(cantidad * precio_unitario) FROM DetallePedidos WHERE id_pedido = @pedido_id_1) WHERE id_pedido = @pedido_id_1;

-- =========================================================
-- PEDIDO 2
-- =========================================================
INSERT INTO Pedidos (id_usuario, fecha_pedido, estado_pedido, total) VALUES
(2, NOW(), 'Pendiente', 0.00);

SET @pedido_id_2 = LAST_INSERT_ID();

INSERT INTO DetallePedidos (id_pedido, id_producto, cantidad, precio_unitario) VALUES
(@pedido_id_2, 2, 3, 1500.00),
(@pedido_id_2, 4, 1, 1500.00);

UPDATE Pedidos SET total = (SELECT SUM(cantidad * precio_unitario) FROM DetallePedidos WHERE id_pedido = @pedido_id_2) WHERE id_pedido = @pedido_id_2;

-- =========================================================
-- PEDIDO 3
-- =========================================================
INSERT INTO Pedidos (id_usuario, fecha_pedido, estado_pedido, total) VALUES
(3, NOW(), 'En camino', 0.00);

SET @pedido_id_3 = LAST_INSERT_ID();

INSERT INTO DetallePedidos (id_pedido, id_producto, cantidad, precio_unitario) VALUES
(@pedido_id_3, 5, 4, 1500.00),
(@pedido_id_3, 1, 2, 1500.00);

UPDATE Pedidos SET total = (SELECT SUM(cantidad * precio_unitario) FROM DetallePedidos WHERE id_pedido = @pedido_id_3) WHERE id_pedido = @pedido_id_3;

-- =========================================================
-- PEDIDO 4
-- =========================================================
INSERT INTO Pedidos (id_usuario, fecha_pedido, estado_pedido, total) VALUES
(4, NOW(), 'Completado', 0.00);

SET @pedido_id_4 = LAST_INSERT_ID();

INSERT INTO DetallePedidos (id_pedido, id_producto, cantidad, precio_unitario) VALUES
(@pedido_id_4, 1, 1, 1500.00);

UPDATE Pedidos SET total = (SELECT SUM(cantidad * precio_unitario) FROM DetallePedidos WHERE id_pedido = @pedido_id_4) WHERE id_pedido = @pedido_id_4;

-- =========================================================
-- PEDIDO 5
-- =========================================================
INSERT INTO Pedidos (id_usuario, fecha_pedido, estado_pedido, total) VALUES
(1, NOW(), 'Pendiente', 0.00);

SET @pedido_id_5 = LAST_INSERT_ID();

INSERT INTO DetallePedidos (id_pedido, id_producto, cantidad, precio_unitario) VALUES
(@pedido_id_5, 2, 2, 1500.00),
(@pedido_id_5, 3, 2, 1500.00);

UPDATE Pedidos SET total = (SELECT SUM(cantidad * precio_unitario) FROM DetallePedidos WHERE id_pedido = @pedido_id_5) WHERE id_pedido = @pedido_id_5;

-- =========================================================
-- PEDIDO 6
-- =========================================================
INSERT INTO Pedidos (id_usuario, fecha_pedido, estado_pedido, total) VALUES
(2, NOW(), 'Completado', 0.00);

SET @pedido_id_6 = LAST_INSERT_ID();

INSERT INTO DetallePedidos (id_pedido, id_producto, cantidad, precio_unitario) VALUES
(@pedido_id_6, 4, 3, 1500.00),
(@pedido_id_6, 5, 2, 1500.00);

UPDATE Pedidos SET total = (SELECT SUM(cantidad * precio_unitario) FROM DetallePedidos WHERE id_pedido = @pedido_id_6) WHERE id_pedido = @pedido_id_6;

-- =========================================================
-- PEDIDO 7
-- =========================================================
INSERT INTO Pedidos (id_usuario, fecha_pedido, estado_pedido, total) VALUES
(3, NOW(), 'En camino', 0.00);

SET @pedido_id_7 = LAST_INSERT_ID();

INSERT INTO DetallePedidos (id_pedido, id_producto, cantidad, precio_unitario) VALUES
(@pedido_id_7, 1, 1, 1500.00),
(@pedido_id_7, 2, 1, 1500.00),
(@pedido_id_7, 3, 1, 1500.00);

UPDATE Pedidos SET total = (SELECT SUM(cantidad * precio_unitario) FROM DetallePedidos WHERE id_pedido = @pedido_id_7) WHERE id_pedido = @pedido_id_7;

-- =========================================================
-- PEDIDO 8
-- =========================================================
INSERT INTO Pedidos (id_usuario, fecha_pedido, estado_pedido, total) VALUES
(4, NOW(), 'Completado', 0.00);

SET @pedido_id_8 = LAST_INSERT_ID();

INSERT INTO DetallePedidos (id_pedido, id_producto, cantidad, precio_unitario) VALUES
(@pedido_id_8, 5, 2, 1500.00);

UPDATE Pedidos SET total = (SELECT SUM(cantidad * precio_unitario) FROM DetallePedidos WHERE id_pedido = @pedido_id_8) WHERE id_pedido = @pedido_id_8;

-- =========================================================
-- PEDIDO 9
-- =========================================================
INSERT INTO Pedidos (id_usuario, fecha_pedido, estado_pedido, total) VALUES
(1, NOW(), 'Pendiente', 0.00);

SET @pedido_id_9 = LAST_INSERT_ID();

INSERT INTO DetallePedidos (id_pedido, id_producto, cantidad, precio_unitario) VALUES
(@pedido_id_9, 1, 3, 1500.00);

UPDATE Pedidos SET total = (SELECT SUM(cantidad * precio_unitario) FROM DetallePedidos WHERE id_pedido = @pedido_id_9) WHERE id_pedido = @pedido_id_9;

-- =========================================================
-- PEDIDO 10
-- =========================================================
INSERT INTO Pedidos (id_usuario, fecha_pedido, estado_pedido, total) VALUES
(2, NOW(), 'Completado', 0.00);

SET @pedido_id_10 = LAST_INSERT_ID();

INSERT INTO DetallePedidos (id_pedido, id_producto, cantidad, precio_unitario) VALUES
(@pedido_id_10, 2, 1, 1500.00),
(@pedido_id_10, 4, 2, 1500.00);

UPDATE Pedidos SET total = (SELECT SUM(cantidad * precio_unitario) FROM DetallePedidos WHERE id_pedido = @pedido_id_10) WHERE id_pedido = @pedido_id_10;

-- =========================================================
-- PEDIDO 11
-- =========================================================
INSERT INTO Pedidos (id_usuario, fecha_pedido, estado_pedido, total) VALUES
(3, NOW(), 'En camino', 0.00);

SET @pedido_id_11 = LAST_INSERT_ID();

INSERT INTO DetallePedidos (id_pedido, id_producto, cantidad, precio_unitario) VALUES
(@pedido_id_11, 3, 2, 1500.00),
(@pedido_id_11, 5, 1, 1500.00);

UPDATE Pedidos SET total = (SELECT SUM(cantidad * precio_unitario) FROM DetallePedidos WHERE id_pedido = @pedido_id_11) WHERE id_pedido = @pedido_id_11;

-- =========================================================
-- PEDIDO 12
-- =========================================================
INSERT INTO Pedidos (id_usuario, fecha_pedido, estado_pedido, total) VALUES
(4, NOW(), 'Completado', 0.00);

SET @pedido_id_12 = LAST_INSERT_ID();

INSERT INTO DetallePedidos (id_pedido, id_producto, cantidad, precio_unitario) VALUES
(@pedido_id_12, 1, 4, 1500.00);

UPDATE Pedidos SET total = (SELECT SUM(cantidad * precio_unitario) FROM DetallePedidos WHERE id_pedido = @pedido_id_12) WHERE id_pedido = @pedido_id_12;

-- =========================================================
-- PEDIDO 13
-- =========================================================
INSERT INTO Pedidos (id_usuario, fecha_pedido, estado_pedido, total) VALUES
(1, NOW(), 'Pendiente', 0.00);

SET @pedido_id_13 = LAST_INSERT_ID();

INSERT INTO DetallePedidos (id_pedido, id_producto, cantidad, precio_unitario) VALUES
(@pedido_id_13, 2, 2, 1500.00),
(@pedido_id_13, 3, 1, 1500.00),
(@pedido_id_13, 4, 1, 1500.00);

UPDATE Pedidos SET total = (SELECT SUM(cantidad * precio_unitario) FROM DetallePedidos WHERE id_pedido = @pedido_id_13) WHERE id_pedido = @pedido_id_13;

-- =========================================================
-- PEDIDO 14
-- =========================================================
INSERT INTO Pedidos (id_usuario, fecha_pedido, estado_pedido, total) VALUES
(2, NOW(), 'Completado', 0.00);

SET @pedido_id_14 = LAST_INSERT_ID();

INSERT INTO DetallePedidos (id_pedido, id_producto, cantidad, precio_unitario) VALUES
(@pedido_id_14, 5, 3, 1500.00);

UPDATE Pedidos SET total = (SELECT SUM(cantidad * precio_unitario) FROM DetallePedidos WHERE id_pedido = @pedido_id_14) WHERE id_pedido = @pedido_id_14;

-- =========================================================
-- PEDIDO 15
-- =========================================================
INSERT INTO Pedidos (id_usuario, fecha_pedido, estado_pedido, total) VALUES
(3, NOW(), 'En camino', 0.00);

SET @pedido_id_15 = LAST_INSERT_ID();

INSERT INTO DetallePedidos (id_pedido, id_producto, cantidad, precio_unitario) VALUES
(@pedido_id_15, 1, 2, 1500.00),
(@pedido_id_15, 2, 2, 1500.00);

UPDATE Pedidos SET total = (SELECT SUM(cantidad * precio_unitario) FROM DetallePedidos WHERE id_pedido = @pedido_id_15) WHERE id_pedido = @pedido_id_15;

-- =========================================================
-- PEDIDO 16
-- =========================================================
INSERT INTO Pedidos (id_usuario, fecha_pedido, estado_pedido, total) VALUES
(4, NOW(), 'Completado', 0.00);

SET @pedido_id_16 = LAST_INSERT_ID();

INSERT INTO DetallePedidos (id_pedido, id_producto, cantidad, precio_unitario) VALUES
(@pedido_id_16, 3, 1, 1500.00),
(@pedido_id_16, 4, 2, 1500.00);

UPDATE Pedidos SET total = (SELECT SUM(cantidad * precio_unitario) FROM DetallePedidos WHERE id_pedido = @pedido_id_16) WHERE id_pedido = @pedido_id_16;

-- =========================================================
-- PEDIDO 17
-- =========================================================
INSERT INTO Pedidos (id_usuario, fecha_pedido, estado_pedido, total) VALUES
(1, NOW(), 'Pendiente', 0.00);

SET @pedido_id_17 = LAST_INSERT_ID();

INSERT INTO DetallePedidos (id_pedido, id_producto, cantidad, precio_unitario) VALUES
(@pedido_id_17, 5, 5, 1500.00);

UPDATE Pedidos SET total = (SELECT SUM(cantidad * precio_unitario) FROM DetallePedidos WHERE id_pedido = @pedido_id_17) WHERE id_pedido = @pedido_id_17;

-- =========================================================
-- PEDIDO 18
-- =========================================================
INSERT INTO Pedidos (id_usuario, fecha_pedido, estado_pedido, total) VALUES
(2, NOW(), 'Completado', 0.00);

SET @pedido_id_18 = LAST_INSERT_ID();

INSERT INTO DetallePedidos (id_pedido, id_producto, cantidad, precio_unitario) VALUES
(@pedido_id_18, 1, 1, 1500.00),
(@pedido_id_18, 3, 1, 1500.00),
(@pedido_id_18, 5, 1, 1500.00);

UPDATE Pedidos SET total = (SELECT SUM(cantidad * precio_unitario) FROM DetallePedidos WHERE id_pedido = @pedido_id_18) WHERE id_pedido = @pedido_id_18;

-- =========================================================
-- PEDIDO 19
-- =========================================================
INSERT INTO Pedidos (id_usuario, fecha_pedido, estado_pedido, total) VALUES
(3, NOW(), 'En camino', 0.00);

SET @pedido_id_19 = LAST_INSERT_ID();

INSERT INTO DetallePedidos (id_pedido, id_producto, cantidad, precio_unitario) VALUES
(@pedido_id_19, 2, 2, 1500.00),
(@pedido_id_19, 4, 1, 1500.00);

UPDATE Pedidos SET total = (SELECT SUM(cantidad * precio_unitario) FROM DetallePedidos WHERE id_pedido = @pedido_id_19) WHERE id_pedido = @pedido_id_19;

-- =========================================================
-- PEDIDO 20
-- =========================================================
INSERT INTO Pedidos (id_usuario, fecha_pedido, estado_pedido, total) VALUES
(4, NOW(), 'Completado', 0.00);

SET @pedido_id_20 = LAST_INSERT_ID();

INSERT INTO DetallePedidos (id_pedido, id_producto, cantidad, precio_unitario) VALUES
(@pedido_id_20, 1, 3, 1500.00);

UPDATE Pedidos SET total = (SELECT SUM(cantidad * precio_unitario) FROM DetallePedidos WHERE id_pedido = @pedido_id_20) WHERE id_pedido = @pedido_id_20;


