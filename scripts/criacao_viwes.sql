
-- View 1: Total de pedidos por mês
DROP VIEW IF EXISTS total_pedidos_por_mes;
CREATE VIEW total_pedidos_por_mes AS
SELECT 
    strftime('%Y-%m', created_at) AS mes,
    COUNT(DISTINCT order_id) AS total_pedidos
FROM fato_pedidos
GROUP BY mes
ORDER BY mes DESC;

-- View 2: Receita total por método de pagamento
DROP VIEW IF EXISTS receita_por_metodo_pagamento;
CREATE VIEW receita_por_metodo_pagamento AS
SELECT 
    payment_method,
    SUM(total) AS receita_total
FROM fato_pedidos
GROUP BY payment_method
ORDER BY receita_total DESC;

-- View 3: Produto mais vendido (quantidade)
DROP VIEW IF EXISTS produto_mais_vendido;
CREATE VIEW produto_mais_vendido AS
SELECT 
    product_id,
    SUM(quantity) AS total_vendido
FROM fato_pedidos
GROUP BY product_id
ORDER BY total_vendido DESC;

-- View 4: Ticket médio por cliente
DROP VIEW IF EXISTS ticket_medio_por_cliente;
CREATE VIEW ticket_medio_por_cliente AS
SELECT 
    user_id,
    COUNT(DISTINCT order_id) AS total_pedidos,
    SUM(total) AS valor_total,
    ROUND(SUM(total) * 1.0 / COUNT(DISTINCT order_id), 2) AS ticket_medio
FROM fato_pedidos
GROUP BY user_id
ORDER BY ticket_medio DESC;

-- View 5: Total de pedidos por status de envio
DROP VIEW IF EXISTS pedidos_por_status_envio;
CREATE VIEW pedidos_por_status_envio AS
SELECT 
    shipping_status,
    COUNT(DISTINCT order_id) AS total_pedidos
FROM fato_pedidos
GROUP BY shipping_status
ORDER BY total_pedidos DESC;

-- View 6: Receita por produto com nome
DROP VIEW IF EXISTS receita_por_produto;
CREATE VIEW receita_por_produto AS
SELECT 
    fp.product_id,
    dp.name AS nome_produto,
    SUM(fp.total) AS receita_total
FROM fato_pedidos fp
LEFT JOIN dim_produtos dp ON fp.product_id = dp.product_id
GROUP BY fp.product_id, dp.name
ORDER BY receita_total DESC;

-- View 7: Total de pedidos por hora (baseado no entry_time do usuário)
DROP VIEW IF EXISTS pedidos_por_hora;
CREATE VIEW pedidos_por_hora AS
SELECT 
    strftime('%H', du.entry_time) AS hora,
    COUNT(DISTINCT fp.order_id) AS total_pedidos
FROM fato_pedidos fp
LEFT JOIN dim_usuarios du ON fp.user_id = du.user_id
GROUP BY hora
ORDER BY hora;

-- View 8: Pedidos por data de entrada do cliente
DROP VIEW IF EXISTS pedidos_por_data_entrada;
CREATE VIEW pedidos_por_data_entrada AS
SELECT 
    du.entry_date,
    COUNT(DISTINCT fp.order_id) AS total_pedidos
FROM fato_pedidos fp
LEFT JOIN dim_usuarios du ON fp.user_id = du.user_id
GROUP BY du.entry_date
ORDER BY du.entry_date;

-- View 9: Ticket médio por e-mail do cliente
DROP VIEW IF EXISTS ticket_medio_cliente_email;
CREATE VIEW ticket_medio_cliente_email AS
SELECT 
    fp.user_id,
    du.`e-mail` AS email,
    ROUND(SUM(fp.total) * 1.0 / COUNT(DISTINCT fp.order_id), 2) AS ticket_medio
FROM fato_pedidos fp
LEFT JOIN dim_usuarios du ON fp.user_id = du.user_id
GROUP BY fp.user_id, du.`e-mail`
ORDER BY ticket_medio DESC;

-- View 10: Total de pedidos por cliente e status de envio
DROP VIEW IF EXISTS pedidos_cliente_status_envio;
CREATE VIEW pedidos_cliente_status_envio AS
SELECT 
    fp.user_id,
    du.name AS nome_cliente,
    fp.shipping_status,
    COUNT(DISTINCT fp.order_id) AS total_pedidos
FROM fato_pedidos fp
LEFT JOIN dim_usuarios du ON fp.user_id = du.user_id
GROUP BY fp.user_id, fp.shipping_status
ORDER BY total_pedidos DESC;
