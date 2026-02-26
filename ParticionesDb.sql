/*
Se particiona por año de la fecha, porque la tabla de citas normalmente se consulta por dia, mes o año.
cuando haya muchas citas, buscar por fechas puede ser mas rapido
*/

CREATE TABLE cita_particionada (
    cita_id VARCHAR(10) NOT NULL,
    fecha DATE NOT NULL,
    diagnostico VARCHAR(200),
    paciente_id VARCHAR(10) NOT NULL,
    medico_id VARCHAR(10) NOT NULL,
    sede_id INT NOT NULL,
    PRIMARY KEY (cita_id, fecha)
)
PARTITION BY RANGE (YEAR(fecha)) (
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION p2026 VALUES LESS THAN (2027),
    PARTITION p_futuro VALUES LESS THAN MAXVALUE
);

INSERT INTO cita_particionada (cita_id, fecha, diagnostico, paciente_id, medico_id, sede_id)
SELECT
    cita_id,
    fecha,
    diagnostico,
    paciente_id,
    medico_id,
    sede_id
FROM cita;