use `cristinasEmpanadas`;

CREATE TABLE `Pedidos_log` (
  `id_log` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `id_pedido_cambiado` INT NOT NULL,
  `accion` VARCHAR(20) NOT NULL,
  `old_estado_pedido` VARCHAR(50) NULL,
  `new_estado_pedido` VARCHAR(50) NULL,
  `old_total` DECIMAL(10, 2) NULL,
  `new_total` DECIMAL(10, 2) NULL,
  `usuario` VARCHAR(100) NOT NULL,
  `fecha_cambio` DATETIME NOT NULL
);


DELIMITER //

CREATE TRIGGER `tr_Pedidos_Insert` AFTER INSERT ON `Pedidos`
FOR EACH ROW
BEGIN
    INSERT INTO `Pedidos_log` (
        `id_pedido_cambiado`,
        `accion`,
        `new_estado_pedido`,
        `new_total`,
        `usuario`,
        `fecha_cambio`
    )
    VALUES (
        NEW.id_pedido,
        'INSERT',
        NEW.estado_pedido,
        NEW.total,
        USER(),
        NOW()
    );
END //

DELIMITER ;


DELIMITER //

CREATE TRIGGER `tr_Pedidos_Delete` AFTER DELETE ON `Pedidos`
FOR EACH ROW
BEGIN
    INSERT INTO `Pedidos_log` (
        `id_pedido_cambiado`,
        `accion`,
        `old_estado_pedido`,
        `old_total`,
        `usuario`,
        `fecha_cambio`
    )
    VALUES (
        OLD.id_pedido,
        'DELETE',
        OLD.estado_pedido,
        OLD.total,
        USER(),
        NOW()
    );
END //

DELIMITER ;



DELIMITER //

CREATE TRIGGER `tr_Pedidos_Update` BEFORE UPDATE ON `Pedidos`
FOR EACH ROW
BEGIN

    IF OLD.estado_pedido <> NEW.estado_pedido OR OLD.total <> NEW.total THEN
        INSERT INTO `Pedidos_log` (
            `id_pedido_cambiado`,
            `accion`,
            `old_estado_pedido`,
            `new_estado_pedido`,
            `old_total`,
            `new_total`,
            `usuario`,
            `fecha_cambio`
        )
        VALUES (
            OLD.id_pedido,
            'UPDATE',
            OLD.estado_pedido,
            NEW.estado_pedido,
            OLD.total,
            NEW.total,
            USER(),
            NOW()
        );
    END IF;
END //

DELIMITER ;
