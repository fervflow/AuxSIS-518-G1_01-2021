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
    sueldo          NUMERIC(9, 2),
)
CREATE TABLE jefe(
    nombre_persona  VARCHAR(100) FOREIGN KEY REFERENCES empleado(nombre_persona) PRIMARY KEY,
    nombre_jefe     VARCHAR(35),
)
GO

INSERT INTO empleado VALUES
    ('Manuel Gutierrez', 'Calle Oruro', 'Potosi', '1970-03-20', 'M'),
    ('Maria Castedo', 'Av. Heroinas #300', 'Cochabamba', '1986-07-16', 'F'),
    ('Angelica Torrez', 'Av. Perez #24', 'La Paz', '1992-05-24', 'F'),
    ('Jose Gutierrez', 'Calle Linares', 'Potosi', '2000-01-30', 'M'),
    ('Byron Torrejon', 'Av. Holanda', 'Santa Cruz', '1978-08-30', 'M');

INSERT compania VALUES
    ('Banco Importante', 'Potosi'),
    ('Banco Nacional de Bolivia', 'Oruro'),
    ('comp3', 'Potosi'),
    ('comp4', 'Sucre'),
    ('comp5', 'Tarija');
GO

INSERT trabaja VALUES 
    ('Manuel Gutierrez', 'Banco Importante', 4000),
    ('Angelica Torrez', 'Banco Importante', 8000),
    ('Jose Gutierrez', 'Banco Importante', 750),
    ('Maria Castedo', 'Banco Nacional de Bolivia', 9000),
    ('Byron Torrejon', 'comp4', 4500)
GO

INSERT jefe VALUES
    ('Manuel Gutierrez', 'Cajero'),
    ('Angelica Torrez', 'Gerente Regional'),
    ('Jose Gutierrez', 'Limpieza'),
    ('Maria Castedo', 'Gerente General'),
    ('Byron Torrejon', 'puesto2')
GO

-- a. Averiguar los nombres de todos los empleados que trabajan para el Banco Importante.
SELECT nombre_persona FROM trabaja
WHERE nombre_compania = 'Banco Importante';

SELECT e.nombre_persona, c.nombre_compania FROM empleado AS e, compania AS c, trabaja AS t
WHERE  e.nombre_persona = t.nombre_persona
    AND t.nombre_compania = c.nombre_compania
    AND c.nombre_compania = 'Banco Importante';

-- b. Nombre y ciudad de residencia de todos los empleados que trabajan para el banco importante.
SELECT e.nombre_persona, e.ciudad FROM empleado AS e, trabaja AS t, compania AS c
WHERE  e.nombre_persona = t.nombre_persona
    AND t.nombre_compania = c.nombre_compania
    AND c.nombre_compania = 'Banco Importante';

SELECT e.nombre_persona, e.ciudad FROM empleado AS e, trabaja AS t
WHERE e.nombre_persona = t.nombre_persona
    AND t.nombre_compania = 'Banco Importante';

-- c. Nombre, calle y ciudad de residencia de todos los empleados que trabajan para el banco importante
    -- y ganan mas de 10000 Bs anuales.
SELECT e.nombre_persona, e.calle, e.ciudad FROM empleado AS e, trabaja AS t
WHERE e.nombre_persona = t.nombre_persona
    AND t.nombre_compania = 'Banco Importante'
    AND t.sueldo*12 > 10000;

-- d. Promedio de la edad de los empleados y mostrar por genero.
SELECT e.genero, AVG(DATEDIFF(YEAR, e.fecha_nac, GETDATE())) AS 'Promedio de edad'
FROM empleado AS e
GROUP BY e.genero;

-- e. Mostrar el sueldo promedio por compañia.
SELECT t.nombre_compania, AVG(t.sueldo) AS 'Sueldo promedio'
FROM trabaja AS t
GROUP BY t.nombre_compania;

select  compania.nombre_compania AS 'Compañia',
        ISNULL(avg(trabaja.sueldo), 0) AS 'Salario promedio'
from compania
left join trabaja
on compania.nombre_compania = trabaja.nombre_compania
GROUP BY compania.nombre_compania;

select  compania.nombre_compania AS 'Compañia',
        CAST(ISNULL(avg(trabaja.sueldo), 0) AS numeric(9,2)) AS 'Salario promedio'
from compania
left join trabaja
on compania.nombre_compania = trabaja.nombre_compania
GROUP BY compania.nombre_compania;

SELECT *
FROM compania
LEFT JOIN trabaja
ON compania.nombre_compania = trabaja.nombre_compania;


SELECT * FROM compania;
SELECT * FROM trabaja;

SELECT * FROM compania, trabaja
WHERE compania.nombre_compania = trabaja.nombre_compania;

SELECT *
FROM compania
INNER JOIN trabaja
ON compania.nombre_compania = trabaja.nombre_compania;

SELECT *
FROM compania
LEFT JOIN trabaja
ON compania.nombre_compania = trabaja.nombre_compania;

SELECT *
FROM compania
RIGHT JOIN trabaja
ON compania.nombre_compania = trabaja.nombre_compania;