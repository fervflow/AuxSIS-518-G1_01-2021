use auxdb;

CREATE TABLE tabla_1 (
    nombre VARCHAR(50),
    fecha DATE,
    char_key CHAR,
)
GO
CREATE TABLE tabla_2 (
    nombre VARCHAR,
    fecha_hora DATETIME
)
GO

-- Adicion de una columna que servira de llave primaria
ALTER TABLE tabla_2 ADD id INT NOT NULL;
-- Adicion de una restriccion tipo Llave primaria a la columna anyadida
ALTER TABLE tabla_2 ADD CONSTRAINT id_tabla_2_pk PRIMARY KEY (id);

SELECT * FROM tabla_1;

-- Alteracion de una columna ya existente para que pueda convertirse en llave primaria
ALTER TABLE tabla_1 ALTER COLUMN char_key CHAR NOT NULL;

ALTER TABLE tabla_1 ADD CONSTRAINT tabla_1_pk_id PRIMARY KEY (char_key);

-- Adicion de una llave foranea en la tabla_1 referenciando a la tabla 2

SELECT * FROM tabla_1;

ALTER TABLE tabla_1 ADD id_tabla2 INT;

ALTER TABLE tabla_1 ADD CONSTRAINT fk_tabla_1_tabla_2 FOREIGN KEY (id_tabla2) REFERENCES tabla_2(id);

-- Creacion de llaves primaria y foranea directamente
CREATE TABLE tabla_3 (
    id INT PRIMARY KEY,
    nombre VARCHAR(50),
    char_key_tabla_1 CHAR FOREIGN KEY (char_key_tabla_1) REFERENCES tabla_1(char_key),
)