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
					("dpayan","1234",'Diego', 'Payan', 'Lopez', '', 80026, 1, 'images/usuarios/1'),
					("mmadrid","1234",'Mayela', 'Madrid', 'Gutierrez', '', 80025, 1, 'images/usuarios/2'),
                    ("nzavala","1234",'Nicolas', 'Zavala', 'Sajaropulos', '', 80024, 1, 'images/usuarios/3'),
                    ("hrosales","1234",'Hernan', 'Rosales', 'Corvera', '', 80023, 1, 'images/usuarios/4');

CREATE TABLE IF NOT EXISTS amigos (
    id INT NOT NULL AUTO_INCREMENT,
    idUsuario INT NOT NULL,
    idAmigo INT NOT NULL,
    PRIMARY KEY (id)
);

ALTER TABLE amigos ADD FOREIGN KEY (idUsuario) REFERENCES usuarios(id);
ALTER TABLE amigos ADD FOREIGN KEY (idAmigo) REFERENCES usuarios(id);

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

INSERT INTO reportes(fecha,descripcion,latitud,longitud,positivos,negativos,tipoReporte,idUsuario, emergencia)
			VALUES
				(NOW(),"Reporte Robo 1", "11.11", "111.43", 11, 1, 1,1,1),
                (NOW(),"Reporte Asalto", "22.22", "122.43", 22, 2, 2,2,1),
                (NOW(),"Secuestro", "33.33", "133.43", 33, 3, 3,3,0),
                (NOW(),"Acoso", "44.44", "144.43", 44, 4, 3,4,0);

CREATE TABLE IF NOT EXISTS imagenesReportes (
    id INT NOT NULL AUTO_INCREMENT,
    idReporte INT NOT NULL,
    src VARCHAR(50),
    PRIMARY KEY (id)
);

ALTER TABLE imagenesReportes ADD FOREIGN KEY (idReporte) REFERENCES reportes(id);

INSERT INTO imagenesReportes(idReporte,src) VALUES 
							(1,'/images/reportes/1-1'),
                            (2,'/images/reportes/2-1'),
                            (3,'/images/reportes/3-1'),
                            (4,'/images/reportes/4-1');
                            
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
