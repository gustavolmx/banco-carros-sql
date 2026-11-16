drop database if exists carros;

create database carros;

use carros;

create table marcas (
	id int not null auto_increment,
    nome_marca varchar(200) not null,
    origem varchar(255) not null,
    primary key (id)
);
insert into marcas (nome_marca, origem)
values ('fiat', 'italia'),
       ('honda', 'japao'),
       ('jeep', 'eua'),
       ('byd', 'china'),
       ('toyota', 'japao');
       
insert into inventario (modelo, transmissao, motor, marcas_id)
values ('corolla', 'automatico', '2.0', 5);       

        
create table inventario (
	id int not null auto_increment,
	modelo varchar(255) not null,
	transmissao varchar(255) not null,
	motor decimal(2,1) not null,
	marcas_id int not null,
	primary key (id),
	foreign key (marcas_id) references marcas(id)
);

insert into inventario (modelo, transmissao, motor, marcas_id)
values ('touro', 'automatico', '2.0', 1),
		('civic', 'manual', '2.0', 2),
        ('compass', 'automatico', '1.0', 3),
        ('song plus', 'automatico', '2.0', 4);
        
insert into inventario (modelo, transmissao, motor, marcas_id)
values ('corolla', 'automatico', '2.0', 5);
        
        
create table clientes (
	id int not null auto_increment,
	nome varchar(255) not null,
    sobre_nome varchar(255) not null,
    endereco varchar(255) not null,
    primary key (id)
);

insert into clientes (nome, sobre_nome, endereco)
values ('Carlos',  'Silva',    'Rua das Flores, 120'),
       ('Mariana', 'Souza',    'Av. Brasil, 450'),
       ('Rafael',  'Lima',     'Rua Sete, 33'),
       ('Juliana', 'Costa',    'Rua do Comércio, 810'),
       ('Pedro',   'Oliveira', 'Av. Paulista, 1000');
        
create table vendas (
    id int not null auto_increment,
    clientes_id int not null,                
    inventario_id int not null,              
    data_venda date not null,                
    valor decimal(10,2) not null,            
    primary key (id),
    foreign key (clientes_id) references clientes(id),
    foreign key (inventario_id) references inventario(id)
);        

insert into vendas (clientes_id, inventario_id, data_venda, valor)
values (1, 2, '2026-01-15', 165000.00), 
       (2, 1, '2026-02-03', 142000.00),  
       (3, 3, '2026-02-20', 178000.00),  
       (4, 4, '2026-03-11', 235000.00),  
       (1, 1, '2026-04-05', 140000.00),  
       (5, 2, '2026-05-18', 168000.00),  
       (2, 3, '2026-06-09', 180000.00),  
       (3, 1, '2026-07-22', 143000.00); 
       
-- 1 Listar todos os carros com o nome da marca. (INNER JOIN)       
select 	
	m.nome_marca, 
    i.modelo
from marcas m
inner join inventario i on m.id = i.marcas_id;

-- 2 Listar os carros automáticos com a marca e o país de origem. (JOIN + WHERE)
select 
	m.nome_marca, 
    i.modelo, 
    m.origem, 
    i.transmissao
from marcas m
inner join inventario i on m.id = i.marcas_id
where i.transmissao = 'automatico';

-- 3 Quantas vendas foram feitas e qual o valor total faturado? (COUNT, SUM)
select count(inventario_id) as vendas_feitas,
		sum(valor) as total
from vendas;

-- 4 Qual o ticket médio das vendas? (AVG)       
select
	avg(valor) as vendas_media
from vendas;

-- 5 Qual o total vendido por marca? (3 tabelas + GROUP BY)
select 
	m.nome_marca,
    sum(v.valor) as total_vendido
from vendas v
inner join inventario i on v.inventario_id = i.id      
inner join marcas m on i.marcas_id = m.id
group by m.nome_marca
order by total_vendido desc;

-- 6 Qual o modelo mais vendido? (GROUP BY + ORDER BY + LIMIT) 
select 
	i.modelo,
    count(*) as total_vendido
from vendas v
inner join inventario i on v.inventario_id = i.id
group by i.modelo
order by total_vendido desc
limit 1; 

-- 7  Quais clientes compraram mais de um carro? (GROUP BY + HAVING) 
select
	c.nome,
    c.sobre_nome,
	count(*) as vendas_por_cliente
from vendas v
inner join clientes c on v.clientes_id = c.id
group by c.id, c.nome, c.sobre_nome
having count(*) > 1;

-- 8 Quanto foi vendido em cada mês? (MONTH() + GROUP BY)
select 
	month(data_venda) as vendas_mes,
    sum(valor) as total
from vendas v
group by vendas_mes
order by total desc;

-- 9 Quais vendas ficaram acima do ticket médio? (subquery)
select
	v.valor,
    v.data_venda
from vendas v
where valor > (select avg(valor) 
from vendas
);

-- 10 Quais carros do inventário nunca foram vendidos? (LEFT JOIN + IS NULL)     
select i.modelo, v.id
from inventario i
left join vendas v on v.inventario_id = i.id
where v.id is null;
