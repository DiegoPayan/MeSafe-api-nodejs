-- DROP DATABASE meSafe;

-- CREATE DATABASE meSafe;

USE meSafe;

CREATE TABLE IF NOT EXISTS tipoUsuario (
    id INT NOT NULL AUTO_INCREMENT,
    tipoUsuario VARCHAR(30),
    PRIMARY KEY (id)
);

INSERT INTO tipoUsuario(tipoUsuario) VALUES('Habitante');

CREATE TABLE IF NOT EXISTS usuarios (
	id INT NOT NULL AUTO_INCREMENT,
    username VARCHAR(30) NOT NULL,
    password VARCHAR(30) NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    apellidoPaterno VARCHAR(30) NOT NULL,
    apellidoMaterno VARCHAR(30),
    curp VARCHAR(20),
    codigoPostal VARCHAR(20) NOT NULL,
    tipoUsuario INT,
    imagenPerfil VARCHAR(50) NOT NULL,
    estatus INT NOT NULL DEFAULT 1,
	PRIMARY KEY (id)
);

ALTER TABLE usuarios ADD FOREIGN KEY (tipoUsuario) REFERENCES tipoUsuario(id);

INSERT INTO usuarios(username,password,nombre,apellidoPaterno,apellidoMaterno, curp, codigoPostal, tipoUsuario, imagenPerfil) 
VALUES 
("dpayan","1234",'Diego', 'Payan', 'Lopez', '', 80026, 1, 'images/usuarios/hombre.png'),
("mmadrid","1234",'Mayela', 'Madrid', 'Gutierrez', '', 80025, 1, 'images/usuarios/mujer.png'),
("nzavala","1234",'Nicol', 'Zavala', 'Sajaropulos', '', 80024, 1, 'images/usuarios/mujer.png'),
("hrosales","1234",'Hernan', 'Rosales', 'Corvera', '', 80023, 1, 'images/usuarios/hombre.png');

CREATE TABLE IF NOT EXISTS amigos (
    id INT NOT NULL AUTO_INCREMENT,
    idUsuario INT NOT NULL,
    idAmigo INT NOT NULL,
    PRIMARY KEY (id)
);

ALTER TABLE amigos ADD FOREIGN KEY (idUsuario) REFERENCES usuarios(id);
ALTER TABLE amigos ADD FOREIGN KEY (idAmigo) REFERENCES usuarios(id);

INSERT INTO amigos(idUsuario,idAmigo) VALUES (1,2),(1,3),(2,4),(3,4);

CREATE TABLE IF NOT EXISTS tipoReportes (
    id INT NOT NULL AUTO_INCREMENT,
    tipoReporte VARCHAR(30),
    PRIMARY KEY (id)
);

INSERT INTO tipoReportes(tipoReporte) VALUES ("Robo"),("Asalto"),("Reporte ciudadano");

CREATE TABLE IF NOT EXISTS reportes(
    id INT NOT NULL AUTO_INCREMENT,
    fecha DATETIME NOT NULL,
    descripcion VARCHAR(100) NOT NULL,
    latitud VARCHAR(30) NOT NULL,
    longitud VARCHAR(30) NOT NULL,
    positivos INT NOT NULL DEFAULT 0,
    negativos INT NOT NULL DEFAULT 0,
    tipoReporte INT NOT NULL,
    idUsuario INT NOT NULL,
    emergencia BOOLEAN NOT NULL,
    PRIMARY KEY (id)
);

ALTER TABLE reportes ADD FOREIGN KEY (tipoReporte) REFERENCES tipoReportes(id);
ALTER TABLE reportes ADD FOREIGN KEY (idUsuario) REFERENCES usuarios(id);

INSERT INTO reportes(fecha,descripcion,latitud,longitud,positivos,negativos,tipoReporte,idUsuario,emergencia)
VALUES
(NOW(),"Robo de minisuper por la noche", "24.80", "-107.43", 150, 10,1,1,false),
(NOW(),"Asalto en callejón oscuro", "24.80", "-107.43", 75, 3, 2,4,true),
(NOW(),"Zona con poca iluminacion de noche", "33.33", "-107.43", 338, 19, 3,3,false),
(NOW(),"Robo en pleno centro", "24.80", "-107.43", 550, 28, 1,2,true),
(NOW(),"Asalto en empresa de desarrollo de software", "24.801", "-107.43", 374, 104, 2,1,true),
(NOW(),"Perro extraviado", "24.80", "-107.43", 258, 4, 3,4,false),
(NOW(),"Robo en colonia infonavit", "24.80", "-107.43", 123, 2, 1,2,true),
(NOW(),"Altado por dos hombres en motocicleta", "24.80", "-107.43", 227, 10, 2,2,true),
(NOW(),"Niña extraviada", "24.80", "-107.43", 103, 755, 3,3,true);

CREATE TABLE IF NOT EXISTS imagenesReportes (
    id INT NOT NULL AUTO_INCREMENT,
    idReporte INT NOT NULL,
    src VARCHAR(50),
    PRIMARY KEY (id)
);

ALTER TABLE imagenesReportes ADD FOREIGN KEY (idReporte) REFERENCES reportes(id);

INSERT INTO imagenesReportes(idReporte,src) VALUES 
							(1,'/images/reportes/1.jpg'),
                            (2,'/images/reportes/2.jpg'),
                            (3,'/images/reportes/3.jpg'),
                            (4,'/images/reportes/4.jpg'),
                            (5,'/images/reportes/5.jpg'),
                            (6,'/images/reportes/6.jpg'),
                            (7,'/images/reportes/7.jpg'),
                            (8,'/images/reportes/8.jpg'),
                            (9,'/images/reportes/9.jpg');
                            
CREATE TABLE IF NOT EXISTS comentariosReportes (
    id INT NOT NULL AUTO_INCREMENT,
    comentario VARCHAR(100),
    idReporte INT NOT NULL,
    idUsuario INT NOT NULL,
    PRIMARY KEY (id)
);

ALTER TABLE comentariosReportes ADD FOREIGN KEY (idReporte) REFERENCES reportes(id);
ALTER TABLE comentariosReportes ADD FOREIGN KEY (idUsuario) REFERENCES usuarios(id);

CREATE TABLE IF NOT EXISTS calificacionReportes (
    id INT NOT NULL AUTO_INCREMENT,
    tipo ENUM('Positivo','Negativo') NOT NULL,
    idReporte INT NOT NULL,
    idUsuario INT NOT NULL,
    PRIMARY KEY (id)
);

ALTER TABLE calificacionReportes ADD FOREIGN KEY (idReporte) REFERENCES reportes(id);
ALTER TABLE calificacionReportes ADD FOREIGN KEY (idUsuario) REFERENCES usuarios(id);

CREATE TABLE IF NOT EXISTS tipoCentroAyuda (
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(30),
    PRIMARY KEY (id)
);

INSERT INTO tipoCentroAyuda(nombre) VALUES ("Hospital"), ("Bomberos"), ("Policias"), ("Instituciones");

CREATE TABLE IF NOT EXISTS centroAyuda (
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    direccion VARCHAR(200) NOT NULL,
    idTipoCentroAyuda INT NOT NULL,
    PRIMARY KEY (id)
);

ALTER TABLE centroAyuda ADD FOREIGN KEY (idTipoCentroAyuda) REFERENCES tipoCentroAyuda(id);

INSERT INTO centroAyuda(nombre,telefono,direccion,idTipoCentroAyuda) 
                VALUES  ("Hospital Civil","758 0500","Álvaro Obregón 1422, Tierra Blanca, 80030 Culiacán Rosales, Sin.", 1),
                        ("Hospital Angeles","758 7700","Av Gral Ignacio Aldama S/N, Guadalupe, 80230 Culiacán Rosales, Sin.", 1),
                        ("Hospital General","716 9815","Blvrd Alfonso G. Calderón 2139, Country Alamos, Culiacán Rosales, Sin.", 1),
                        ("Estacion #1 Bomberos","712 3199","Gabriel Leyva 444 Oriente, Centro, 80000 Culiacán Rosales, Sin.", 2),
                        ("Estacion #2 Bomberos","714 5750","Avenida Emiliano Zapata 3536, Francisco Villa, 80110 Culiacán Rosales, Sin.", 2),
                        ("Estacion #3 Bomberos","753 4520","Av. Álvaro Obregón 273, 6 de Enero, 80010 Culiacán Rosales, Sin.", 2),
                        ("Fiscalia General del Estado","713 3200","Enrique Sánchez Alonso 1833, Desarrollo Urbano Tres Ríos, 80100 Culiacán Rosales, Sin.", 3),
                        ("Policia de Investigacion","714 2833","Av. Álvaro Obregón 273, 6 de Enero, 80010 Culiacán Rosales, Sin.", 3),
                        ("Servicio de emergencia","911","Culiacan Sin.", 3),
                        ("Instituto Municipal de las mujeres","716 9757","Calle Cristóbal Colón 245, Primer Cuadro, 80000 Culiacán Rosales, Sin.", 4),
                        ("DIF","715 7142","Juan José Ríos, Poniente #265-B, Jorge Almada, 80200 Culiacán Rosales, Sin.", 4),
                        ("Instituto Estatal de protección civil","717 8287","Primera 65, Vallado Viejo, 80110 Culiacán Rosales, Sin.", 4);
