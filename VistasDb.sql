
-- medico, facultad y especialidad

CREATE VIEW vw_medico_facultad_especialidad AS
SELECT
    m.medico_id,
    m.nombre AS medico,
    f.nombre AS facultad,
    e.nombre AS especialidad
FROM medico m
INNER JOIN facultad f
    ON m.facultad_id = f.facultad_id
INNER JOIN especialidad e
    ON m.especialidad_id = e.especialidad_id;

-- numero de pacientes por medicamento 

CREATE VIEW vw_pacientes_por_medicamento AS
SELECT
    md.medicamento_id,
    md.nombre AS medicamento,
    COUNT(DISTINCT c.paciente_id) AS numero_pacientes
FROM medicamento md
INNER JOIN cita_medicamento cm
    ON md.medicamento_id = cm.medicamento_id
INNER JOIN cita c
    ON cm.cita_id = c.cita_id
GROUP BY md.medicamento_id, md.nombre;
