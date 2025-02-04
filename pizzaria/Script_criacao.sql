CREATE DATABASE IF NOT EXISTS pizzaria;
USE pizzaria;

-- Tabela de Clientes
CREATE TABLE cliente (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    ultimo_nome VARCHAR(45),
    celular VARCHAR(45)
);

-- Tabela de Bebidas
CREATE TABLE bebida (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    preco FLOAT NOT NULL
);

-- Tabela de Status dos Pedidos
CREATE TABLE status (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL
);

-- Tabela de Tipos de Entrega
CREATE TABLE entrega (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(45) NOT NULL
);

-- Tabela de Bordas de Pizza
CREATE TABLE bordas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL
);

-- Tabela de Massas
CREATE TABLE massas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(30) NOT NULL
);

-- Tabela de Pizzas
CREATE TABLE pizza (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tamanho VARCHAR(45) NOT NULL,
    preco FLOAT NOT NULL
);

-- Tabela de Sabores
CREATE TABLE sabor (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL
);

-- Tabela de Endereços
CREATE TABLE endereco (
    id INT AUTO_INCREMENT PRIMARY KEY,
    complemento VARCHAR(45),
    numero VARCHAR(45),
    rua VARCHAR(45),
    cep VARCHAR(45),
    cliente_id INT,
    CONSTRAINT fk_endereco_cliente FOREIGN KEY (cliente_id) REFERENCES cliente(id) ON DELETE CASCADE
);

-- Tabela de Pedidos
CREATE TABLE pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    entrega_id INT,
    borda_id INT,
    massas_id INT,
    endereco_id INT,
    status_id INT,
    CONSTRAINT fk_pedido_entrega FOREIGN KEY (entrega_id) REFERENCES entrega(id) ON DELETE SET NULL,
    CONSTRAINT fk_pedido_borda FOREIGN KEY (borda_id) REFERENCES bordas(id) ON DELETE SET NULL,
    CONSTRAINT fk_pedido_massas FOREIGN KEY (massas_id) REFERENCES massas(id) ON DELETE SET NULL,
    CONSTRAINT fk_pedido_endereco FOREIGN KEY (endereco_id) REFERENCES endereco(id) ON DELETE SET NULL,
    CONSTRAINT fk_pedido_status FOREIGN KEY (status_id) REFERENCES status(id) ON DELETE SET NULL
);

-- Relacionamento entre Pedidos e Pizzas
CREATE TABLE pedido_pizza (
    order_id INT,
    pizza_id INT,
    quantidade INT NOT NULL,
    PRIMARY KEY (order_id, pizza_id),
    CONSTRAINT fk_pedido_pizza_pedido FOREIGN KEY (order_id) REFERENCES pedido(id) ON DELETE CASCADE,
    CONSTRAINT fk_pedido_pizza_pizza FOREIGN KEY (pizza_id) REFERENCES pizza(id) ON DELETE CASCADE
);

-- Relacionamento entre Pedidos e Sabores (Muitos para Muitos)
CREATE TABLE pedido_sabor (
    pedido_id INT,
    sabor_id INT,
    PRIMARY KEY (pedido_id, sabor_id),
    CONSTRAINT fk_pedido_sabor_pedido FOREIGN KEY (pedido_id) REFERENCES pedido(id) ON DELETE CASCADE,
    CONSTRAINT fk_pedido_sabor_sabor FOREIGN KEY (sabor_id) REFERENCES sabor(id) ON DELETE CASCADE
);

-- Relacionamento entre Pedidos e Bebidas (Muitos para Muitos)
CREATE TABLE pedido_bebida (
    pedido_id INT,
    bebida_id INT,
    PRIMARY KEY (pedido_id, bebida_id),
    CONSTRAINT fk_pedido_bebida_pedido FOREIGN KEY (pedido_id) REFERENCES pedido(id) ON DELETE CASCADE,
    CONSTRAINT fk_pedido_bebida_bebida FOREIGN KEY (bebida_id) REFERENCES bebida(id) ON DELETE CASCADE
);