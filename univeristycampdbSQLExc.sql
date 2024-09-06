-- Crear una base SQL con MySQL workbench para una univerdidad que administre estudiantes, cursos, profesores y calificaciones
CREATE DATABASE universidad_sql_course_db;

USE universidad_sql_course_db;
-- Construir una base de datos con las tablas porfesores, estudiantes, cursos,calificaciones y sus relaciones  foreign key entre tablas
CREATE TABLE calificaciones (
  calificaciones_id INT NOT NULL AUTO_INCREMENT,
  calificacion_profesor_id  INT NOT NULL,
  calificacion_estudiante_id  INT NOT NULL,
  nota   DECIMAL (3,2) DEFAULT NULL,
  calificaciones_calificaciones_id  INT NOT NULL,
  calificaciones_calificaciones_id1 INT NOT NULL,
  PRIMARY KEY (calificaciones_id),
  KEY fk_calificaciones_calificaciones2_idx (calificacion_profesor_id),
 CONSTRAINT  fk_calificaciones_calificaciones1
 FOREIGN KEY (calificaciones_id)    REFERENCES estudiantes (estudiante_id) ON UPDATE CASCADE
);

CREATE TABLE  cursos (
  curso_id  INT NOT NULL AUTO_INCREMENT,
  asignatura   VARCHAR(50) DEFAULT NULL,
  profesor_id  INT DEFAULT NULL,
  cursos_curso_id  INT NOT NULL,
  PRIMARY KEY (curso_id ,cursos_curso_id),
  KEY  fk_profesor  (profesor_id),
  KEY fk_cursos_cursos1_idx ( asignatura)
);


CREATE TABLE  estudiantes (
  estudiante_id  INT NOT NULL AUTO_INCREMENT,
  estudiante_curso_id INT NOT NULL,
  estudiante_nombre  VARCHAR(50) NOT NULL,
  estudiante_apellido  VARCHAR (50) NOT NULL,
  estudiante_email  VARCHAR  (100) NOT NULL,
  profesores_profesor_id  INT NOT NULL,
  PRIMARY KEY (estudiante_id),
  UNIQUE KEY  estudiante_email  ( estudiante_email),
  KEY `fk_estudiantes_profesores1_idx` (`profesores_profesor_id`)
);
CREATE TABLE  profesores (
  profesor_id  INT NOT NULL AUTO_INCREMENT,
  profesor_curso_id  INT NOT NULL,
  profesor_nombre   VARCHAR(50) DEFAULT NULL,
  profesor_apellido VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (profesor_id)
);


-- Crear un script que complete todas las tablas de la base de datos con datos de muestra
INSERT INTO cursos (asignatura,profesor_id)
VALUES
('DerechoCivilI',40),
('DerechoRomanoI',30),
('Estadistica I',10),
('Economía I',10),
('Derecho Civil II',30),
('Derecho Romano II',20),
('Estadística II',20),
('Economía II',30);
 

INSERT INTO profesores(profesor_id,profesor_curso_id,profesor_nombre,profesor_apellido)
VALUES

(10, 3001, 'Ander', 'Busturia'),
(20, 3002, 'Elena', 'Gómez'),
(30, 3003, 'Fernando','Llanos'),
(40, 3004, 'Carmen', 'Almagro');

INSERT INTO estudiantes (estudiante_id, estudiante_curso_id, estudiante_nombre, estudiante_apellido, estudiante_email)
VALUES

(13, 124, 'Elena', 'Garamendi', 'garamendielena@gmail.com'),
(14, 125,'Jon', 'Gandarias',' gandariasjon@gmail.com'),
(15, 126, 'Carmen', 'Bustamante','bustamantecarmen@gmail.com'), 
(16, 127, 'Patxi', 'Alonso', 'alonsopatxi@gmail.com'),
(17, 128, 'Selena','García', 'garciaselena@gmail.com'), 
(18, 129, 'Jokin', 'Sanchez', 'sanchezjokin@gmail.com');

INSERT INTO cursos ( calificaciones_id, calificacion_profesor_id, calificacion_estudiante_id, nota, calificaciones_calificaciones_id )
VALUES
(13, 3004, 12501, 8.25, 123),
(14, 3003, 12702, 6.50, 365),
(15, 3004, 12603, 4.50, 352),
(16, 3001, 12405, 9.40, 125),
(17, 3003, 12801, 7.70, 745),
(18, 3002, 12903, 5.80, 147),

-- La nota media que da cada profesor

SELECT p.profesor_nombre, AVG(ca.nota) AS nota_media
FROM profesores p
JOIN cursos cu ON p.profesor_id = cu.profesor_id
JOIN calificaciones ca ON cu.curso_id = curso_id
GROUP BY p.profesor_nombre);


-- Las mejores calificaciones de cada estudiante

SELECT e.estudiante_nombre AS estudiante_nombre, MAX(ca.nota) AS mejor_calificacion
FROM estudiantes e
JOIN calificaciones ca ON e.estudiante_id = ca.nota
GROUP BY e.estudiante_nombre;

-- Ordena los estudiantes por los cursos en los que estan matriculados

SELECT e. estudiante_nombre AS estudiante_nombre, c.asignatura AS curso_matriculado
FROM estudiantes e
JOIN cursos c ON e.estudiante_curso_id = c.curso_id;


-- Cree un informe resumido de los cursos y sus calificaciones promedio, ordenados desde el curso más desafiante (curso con la calificación promedio más baja) hasta el curso más fácil.

SELECT c.asignatura AS nombre_curso, AVG(cal.nota) AS calificacion_promedio
FROM cursos c
JOIN calificaciones cal ON c.curso_id= cal.calificacion_profesor_id
GROUP BY c.asignatura
ORDER BY calificacion_promedio ASC;


-- Encontrar qué estudiante y profesor tienen más cursos en común

SELECT e.estudiante_nombre AS estudiante_nombre, p.profesor_nombre AS profesor_nombre, COUNT(*) AS cantidad_cursos_en_comun
FROM estudiantes e
JOIN cursos ec ON e.estudiante_curso_id = ec.curso_id
JOIN profesores p ON ec.curso_id = p.profesor_curso_id
GROUP BY e.estudiante_nombre, p.profesor_nombre
ORDER BY cantidad_cursos_en_comun DESC;
