CREATE DATABASE parcial_1;
GO
USE parcial_1;
GO
-- empleado(*nombre-persona, calle, ciudad, fecha-nac, genero)
-- trabaja(*nombre-persona, nombre-compañia, sueldo)
-- compañia(*nombre-compañia, ciudad)
-- jefe(*nombre-persona, nombre-jefe)

CREATE TABLE empleado(
    nombre_persona  VARCHAR(100) PRIMARY KEY,
    calle           VARCHAR(50),
    ciudad          VARCHAR(35),
    fecha_nac       DATE,
    genero          CHAR(1),
)
CREATE TABLE compania(
    nombre_compania VARCHAR(50) PRIMARY KEY,
    ciudad          VARCHAR(35),
)
GO
CREATE TABLE trabaja(
    nombre_persona  VARCHAR(100) FOREIGN KEY REFERENCES empleado(nombre_persona) PRIMARY KEY,
    nombre_compania VARCHAR(50) FOREIGN KEY REFERENCES compania(nombre_compania),
    sueldo          MONEY
)
CREATE TABLE jefe(
    nombre_persona  VARCHAR(100) FOREIGN KEY REFERENCES empleado(nombre_persona) PRIMARY KEY,
    nombre_jefe     VARCHAR(35),
)
GO

INSERT empleado VALUES
    ('Manuel Gutierrez', 'Calle Oruro', 'Potosi', '1970-03-20', 'M'),
    ('Maria Castedo', 'Av. Heroinas #300', 'Cochabamba', '1986-07-16', 'F'),
    ('Angelica Torrez', 'Av. Perez #24', 'La Paz', '1992-05-24', 'F'),
    ('Jose Gutierrez', 'Calle Linares', 'Potosi', '2000-01-30', 'M'),
    ('Byron Torrejon', 'Av. Holanda', 'Santa Cruz', '1978-08-30', 'M')
GO

INSERT compania VALUES
    ('Banco Importante', 'Potosi'),
    ('Banco Nacional de Bolivia', 'Oruro'),
    ('comp3', 'Potosi'),
    ('comp4', 'Sucre'),
    ('comp5', 'Tarija')
GO

INSERT trabaja VALUES 
    ('Manuel Gutierrez', 'Banco Importante', 4000),
    ('Angelica Torrez', 'Banco Importante', 8000),
    ('Jose Gutierrez', 'Banco Importante', 800),
    ('Maria Castedo', 'Banco Nacional de Bolivia', 9000),
    ('Byron Torrejon', 'comp4', 4500)
GO

INSERT jefe VALUES
    ('Manuel Gutierrez', 'Cajero'),
    ('Angelica Torrez', 'Gerente General'),
    ('Jose Gutierrez', 'Limpieza'),
    ('Maria Castedo', 'Gerente General'),
    ('Byron Torrejon', 'puesto2')
GO

-- a. Averiguar los nombres de todos los empleados que trabajan para el Banco Importante.
SELECT DISTINCT e.nombre_persona FROM empleado AS e, compania AS c
WHERE e.nombre_persona IN (SELECT nombre_persona FROM trabaja
        WHERE nombre_compania = 'Banco Importante')

SELECT nombre_persona FROM trabaja
WHERE nombre_compania = 'Banco Importante';

-- b. Nombre y ciudad de residencia de todos los empleados que trabajan para el banco importante.
SELECT e.nombre_persona, e.ciudad FROM trabaja AS t, empleado AS e
WHERE e.nombre_persona = t.nombre_persona
AND t.nombre_compania = 'Banco Importante';

-- c. Nombre, calle y ciudad de residencia de todos los empleados que trabajan para el banco importante
-- y ganan mas de 10000 Bs anuales.
SELECT e.nombre_persona, e.calle, e.ciudad FROM trabaja AS t, empleado AS e
WHERE e.nombre_persona = t.nombre_persona
AND t.nombre_compania = 'Banco Importante'
AND t.sueldo*12 > 10000;

-- d. Promedio de la edad de los empleados y mostrar por genero.
SELECT AVG(DATEDIFF(YEAR, fecha_nac, GETDATE())) AS 'Promedio de edades', genero
FROM empleado
GROUP BY genero;

SELECT DATEDIFF(YEAR, fecha_nac, GETDATE()) FROM empleado;
SELECT * FROM empleado;

-- e. Mostrar el sueldo promedio por compañia.
SELECT AVG(sueldo) AS 'Promedio de sueldos', nombre_compania
FROM trabaja
GROUP BY nombre_compania;

SELECT c.nombre_compania, ISNULL(AVG(t.sueldo), 0) AS 'Promedio de sueldos'
FROM compania AS c
LEFT JOIN trabaja AS t
ON c.nombre_compania = t.nombre_compania
GROUP BY c.nombre_compania;



SELECT * FROM compania;

-- JOINS
SELECT * FROM compania, trabaja
WHERE compania.nombre_compania = trabaja.nombre_compania;

SELECT * FROM compania
INNER JOIN trabaja
ON compania.nombre_compania = trabaja.nombre_compania;

SELECT * FROM compania
LEFT JOIN trabaja
ON compania.nombre_compania = trabaja.nombre_compania;

SELECT * FROM compania
RIGHT JOIN trabaja
ON compania.nombre_compania = trabaja.nombre_compania;