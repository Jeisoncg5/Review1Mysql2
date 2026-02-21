-- REVIEW 1 Mysql 2
-- Jeison Cristancho

-- Todos los procedimientos cuentan con manejo de errores, se captura el error y se registra en la tabla de log de errores.
-- Tabla CITA (Agregar Datos)

DROP PROCEDURE IF EXISTS sp_cita_insertar//
CREATE PROCEDURE sp_cita_insertar(
  IN p_cita_id VARCHAR(10),
  IN p_fecha DATE,
  IN p_diagnostico VARCHAR(200),
  IN p_paciente_id VARCHAR(10),
  IN p_medico_id VARCHAR(10),
  IN p_sede_id INT
)
BEGIN
  DECLARE v_errno INT DEFAULT 0;
  DECLARE v_msg TEXT;

  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    GET DIAGNOSTICS CONDITION 1 v_errno = MYSQL_ERRNO, v_msg = MESSAGE_TEXT;
    CALL sp_log_error('PROCEDURE','sp_cita_insertar','cita', v_errno, v_msg);
    RESIGNAL;
  END;

  INSERT INTO cita(cita_id, fecha, diagnostico, paciente_id, medico_id, sede_id)
  VALUES (p_cita_id, p_fecha, p_diagnostico, p_paciente_id, p_medico_id, p_sede_id);
END//

-- Tabla CITA (Consultar Datos)

DROP PROCEDURE IF EXISTS sp_cita_consultar//
CREATE PROCEDURE sp_cita_consultar(IN p_cita_id VARCHAR(10))
BEGIN
  DECLARE v_errno INT DEFAULT 0;
  DECLARE v_msg TEXT;

  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    GET DIAGNOSTICS CONDITION 1 v_errno = MYSQL_ERRNO, v_msg = MESSAGE_TEXT;
    CALL sp_log_error('PROCEDURE','sp_cita_consultar','cita', v_errno, v_msg);
    RESIGNAL;
  END;

  SELECT * FROM cita WHERE cita_id = p_cita_id;
END//


-- Tabla CITA (Actualizar Datos)

DROP PROCEDURE IF EXISTS sp_cita_actualizar//
CREATE PROCEDURE sp_cita_actualizar(
  IN p_cita_id VARCHAR(10),
  IN p_fecha DATE,
  IN p_diagnostico VARCHAR(200),
  IN p_paciente_id VARCHAR(10),
  IN p_medico_id VARCHAR(10),
  IN p_sede_id INT
)
BEGIN
  DECLARE v_errno INT DEFAULT 0;
  DECLARE v_msg TEXT;

  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    GET DIAGNOSTICS CONDITION 1 v_errno = MYSQL_ERRNO, v_msg = MESSAGE_TEXT;
    CALL sp_log_error('PROCEDURE','sp_cita_actualizar','cita', v_errno, v_msg);
    RESIGNAL;
  END;

  UPDATE cita
  SET fecha = p_fecha,
      diagnostico = p_diagnostico,
      paciente_id = p_paciente_id,
      medico_id = p_medico_id,
      sede_id = p_sede_id
  WHERE cita_id = p_cita_id;
END//

-- Tabla CITA (Eliminar Datos)

DROP PROCEDURE IF EXISTS sp_cita_eliminar//
CREATE PROCEDURE sp_cita_eliminar(IN p_cita_id VARCHAR(10))
BEGIN
  DECLARE v_errno INT DEFAULT 0;
  DECLARE v_msg TEXT;

  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    GET DIAGNOSTICS CONDITION 1 v_errno = MYSQL_ERRNO, v_msg = MESSAGE_TEXT;
    CALL sp_log_error('PROCEDURE','sp_cita_eliminar','cita', v_errno, v_msg);
    RESIGNAL;
  END;

  DELETE FROM cita WHERE cita_id = p_cita_id;
END//
