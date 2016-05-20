
DROP TABLE Login CASCADE CONSTRAINTS;
DROP TABLE Centros CASCADE CONSTRAINTS;
DROP TABLE Trabajadores CASCADE CONSTRAINTS;
DROP TABLE Partes CASCADE CONSTRAINTS;
DROP TABLE Abiertos CASCADE CONSTRAINTS;
DROP TABLE Cerrados CASCADE CONSTRAINTS;
DROP TABLE modifica CASCADE CONSTRAINTS;
DROP TABLE Viajes CASCADE CONSTRAINTS;


CREATE TABLE Login (
    usuario     VARCHAR2 (20) NOT NULL,
    contrasena  VARCHAR2 (20) NOT NULL
);
ALTER TABLE Login ADD CONSTRAINT Login_PK PRIMARY KEY (usuario);


CREATE TABLE Centros (
    id_centro VARCHAR2 (10) NOT NULL,
    nombre    VARCHAR2 (15) NOT NULL,
    tlf_fijo  VARCHAR2 (9) NOT NULL,
    cp        VARCHAR2 (5) NOT NULL,
    provincia VARCHAR2 (10) NOT NULL,
    ciudad    VARCHAR2 (15) NOT NULL,
    calle     VARCHAR2 (30) NOT NULL,
    numero    VARCHAR2 (3) NOT NULL
);
ALTER TABLE Centros ADD CONSTRAINT Centros_PK PRIMARY KEY (id_centro);


CREATE TABLE Trabajadores (
    dni          VARCHAR2 (9) NOT NULL,
    nombre       VARCHAR2 (15) NOT NULL,
    apellido1    VARCHAR2 (20) NOT NULL,
    apellido2    VARCHAR2 (20) NOT NULL,
    calle        VARCHAR2 (30) NOT NULL,
    numero       VARCHAR2 (3) NOT NULL,
    piso         VARCHAR2 (3) NOT NULL,
    mano         VARCHAR2 (5) NOT NULL,
    tlf_empresa  VARCHAR2 (9) NOT NULL,
    tlf_personal VARCHAR2 (9),
    fecha_nac    DATE,
    salario      FLOAT (9),
    tipo         VARCHAR(1),
    Centros_id_centro VARCHAR2 (10) NOT NULL,
    Login_usuario VARCHAR2 (20) NOT NULL
);
ALTER TABLE Trabajadores ADD CONSTRAINT Trabajadores_PK PRIMARY KEY (dni);


CREATE TABLE Partes (
    id_parte      VARCHAR2 (10) NOT NULL,
    fecha_inicio  DATE NOT NULL,
    km_inicio     FLOAT (10) NOT NULL,
    km_fin        FLOAT (10) NOT NULL,
    gasoil        FLOAT (5),
    autopista     FLOAT (5),
    dieta         FLOAT (5),
    otros         FLOAT (5),
    incidencias   VARCHAR2 (500),
    Trabajadores_dni VARCHAR2 (9) NOT NULL
);
ALTER TABLE Partes ADD CONSTRAINT Partes_PK PRIMARY KEY (id_parte);


CREATE TABLE Abiertos (
    id_parte VARCHAR2 (10) NOT NULL
);
ALTER TABLE Abiertos ADD CONSTRAINT Abiertos_PK PRIMARY KEY (id_parte);


CREATE TABLE Cerrados (
    id_parte           VARCHAR2 (10) NOT NULL,
    validacion         CHAR (1) NOT NULL,
    fecha_fin          DATE NOT NULL,
    Trabajadores_dni VARCHAR2 (9) NOT NULL
);
ALTER TABLE Cerrados ADD CONSTRAINT Cerrados_PK PRIMARY KEY (id_parte);


CREATE TABLE modifica (
    Trabajadores_dni VARCHAR2 (9) NOT NULL,
    Partes_id_parte     VARCHAR2 (10) NOT NULL,
    fecha_modif        DATE NOT NULL
);
ALTER TABLE modifica ADD CONSTRAINT modifica_PK PRIMARY KEY (Trabajadores_dni, Partes_id_parte);


CREATE TABLE Viajes (
    id_viaje       VARCHAR2 (10) NOT NULL,
    hora_inicio    VARCHAR2 (5) NOT NULL,
    hora_fin       VARCHAR2 (5) NOT NULL,
    matricula      VARCHAR2 (9) NOT NULL,
    num_albaran    VARCHAR2 (10) NOT NULL,
    Partes_id_parte VARCHAR2 (10) NOT NULL
);
ALTER TABLE Viajes ADD CONSTRAINT Viajes_PK PRIMARY KEY (id_viaje);


ALTER TABLE Trabajadores ADD CONSTRAINT Trabajadores_Login_FK FOREIGN KEY (Login_usuario)
REFERENCES Login (usuario) ON DELETE CASCADE;

ALTER TABLE Trabajadores ADD CONSTRAINT Trabajadores_Centros_FK FOREIGN KEY (Centros_id_centro)
REFERENCES Centros (id_centro) ON DELETE CASCADE;

ALTER TABLE Partes ADD CONSTRAINT Partes_Trabajadores_FK FOREIGN KEY (Trabajadores_dni)
REFERENCES Trabajadores (dni) ON DELETE CASCADE;

ALTER TABLE Abiertos ADD CONSTRAINT Abiertos_Partes_FK FOREIGN KEY (id_parte)
REFERENCES Partes (id_parte);

ALTER TABLE Cerrados ADD CONSTRAINT Cerrados_Trabajadores_FK FOREIGN KEY (Trabajadores_dni)
REFERENCES Trabajadores (dni) ON DELETE CASCADE;

ALTER TABLE Cerrados ADD CONSTRAINT Cerrados_Partes_FK FOREIGN KEY (id_parte)
REFERENCES Partes (id_parte);

ALTER TABLE modifica ADD CONSTRAINT FK_ASS_6 FOREIGN KEY (Trabajadores_dni)
REFERENCES Trabajadores (dni) ON DELETE CASCADE;

ALTER TABLE modifica ADD CONSTRAINT FK_ASS_7 FOREIGN KEY (Partes_id_parte)
REFERENCES Partes (id_parte) ON DELETE CASCADE;

ALTER TABLE Viajes ADD CONSTRAINT Viajes_Partes_FK FOREIGN KEY (Partes_id_parte)
REFERENCES Partes (id_parte) ON DELETE CASCADE;


INSERT INTO Login VALUES ('aGarciaM','1111111A');
INSERT INTO Login VALUES ('aGomezP','22222222B');
INSERT INTO Login VALUES ('jFernandezL','33333333C');
INSERT INTO Login VALUES ('aMadinaS','44444444D');
INSERT INTO Login VALUES ('mAntonR','55555555E');
INSERT INTO Login VALUES ('nAzkorretaG','66666666F');
INSERT INTO Login VALUES ('nMasvidalC','77777777G');
INSERT INTO Login VALUES ('lMunarB','88888888H');
INSERT INTO Login VALUES ('aCorresB','99999999I');
INSERT INTO Login VALUES ('hQuintasP','00000000J');


INSERT INTO Centros VALUES ('111111111','Primero','945155636','01001','Alava','Vitoria-Gasteiz','calle Postas','7');
INSERT INTO Centros VALUES ('222222222','Segundo','943135619','03003','Pontevedra','Sanxenxo','calle Rua Castelao','13');
INSERT INTO Centros VALUES ('333333333','Tercero','941564578','01204','Madrid','Madrid','Gran Via','48');
INSERT INTO Centros VALUES ('444444444','Cuarto','947321465','06004','Sevilla','Sevilla','calle Ramon Carande','24');
INSERT INTO Centros VALUES ('555555555','Quinto','948257621','03507','Barcelona','Sabadell','carrer del Valles','30');


INSERT INTO Trabajadores VALUES ('11111111A','Aritz','Garcia','Martinez','calle Perdida','1','1','Dcha','645783521','694525315','21/03/1990',999.99,'A','111111111','aGarciaM');
INSERT INTO Trabajadores VALUES ('22222222B','Amaia','Gomez','Pereda','calle Nula','4','2','Izqu','612785432','698452135','12/11/1895',999.99,'L','111111111','aGomezP');
INSERT INTO Trabajadores VALUES ('33333333C','Jon','Fernandez','Larrinoa','calle Salida','7','3','Dcha','678541235','698523214','02/09/1893',999.99,'A','222222222','jFernandezL');
INSERT INTO Trabajadores VALUES ('44444444D','Ane','Madina','Salazar','calle Arriaga','11','4','Izqu','687521432','698532147','06/05/1892',999.99,'L','222222222','aMadinaS');
INSERT INTO Trabajadores VALUES ('55555555E','Markel','Anton','Roldan','calle Alacala','15','5','Dcha','678521456','698632564','15/08/1890',999.99,'A','333333333','mAntonR');
INSERT INTO Trabajadores VALUES ('66666666F','Naia','Azkorreta','Gutierrez','calle Paz','1','6','Izqu','689452512','632124574','08/06/1998',999.99,'L','333333333','nAzkorretaG');
INSERT INTO Trabajadores VALUES ('77777777G','Nicolas','Masvidal','Cuesta','calle Erre','1','7','Dcha','645127898','632541278','16/09/1991',999.99,'A','444444444','nMasvidalC');
INSERT INTO Trabajadores VALUES ('88888888H','Leire','Munar','Bengoa','calle Zapa','1','8','Izqu','698572514','678523659','30/10/1995',999.99,'L','444444444','lMunarB');
INSERT INTO Trabajadores VALUES ('99999999I','Aimar','Corres','Bueno','calle Kutxi','1','9','Dcha','698542132','698632589','11/05/1993',999.99,'A','555555555','aCorresB');
INSERT INTO Trabajadores VALUES ('00000000J','Hodei','Quintas','Prieto','calle Pinto','1','10','Izqu','698523258','689452132','26/08/1999',999.99,'L','555555555','hQuintasP');

