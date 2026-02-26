-- REVIEW 1 Mysql 2
-- Jeison Cristancho


-- Base de Datos asi mismo Inputs

DROP DATABASE IF EXISTS clinica;
CREATE DATABASE clinica;
USE clinica;

CREATE TABLE paciente (
  paciente_id VARCHAR(10) PRIMARY KEY,
  nombre VARCHAR(120) NOT NULL,
  telefono VARCHAR(30)
);

CREATE TABLE facultad (
  facultad_id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(120) NOT NULL UNIQUE,
  decano VARCHAR(120)
);

CREATE TABLE especialidad (
  especialidad_id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(120) NOT NULL UNIQUE
);

CREATE TABLE sede (
  sede_id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(120) NOT NULL UNIQUE,
  direccion VARCHAR(200)
);

CREATE TABLE medico (
  medico_id VARCHAR(10) PRIMARY KEY,
  nombre VARCHAR(120) NOT NULL,
  especialidad_id INT NOT NULL,
  facultad_id INT NOT NULL,
  FOREIGN KEY (especialidad_id) REFERENCES especialidad(especialidad_id),
  FOREIGN KEY (facultad_id) REFERENCES facultad(facultad_id)
);

CREATE TABLE cita (
  cita_id VARCHAR(10) PRIMARY KEY,
  fecha DATE NOT NULL,
  diagnostico VARCHAR(200),
  paciente_id VARCHAR(10) NOT NULL,
  medico_id VARCHAR(10) NOT NULL,
  sede_id INT NOT NULL,
  FOREIGN KEY (paciente_id) REFERENCES paciente(paciente_id),
  FOREIGN KEY (medico_id) REFERENCES medico(medico_id),
  FOREIGN KEY (sede_id) REFERENCES sede(sede_id)
);

CREATE TABLE medicamento (
  medicamento_id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(120) NOT NULL UNIQUE
);

CREATE TABLE cita_medicamento (
  cita_id VARCHAR(10) NOT NULL,
  medicamento_id INT NOT NULL,
  dosis VARCHAR(50),
  PRIMARY KEY (cita_id, medicamento_id),
  FOREIGN KEY (cita_id) REFERENCES cita(cita_id),
  FOREIGN KEY (medicamento_id) REFERENCES medicamento(medicamento_id)
);


INSERT INTO informe_citas_diario (fecha_cita, sede, medico, total_pacientes)
SELECT 
    c.fecha,
    s.nombre AS sede,
    m.nombre AS medico,
    COUNT(DISTINCT c.paciente_id) AS total_pacientes
FROM cita c
INNER JOIN sede s ON c.sede_id = s.sede_id
INNER JOIN medico m ON c.medico_id = m.medico_id
GROUP BY c.fecha, s.nombre, m.nombre;


-- --------------------------------------------------
-- Tabla para almacenar informes de citas diarias ---
-- --------------------------------------------------

CREATE TABLE informe_citas_diario (
    informe_id INT AUTO_INCREMENT PRIMARY KEY,
    fecha_cita DATE NOT NULL,
    sede VARCHAR(120) NOT NULL,
    medico VARCHAR(120) NOT NULL,
    total_pacientes INT NOT NULL,
    fecha_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP
);


INSERT INTO facultad (facultad_id, nombre, decano) VALUES (1, 'Medicina', 'Dr. Wilson');
INSERT INTO facultad (facultad_id, nombre, decano) VALUES (2, 'Ciencias', 'Dr. Palmer');

INSERT INTO especialidad (especialidad_id, nombre) VALUES (1, 'Infectología');
INSERT INTO especialidad (especialidad_id, nombre) VALUES (2, 'Cardiología');
INSERT INTO especialidad (especialidad_id, nombre) VALUES (3, 'Neurocirugía');

INSERT INTO sede (sede_id, nombre, direccion) VALUES (1, 'Centro Médico', 'Calle 5 #10');
INSERT INTO sede (sede_id, nombre, direccion) VALUES (2, 'Clínica Norte', 'Av. Libertador');

INSERT INTO medicamento (medicamento_id, nombre) VALUES (1, 'Paracetamol');
INSERT INTO medicamento (medicamento_id, nombre) VALUES (2, 'Ibuprofeno');
INSERT INTO medicamento (medicamento_id, nombre) VALUES (3, 'Amoxicilina');
INSERT INTO medicamento (medicamento_id, nombre) VALUES (4, 'Aspirina');
INSERT INTO medicamento (medicamento_id, nombre) VALUES (5, 'Ergotamina');

INSERT INTO paciente (paciente_id, nombre, telefono) VALUES ('P-501', 'Juan Rivas', '600-111');
INSERT INTO paciente (paciente_id, nombre, telefono) VALUES ('P-502', 'Ana Soto', '600-222');
INSERT INTO paciente (paciente_id, nombre, telefono) VALUES ('P-503', 'Luis Paz', '600-333');

INSERT INTO medico (medico_id, nombre, especialidad_id, facultad_id) VALUES ('M-10', 'Dr. House', 1, 1);
INSERT INTO medico (medico_id, nombre, especialidad_id, facultad_id) VALUES ('M-22', 'Dra. Grey', 2, 1);
INSERT INTO medico (medico_id, nombre, especialidad_id, facultad_id) VALUES ('M-30', 'Dr. Strange', 3, 2);

INSERT INTO cita (cita_id, fecha, diagnostico, paciente_id, medico_id, sede_id) VALUES ('C-001', '2024-05-10', 'Gripe Fuerte', 'P-501', 'M-10', 1);
INSERT INTO cita (cita_id, fecha, diagnostico, paciente_id, medico_id, sede_id) VALUES ('C-002', '2024-05-11', 'Infección', 'P-502', 'M-10', 1);
INSERT INTO cita (cita_id, fecha, diagnostico, paciente_id, medico_id, sede_id) VALUES ('C-003', '2024-05-12', 'Arritmia', 'P-501', 'M-22', 2);
INSERT INTO cita (cita_id, fecha, diagnostico, paciente_id, medico_id, sede_id) VALUES ('C-004', '2024-05-15', 'Migraña', 'P-503', 'M-30', 2);

INSERT INTO cita_medicamento (cita_id, medicamento_id, dosis) VALUES ('C-001', 1, '500mg');
INSERT INTO cita_medicamento (cita_id, medicamento_id, dosis) VALUES ('C-001', 2, '400mg');
INSERT INTO cita_medicamento (cita_id, medicamento_id, dosis) VALUES ('C-002', 3, '875mg');
INSERT INTO cita_medicamento (cita_id, medicamento_id, dosis) VALUES ('C-003', 4, '100mg');
INSERT INTO cita_medicamento (cita_id, medicamento_id, dosis) VALUES ('C-004', 5, '1mg');