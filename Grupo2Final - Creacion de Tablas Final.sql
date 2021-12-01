
-- Create tables
IF (NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Fecha'))
BEGIN
  CREATE TABLE Fecha
  (
    id INT NOT NULL,
    año INT,
    mes INT,
    PRIMARY KEY(id)
  )
END;

IF (NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'CentroPoblado'))
BEGIN
  CREATE TABLE CentroPoblado
  (
    id INT NOT NULL,
    nombre VARCHAR(100),
    PRIMARY KEY(id)
  )
END;

IF (NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Categoria'))
BEGIN
  CREATE TABLE Categoria
  (
    id INT NOT NULL,
    nombre VARCHAR(100),
    PRIMARY KEY(id)
  )
END;

IF (NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'HechoCobertura'))
BEGIN
  CREATE TABLE HechoCobertura
  (
    id INT NOT NULL,
    FechaReporteCobertura INT,
    TipoCobertura INT,
    AeropuertoMasCercano INT,
    CentroPoblado_id INT,
    distancia FLOAT,
    flagCobertura bit,
    PRIMARY KEY(id)
  )
END;

IF (NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Caracteristicas'))
BEGIN
  CREATE TABLE Caracteristicas
  (
    id INT NOT NULL,
    tipoEquipo VARCHAR(4),
    tipoVuelo VARCHAR(1),
    trafico VARCHAR(1),
    empresa VARCHAR(150),
    PRIMARY KEY(id)
  )
END;

IF (NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'HechoVuelo'))
BEGIN
  CREATE TABLE HechoVuelo
  (
    id INT NOT NULL,
    Fecha_id INT,
    origen INT,
    destino INT,
    Caracteristicas_id INT,
    vuelos INT,
    sillas INT,
    carga_ofrecida INT,
    pasajeros INT,
    carga_bordo INT,
    PRIMARY KEY(id)
  )
END;

IF (NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Geografia'))
BEGIN
  CREATE TABLE Geografia
  (
    id BIGINT NOT NULL UNIQUE,
    gcd_municipio INT NOT NULL,
    municipio VARCHAR(100),
    gcd_departamento INT,
    departamento VARCHAR(100),
    PRIMARY KEY(id)
  )
END;

IF (NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Aeropuerto'))
BEGIN
  CREATE TABLE Aeropuerto
  (
    id INT NOT NULL,
    sigla VARCHAR(3) NOT NULL,
    iata VARCHAR(3),
    nombre VARCHAR(100),
    latitud FLOAT,
    longitud FLOAT,
    propietario VARCHAR(100),
    explotador VARCHAR(100),
    longitud_pista INT,
    ancho_pista INT,
    pbmo INT,
    elevacion INT,
    resolucion BIGINT,
    fecha_construccion DATE,
    fecha_vigencia DATE,
    clase VARCHAR(2),
    tipo VARCHAR(100),
    numero_vuelos_origen BIGINT,
    Geografia_id BIGINT,
    Categoria_id INT,
    anoInicio INT,
    anoFin INT,
    flagActual INT,
    PRIMARY KEY(id)
  )
END;

IF (NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'GeografiaFecha'))
BEGIN
  CREATE TABLE GeografiaFecha
  (
    id INT NOT NULL,
    Fecha_id INT,
    Geografia_id BIGINT,
    PRIMARY KEY(id)
  )
END;

IF (NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'IndicadorPobreza'))
BEGIN
  CREATE TABLE IndicadorPobreza
  (
    id INT NOT NULL,
    indicador VARCHAR(100),
    PRIMARY KEY(id)
  )
END;

IF (NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'HechoIndicadorPobreza'))
BEGIN
  CREATE TABLE HechoIndicadorPobreza
  (
    id INT NOT NULL,
    GeografiaFecha_id INT,
    IndicadorPobreza_id INT,
    valor FLOAT,
    PRIMARY KEY(id)
  )
END;


-- Create FKs
ALTER TABLE HechoVuelo
    ADD    FOREIGN KEY (Fecha_id)
    REFERENCES Fecha(id)
;
    
ALTER TABLE HechoCobertura
    ADD    FOREIGN KEY (FechaReporteCobertura)
    REFERENCES Fecha(id)
;
    
ALTER TABLE HechoCobertura
    ADD    FOREIGN KEY (CentroPoblado_id)
    REFERENCES CentroPoblado(id)
;
    
ALTER TABLE Aeropuerto
    ADD    FOREIGN KEY (Categoria_id)
    REFERENCES Categoria(id)
;
    
ALTER TABLE HechoCobertura
    ADD    FOREIGN KEY (TipoCobertura)
    REFERENCES Categoria(id)
;
    
ALTER TABLE HechoCobertura
    ADD    FOREIGN KEY (AeropuertoMasCercano)
    REFERENCES Aeropuerto(id)
;
    
ALTER TABLE HechoVuelo
    ADD    FOREIGN KEY (Caracteristicas_id)
    REFERENCES Caracteristicas(id)
;
    
ALTER TABLE HechoVuelo
    ADD    FOREIGN KEY (origen)
    REFERENCES Aeropuerto(id)
;
    
ALTER TABLE HechoVuelo
    ADD    FOREIGN KEY (destino)
    REFERENCES Aeropuerto(id)
;
    
ALTER TABLE Aeropuerto
    ADD    FOREIGN KEY (Geografia_id)
    REFERENCES Geografia(id)
;
    
ALTER TABLE GeografiaFecha
    ADD    FOREIGN KEY (Fecha_id)
    REFERENCES Fecha(id)
;
    
ALTER TABLE HechoIndicadorPobreza
    ADD    FOREIGN KEY (GeografiaFecha_id)
    REFERENCES GeografiaFecha(id)
;
    
ALTER TABLE HechoIndicadorPobreza
    ADD    FOREIGN KEY (IndicadorPobreza_id)
    REFERENCES IndicadorPobreza(id)
;
    
ALTER TABLE GeografiaFecha
    ADD    FOREIGN KEY (Geografia_id)
    REFERENCES Geografia(id)
;
    
