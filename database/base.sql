drop schema public cascade;
create schema public;

--SEQUENCE

--Sample:
/*
 
 CREATE TEMPORARY SEQUENCE area_brasil
 INCREMENT BY 2
 MINVALUE 8500000
 MAXVALUE 8500001
 START WITH 8500000
 CYCLE
 CACHE 1;
---------------------------

CREATE SEQUENCE serial START 101;

*/

create sequence serial_senioridade start 1;
create sequence serial_colaborador start 1;
create sequence serial_categoria start 1;
create sequence serial_competencia start 1;
create sequence serial_turma_formacao start 1;
create sequence serial_status start 1;

--------------------------

create table senioridade(
	id INT primary key,
	nome_senioridade VARCHAR(12) not NULL
);

create table colaborador(
	id INT primary key,
	nome_colaborador VARCHAR(20) not null,
	sobrenome_colaborador VARCHAR(15) not null,
	cpf INT not null unique,
	email varchar(50) not null unique,
	foto bytea, /*
	NOTA: O PostgreSQL tem apenas bytea ,
	não tem um BLOB Oracle padrão : "O padrão SQL define (...) BLOB.
	O formato de entrada é diferente de bytea, mas as funções
	e operadores fornecidos são basicamente os mesmos",
	Confira o manual:
	https://www.postgresql.org/docs/current/datatype-binary.html*/
	data_nascimento DATE not null,
	data_admissao DATE not null
	--id_senioridade INT not null references senioridade(id_senioridade)
);

create table categoria(
	id INT primary key,
	nome_categoria VARCHAR(30) not null unique
);

create table competencia(
	id INT primary key,
	nome_competencia VARCHAR(30) not null unique,
	descricao VARCHAR(50) not null,
	id_categoria INT not null references categoria
);

create table colaborador_competencia(
	id_colaborador INT not null references colaborador,
	id_competencia INT not null references competencia,
	primary key(id_colaborador, id_competencia),
	nivel INT not null check(nivel >= 1 and nivel <= 5)
);

create table status(
	id INT primary key,
	nome_status VARCHAR(15) not null
);

create table turma_formacao(
	id INT primary key,
	nome_turma_formacao VARCHAR(30) not null,
	descricao_turma_formacao VARCHAR(100) not null,
	dataTermino DATE,
	id_status INT not null references status 
);

create table turma_colaborador_competencia(
	id_turma_formacao INT references turma_formacao,
	id_colaborador INT references  colaborador,
	id_competencia INT references competencia,
	primary key(id_turma_formacao, id_competencia, id_colaborador)
);

/*insert into senioridade (id, nome_senioridade) values (nextval('serial_senioridade'), 'Estagiário');
insert into senioridade (id, nome_senioridade) values (nextval('serial_senioridade'), 'Júnior');
insert into senioridade (id, nome_senioridade) values (nextval('serial_senioridade'), 'Pleno');
insert into senioridade (id, nome_senioridade) values (nextval('serial_senioridade'), 'Sênior');

/*Backend, Frontend, Banco, Arquitetura, Metodologia Ágil, Testes,
Devops, Liderança.*/
insert into categoria (id, nome_categoria) values (nextval('serial_categoria'), 'Backend');
insert into categoria (id, nome_categoria) values (nextval('serial_categoria'),'Frontend');
insert into categoria (id, nome_categoria) values (nextval('serial_categoria'),'Banco');
insert into categoria (id, nome_categoria) values (nextval('serial_categoria'),'Arquitetura');
insert into categoria (id, nome_categoria) values (nextval('serial_categoria'),'Metodologia Ágil');
insert into categoria (id, nome_categoria) values (nextval('serial_categoria'),'Testes');
insert into categoria (id, nome_categoria) values (nextval('serial_categoria'),'Devops');
insert into categoria (id, nome_categoria) values (nextval('serial_categoria'),'Liderança');

/*Pendente, Iniciada, Concluída.*/
insert into status (id, nome_status) values (nextval('serial_status'), 'Pendente');
insert into status (id, nome_status) values (nextval('serial_status'), 'Iniciada');
insert into status (id, nome_status) values (nextval('serial_status'), 'Concluída')*/