CREATE Database Library;
USE Library;

CREATE TABLE IF NOT EXISTS Rol (
IDRol INT NOT NULL,
NombreRol VARCHAR(45) NOT NULL,
  PRIMARY KEY (IDRol)

);

CREATE TABLE IF NOT EXISTS Ciudad (
IDCiudad INT NOT NULL AUTO_INCREMENT,
NombreCiudad VARCHAR(45) NOT NULL,
  PRIMARY KEY (IDCiudad)
);

CREATE TABLE IF NOT EXISTS Comuna (
IDComuna INT NOT NULL AUTO_INCREMENT,
NombreComuna VARCHAR(45) NOT NULL,
  PRIMARY KEY (IDComuna)

);

CREATE TABLE IF NOT EXISTS Region (
IDRegion INT NOT NULL,
NombreRegion VARCHAR(45) NOT NULL,
  PRIMARY KEY (IDRegion)

);
  
CREATE TABLE IF NOT EXISTS Direccion (
IDDireccion INT NOT NULL AUTO_INCREMENT,
Calle VARCHAR(45) NOT NULL,
NroDomicilio INT NOT NULL,
Dpto INT NOT NULL,
Ciudad_IDCiudad INT NOT NULL,
Comuna_IDComuna INT NOT NULL,
Region_IDRegion INT NOT NULL,
  PRIMARY KEY (IDDireccion),
  FOREIGN KEY (Ciudad_IDCiudad) references Ciudad(IDCiudad),
  FOREIGN KEY (Comuna_IDComuna) references Comuna(IDComuna),
  FOREIGN KEY (Region_IDRegion) references Region(IDRegion)

);
  
CREATE TABLE IF NOT EXISTS Usuario (
IDUsuario INT NOT NULL AUTO_INCREMENT,
NombreUsuario VARCHAR(40) NOT NULL,
ApellidoUsuario VARCHAR(40) NOT NULL,
Rol_IDRol INT NOT NULL,
Direccion_IDDireccion INT NOT NULL,
  PRIMARY KEY (IDUsuario),
  FOREIGN KEY (Rol_IDRol) references Rol(IDRol),
  FOREIGN KEY (Direccion_IDDireccion) references Direccion(IDDireccion)

);
  
CREATE TABLE IF NOT EXISTS Categoria(
IDCategoria INT NOT NULL AUTO_INCREMENT,
categoria VARCHAR(45) NOT NULL,
  PRIMARY KEY (IDCategoria)

);

CREATE TABLE IF NOT EXISTS Editorial (
IDEditorial INT NOT NULL AUTO_INCREMENT,
Editorial VARCHAR(45) NOT NULL,
  PRIMARY KEY (IDEditorial)

);

CREATE TABLE IF NOT EXISTS Autor (
IDAutor INT NOT NULL AUTO_INCREMENT,
Autor VARCHAR(45) NULL,
  PRIMARY KEY (IDAutor)

);
  
CREATE TABLE IF NOT EXISTS Libro (
IDLibro INT NOT NULL AUTO_INCREMENT,
NombreLibro VARCHAR(40) NOT NULL,
Autor_IDAutor INT NOT NULL,
Categoria_IDCategoria INT NOT NULL,
Editorial_IDEditorial INT NOT NULL,
  PRIMARY KEY (IDLibro),
  FOREIGN KEY (Autor_IDAutor) references Autor(IDAutor),
  FOREIGN KEY (Categoria_IDCategoria) references Categoria(IDCategoria),
  FOREIGN KEY (Editorial_IDEditorial) references Editorial(IDEditorial)

);

CREATE TABLE IF NOT EXISTS Unidad (
IDUnidad INT NOT NULL AUTO_INCREMENT,
Estado VARCHAR(45) NULL,
Libro_IDLibro INT NOT NULL,
  PRIMARY KEY (IDUnidad),
  FOREIGN KEY (Libro_IDLibro) references Libro(IDLibro)
);
  
CREATE TABLE IF NOT EXISTS Prestamo (
IDPrestamo INT NOT NULL AUTO_INCREMENT,
FechaEntrega DATE NOT NULL,
FechaDevolucion DATE NOT NULL,
Unidad_IDUnidad INT NOT NULL,
Usuario_IDUsuario INT NOT NULL,
  PRIMARY KEY (IDPrestamo),
  FOREIGN KEY (Unidad_IDUnidad) references Unidad(IDUnidad),
  FOREIGN KEY (Usuario_IDUsuario) references Usuario(IDUsuario)
  
);

insert into Rol (IDRol,NombreRol) values
				        (1,"Alumno"),
                (2,"Profesor"),
                (3,"Asistente Estudiantil");

insert into Ciudad (NombreCiudad) values
                    ("Santa Maria");

insert into Comuna (NombreComuna) values
                    ("Santa Maria");

insert into Region (IDRegion, NombreRegion) values
                    (5, "Valparaiso");

insert into Direccion (Calle, NroDomicilio, Dpto, Ciudad_IDCiudad, Comuna_IDComuna, Region_IDRegion) values
                      ("retamal", "32", "0", "1","1","5"),
                      ("perez"  , "10", "0", "1","1","5"),
                      ("lilas"  , "21", "0", "1","1","5");
                      
insert into Usuario (NombreUsuario, ApellidoUsuario, Rol_IDRol, Direccion_IDDireccion) values
                    ('Javiera' ,'Lopez','3','1'),
                    ('Felipe' ,'Olmos','2','2'),
                    ('Sebastian' ,'Diaz','1','3');
 
insert into Categoria(categoria)values
                      ("Ciencias"),
                      ("Matematicas"),
                      ("Ciencia Ficcion"),
                      ("Fantasia"),
                      ("Poesia");

insert into Editorial(Editorial) values
                    ("Patria"),
                    ('Planetalector'),
                    ('Editorial Nascimento');

insert into Autor (Autor) values
                    ("Aurelio Baldor"),
                    ("C. S. Lewis"),
                    ('Pablo Neruda');

insert into Libro (NombreLibro, Autor_IDAutor, Categoria_IDCategoria, Editorial_IDEditorial) values
                    ("Álgebra de Baldor", '1', '2', '1'),
                    ("Las crónicas de Narnia", '2', '4', '2'),
                    ("Crepusculario", '3', '5', '3');
                    
insert into Unidad (Estado, Libro_IDLibro) values
                    ("Operacional", 1),
                    ("Operacional", 1),
                    ("Operacional", 2),
                    ("Operacional", 2),
                    ("Operacional", 3),
                    ('Operacional', 3);

insert into Prestamo (FechaEntrega, FechaDevolucion, Unidad_IDUnidad, Usuario_IDUsuario) values
                    ("21-09-29",'21-10-10', '1', '1'),
                    ("21-09-28",'21-10-09', '2', '2'),
                    ("21-09-27",'21-10-08', '3', '3');


/*Devolucion*/
DELETE FROM Prestamo where Unidad_IDUnidad = 1;


/*Muestra el total de stock y cantidad de prestados*/
SELECT count(IDPrestamo) as 'Prestados' from prestamo
union
Select 'Unidades' 
union
Select count(IDUnidad) from Unidad;


/*Muestra los prestados con nombre, ID, Etc.*/

SELECT Prestamo.IDPrestamo, Prestamo.FechaEntrega, Prestamo.FechaDevolucion, Libro.IDLibro, Unidad.IDUnidad, Libro.NombreLibro, Usuario.IDUsuario, Usuario.NombreUsuario
FROM ((Prestamo
INNER JOIN Unidad ON Prestamo.Unidad_IDUnidad = Unidad.IDUnidad)
INNER JOIN Usuario ON Prestamo.Usuario_IDUsuario = Usuario.IDUsuario
INNER JOIN Libro ON Prestamo.Unidad_IDUnidad = Libro.IDLibro);

/*Muestra por categoria*/
SELECT Unidad.IDUnidad, Libro.NombreLibro, Categoria.categoria, Unidad.Estado
FROM ((Libro
INNER JOIN Categoria ON Libro.Categoria_IDCategoria = Categoria.IDCategoria)
INNER JOIN Unidad ON Unidad.Libro_IDLibro = Libro.IDLibro);


/*Renovar prestamo*/
UPDATE Prestamo 
SET 
    FechaDevolucion = '21-10-20'
WHERE
    IDPrestamo = 3;


/*Dar de baja*/
UPDATE Unidad 
SET 
    Estado = 'Inutilizable'
WHERE
    IDUnidad = 1;

/*Eliminar Usuario*/
DELETE FROM Usuario where IDUsuario = 1;