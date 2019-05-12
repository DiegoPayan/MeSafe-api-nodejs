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

INSERT INTO tipoReportes(tipoReporte) VALUES ("Robo"),("Asalto"),("Secuestro"),("Acoso"),("Reporte ciudadano");

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
    PRIMARY KEY (id)
);

ALTER TABLE reportes ADD FOREIGN KEY (tipoReporte) REFERENCES tipoReportes(id);
ALTER TABLE reportes ADD FOREIGN KEY (idUsuario) REFERENCES usuarios(id);

INSERT INTO reportes(fecha,descripcion,latitud,longitud,positivos,negativos,tipoReporte,idUsuario)
			VALUES
				(NOW(),"Este es un reporte bonito 1", "11.11", "111.43", 11, 1, 1,1),
                (NOW(),"Este es un reporte bonito 2", "22.22", "122.43", 22, 2, 2,2),
                (NOW(),"Este es un reporte bonito 3", "33.33", "133.43", 33, 3, 3,3),
                (NOW(),"Este es un reporte bonito 4", "44.44", "144.43", 44, 4, 4,4),
                (NOW(),"Este es un reporte bonito 5", "55.55", "155.43", 55, 5, 5,1);

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
                            (4,'/images/reportes/4-1'),
                            (5,'/images/reportes/5-1');
                            
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
