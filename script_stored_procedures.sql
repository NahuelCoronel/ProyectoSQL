use `cristinasEmpanadas`;

DELIMITER //

CREATE PROCEDURE `ObtenerDetallePedido`(IN pedido_id INT)
BEGIN
    SELECT
        p.nombre AS nombre_producto,
        dp.cantidad,
        dp.precio_unitario,
        (dp.cantidad * dp.precio_unitario) AS subtotal
    FROM
        DetallePedidos AS dp
    JOIN
        Productos AS p ON dp.id_producto = p.id_producto
    WHERE
        dp.id_pedido = pedido_id;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `ObtenerPedidosActivos`()
BEGIN
    SELECT
        p.id_pedido,
        u.nombre AS nombre_cliente,
        u.apellido AS apellido_cliente,
        u.telefono,
        u.direccion,
        p.fecha_pedido,
        p.estado_pedido,
        p.total
    FROM
        Pedidos AS p
    JOIN
        Usuarios AS u ON p.id_usuario = u.id_usuario
    WHERE
        p.estado_pedido = 'Pendiente' OR p.estado_pedido = 'En camino'
    ORDER BY
        p.fecha_pedido ASC;
END //

DELIMITER ;


DELIMITER //


CREATE PROCEDURE `ActualizarEstadoPedido`(
    IN p_id_pedido INT,
    IN nuevo_estado VARCHAR(50)
)
BEGIN
    -- Validar que el pedido exista antes de actualizar
    IF EXISTS (SELECT 1 FROM Pedidos WHERE id_pedido = id_pedido) THEN
        UPDATE Pedidos
        SET estado_pedido = nuevo_estado
        WHERE id_pedido = p_id_pedido;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El ID de pedido no existe.';
    END IF;
END //

DELIMITER ;


