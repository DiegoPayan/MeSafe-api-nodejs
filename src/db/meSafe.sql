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
    estatus INT NOT NULL DEFAULT 1,
	PRIMARY KEY (id)
);

ALTER TABLE usuarios ADD FOREIGN KEY (tipoUsuario) REFERENCES tipoUsuario(id);

INSERT INTO usuarios(username,password,nombre,apellidoPaterno,apellidoMaterno, curp, codigoPostal, tipoUsuario) 
				VALUES 
					("dpayan","1234",'Diego', 'Payan', 'Lopez', '', 80026, 1),
					("mmadrid","1234",'Mayela', 'Madrid', 'Gutierrez', '', 80025, 1),
                    ("nzavala","1234",'Nicolas', 'Zavala', 'Sajaropulos', '', 80024, 1),
                    ("hrosales","1234",'Hernan', 'Rosales', 'Corvera', '', 80023, 1);

-- CREATE TABLE IF NOT EXISTS amigos


CREATE TABLE IF NOT EXISTS tipoReportes (
    id INT NOT NULL AUTO_INCREMENT,
    tipoReporte VARCHAR(30),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS reportes(
    id INT NOT NULL AUTO_INCREMENT,
    fecha DATETIME NOT NULL,
    descripcion VARCHAR(100) NOT NULL,
    latitud DECIMAL(10,2) NOT NULL,
    logitud DECIMAL(10,2) NOT NULL,
    tipoReporte INT NOT NULL,
    idUsuario INT NOT NULL
);

ALTER TABLE reportes ADD FOREIGN KEY (tipoReporte) REFERENCES tipoReporte(id);
ALTER TABLE reportes ADD FOREIGN KEY (idUsuario) REFERENCES usuarios(id);

-- CREATE TABLE IF NOT EXISTS imagenesReportes

-- CREATE TABLE IF NOT EXISTS detallesReportes

