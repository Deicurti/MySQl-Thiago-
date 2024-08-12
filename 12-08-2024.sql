-- create database Task: Lista com join 2
-- use Task: Lista com join 2
-- Listar o número do pedido, a data do pedido e o nome do cliente dos pedidos realizados em agosto de 2016:

SELECT Pedidos.numero_pedido, Pedidos.data_pedido, Clientes.nome
FROM Pedidos
JOIN Clientes ON Pedidos.cliente_id = Clientes.cliente_id
WHERE EXTRACT(MONTH FROM Pedidos.data_pedido) = 8
AND EXTRACT(YEAR FROM Pedidos.data_pedido) = 2016;

-- Listar o número do pedido, a data do pedido, o nome do cliente e o nome do vendedor dos pedidos realizados em julho de 2016:

SELECT Pedidos.numero_pedido, Pedidos.data_pedido, Clientes.nome AS nome_cliente, Vendedores.nome AS nome_vendedor
FROM Pedidos
JOIN Clientes ON Pedidos.cliente_id = Clientes.cliente_id
JOIN Vendedores ON Pedidos.vendedor_id = Vendedores.vendedor_id
WHERE EXTRACT(MONTH FROM Pedidos.data_pedido) = 7
AND EXTRACT(YEAR FROM Pedidos.data_pedido) = 2016;
-- Listar o nome e o preço dos produtos comprados pelo cliente com id=1:

SELECT Produtos.nome AS nome_produto, Produtos.preco
FROM Pedidos
JOIN ItensPedido ON Pedidos.numero_pedido = ItensPedido.numero_pedido
JOIN Produtos ON ItensPedido.produto_id = Produtos.produto_id
WHERE Pedidos.cliente_id = 1;
-- Listar o número do pedido e o nome dos clientes que possuem ou não possuem pedidos:

SELECT Clientes.nome AS nome_cliente, Pedidos.numero_pedido
FROM Clientes
LEFT JOIN Pedidos ON Clientes.cliente_id = Pedidos.cliente_id;

-- Listar o nome, preço, nome da categoria e nome da marca do produto mais caro:

SELECT Produtos.nome AS nome_produto, Produtos.preco, Categorias.nome AS nome_categoria, Marcas.nome AS nome_marca
FROM Produtos
JOIN Categorias ON Produtos.categoria_id = Categorias.categoria_id
JOIN Marcas ON Produtos.marca_id = Marcas.marca_id
WHERE Produtos.preco = (
    SELECT MAX(preco) FROM Produtos
);

-- Listar o número do pedido, valor total e nome do cliente do pedido mais caro:

SELECT Pedidos.numero_pedido, Pedidos.valor_total, Clientes.nome AS nome_cliente
FROM Pedidos
JOIN Clientes ON Pedidos.cliente_id = Clientes.cliente_id
WHERE Pedidos.valor_total = (
    SELECT MAX(valor_total) FROM Pedidos
);
-- Listar o número do pedido, valor total e nome do vendedor do pedido mais barato:

SELECT Pedidos.numero_pedido, Pedidos.valor_total, Vendedores.nome AS nome_vendedor
FROM Pedidos
JOIN Vendedores ON Pedidos.vendedor_id = Vendedores.vendedor_id
WHERE Pedidos.valor_total = (
    SELECT MIN(valor_total) FROM Pedidos
);