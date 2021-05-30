/* Nombre completo:
 * CI:
 * Fecha:
*/

/*
    1. Ordene las instrucciones de creación y uso de la base de datos, como tambien las de creación de tablas:
*/

USE hoteles_DB_aux;
GO

CREATE DATABASE hoteles_DB_aux;
GO

CREATE TABLE empresa (
    id              INT IDENTITY PRIMARY KEY,
    nombre_empresa  VARCHAR(128),
    email           VARCHAR(255),
    id_ciudad       INT FOREIGN KEY REFERENCES ciudad(id),
    direccion       VARCHAR(255),
    detalles        TEXT,
    activo          INT,
)
GO


CREATE TABLE pais (
    id          INT IDENTITY PRIMARY KEY,
    nombre_pais VARCHAR(128),
)
GO


CREATE TABLE tipo_habitacion (
    id          INT IDENTITY PRIMARY KEY,
    nombre_tipo VARCHAR(128),
)
GO


CREATE TABLE habitacion (
    id                  INT IDENTITY,
    id_hotel            INT,
    nombre_habitacion   VARCHAR(128),
    descripcion         TEXT,
    id_tipo_habitacion  INT,
    precio_actual       DECIMAL(10,2),
    disponible          INT,
)
GO


CREATE TABLE categoria (
    id                  INT IDENTITY PRIMARY KEY,
    nombre_categoria    VARCHAR(128),
)
GO


CREATE TABLE hotel (
    id              INT IDENTITY PRIMARY KEY,
    nombre_hotel    VARCHAR(128),
    descripcion     TEXT,
    id_empresa      INT FOREIGN KEY REFERENCES empresa(id),
    id_ciudad       INT FOREIGN KEY REFERENCES ciudad(id),
    id_categoria    INT FOREIGN KEY REFERENCES categoria(id),
    activo          DECIMAL(1),
)
GO


CREATE TABLE ciudad (
    id              INT IDENTITY PRIMARY KEY,
    nombre_ciudad   VARCHAR(128),
    id_pais         INT FOREIGN KEY REFERENCES pais(id),
)
GO


/*
    2. Escriba las sentencias SQL necesarias y agregar el comando GO donde corresponda para separar
    grupos de instrucciones para las siguientes:
*/

-- a. Cambiar el tipo de dato a BIT, de la columna 'activo' de la tabla 'empresa', 'activo' de 'hotel' y 'disponible' de 'habitacion'

-- b. Agregar una restricción de llave primaria a la columna 'id' de la tabla 'habitacion'

-- c. Agregar las restricciones de llaves foráneas correspondientes en la tabla 'habitacion'

-- d. Eliminar las columnas 'nombre_habitacion' y 'descripcion' de la tabla 'habitacion'


/*
    3. Ordenar las instrucciones de insercion de datos:
*/

INSERT ciudad (nombre_ciudad, id_pais) VALUES
    ('La Paz', 1),
    ('Buenos Aires', 2),
    ('Potosí', 1),
    ('Quito', 3),
    ('Cochabamba', 1),
    ('Cuenca', 3),
    ('Berlin', 4);
GO


INSERT INTO pais (nombre_pais) VALUES
    ('Bolivia'),
    ('Argentina'),
    ('Ecuador'),
    ('Alemania');
GO


INSERT categoria VALUES
    ('1 Estrella (Económico)'),
    ('2 Estrellas (Valor)'),
    ('3 Estrellas (Calidad)'),
    ('4 Estrellas (Superior)'),
    ('5 Estrellas (Excepcional)');
GO


INSERT empresa VALUES
    ('Red Hotel Bolivia', 'info@redhotelbolivia.com', 1, 'c. León M. Loza N° 1054, esquina Zeballos. San Pedro Alto',
        'Red Hotelera, de Negocios e Información especializada en Turismo de Bolivia para el mundo.',
        'true'),
    ('AHT-RA', 'info@ahtra.com.ar', 2, 'Piedras 383 1° - CP (1070) Buenos Aires - Argentina',
        'La Asociación de Hoteles de Turismo de la República Argentina es una organización sin fines de lucro con amplia trayectoria,reconocimiento y presencia en todo el territorio nacional fundada en febrero de 1977.',
        'false'),
    ('Cofradía Hotelera', 'info@cofradiahotelera.org', 4, 'Roca E5-33 y Juan León Mera, Quito, Ecuador',
        'La Cofradía Hotelera es una agrupación civil sin fines de lucro cuyo objetivo principal es la profesionalización del sector alojamiento a través del desarrollo de programas y proyectos que impulsen al sector en su desarrollo productivo.',
        'true'),
    ('Design Hotels TM', 'res@designhotels.com', 7, 'Stralauer Allee 2C, 10245 Berlin, Alemania',
        'Durante un cuarto de siglo, hemos estado a la vanguardia de un movimiento en viajes al seleccionar una colección global de hoteles independientes impulsados ​​por el diseño que funcionan como centros sociales y espacios para experiencias útiles.',
        'true');
GO


INSERT habitacion (id_hotel, id_tipo_habitacion, precio_actual, disponible) VALUES
    (1, 2, 1950, 1),
    (1, 1, 1350, 1),
    (1, 1, 1300, 0),
    (1, 3, 970, 1),
    (1, 3, 940, 0),
    (1, 4, 1000, 1),
    (1, 4, 990, 0),
    (1, 6, 730, 1),
    (1, 6, 750, 1),
    (1, 6, 770, 0),
    (1, 7, 530, 1),
    (1, 7, 520, 0),
    (1, 7, 520, 1),
    (1, 7, 560, 1),
    (1, 7, 560, 0);
INSERT habitacion VALUES
    (2, 1, 1050, 1),
    (2, 1, 1000, 0),
    (2, 4, 800, 1),
    (2, 4, 820, 0),
    (2, 6, 530, 1),
    (2, 6, 520, 1),
    (2, 6, 550, 0),
    (2, 5, 650, 1),
    (2, 5, 660, 0),
    (2, 7, 320, 1),
    (2, 7, 360, 1),
    (2, 7, 360, 0),
    (2, 7, 350, 1),
    (2, 7, 350, 0);
GO


INSERT hotel VALUES
    ('Atix Hotel™',
        'Atix es un hotel de cinco estrellas en la zona sur de La Paz, Bolivia. Parte de Design Hotels™. Mencionado en Travel + Leisure’s It List 2017, entre los mejores nuevos hoteles del mundo.',
        4, 1, 5, 'true'),
    ('Hotel Santa Mónica',
        'Con una terraza solárium y también habitaciones para alérgicos, Hotel Santa Mónica Potosí está situado a 550 metros del Museo Convento Santa Teresa. Un destino popular es Potosí, a 400 metros de la propiedad.',
        1, 3, 4, 'true'),
    ('Hotel Cruz del Vado',
        'El Hotel Cruz del Vado siempre fue un edificio lleno de historia, arte y cultura. Fue arduamente intervenido utilizando una fusión de técnicas constructivas tradicionales y modernas, conservando la esencia e historia de este edificio patrimonial. dándole nuestra propia identidad.',
        3, 6, 5, 'false');
GO


INSERT tipo_habitacion VALUES
    ('Suite'),
    ('Suite Presidencial'),
    ('King'),
    ('Queen'),
    ('Triple'),
    ('Doble'),
    ('Individual');
GO

