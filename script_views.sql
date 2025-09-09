use `cristinasEmpanadas`;
CREATE VIEW `HistorialDePedidos` AS
SELECT
  p.id_pedido,
  u.nombre AS nombre_cliente,
  u.apellido AS apellido_cliente,
  p.fecha_pedido,
  p.estado_pedido,
  p.total
FROM
  Pedidos AS p
JOIN
  Usuarios AS u ON p.id_usuario = u.id_usuario;
  
  
CREATE VIEW `RankingProductos` AS
SELECT
  prod.nombre AS nombre_producto,
  SUM(dp.cantidad) AS cantidad_total_vendida
FROM
  DetallePedidos AS dp
JOIN
  Productos AS prod ON dp.id_producto = prod.id_producto
GROUP BY
  prod.nombre
ORDER BY
  cantidad_total_vendida DESC;
  
CREATE VIEW `ResumenVentasDiarias` AS
SELECT
  DATE(fecha_pedido) AS fecha_venta,
  COUNT(id_pedido) AS numero_pedidos,
  SUM(total) AS total_recaudado
FROM
  Pedidos
GROUP BY
  DATE(fecha_pedido)
ORDER BY
  fecha_venta DESC;