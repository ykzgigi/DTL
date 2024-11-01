Create database bd_export;

use bd_export;


create table departamento (
id INT primary key auto_increment not null,
nome VARCHAR(50) not null,
localizacao varchar(50) not null,
orcamento decimal (10,2)
);

INSERT into departamento (nome,localizacao,orcamento)
values ("RH", "Rio de Janeiro", 4000.00),
("Marketing", "São Paulo",30000.00),
("TI", "Santa Catarina", 540000.00),
("Finanças", "Pindamonhangaba", 25000.00),
("Vendas", "Indaiatuba", 640000.00);

#exporta via SQL
SELECT * FROM departamento
INTO OUTFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\depto.csv'
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n';

delete from departamento
where id = 5;


#importa arquivo, csv exportado
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\depto.csv'
INTO TABLE departamento
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n';

select * from departamento;


##inicio da transação
START transaction;

##Aumentar o orçamento do departamento de TI em 1000
UPDATE departamento SET orcamento = orcamento + 1000.00 WHERE nome = 'TI';


## Aumentar o orçamento do departamento Financeiro em 1000
UPDATE departamento SET orcamento = orcamento + 10000000.00 WHERE nome = 'Finanças';

##confirmar transação
COMMIT;



START transaction;


UPDATE departamento SET orcamento = orcamento - 5000.00 WHERE nome = 'Marketing';


UPDATE departamento SET orcamento = orcamento - 3000.00 WHERE nome = 'Vendas';

ROLLBACK;


select * from departamento;





START transaction;

UPDATE departamento SET orcamento = orcamento + 5000.00 WHERE nome = 'RH';


##Definir um ponto intermediário
savepoint ajuste_parcial;

UPDATE departamento SET orcamento = orcamento + 3000.00 WHERE nome = 'Vendas';

##Reverter para o ponto intermediário(desfaz o aumento do orçamento de vendas)
ROLLBACK TO ajuste_parcial;


select * from departamento;


