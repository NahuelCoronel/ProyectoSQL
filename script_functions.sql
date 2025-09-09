use `cristinasEmpanadas`;


DELIMITER //

CREATE FUNCTION `CalcularPrecioConDescuento`(precio DECIMAL(10, 2), descuento_porcentaje INT)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    RETURN precio - (precio * (descuento_porcentaje / 100));
END //

DELIMITER ;


DELIMITER //

CREATE FUNCTION `DescripcionEstadoPedido`(estado VARCHAR(50))
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE descripcion VARCHAR(100);

    CASE estado
        WHEN 'Completado' THEN SET descripcion = 'Pedido entregado y finalizado';
        WHEN 'Pendiente' THEN SET descripcion = 'En espera de confirmación y preparación';
        WHEN 'En camino' THEN SET descripcion = 'El pedido está en camino a su dirección';
        ELSE SET descripcion = 'Estado desconocido';
    END CASE;

    RETURN descripcion;
END //

DELIMITER ;


