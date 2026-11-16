CREATE DATABASE saep_db;
\c saep_db

CREATE TABLE usuario (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(100) NOT NULL
);

CREATE TABLE cliente (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(100) NOT NULL UNIQUE,
    celular VARCHAR(20)
);

CREATE TABLE imoveis (
    id SERIAL PRIMARY KEY,
    endereco VARCHAR(200) NOT NULL,
    cliente_id INTEGER NOT NULL REFERENCES cliente (id)
);

CREATE TABLE alugueis (
    id SERIAL PRIMARY KEY,
    data DATE NOT NULL,
    imoveis_id INTEGER NOT NULL REFERENCES imoveis (id)
);

INSERT INTO usuario (nome, senha) VALUES ('admin', '$2b$10$B7UBJNI6wHUk1GpHXG0bEOeSiCd23xVIjp29nMXw/xAWCQ/ZtJXOm');
INSERT INTO usuario (nome, senha) VALUES ('joao_silva', '$2b$10$6N0rNYWC/e4No2a4Q6tvwudx6ybaw8.kkgwU.biOcNUccVUEyrk6q');
INSERT INTO usuario (nome, senha) VALUES ('maria_souza', '$2b$10$FkdSXRJklT.HDntqR3mzNOgSNxOIkXvNmnJyUWl/OaKkZi4t3RMIW');
INSERT INTO usuario (nome, senha) VALUES ('pedro_santos', '$2b$10$iFCenPAcOCiIVuLnl170c.acTK/CjMNk/zUsy.vKT/Af/qBo.XF.K');

INSERT INTO cliente (nome, cpf, celular) VALUES ('Ana Oliveira', 'bf37e84c06dbccd8b23915006224b864', '(11) 91111-1111');
INSERT INTO cliente (nome, cpf, celular) VALUES ('Bruno Costa', '1e6a1b52b56ef4d357721bd4eb6a096f', '(11) 92222-2222');
INSERT INTO cliente (nome, cpf, celular) VALUES ('Carlos Mendes', '7e14dd1293254803ba5cb4a500a083f0', '(11) 93333-3333');
INSERT INTO cliente (nome, cpf, celular) VALUES ('Diana Rocha', 'f891168a98c81ec13f560dceb4de3d74', '(11) 94444-4444');

INSERT INTO imoveis (endereco, cliente_id) VALUES ('Rua das Flores, 123 - Centro', 1);
INSERT INTO imoveis (endereco, cliente_id) VALUES ('Avenida Brasil, 1500 - Bela Vista', 2);
INSERT INTO imoveis (endereco, cliente_id) VALUES ('Praça da Sé, 45 - Sé', 3);
INSERT INTO imoveis (endereco, cliente_id) VALUES ('Alameda Santos, 987 - Cerqueira César', 4);

INSERT INTO alugueis (data, imoveis_id) VALUES ('2026-01-15', 1);
INSERT INTO alugueis (data, imoveis_id) VALUES ('2026-02-20', 2);
INSERT INTO alugueis (data, imoveis_id) VALUES ('2026-05-10', 3);
INSERT INTO alugueis (data, imoveis_id) VALUES ('2026-11-05', 4);
