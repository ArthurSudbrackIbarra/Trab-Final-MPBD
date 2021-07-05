-- Deletar as tabelas
DROP TABLE clientes CASCADE CONSTRAINTS;
DROP TABLE compras CASCADE CONSTRAINTS;
DROP TABLE enderecos CASCADE CONSTRAINTS;
DROP TABLE fornecedores CASCADE CONSTRAINTS;
DROP TABLE gerentes CASCADE CONSTRAINTS;
DROP TABLE lojas CASCADE CONSTRAINTS;
DROP TABLE telefones CASCADE CONSTRAINTS;
DROP TABLE lojas_fisicas CASCADE CONSTRAINTS;
DROP TABLE lojas_virt_trans CASCADE CONSTRAINTS;
DROP TABLE lojas_virtuais CASCADE CONSTRAINTS;
DROP TABLE produtos CASCADE CONSTRAINTS;
DROP TABLE produtos_lojas CASCADE CONSTRAINTS;
DROP TABLE transportadoras CASCADE CONSTRAINTS;

-- Criar as tabelas
CREATE TABLE enderecos (
 id_endereco NUMERIC(10) NOT NULL,
 logradouro VARCHAR(100) NOT NULL,
 complemento VARCHAR(100),
 cidade VARCHAR(100) NOT NULL
);
ALTER TABLE enderecos ADD CONSTRAINT PK_enderecos PRIMARY KEY (id_endereco);

CREATE TABLE fornecedores (
 id_fornecedor NUMERIC(10) NOT NULL,
 nome VARCHAR(100) NOT NULL,
 preco_frete NUMERIC(7,3) NOT NULL
);
ALTER TABLE fornecedores ADD CONSTRAINT PK_fornecedores PRIMARY KEY (id_fornecedor);

CREATE TABLE gerentes (
 id_gerente NUMERIC(10) NOT NULL,
 nome VARCHAR(100) NOT NULL,
 cpf CHAR(11) NOT NULL
);
ALTER TABLE gerentes ADD CONSTRAINT PK_gerentes PRIMARY KEY (id_gerente);
CREATE UNIQUE INDEX ak_cpf_gerentes ON gerentes (cpf);

CREATE TABLE lojas (
 id_loja NUMERIC(10) NOT NULL,
 nome VARCHAR(100) NOT NULL,
 gasto_mensal NUMERIC(10,3),
 prod_mais_vendido VARCHAR(100),
 num_funcionarios NUMERIC(7),
 id_gerente NUMERIC(10) NOT NULL,
 tipo CHAR(1) NOT NULL
);
ALTER TABLE lojas ADD CONSTRAINT PK_lojas PRIMARY KEY (id_loja);
ALTER TABLE lojas ADD CONSTRAINT CK_lojas CHECK (tipo in ('F','V'));

CREATE TABLE telefones(
    id_loja NUMERIC(10) NOT NULL,
    ddd NUMERIC(3) NOT NULL,
    operadora VARCHAR(50) NOT NULL,
    numero NUMERIC(9) NOT NULL
);

CREATE TABLE lojas_fisicas (
 id_loja NUMERIC(10) NOT NULL,
 valor_aluguel NUMERIC(7,3) NOT NULL,
 num_andares NUMERIC(2) NOT NULL,
 num_corredores NUMERIC(10) NOT NULL,
 id_endereco NUMERIC(10) NOT NULL
);
ALTER TABLE lojas_fisicas ADD CONSTRAINT PK_lojas_fisicas PRIMARY KEY (id_loja);

CREATE TABLE produtos (
 id_produto NUMERIC(10) NOT NULL,
 nome VARCHAR(100) NOT NULL,
 preco NUMERIC(10,3) NOT NULL,
 id_fornecedor NUMERIC(10) NOT NULL
);
ALTER TABLE produtos ADD CONSTRAINT PK_produtos PRIMARY KEY (id_produto);

CREATE TABLE produtos_lojas (
 id_prod_loj NUMERIC(10) NOT NULL,
 id_produto NUMERIC(10) NOT NULL,
 id_loja NUMERIC(10) NOT NULL
);
ALTER TABLE produtos_lojas ADD CONSTRAINT PK_prod_loj PRIMARY KEY (id_prod_loj);

CREATE TABLE transportadoras (
 id_transportadora NUMERIC(10) NOT NULL,
 nome VARCHAR(100) NOT NULL,
 preco_km NUMERIC(7,3) NOT NULL,
 preco_kg NUMERIC(7,3) NOT NULL
);
ALTER TABLE transportadoras ADD CONSTRAINT PK_transportadoras PRIMARY KEY (id_transportadora);

CREATE TABLE clientes (
 id_cliente NUMERIC(10) NOT NULL,
 id_loja NUMERIC(10) NOT NULL,
 nome VARCHAR(100) NOT NULL,
 cpf CHAR(11) NOT NULL,
 data_primeira_compra DATE,
 data_ultima_compra DATE
);
ALTER TABLE clientes ADD CONSTRAINT PK_clientes PRIMARY KEY (id_cliente,id_loja);

CREATE TABLE compras (
 id_compra NUMERIC(10) NOT NULL,
 data_efetivacao DATE NOT NULL,
 quantidade NUMERIC(5) NOT NULL,
 forma_pagamento VARCHAR(50) NOT NULL,
 preco_pago NUMERIC(7,3) NOT NULL,
 id_cliente NUMERIC(10) NOT NULL,
 id_loja NUMERIC(10) NOT NULL,
 id_produto NUMERIC(10) NOT NULL
);
ALTER TABLE compras ADD CONSTRAINT PK_compras PRIMARY KEY (id_compra);

CREATE TABLE lojas_virtuais (
 id_loja NUMERIC(10) NOT NULL,
 preco_hospedagem NUMERIC(7,3) NOT NULL,
 site VARCHAR(255) NOT NULL
);
ALTER TABLE lojas_virtuais ADD CONSTRAINT PK_lojas_virtuais PRIMARY KEY (id_loja);

CREATE TABLE lojas_virt_trans (
 id_loj_virt_trans NUMERIC(10) NOT NULL,
 id_loja NUMERIC(10) NOT NULL,
 id_transportadora NUMERIC(10) NOT NULL,
 duracao_contrato_em_dias NUMERIC(5) NOT NULL
);
ALTER TABLE lojas_virt_trans ADD CONSTRAINT PK_lojas_virt_trans PRIMARY KEY (id_loj_virt_trans);

-- Foreign Keys
ALTER TABLE lojas ADD CONSTRAINT FK_lojas_0 FOREIGN KEY (id_gerente) REFERENCES gerentes (id_gerente);

ALTER TABLE telefones ADD CONSTRAINT FK_lojas_tel_0 FOREIGN KEY (id_loja) REFERENCES lojas (id_loja);

ALTER TABLE lojas_fisicas ADD CONSTRAINT FK_lojas_fisicas_0 FOREIGN KEY (id_loja) REFERENCES lojas (id_loja);
ALTER TABLE lojas_fisicas ADD CONSTRAINT FK_lojas_fisicas_1 FOREIGN KEY (id_endereco) REFERENCES enderecos (id_endereco);

ALTER TABLE produtos ADD CONSTRAINT FK_produtos_1 FOREIGN KEY (id_fornecedor) REFERENCES fornecedores (id_fornecedor);

ALTER TABLE clientes ADD CONSTRAINT FK_clientes_0 FOREIGN KEY (id_loja) REFERENCES lojas (id_loja);

ALTER TABLE compras ADD CONSTRAINT FK_compras_0 FOREIGN KEY (id_cliente,id_loja) REFERENCES clientes (id_cliente,id_loja);
ALTER TABLE compras ADD CONSTRAINT FK_compras_1 FOREIGN KEY (id_produto) REFERENCES produtos (id_produto);

ALTER TABLE lojas_virtuais ADD CONSTRAINT FK_lojas_virtuais_0 FOREIGN KEY (id_loja) REFERENCES lojas (id_loja);

ALTER TABLE produtos_lojas ADD CONSTRAINT FK_prod_loj_0 FOREIGN KEY (id_produto) REFERENCES produtos (id_produto);
ALTER TABLE produtos_lojas ADD CONSTRAINT FK_prod_loj_1 FOREIGN KEY (id_loja) REFERENCES lojas (id_loja);

ALTER TABLE lojas_virt_trans ADD CONSTRAINT FK_lojas_virt_trans_0 FOREIGN KEY (id_loja) REFERENCES lojas_virtuais (id_loja);
ALTER TABLE lojas_virt_trans ADD CONSTRAINT FK_lojas_virt_trans_1 FOREIGN KEY (id_transportadora) REFERENCES transportadoras (id_transportadora);

-- Inserts
INSERT INTO gerentes(id_gerente,nome,cpf) VALUES(1, 'Aloísio Dalberto Machado', '19484726401');
INSERT INTO gerentes(id_gerente,nome,cpf) VALUES(2, 'Betina Braum Limitte', '39484726404');
INSERT INTO gerentes(id_gerente,nome,cpf) VALUES(3, 'Gustavo Hertz Fried', '78484726422');
INSERT INTO gerentes(id_gerente,nome,cpf) VALUES(4, 'Clarisse Heidrich Moreira', '99484726409');
INSERT INTO gerentes(id_gerente,nome,cpf) VALUES(5, 'Hugo de Nogueira Bragança', '05484726845');

INSERT INTO lojas(id_loja,nome,gasto_mensal,prod_mais_vendido,num_funcionarios,id_gerente,tipo) VALUES(1,'PowerDresses',50000,'Vestido Branco Le Lis',50,1,'F');
INSERT INTO lojas(id_loja,nome,gasto_mensal,prod_mais_vendido,num_funcionarios,id_gerente,tipo) VALUES(2,'Jeans and Jeans',68000,'Jeans Folk Wrangler',56,2,'F');
INSERT INTO lojas(id_loja,nome,gasto_mensal,prod_mais_vendido,num_funcionarios,id_gerente,tipo) VALUES(3,'Extreme Tops',178900,'Boné Feminino Ultramarino HRX',117,3,'F');
INSERT INTO lojas(id_loja,nome,gasto_mensal,prod_mais_vendido,num_funcionarios,id_gerente,tipo) VALUES(4,'Pantos',17000,'Calça Xadrez Armani',9,4,'V');
INSERT INTO lojas(id_loja,nome,gasto_mensal,prod_mais_vendido,num_funcionarios,id_gerente,tipo) VALUES(5,'Gloomy',2719800,'Camisa Social Azul Celeste Zodiac',221,5,'V');

INSERT INTO telefones(id_loja,ddd,operadora,numero) VALUES(1,67,'Vivo',999626492);
INSERT INTO telefones(id_loja,ddd,operadora,numero) VALUES(1,51,'Vivo',983104728);
INSERT INTO telefones(id_loja,ddd,operadora,numero) VALUES(2,55,'Tim',995372918);
INSERT INTO telefones(id_loja,ddd,operadora,numero) VALUES(3,13,'Tim',998612049);
INSERT INTO telefones(id_loja,ddd,operadora,numero) VALUES(3,11,'Claro',998012934);
INSERT INTO telefones(id_loja,ddd,operadora,numero) VALUES(4,84,'Claro',999464623);
INSERT INTO telefones(id_loja,ddd,operadora,numero) VALUES(5,41,'Oi',999780954);
INSERT INTO telefones(id_loja,ddd,operadora,numero) VALUES(5,42,'Oi',998452600);

INSERT INTO enderecos(id_endereco,logradouro,complemento,cidade) VALUES(1,'Av. João Baptista',null,'Criciúma');
INSERT INTO enderecos(id_endereco,logradouro,complemento,cidade) VALUES(2,'Av. Carlos Drummond',null,'Macapá');
INSERT INTO enderecos(id_endereco,logradouro,complemento,cidade) VALUES(3,'Av. Borges Santana','Prédio D','Lajeado');
INSERT INTO enderecos(id_endereco,logradouro,complemento,cidade) VALUES(4,'Av. Marcelo Girardi',null,'Porto Seguro');
INSERT INTO enderecos(id_endereco,logradouro,complemento,cidade) VALUES(5,'Av. Napoleão Bonaparte',null,'Pomerode');

INSERT INTO lojas_fisicas(id_loja,valor_aluguel,num_andares,num_corredores,id_endereco) VALUES(1,2229.99,3,8,1);
INSERT INTO lojas_fisicas(id_loja,valor_aluguel,num_andares,num_corredores,id_endereco) VALUES(2,3799.99,5,13,2);
INSERT INTO lojas_fisicas(id_loja,valor_aluguel,num_andares,num_corredores,id_endereco) VALUES(3,8659.99,9,22,3);

INSERT INTO transportadoras(id_transportadora,nome,preco_km,preco_kg) VALUES(1,'Transportaqui', 22.9, 11.7);
INSERT INTO transportadoras(id_transportadora,nome,preco_km,preco_kg) VALUES(2,'Heyer', 23.1, 12.71);
INSERT INTO transportadoras(id_transportadora,nome,preco_km,preco_kg) VALUES(3,'NovaRetro', 20.9, 13.7);
INSERT INTO transportadoras(id_transportadora,nome,preco_km,preco_kg) VALUES(4,'AlphaTransport', 18.9, 14.6);
INSERT INTO transportadoras(id_transportadora,nome,preco_km,preco_kg) VALUES(5,'Joltex', 28.9, 7.89);

INSERT INTO lojas_virtuais(id_loja,preco_hospedagem,site) VALUES(4,319.99,'www.pantos.com.br');
INSERT INTO lojas_virtuais(id_loja,preco_hospedagem,site) VALUES(5,899.99,'www.gloomy.com');

INSERT INTO lojas_virt_trans(id_loj_virt_trans,id_loja,id_transportadora,duracao_contrato_em_dias) VALUES(1,4,1,365);
INSERT INTO lojas_virt_trans(id_loj_virt_trans,id_loja,id_transportadora,duracao_contrato_em_dias) VALUES(2,4,2,730);
INSERT INTO lojas_virt_trans(id_loj_virt_trans,id_loja,id_transportadora,duracao_contrato_em_dias) VALUES(3,4,3,1028);
INSERT INTO lojas_virt_trans(id_loj_virt_trans,id_loja,id_transportadora,duracao_contrato_em_dias) VALUES(4,5,4,188);
INSERT INTO lojas_virt_trans(id_loj_virt_trans,id_loja,id_transportadora,duracao_contrato_em_dias) VALUES(5,5,5,900);

INSERT INTO fornecedores(id_fornecedor,nome,preco_frete) VALUES(1,'Helix Fornecimentos',249.99);
INSERT INTO fornecedores(id_fornecedor,nome,preco_frete) VALUES(2,'Gambler Fornecimentos',219.99);
INSERT INTO fornecedores(id_fornecedor,nome,preco_frete) VALUES(3,'Kokoa Fornecimentos',329.99);
INSERT INTO fornecedores(id_fornecedor,nome,preco_frete) VALUES(4,'Gooliver Fornecimentos',209.99);
INSERT INTO fornecedores(id_fornecedor,nome,preco_frete) VALUES(5,'Rush Fornecimentos',469.99);

INSERT INTO produtos(id_produto,nome,preco,id_fornecedor) VALUES(1,'Vestido Branco Le Lis',1499.99,1);
INSERT INTO produtos(id_produto,nome,preco,id_fornecedor) VALUES(2,'Jeans Folk Wrangler',399.99,2);
INSERT INTO produtos(id_produto,nome,preco,id_fornecedor) VALUES(3,'Boné Feminino Ultramarino HRX',29.99,3);
INSERT INTO produtos(id_produto,nome,preco,id_fornecedor) VALUES(4,'Calça Xadrez Armani',499.99,4);
INSERT INTO produtos(id_produto,nome,preco,id_fornecedor) VALUES(5,'Camisa Social Azul Celeste Zodiac',599.99,5);
INSERT INTO produtos(id_produto,nome,preco,id_fornecedor) VALUES(6,'Meias Amarelas Adidas',7.99,1);
INSERT INTO produtos(id_produto,nome,preco,id_fornecedor) VALUES(7,'Meias Laranjas Adidas',7.99,2);
INSERT INTO produtos(id_produto,nome,preco,id_fornecedor) VALUES(8,'Meias Pretas Adidas',7.99,3);
INSERT INTO produtos(id_produto,nome,preco,id_fornecedor) VALUES(9,'Meias Vermelhas Adidas',7.99,4);
INSERT INTO produtos(id_produto,nome,preco,id_fornecedor) VALUES(10,'Meias Verdes Adidas',7.99,5);

INSERT INTO produtos_lojas(id_prod_loj,id_produto,id_loja) VALUES(1,1,1);
INSERT INTO produtos_lojas(id_prod_loj,id_produto,id_loja) VALUES(2,2,2);
INSERT INTO produtos_lojas(id_prod_loj,id_produto,id_loja) VALUES(3,3,3);
INSERT INTO produtos_lojas(id_prod_loj,id_produto,id_loja) VALUES(4,4,4);
INSERT INTO produtos_lojas(id_prod_loj,id_produto,id_loja) VALUES(5,5,5);
INSERT INTO produtos_lojas(id_prod_loj,id_produto,id_loja) VALUES(6,6,1);
INSERT INTO produtos_lojas(id_prod_loj,id_produto,id_loja) VALUES(7,7,2);
INSERT INTO produtos_lojas(id_prod_loj,id_produto,id_loja) VALUES(8,8,3);
INSERT INTO produtos_lojas(id_prod_loj,id_produto,id_loja) VALUES(9,9,4);
INSERT INTO produtos_lojas(id_prod_loj,id_produto,id_loja) VALUES(10,10,5);

INSERT INTO clientes(id_cliente,id_loja,nome,cpf,data_primeira_compra,data_ultima_compra) VALUES(1,1,'Marcelino Fugaz Chester','29417503850',TO_DATE('2020-06-05', 'YYYY-MM-DD'),TO_DATE('2021-06-20', 'YYYY-MM-DD'));
INSERT INTO clientes(id_cliente,id_loja,nome,cpf,data_primeira_compra,data_ultima_compra) VALUES(1,2,'Marcelino Fugaz Chester','29417503850',TO_DATE('2020-08-07', 'YYYY-MM-DD'),TO_DATE('2021-11-23', 'YYYY-MM-DD'));
INSERT INTO clientes(id_cliente,id_loja,nome,cpf,data_primeira_compra,data_ultima_compra) VALUES(2,1,'Vanessa Visconde Girardi','49417503851',TO_DATE('2020-07-06', 'YYYY-MM-DD'),TO_DATE('2021-11-01', 'YYYY-MM-DD'));
INSERT INTO clientes(id_cliente,id_loja,nome,cpf,data_primeira_compra,data_ultima_compra) VALUES(3,2,'Leonardo Versalles Gotz','79417503850',TO_DATE('2020-04-04', 'YYYY-MM-DD'),TO_DATE('2021-03-03', 'YYYY-MM-DD'));
INSERT INTO clientes(id_cliente,id_loja,nome,cpf,data_primeira_compra,data_ultima_compra) VALUES(4,3,'Breno Humbert Fagundes','89417503858',TO_DATE('2020-03-21', 'YYYY-MM-DD'),TO_DATE('2021-06-30', 'YYYY-MM-DD'));
INSERT INTO clientes(id_cliente,id_loja,nome,cpf,data_primeira_compra,data_ultima_compra) VALUES(5,3,'Kevin Flores da Cunha','19417503851',TO_DATE('2020-09-22', 'YYYY-MM-DD'),TO_DATE('2021-08-09', 'YYYY-MM-DD'));
INSERT INTO clientes(id_cliente,id_loja,nome,cpf,data_primeira_compra,data_ultima_compra) VALUES(6,4,'Moana Barcellos Lima','59417503855',TO_DATE('2020-10-10', 'YYYY-MM-DD'),TO_DATE('2021-08-24', 'YYYY-MM-DD'));
INSERT INTO clientes(id_cliente,id_loja,nome,cpf,data_primeira_compra,data_ultima_compra) VALUES(7,4,'Heitor Drew Kelvin','77417503888',TO_DATE('2020-10-13', 'YYYY-MM-DD'),TO_DATE('2021-04-24', 'YYYY-MM-DD'));
INSERT INTO clientes(id_cliente,id_loja,nome,cpf,data_primeira_compra,data_ultima_compra) VALUES(8,5,'César Rodrigues Salgueiro','23417503860',TO_DATE('2020-11-18', 'YYYY-MM-DD'),TO_DATE('2021-05-05', 'YYYY-MM-DD'));
INSERT INTO clientes(id_cliente,id_loja,nome,cpf,data_primeira_compra,data_ultima_compra) VALUES(9,5,'Alan Minsk Bertrudes','17417503884',TO_DATE('2020-01-25', 'YYYY-MM-DD'),TO_DATE('2021-02-27', 'YYYY-MM-DD'));

INSERT INTO compras(id_compra,data_efetivacao,quantidade,forma_pagamento,preco_pago,id_cliente,id_loja,id_produto) VALUES(1,TO_DATE('2020-06-05', 'YYYY-MM-DD'),3,'Cartão Crédito',4499.97,1,1,1);
INSERT INTO compras(id_compra,data_efetivacao,quantidade,forma_pagamento,preco_pago,id_cliente,id_loja,id_produto) VALUES(2,TO_DATE('2021-06-20', 'YYYY-MM-DD'),2,'Cartão Crédito',799.98,1,1,2);
INSERT INTO compras(id_compra,data_efetivacao,quantidade,forma_pagamento,preco_pago,id_cliente,id_loja,id_produto) VALUES(3,TO_DATE('2020-08-07', 'YYYY-MM-DD'),1,'Cartão Crédito',29.99,1,2,3);
INSERT INTO compras(id_compra,data_efetivacao,quantidade,forma_pagamento,preco_pago,id_cliente,id_loja,id_produto) VALUES(4,TO_DATE('2021-11-23', 'YYYY-MM-DD'),1,'Cartão Débito',499.99,1,2,4);
INSERT INTO compras(id_compra,data_efetivacao,quantidade,forma_pagamento,preco_pago,id_cliente,id_loja,id_produto) VALUES(5,TO_DATE('2020-07-06', 'YYYY-MM-DD'),5,'Boleto Bancário',2999.95,2,1,5);
INSERT INTO compras(id_compra,data_efetivacao,quantidade,forma_pagamento,preco_pago,id_cliente,id_loja,id_produto) VALUES(6,TO_DATE('2021-11-01', 'YYYY-MM-DD'),7,'Boleto Bancário',55.93,2,1,6);
INSERT INTO compras(id_compra,data_efetivacao,quantidade,forma_pagamento,preco_pago,id_cliente,id_loja,id_produto) VALUES(7,TO_DATE('2020-04-04', 'YYYY-MM-DD'),1,'Cartão Crédito',7.99,3,2,7);
INSERT INTO compras(id_compra,data_efetivacao,quantidade,forma_pagamento,preco_pago,id_cliente,id_loja,id_produto) VALUES(8,TO_DATE('2021-03-03', 'YYYY-MM-DD'),1,'Boleto Bancário',7.99,3,2,8);
INSERT INTO compras(id_compra,data_efetivacao,quantidade,forma_pagamento,preco_pago,id_cliente,id_loja,id_produto) VALUES(9,TO_DATE('2020-03-21', 'YYYY-MM-DD'),2,'Cartão Crédito',15.98,4,3,9);
INSERT INTO compras(id_compra,data_efetivacao,quantidade,forma_pagamento,preco_pago,id_cliente,id_loja,id_produto) VALUES(10,TO_DATE('2021-06-30', 'YYYY-MM-DD'),2,'Cartão Crédito',15.98,4,3,10);
INSERT INTO compras(id_compra,data_efetivacao,quantidade,forma_pagamento,preco_pago,id_cliente,id_loja,id_produto) VALUES(11,TO_DATE('2020-09-22', 'YYYY-MM-DD'),1,'Cartão Crédito',1499.99,5,3,1);
INSERT INTO compras(id_compra,data_efetivacao,quantidade,forma_pagamento,preco_pago,id_cliente,id_loja,id_produto) VALUES(12,TO_DATE('2021-08-09', 'YYYY-MM-DD'),1,'PIX',399.99,5,3,2);
INSERT INTO compras(id_compra,data_efetivacao,quantidade,forma_pagamento,preco_pago,id_cliente,id_loja,id_produto) VALUES(13,TO_DATE('2020-10-10', 'YYYY-MM-DD'),1,'PayPal',29.99,6,4,3);
INSERT INTO compras(id_compra,data_efetivacao,quantidade,forma_pagamento,preco_pago,id_cliente,id_loja,id_produto) VALUES(14,TO_DATE('2021-08-24', 'YYYY-MM-DD'),1,'Cartão Débito',499.99,6,4,4);
INSERT INTO compras(id_compra,data_efetivacao,quantidade,forma_pagamento,preco_pago,id_cliente,id_loja,id_produto) VALUES(15,TO_DATE('2020-10-13', 'YYYY-MM-DD'),1,'Cartão Débito',599.99,7,4,5);
INSERT INTO compras(id_compra,data_efetivacao,quantidade,forma_pagamento,preco_pago,id_cliente,id_loja,id_produto) VALUES(16,TO_DATE('2021-04-24', 'YYYY-MM-DD'),1,'Cartão Crédito',7.99,7,4,6);
INSERT INTO compras(id_compra,data_efetivacao,quantidade,forma_pagamento,preco_pago,id_cliente,id_loja,id_produto) VALUES(17,TO_DATE('2020-11-18', 'YYYY-MM-DD'),1,'PayPal',7.99,8,5,7);
INSERT INTO compras(id_compra,data_efetivacao,quantidade,forma_pagamento,preco_pago,id_cliente,id_loja,id_produto) VALUES(18,TO_DATE('2021-05-05', 'YYYY-MM-DD'),1,'PIX',7.99,8,5,8);
INSERT INTO compras(id_compra,data_efetivacao,quantidade,forma_pagamento,preco_pago,id_cliente,id_loja,id_produto) VALUES(19,TO_DATE('2020-01-25', 'YYYY-MM-DD'),1,'PIX',7.99,9,5,9);
INSERT INTO compras(id_compra,data_efetivacao,quantidade,forma_pagamento,preco_pago,id_cliente,id_loja,id_produto) VALUES(20,TO_DATE('2021-02-27', 'YYYY-MM-DD'),2,'PIX',15.98,9,5,10);

COMMIT;

-- Consultas

-- (3 tabelas) Liste o nome e o preço de todos os produtos da loja 'Gloomy'.
SELECT
    prod.nome,
    prod.preco
FROM
    lojas loj INNER JOIN produtos_lojas pl ON pl.id_loja = loj.id_loja
    INNER JOIN produtos prod ON prod.id_produto = pl.id_produto
WHERE
    loj.nome = 'Gloomy';
    
-- (4 tabelas) Liste todas as compras realizadas na loja 'Pantos', o nome do produto comprado e o nome dos clientes que realizaram estas compras.
SELECT
    compr.data_efetivacao,
    compr.quantidade,
    compr.forma_pagamento,
    compr.preco_pago,
    cli.nome AS nome_cliente,
    prod.nome AS nome_produto
FROM
    compras compr INNER JOIN clientes cli ON cli.id_cliente = compr.id_cliente
    INNER JOIN produtos prod ON prod.id_produto = compr.id_produto
    INNER JOIN lojas loj ON loj.id_loja = compr.id_loja
WHERE
    loj.nome = 'Pantos';

-- (4 tabelas) Liste o lucro total o id e o nome de todas as lojas cadastradas no sistema que possuem a letra 'S' em seus nomes.
SELECT
    loj.id_loja,
    loj.nome,
    SUM(compr.preco_pago) as lucro
FROM
    compras compr INNER JOIN clientes cli ON cli.id_cliente = compr.id_cliente
    INNER JOIN produtos prod ON prod.id_produto = compr.id_produto
    INNER JOIN lojas loj ON loj.id_loja = compr.id_loja
GROUP BY
    loj.id_loja,
    loj.nome
HAVING
    loj.nome like '%s%' or loj.nome like '%S%';

-- (6 tabelas) Liste o nome dos gerentes, o nome, o telefone (ddd + numero) e o site de suas lojas virtuais, 
-- além do nome e do tempo em dias do contrato das transportadoras que as lojas em questão tem parceria.
SELECT 
    ger.nome as nome_gerente,
    loj.nome as nome_loja,
    tel.ddd,
    tel.numero,
    loj_virt.site,
    trans.nome as nome_transportadora,
    loj_virt_trans.duracao_contrato_em_dias
FROM
    gerentes ger INNER JOIN lojas loj ON loj.id_gerente = ger.id_gerente
    INNER JOIN telefones tel ON tel.id_loja = loj.id_loja
    INNER JOIN lojas_virtuais loj_virt ON loj_virt.id_loja = loj.id_loja
    INNER JOIN lojas_virt_trans loj_virt_trans ON loj_virt_trans.id_loja = loj_virt.id_loja
    INNER JOIN transportadoras trans ON trans.id_transportadora = loj_virt_trans.id_transportadora;
    
-- Liste o nome, o número de andares, o número de corredores e o valor do aluguel
-- de todas as lojas físicas que até agora não obtiveram mais de 10 mil reais em vendas,
-- juntamente com o cpf dos gerentes destas lojas.
SELECT 
    ger.cpf as cpf_gerente,
    loj.nome as nome_loja,
    loj_fis.num_andares,
    loj_fis.num_corredores,
    loj_fis.valor_aluguel
FROM
    gerentes ger INNER JOIN lojas loj on loj.id_gerente = ger.id_gerente
    INNER JOIN lojas_fisicas loj_fis on loj_fis.id_loja = loj.id_loja
WHERE
    loj.id_loja IN (
        SELECT
            loj.id_loja
        FROM
            compras compr INNER JOIN clientes cli ON cli.id_cliente = compr.id_cliente
            INNER JOIN produtos prod ON prod.id_produto = compr.id_produto
            INNER JOIN lojas loj ON loj.id_loja = compr.id_loja
        GROUP BY
            loj.id_loja
        HAVING
            SUM(compr.preco_pago) < 10000
);
        
-- (Atualização) Reduza em 20% o valor do aluguel de todas as lojas físicas que até agora
-- não concluíram pelo menos 8 vendas.
UPDATE 
    lojas_fisicas
SET 
    lojas_fisicas.valor_aluguel = lojas_fisicas.valor_aluguel - (lojas_fisicas.valor_aluguel * 0.2)
WHERE
    lojas_fisicas.id_loja IN (
        SELECT
            loj_fis.id_loja
        FROM
            lojas loj INNER JOIN lojas_fisicas loj_fis ON loj_fis.id_loja = loj.id_loja
            INNER JOIN clientes cli ON cli.id_loja = loj.id_loja
            INNER JOIN compras compr ON compr.id_cliente = cli.id_cliente
        GROUP BY
            loj_fis.id_loja
        HAVING 
            COUNT(compr.id_compra) < 8
);