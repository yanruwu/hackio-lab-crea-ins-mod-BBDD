-- Crear tablas
create table if not exists clientes(
	id_cliente serial primary key,
	nombre varchar(100) not null,
	email varchar(100) unique,
	direccion varchar(300),
	telefono bigint unique,
	pais varchar(100)
);

create table if not exists empleados(
	id_empleado serial primary key,
	nombre varchar(100) not null,
	cargo varchar(100),
	email varchar(300) unique
);

create table if not exists proveedores(
	id_proveedor serial primary key,
	nombre varchar(100) not null,
	contacto varchar(100) not null,
	telefono bigint unique,
	direccion varchar(300)
);

create table if not exists envios(
	id_envio serial primary key,
	fecha_envio date not null,
	estado varchar(100) not null,
	total decimal not null,
	id_cliente int not null,
	id_empleado int not null,
	id_proveedor int not null,
	foreign key (id_cliente) 
		references clientes(id_cliente)
		on delete restrict
		on update cascade,
	foreign key (id_empleado) 
		references empleados(id_empleado)
		on delete restrict
		on update cascade,
	foreign key (id_proveedor) 
		references proveedores(id_proveedor)
		on delete restrict
		on update cascade
);


create table if not exists detalle_de_envios(
	id_detalle serial primary key,
	producto varchar(300) not null,
	cantidad decimal not null,
	precio_unitario decimal not null,
	id_envio int not null,
	foreign key (id_envio) 
		references envios(id_envio)
		on delete restrict
		on update cascade
);

	create table regiones(
		id_region serial primary key,
		nombre varchar(300) not null,
		pais varchar(100) not null
	) ;

alter table clientes
alter column telefono type bigint,
add constraint TEL check(telefono > 0);

alter table proveedores
alter column telefono type bigint,
add constraint TEL check(telefono > 0);

-- Introducir valores
insert into clientes(nombre, email, direccion, telefono, pais)
values	('Lola', 'lola@gmail.com', 'Av. de Lola 1', 616616616, 'España'),
		('Pepe', 'pepe@gmail.com', 'Av. de Pepe 1', 626626626, 'España'),
		('John', 'john@gmail.com', 'John St. 1', 2071234567, 'UK'),
		('Mario', 'mario@gmail.com', 'Av. de Mario 1', 636636636, 'España'),
		('Maria', 'maria@gmail.com', 'Av. de Maria 1', 646646646, 'España'),
		('Mikel', 'mikel@gmail.com', 'Borstelmannsweg 70', 656656656, 'Alemania'),
		('Louis', 'louis@gmail.com', 'Louis St. 1', 3125643628, 'UK'),
		('Hackio', 'data@hackio.com', 'Calle de Arturo Soria, 245', 666666666, 'España'),
		('David', 'david@gmail.com', 'Av. de David 1', 676676676, 'España'),
		('Cheng', 'cheng@gmail.com', 'San Jun St. Shulin 238', 921234567, 'Taiwan');

insert into empleados (nombre, email, cargo)
values	('Ana', 'ana@gmail.com', 'Directora'),
		('Juan', 'juan@gmail.com', 'Gerente'),
		('Marta', 'marta@gmail.com', 'Supervisora'),
		('Pedro', 'pedro@gmail.com', 'Asistente'),
		('Luis', 'luis@gmail.com', 'Coordinador');
	
insert into proveedores (nombre, contacto, telefono, direccion)
values	('Tech Supplies', 'Carlos', '622112233', 'Calle Tecnología 15'),
		('Distribuciones Martínez', 'Martín', '633445566', 'Av. Central 123'),
		('Servicios Globales', 'Laura', '644778899', 'Calle del Comercio 45');
	
insert into envios(fecha_envio, estado, total, id_cliente, id_empleado, id_proveedor)
values	('2023-07-26', 'En preparación', 18.00, 1, 2, 1),
		('2023-08-01', 'En camino', 45.50, 3, 1, 2),
		('2023-09-15', 'Entregado', 75.00, 5, 4, 3),
		('2023-10-10', 'Pendiente', 22.75, 7, 3, 1),
		('2023-11-02', 'Cancelado', 30.00, 9, 5, 2),
		('2023-07-30', 'Entregado', 150.00, 4, 2, 3),
		('2023-08-15', 'En preparación', 60.25, 6, 1, 1),
		('2023-09-20', 'En camino', 95.50, 10, 3, 2);

insert into detalle_de_envios (producto, cantidad, precio_unitario, id_envio) 
values	('Camiseta', 2, 9.00, 1),
		('Pantalones', 1, 45.50, 2),
		('Zapatillas', 3, 25.00, 3),
		('Chaqueta', 1, 22.75, 4),
		('Sombrero', 5, 6.00, 5),
		('Cinturón', 4, 37.50, 6),
		('Bufanda', 2, 7.56, 7),
		('Guantes', 3, 6.17, 8);
	
insert into regiones (nombre, pais)
values	('Andalucía', 'España'),
		('Baviera', 'Alemania'),
		('California', 'EE.UU.'),
		('Quebec', 'Canadá'),
		('Río de Janeiro', 'Brasil');


-- Modificar valores	
update envios 
set estado = 'Entregado'
where id_envio = 3;

update empleados 
set cargo = 'Director de Datos'
where id_empleado = 5;

update detalle_de_envios
set precio_unitario = precio_unitario * 1.10
where producto = 'Camiseta';

update envios e
set total = d.cantidad * d.precio_unitario
from detalle_de_envios d
where d.id_envio = e.id_envio;

update clientes
set direccion = 'Nueva Calle B, 123'
where id_cliente = 2;

update envios 
set id_proveedor = 3
where id_envio = 4;

update detalle_de_envios 
set cantidad = 5
where id_envio = 2;

update envios 
set total = 50
where id_envio = 5;

update proveedores 
set contacto = 'Nuevo Contacto 2'
where id_proveedor = 2;

update clientes 
set pais = 'Portugal'
where id_cliente = 6;

update envios 
set fecha_envio = '2024-08-10'
where id_envio = 7;

-- Eliminación de datos
alter table clientes 
add column fecha_nacimiento DATE;

alter table proveedores 
add column codigo_postal VARCHAR(10);

alter table proveedores 
drop column contacto;

alter table regiones 
drop column pais;

alter table clientes 
drop constraint TEL;
alter table clientes
alter column telefono type VARCHAR(15);

alter table envios 
alter column total type numeric(12,2);

alter table empleados 
add column fecha_contrato DATE;

alter table envios 
drop column estado;

alter table empleados 
rename column nombre to nombre_completo;

-- Contestación de preguntas

select count(id_cliente) from clientes c 
where pais = 'España';		--n de clientes en españa

select * from envios e 
where id_empleado = 3;		-- envíos realizados por empleado con id 3

select producto from detalle_de_envios dde
where id_envio = 7;			-- productos en envío con id 7

select * from proveedores p 
where telefono = 622112233;	-- proveedores con ese número de teléfono

select * from empleados e 
where cargo = 'Supervisor de Envíos'; -- empleados con ese cargo (en mi caso ninguno)

select * from envios e 
where id_cliente = 5;

select * from regiones r; 	-- listar todas las regiones con su nombre y país (no hay país porque lo eliminamos)

select producto, precio_unitario from detalle_de_envios dde
where precio_unitario > 30;	-- listar todos los productos con precio unitario > 50 (usé 30 porque no habían > 50)

select * from envios e 
where fecha_envio = '2024-08-10';	-- listar envíos realizados en 2024-08-10

select * from clientes c 
where (c.telefono like '6166%');	-- listar clientes cuyo número comienza con 6166
