DROP DATABASE IF EXISTS pizzeria;
CREATE DATABASE pizzeria CHARACTER SET utf8mb4;
USE pizzeria;

CREATE TABLE provincias(
id_provincia INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(20) NOT NULL
);

CREATE TABLE localidades (
id_localidad INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(20) NOT NULL,
id_provincia  INTEGER UNSIGNED NOT NULL,
FOREIGN KEY (id_provincia) REFERENCES provincias (id_provincia)
);

CREATE TABLE clientes (
id_cliente INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(20) NOT NULL,
apellido VARCHAR(20) NOT NULL,
direccion VARCHAR (45) NOT NULL,
codigo_postal INT NOT NULL,
telefono VARCHAR (20) NOT NULL,
id_localidad INT UNSIGNED NOT NULL,
id_provincia INT UNSIGNED NOT NULL,
FOREIGN KEY (id_provincia) REFERENCES provincias (id_provincia),
FOREIGN KEY (id_localidad) REFERENCES localidades (id_localidad)
);

CREATE TABLE pizzas (
id_categoria INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(20) NOT NULL
);
  
CREATE TABLE tipo_de_productos (
id_producto INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR (20) NOT NULL,
descripcion VARCHAR (45) NOT NULL,
imagen BLOB NOT NULL,
precio FLOAT NOT NULL,
id_categoria_pizza INT UNSIGNED,
FOREIGN KEY (id_categoria_pizza) REFERENCES pizzas (id_categoria)
);

CREATE TABLE tiendas (
id_tienda INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
direccion VARCHAR(45) NOT NULL ,
codigo_postal INT NOT NULL,
id_localidad INT UNSIGNED NOT NULL,
id_provincia INT UNSIGNED NOT NULL,
FOREIGN KEY (id_provincia) REFERENCES provincias (id_provincia),
FOREIGN KEY (id_localidad) REFERENCES localidades (id_localidad)
);

CREATE TABLE empleados (
id_empleado INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(20) NOT NULL,
apellido VARCHAR(20) NOT NULL,
NIF VARCHAR(9) NOT NULL,
telefono VARCHAR(20) NOT NULL,
id_tienda INT UNSIGNED,
ocupacion ENUM('repartidor', 'cocinero') NOT NULL,
FOREIGN KEY (id_tienda) REFERENCES tiendas (id_tienda)
);

CREATE TABLE pedidos (
id_pedido INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
id_cliente INTEGER UNSIGNED NOT NULL,
fecha_hora_pedido DATETIME NOT NULL,
tipo ENUM('reparto a domicilio', 'recogida en el local') NOT NULL,
cantidad_productos INTEGER NOT NULL,
id_tienda INTEGER UNSIGNED NOT NULL,
precio INTEGER NOT NULL,
id_repartidor INTEGER UNSIGNED,
fecha_hora_entrega DATETIME,
FOREIGN KEY (id_repartidor) REFERENCES empleados (id_empleado),
FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente),
FOREIGN KEY (id_tienda) REFERENCES tiendas (id_tienda)
);


/* Provincias */
INSERT INTO provincias VALUES (1, 'CATALUÑA');

/* Localidad */
INSERT INTO localidades VALUES (1, 'BARCELONA', 1);

/* Clientes */
INSERT INTO clientes VALUES (1, 'Edgar', 'Lake', 'CALLE ROSSELO 168', 08029, '659382432', 1, 1);

/* Pizzas */
INSERT INTO pizzas VALUES (1, 'Margarita');

/* Tipo de producto */
INSERT INTO tipo_de_productos VALUES (1, 'pizza', 'pizza con salsa de tomate y mozarella', 'C:/Users/anna1/Downloads/Pizza_margarita.jpg', 9.5, 1);

/* Tiendas */
INSERT INTO tiendas VALUES (1, 'CALLE VALLESPIR 85', 08014, 1,1);

/* Empleados */
INSERT INTO empleados VALUES (1, 'Andres', 'Gonzalez', 'Y5129443H', '659382433', 1, 'repartidor');

/* Pedidos */
INSERT INTO pedidos VALUES (1, 1, '2022-07-27', 'reparto a domicilio', 2, 1, 19, 1, '2022-07-27');
