-- Active: 1701011051961@@127.0.0.1@3306
CREATE DATABASE empresa_db;
    DEFAULT CHARACTER SET = 'utf8mb4';
USE empresa_db;

CREATE TABLE empregado (
    enome VARCHAR(40),
    cpf NUMERIC(11) PRIMARY KEY,
    nasc DATE,
    endereco VARCHAR(40),
    sexo CHAR(1),
    salario DECIMAL(10,2),
    superv NUMERIC(11),
    dept NUMERIC(4)
    Foreign Key (superv) REFERENCES empregado(cpf),
    Foreign Key (dept) REFERENCES departamento(dnum)
);

CREATE TABLE departamento (
    dnome VARCHAR(30),
    dnum NUMERIC(4) PRIMARY KEY,
    gerente VARCHAR(40)
);

CREATE TABLE local_dept (
    numdept NUMERIC(4),
    localdept NUMERIC(4) PRIMARY KEY,
    Foreign Key (numdept) REFERENCES departamento(dnum)
);

CREATE TABLE projeto (
    pnome VARCHAR(40),
    pnum NUMERIC(4) PRIMARY KEY,
    plocal VARCHAR(30),
    dnum NUMERIC(4),
    Foreign Key (dnum) REFERENCES departamento(dnum)
);

CREATE TABLE trabalha_no (
    emp NUMERIC(11),
    proj NUMERIC(4),
    horas INTEGER,
    Foreign Key (emp) REFERENCES empregado(cpf),
    Foreign Key (proj) REFERENCES projeto(pnum)
);

CREATE TABLE dependentes (
    emp NUMERIC(11),
    nomedepend VARCHAR(40) PRIMARY KEY,
    sexo CHAR(1),
    nasc DATE,
    parentesco VARCHAR(15),
    Foreign Key (emp) REFERENCES empregado(cpf)
);

INSERT INTO dependente
VALUES (1111, 'João', 'M', '1990-01-01', 'Filho');

INSERT INTO projeto
VALUES ('EDUCACIONAL', 1, 'São Paulo', 3);


UPDATE empregado
SET salario = salario * 2 
WHERE cpf = 1111;

UPDATE empregado
SET superv = (
    SELECT gerente
    FROM departamento
    WHERE dnum = 2
    LIMIT 1
)
WHERE cpf = 56789;

DELETE FROM dependentes
WHERE nomedepend = 'JOAOZINHO' AND parentesco = 'SOBRINHO' AND emp = 12345;

SELECT pnome, plocal
FROM projeto;

SELECT E.nome AS empregado_nome, E.salario AS empregado_salario,
        S.nome AS supervisor_nome, S.salario AS supervisor_salario
FROM empregado AS E
INNER JOIN empregado AS S ON E.superv = S.cpf
WHERE E.salario > S.salario;

SELECT gerente
FROM departamento;

SELECT cpf
FROM empregado
WHERE NOT cpf = trabalha_no.emp;

SELECT E.nome AS empregado_nome, P.pnome AS projeto_nome, T.horas AS horas_trabalhadas
FROM empregado AS E 
INNER JOIN trabalha_no AS T ON E.cpf = T.emp
INNER JOIN projeto AS P ON T.proj = P.pnum;

