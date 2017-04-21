-- Quitar tablas si ya estan
DROP TABLE IF EXISTS notas;
DROP TABLE IF EXISTS inscripto_en;
DROP TABLE IF EXISTS materias;
DROP TABLE IF EXISTS alumnos;
DROP TABLE IF EXISTS carreras;
DROP TABLE IF EXISTS departamentos;

DROP TABLE IF EXISTS empleados;
DROP TABLE IF EXISTS sectores;

--- Tablas de primera clase
CREATE TABLE departamentos (
  codigo INTEGER NOT NULL,
  nombre VARCHAR(30) NOT NULL,
  CONSTRAINT pk_departamentos PRIMARY KEY (codigo)
);
INSERT INTO departamentos (codigo , nombre) 
  VALUES (71,'Gestión'),(75,'Computación');
CREATE TABLE materias (
  codigo INTEGER NOT NULL,
  numero INTEGER NOT NULL,
  nombre VARCHAR(30) NOT NULL,
  CONSTRAINT pk_materias PRIMARY KEY 
   (codigo, numero),
  CONSTRAINT fk_materia_depto FOREIGN KEY (codigo) 
   REFERENCES departamentos (codigo)
   ON UPDATE RESTRICT ON DELETE RESTRICT
);
INSERT INTO materias (codigo, numero, nombre) VALUES
  (71 , 14, 'Modelos y Optimización I') ,
  (71 , 15, 'Modelos y Optimización II') ,
  (75 , 1, 'Computación') ,
  (75 , 6, 'Organización de Datos') ,
  (75 , 15, 'Base de datos');
CREATE TABLE alumnos (
  padron INTEGER NOT NULL,
  nombre VARCHAR(30) NOT NULL,
  apellido VARCHAR(30) NOT NULL,
  intercambio BOOLEAN NOT NULL DEFAULT FALSE,
  fecha_ingreso DATE NOT NULL,
  CONSTRAINT pk_alumnos PRIMARY KEY (padron)
);
INSERT INTO alumnos (padron, nombre, apellido, intercambio, fecha_ingreso) VALUES
  (71000,'Daniel','Molina',FALSE,'2010-03-01') ,
  (72000,'Paula','Pérez Alonso',FALSE,'2010-08-02') ,
  (73000,'José Agustín','Molina',TRUE,'2011-03-07') ,
  (74000,'Miguel','Mazzeo',FALSE,'2011-03-07') ,
  (75000,'Clemente','Onelli',FALSE,'2011-03-07') ,
  (76000,'Graciela','Lecube',TRUE,'2011-08-01');
CREATE TABLE notas(
  padron INTEGER NOT NULL,
  codigo INTEGER NOT NULL,
  numero INTEGER NOT NULL,
  fecha DATE NOT NULL,
  nota INTEGER NOT NULL,
  CONSTRAINT pk_notas PRIMARY KEY
   (padron, codigo, numero, fecha),
  CONSTRAINT fk_nota_alumno FOREIGN KEY (padron) 
   REFERENCES alumnos (padron) 
   ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT fk_nota_materia FOREIGN KEY 
   (codigo, numero) REFERENCES materias 
   (codigo, numero)
   ON UPDATE RESTRICT ON DELETE RESTRICT
);
INSERT INTO notas (padron, codigo, numero, nota, fecha) VALUES
  (73000, 71, 14, 5, '2013-12-09'), 
  (73000, 71, 15, 9, '2014-07-07'), 
  (73000, 75, 1, 5, '2010-07-14'), 
  (73000, 75, 6, 10, '2012-07-18'), 
  (73000, 75, 15, 4, '2013-07-10'), 
  (72000, 71, 14, 6, '2013-07-08'), 
  (72000, 71, 15, 2, '2013-12-09'), 
  (72000, 75, 1, 4, '2010-12-16'),
  (72000, 75, 6, 4, '2012-07-25'), 
  (72000, 75, 15, 1, '2013-07-10'), 
  (72000, 75, 15, 6, '2013-07-17'), 
  (75000, 71, 14, 7, '2013-12-16'), 
  (75000, 71, 15, 2, '2014-07-07'), 
  (75000, 75, 1, 8, '2010-07-21'), 
  (75000, 75, 6, 7, '2012-07-11'), 
  (75000, 75, 15, 2, '2013-07-24'), 
  (71000, 71, 14, 4, '2013-12-09'), 
  (71000, 75, 1, 4, '2010-12-16'), 
  (71000, 75, 6, 2, '2012-07-18'), 
  (71000, 75, 6, 6, '2012-07-25'), 
  (71000, 75, 15, 7, '2013-07-10'), 
  (76000, 75, 15, 2, '2013-07-17'), 
  (76000, 75, 15, 10, '2013-07-24'); 
CREATE TABLE carreras (
  codigo INTEGER NOT NULL,
  nombre CHARACTER(40) NOT NULL,
  CONSTRAINT pk_carreras PRIMARY KEY (codigo)
);
INSERT INTO carreras (codigo,nombre)VALUES
  (7, 'Ingeniería Electrónica'), 
  (9, 'Licenciatura en Análisis de Sistemas'), 
  (10, 'Ingeniería en Informática');
CREATE TABLE inscripto_en (
  padron INTEGER NOT NULL,
  codigo INTEGER NOT NULL,
  CONSTRAINT pk_inscripto_en PRIMARY KEY 
   (padron, codigo) ,
  CONSTRAINT fk_inscripto_padron FOREIGN KEY 
   (padron) REFERENCES alumnos (padron)
   ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT fk_inscripto_carrera FOREIGN KEY 
   (codigo) REFERENCES carreras (codigo)
   ON UPDATE RESTRICT ON DELETE RESTRICT
);
INSERT INTO inscripto_en (padron, codigo) VALUES
  (71000,10) , (72000,10) , (73000,9) ,(73000,10),
  (74000,10) , (75000,9) , (76000,9);
  
-- Tablas para analizar valores nulos
CREATE TABLE sectores (
    codigo INTEGER NOT NULL PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL
);
CREATE TABLE empleados (
    legajo INTEGER NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    apellido VARCHAR(30) NOT NULL,
    sector_supervisor INTEGER,
    sueldo DECIMAL NOT NULL,
    CONSTRAINT pk_empleados PRIMARY KEY (legajo) ,
    CONSTRAINT fk_empleado_sector FOREIGN KEY (sector_supervisor) 
    REFERENCES sectores (codigo)
    ON UPDATE RESTRICT ON DELETE RESTRICT
);
INSERT INTO sectores (codigo, nombre)
VALUES (1,'Contabilidad'), (2,'RRHH'), (3,'Logística');
INSERT INTO empleados (legajo, nombre, apellido, sector_supervisor, sueldo)
VALUES (100, 'Carlos', 'Moreno' , 3 , 100000)
, (200, 'Diego' , 'Fernández' , 2 , 100000)
, (300, 'Gabriel' , 'Gigolosa' , NULL  , 100000)
, (400, 'Matías' , 'Lois' , 3 , 100000);
  
  
-- 1.1 Devuelva todas las notas que se han registrado en el sistema, sin repetir, ordenado de mayor a menor
select distinct nota from notas order by nota desc;

-- 1.2 Para cada materia, devuelva en su primer columna el código de departamento y el
-- número de materia en el formato “XX.YY” (llámesela “código”) y en la segunda
-- columna el nombre, ordenado el listado por nombre descendente
select to_char(codigo, 'fm00') || '.' || LPAD(numero::text, 2, '0') as "codigo", nombre from materias order by nombre desc;


-- 1.3 Para cada nota registrada, devuelva el padrón, código de departamento, número de
-- materia, fecha y nota expresada como un valor entre 1 y 100. Mostrar los resultados
-- paginados en páginas de 5 resultados cada una, devolviendo la tercer página
select padron, codigo, numero, fecha, nota * 10 as "nota" from notas order by 1,2,3,4,5 limit 5 offset 10;

-- esta forma es la sql estandar
select padron, codigo, numero, fecha, nota * 10 as "nota" from notas order by padron, codigo, numero, fecha offset 10 FETCH FIRST 5 ROWS ONLY;

-- 2.1 Devuelva el padrón y nombre de los alumnos cuyo apellido es “molina”. Asuma
-- que no sabe cómo se almacenó dicho valor
select padron, apellido, nombre from alumnos where apellido ilike 'molina';
select padron, apellido, nombre from alumnos where lower(apellido) = 'molina';

-- 2.2 Devuelva el padrón de los alumnos que ingresaron en la facultad en 2010
select * from alumnos where fecha_ingreso between '2010-01-01' and '2010-12-31';
select * from alumnos where date_part('year', fecha_ingreso) = 2010;
select * from alumnos where EXTRACT (YEAR FROM fecha_ingreso) = 2010;

-- 2.3 Devuelva el apellido y padrón de aquellos alumnos cuyo nombre es Daniel, Miguel
-- o Clemente y su padrón es mayor a 72000
select apellido, padron from alumnos where nombre in ('Daniel', 'Miguel', 'Clemente') and padron > 72000;
select apellido, padron from alumnos where (nombre ilike 'daniel' or nombre ilike 'miguel' or nombre ilike 'clemente') and padron > 72000;

-- 3.1 Devolver nombre de departamento y nombre de materia para cada materia,
-- ordenado por nombre de materia
select d.nombre, m.nombre 
from materias m
inner join departamentos d on m.codigo = d.codigo
order by m.nombre;

select d.nombre, m.nombre 
from materias m
inner join departamentos d using (codigo)
order by m.nombre;

-- 3.2 Para cada carrera, listar su código y el padrón de los alumnos que estén inscriptos
-- en ella. Incluir las carreras en las que no hay alumnos inscriptos. Ordenar por
-- código de carrera y padrón.
select c.codigo, i.padron
from carreras c
left join inscripto_en i on c.codigo = i.codigo
order by c.codigo, i.padron;

select c.codigo, i.padron
from inscripto_en i
right join carreras c on c.codigo = i.codigo
order by c.codigo, i.padron;

select c.codigo, i.padron
from inscripto_en i
right join carreras c on c.codigo = i.codigo
order by i.padron NULLS LAST;

-- 3.3 Para cada alumno, mostrar su padrón y la o las notas que tuvo en la materia 71.14.
-- Incluir también a los alumnos que no tengan nota en la materia. Ordenar por padrón.
select a.padron, n.nota
from alumnos a
left join notas n on a.padron = n.padron
where n.codigo is null or (n.codigo = 71 and n.numero = 14)
order by a.padron;

select a.padron, n.nota
from alumnos a
left join notas n on (a.padron = n.padron and n.codigo = 71 and n.numero = 14)
order by a.padron;

-- 3.4 Obtener el padrón de los alumnos que aprobaron al menos 3 materias con nota
-- mayor o igual a 5
-- REVISAR!!
select padron 
from notas 
where nota >= 5
group by padron 
having count(nota) >= 3;

select distinct n1.padron
from notas n1, notas n2, notas n3
WHERE
n1.padron = n2.padron and n2.padron = n3.padron
and n1.nota >= 5 and n2.nota >= 5 and n3.nota >= 5
and (n1.codigo <> n2.codigo OR n1.numero <> n2.numero)
and (n1.codigo <> n3.codigo OR n1.numero <> n3.numero)
and (n2.codigo <> n3.codigo OR n2.numero <> n3.numero);

-- 4.1 Obtener el padrón, nombre y apellido de los alumnos que tienen el mismo apellido
-- que el alumno de padrón 71000
-- Una forma
select todos.padron, todos.nombre, todos.apellido
from alumnos todos
inner join alumnos padron on todos.apellido = padron.apellido
where padron.padron = 71000
and todos.padron != 71000;
-- Otra
select padron, nombre, apellido 
from alumnos
where apellido = (select apellido from alumnos where padron = 71000)
and padron != 71000;

select padron, nombre, apellido 
from alumnos
where apellido = ALL (select apellido from alumnos where padron = 71000) -- ALL apellido igual a TODOS, SOME apellido igual al menos uno
-- apellido > ALL => apellido mayor a todos
-- apellido > SOME => apellido mayor a alguno
and padron != 71000;


-- 4.2 Obtener el padrón de los alumnos que aprobaron la materia 71.14 y no aprobaron
-- la materia 71.15
-- REVISAR!!
select distinct mat14.padron
from notas mat14
left join notas mat15 on mat14.padron = mat15.padron
where 
mat14.codigo = 71 and mat14.numero = 14 and mat14.nota >= 4
and (
	(mat15.codigo = 71 and mat15.numero = 15 and mat15.nota < 4)
OR
	NOT EXISTS (select 1 from notas noexiste where mat14.padron = noexiste.padron and noexiste.codigo = 71 and numero = 15)
)
order by mat14.padron;

select padron
from alumnos
where padron = ANY (select padron from notas where codigo = 71 and numero = 14 and nota >= 4)
-- = ANY  <===> IN
and padron <> ALL (select padron from notas where codigo = 71 and numero = 15 and nota >= 4);
-- <> ANY <====> NOT IN

select padron
from alumnos a
where EXISTS (select padron from notas n1 where codigo = 71 and numero = 14 and nota >= 4 AND n1.padron = a.padron)
and NOT EXISTS (select 1 from notas n2 where codigo = 71 and numero = 15 and nota >= 4 AND n2.padron = a.padron);

-- 4.3 Obtener el padrón y apellido de los alumnos que tienen nota en todas las materias
-- REVISAR!!!
select distinct alumnos.padron, alumnos.apellido
from notas
inner join alumnos on notas.padron = alumnos.padron
left join
(
	select padron, codigo, numero from alumnos, materias -- Todas las combinaciones posibles
	except
	select padron, codigo, numero from notas -- Las que existen
) faltantes on notas.padron = faltantes.padron
where faltantes.padron is null
order by padron;

-- La posta
-- No exista una materia para la que un alumno no tenga nota
-- no exista una nota para una materia
select padron, apellido 
from alumnos a
where NOT EXISTS (
	select * from materias m -- que no exista una materia
	where  NOT EXISTS (
		select * from notas n
		where n.padron = a.padron
		and n.codigo = m.codigo
		and n.numero = m.numero
	)
);

select padron, apellido from alumnos a
-- Que la resta entre todas las materias y las que tiene nota sea conjunto vacio
where not exists (
	select codigo, numero from materias m -- todas las materias
	except
	select codigo, numero from notas n -- menos las que el alumno tiene nota
	where n.padron = a.padron
);

-- 4.4 Obtener el padrón y apellido de los alumnos de intercambio que tienen nota en
-- todas las materias
-- Igual al anterior, pero agrego filtro en alumnos
select distinct alumnos.padron, alumnos.apellido
from notas
inner join alumnos on notas.padron = alumnos.padron
left join
(
	select padron, codigo, numero from alumnos, materias -- Todas las combinaciones posibles
	except
	select padron, codigo, numero from notas -- Las que existen
) faltantes on notas.padron = faltantes.padron
where faltantes.padron is null and alumnos.intercambio = 't'
order by padron;

select padron, apellido from alumnos a
-- Que la resta entre todas las materias y las que tiene nota sea conjunto vacio
where not exists (
	select codigo, numero from materias m -- todas las materias
	except
	select codigo, numero from notas n -- menos las que el alumno tiene nota
	where n.padron = a.padron
)
and a.intercambio = true;


-- 4.5 Obtener el padrón y apellido de los alumnos que tienen nota en todas las materias
-- del departamento 75
select distinct alumnos.padron, apellido from notas
inner join alumnos on notas.padron = alumnos.padron
left join (
select padron, codigo, numero from alumnos, materias where codigo = 75
except
select padron, codigo, numero from notas
) faltantes on notas.padron = faltantes.padron
where faltantes.padron is null
order by padron;

select padron, apellido from alumnos a
-- Que la resta entre todas las materias y las que tiene nota sea conjunto vacio
where not exists (
	select codigo, numero from materias m -- todas las materias
	where m.codigo = 75
	except
	select codigo, numero from notas n -- menos las que el alumno tiene nota
	where n.padron = a.padron
);

-- 4.6 Obtener el padrón y apellido de los alumnos que aprobaron todas las materias
select alumnos.padron, alumnos.apellido
from alumnos 
left join 
(select padron, codigo, numero from alumnos, materias
except
select padron, codigo, numero from notas where nota >=4
) faltantes on alumnos.padron = faltantes.padron
where faltantes.padron is null;

select padron, apellido from alumnos a
-- Que la resta entre todas las materias y las que tiene nota sea conjunto vacio
where not exists (
	select codigo, numero from materias m -- todas las materias
	except
	select codigo, numero from notas n -- menos las que el alumno tiene nota
	where n.padron = a.padron and n.nota >= 4
);

-- 5.1 Devuelva cuántos alumnos tienen al menos una nota mayor o igual a 7
-- REVISAR!!
select count(1) from (
	select padron, count(nota) from notas where nota >= 7 group by padron
) sub;

select count(distinct padron) from notas where nota >= 7 ;

-- 5.2 Devuelva el padrón de los alumnos que se hayan sacado la mejor nota en materias
-- del departamento 75
select * 
from notas
where codigo = 75
except 
select n2.* from notas n1
inner join notas n2 on n1.codigo = n2.codigo and n1.numero = n2.numero
where n1.nota > n2.nota
order by padron;

select padron from notas
where nota = (select max(nota) from notas where codigo = 75)
and codigo = 75;

-- 5.3 Para cada alumno, obtenga el padrón y su promedio de notas
select a.padron, avg(nota)
from alumnos a
inner join notas n on a.padron = n.padron
group by a.padron order by a.padron;

-- 5.4 Para cada alumno que tenga un promedio de nota mayor a 5, indicar su padrón,
-- apellido y cantidad de materias en las que tiene nota
select notas.padron, apellido , count(nota) as "cantidad materias"
from notas
inner join alumnos on notas.padron = alumnos.padron
group by notas.padron, apellido having avg(nota) > 5;

select notas.padron, apellido , count(distinct codigo::text || numero::text) as "cantidad materias"
from notas
inner join alumnos on notas.padron = alumnos.padron
group by notas.padron, apellido having avg(nota) > 5;

select notas.padron, apellido , count(distinct to_char(codigo, 'fm00') || to_char(numero, 'fm00')) as "cantidad materias"
from notas
inner join alumnos on notas.padron = alumnos.padron
group by notas.padron, apellido having avg(nota) > 5;

-- 5.5 Obtener el padrón de los alumnos que aprobaron la mayor cantidad de materias
select padron 
from notas n
where n.nota >= 4
group by padron having count(1) = (select count(distinct codigo::text || numero::text) from notas where nota >= 4);


select n.padron
from notas n
where n.nota >= 4
group by n.padron having count(*) >= ALL (
	select count(*)
	from notas n
	where n.nota >= 4
	group by n.padron
);


update empleados set sueldo = sueldo *1.1 where sector_supervisor = 2;

update empleados set sueldo = sueldo * 1.5 where sector_supervisor <> 2 
or sector_supervisor is null;
-- or sector_supervisor = NULL


-- Y el nulo ????
select * from empleados;

select codigo, nombre from sectores s
where not exists (select 1 from empleados e where e.sector_supervisor = s.codigo);

-- Tener cuidado con que subconsultas no devuelvan valores nulos
select codigo, nombre from sectores s
where s.codigo not in (select e.sector_supervisor from empleados e where e.sector_supervisor is not null);

select legajo, nombre, sector_supervisor from empleados e
order by sector_supervisor NULLS FIRST;


-- Para cada sector cuantos empleados supervisan a dicho sector
-- incluir sectores que no supervisan ningun empleado
select s.codigo, s.nombre, count(e.legajo)
from empleados e 
right join sectores s on e.sector_supervisor = s.codigo
group by s.codigo, s.nombre
order by s.codigo
;