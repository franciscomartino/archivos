
-- Create tables
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