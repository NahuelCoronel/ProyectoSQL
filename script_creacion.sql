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
    