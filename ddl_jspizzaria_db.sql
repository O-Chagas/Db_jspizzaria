CREATE TABLE cliente (
idCliente INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(50) NOT NULL,
celular CHAR(11) NOT NULL
);

CREATE TABLE endereco (
idEndereco INT AUTO_INCREMENT PRIMARY KEY,
tipoLogradouro VARCHAR(10) NOT NULL,
logradouro VARCHAR(50) NOT NULL,
numero VARCHAR(6) NOT NULL,
complemento VARCHAR(10),
CEP CHAR(8) NOT NULL,
bairro VARCHAR(30) NOT NULL,
cidade VARCHAR(30) NOT NULL,
UF VARCHAR(2) NOT NULL,
idCliente INT NOT NULL,
CONSTRAINT fk_endereco_cliente FOREIGN KEY (idCliente) REFERENCES cliente (idCliente)
);

CREATE TABLE formaPagamento (
idFormaPagamento INT AUTO_INCREMENT PRIMARY KEY,
nomeFormaPagamento VARCHAR(50) NOT NULL
);

CREATE TABLE perfil (
idPerfil INT AUTO_INCREMENT PRIMARY KEY,
nomePerfil VARCHAR(30)
);

CREATE TABLE usuario (
idUsuario INT AUTO_INCREMENT PRIMARY KEY,
nomeUsuario VARCHAR(50) NOT NULL,
cpfUsuario CHAR(11) NOT NULL,
login VARCHAR(30) NOT NULL,
senha CHAR(8),
idPerfil INT NOT NULL,
CONSTRAINT fk_usuario_perfil FOREIGN KEY (idPerfil) REFERENCES perfil (idPerfil)
);

CREATE TABLE pizzas (
idPizza INT AUTO_INCREMENT PRIMARY KEY,
nomePizza VARCHAR(30) NOT NULL,
pathFoto VARCHAR(50) NOT NULL,
valor DECIMAL(7,2) NOT NULL,
tamanho CHAR(1) NOT NULL,
descricao VARCHAR(150),
idUsuario INT NOT NULL,
CONSTRAINT fk_pizzas_usuario FOREIGN KEY (idUsuario) REFERENCES usuario (idUsuario)
);

CREATE TABLE pedido (
idPedido INT AUTO_INCREMENT PRIMARY KEY,
dataPedido DATETIME,
valorToral DECIMAL(10,2),
idFormaPagamento INT NOT NULL,
idCliente INT NOT NULL,
idUsuario INT NOT NULL,
CONSTRAINT fk_pedido_formaPagamento FOREIGN KEY (idFormaPagamento) REFERENCES formaPagamento (idFormaPagamento),
CONSTRAINT fk_pedido_cliente FOREIGN KEY (idCliente) REFERENCES cliente (idCliente),
CONSTRAINT fk_pedido_usuario FOREIGN KEY (idUsuario) REFERENCES usuario (idUsuario)
);

CREATE TABLE pedidosPizza (
idPedido INT NOT null,
idPizza INT NOT null,
qtdPizza INT,
valorParcialItem DECIMAL(10,2),
PRIMARY KEY (idPedido, idPizza),
CONSTRAINT fk_pedidosPizza_pedido FOREIGN KEY (idPedido) REFERENCES pedido (idPedido),
CONSTRAINT fk_pedidosPizza_pizzas FOREIGN KEY (idPizza) REFERENCES pizzas (idPizza)
);

CREATE TABLE parcela (
idPedido INT PRIMARY KEY NOT NULL,
qtdParcelas INT NOT NULL,
CONSTRAINT fk_parcela_pedido FOREIGN KEY (idPedido) REFERENCES pedido (idPedido)
);

CREATE TABLE promocoes (
idPromocao INT AUTO_INCREMENT PRIMARY KEY,
descricaoPromocao VARCHAR(50) NOT NULL,
dataInicio DATETIME NOT NULL,
dataFim DATETIME NOT NULL,
percentualDesconto DECIMAL(5,2) NOT NULL,
statusPromocao CHAR(1) NOT NULL,
idUsuario INT NOT NULL,
idPizza INT NOT NULL,
CONSTRAINT fk_promocoes_usuario FOREIGN KEY (idUsuario) REFERENCES usuario (idUsuario),
CONSTRAINT fk_promocoes_pizzas FOREIGN KEY (idPizza) REFERENCES pizzas (idPizza)
);