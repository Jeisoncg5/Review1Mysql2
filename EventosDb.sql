DELIMITER $$

CREATE EVENT ev_actualizar_informe_citas
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP + INTERVAL 1 DAY
DO
BEGIN
    DELETE FROM informe_citas_diario;

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
END$$

DELIMITER ;