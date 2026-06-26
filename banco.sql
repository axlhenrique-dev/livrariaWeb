CREATE DATABASE livraria;
USE livraria;

CREATE TABLE editora (
    id INTEGER NOT NULL AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL,
    cidade VARCHAR(45),
    PRIMARY KEY (id)
);

CREATE TABLE livro (
    id INTEGER NOT NULL AUTO_INCREMENT,
    titulo VARCHAR(120) NOT NULL,
    autor VARCHAR(60) NOT NULL,
    ano INTEGER,
    preco DOUBLE,
    foto VARCHAR(45),
    idEditora INTEGER,
    PRIMARY KEY (id),
    FOREIGN KEY (idEditora) REFERENCES editora(id)
);

CREATE TABLE usuario (
    id INTEGER NOT NULL AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,

    senha VARCHAR(32) NOT NULL,
    PRIMARY KEY (id)
);


INSERT INTO editora (nome, cidade) VALUES ("Companhia das Letras", "São Paulo");
INSERT INTO editora (nome, cidade) VALUES ("Rocco", "Rio de Janeiro");

INSERT INTO livro (titulo, autor, ano, preco, foto, idEditora) VALUES
    ("Dom Casmurro", "Machado de Assis", 1899, 29.90, "domcasmurro.jpg", 1);

INSERT INTO livro (titulo, autor, ano, preco, foto, idEditora) VALUES
    ("O Senhor dos Anéis", "J.R.R. Tolkien", 1954, 89.90, "senhordosaneis.jpg", 2);

INSERT INTO livro (titulo, autor, ano, preco, foto, idEditora) VALUES 
("Sapiens: Uma breve história da humanidade", "Yuval Noah Harari", 2020, 49.90,"sapiens.png", 1);

INSERT INTO livro (titulo, autor, ano, preco, foto, idEditora) VALUES 
("Capitães da Areia", "Jorge Amado", 1937, 39.90,"capitaesdaareia.png", 1);

-- Usuário de teste administrador
INSERT INTO usuario (nome, senha) VALUES ("administrador", "livraria2026");
