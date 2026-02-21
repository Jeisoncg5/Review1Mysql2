-- REVIEW 1 Mysql 2
-- Jeison Cristancho

-- Todos los procedimientos cuentan con manejo de errores, se captura el error y se registra en la tabla de log de errores.
-- Tabla CITA_MEDICAMENTO (Agregar Datos)

DROP PROCEDURE IF EXISTS sp_cita_medicamento_insertar//
CREATE PROCEDURE sp_cita_medicamento_insertar(
  IN p_cita_id VARCHAR(10),
  IN p_medicamento_id INT,
  IN p_dosis VARCHAR(50)
)
BEGIN
  DECLARE v_errno INT DEFAULT 0;
  DECLARE v_msg TEXT;

  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    GET DIAGNOSTICS CONDITION 1 v_errno = MYSQL_ERRNO, v_msg = MESSAGE_TEXT;
    CALL sp_log_error('PROCEDURE','sp_cita_medicamento_insertar','cita_medicamento', v_errno, v_msg);
    RESIGNAL;
  END;

  INSERT INTO cita_medicamento(cita_id, medicamento_id, dosis)
  VALUES (p_cita_id, p_medicamento_id, p_dosis);
END//

-- Tabla CITA_MEDICAMENTO (Consultar Datos)

DROP PROCEDURE IF EXISTS sp_cita_medicamento_actualizar//
CREATE PROCEDURE sp_cita_medicamento_actualizar(
  IN p_cita_id VARCHAR(10),
  IN p_medicamento_id INT,
  IN p_dosis VARCHAR(50)
)
BEGIN
  DECLARE v_errno INT DEFAULT 0;
  DECLARE v_msg TEXT;

  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    GET DIAGNOSTICS CONDITION 1 v_errno = MYSQL_ERRNO, v_msg = MESSAGE_TEXT;
    CALL sp_log_error('PROCEDURE','sp_cita_medicamento_actualizar','cita_medicamento', v_errno, v_msg);
    RESIGNAL;
  END;

  UPDATE cita_medicamento
  SET dosis = p_dosis
  WHERE cita_id = p_cita_id AND medicamento_id = p_medicamento_id;
END//

-- Tabla CITA_MEDICAMENTO (Eliminar Datos)

DROP PROCEDURE IF EXISTS sp_cita_medicamento_eliminar//
CREATE PROCEDURE sp_cita_medicamento_eliminar(
  IN p_cita_id VARCHAR(10),
  IN p_medicamento_id INT
)
BEGIN
  DECLARE v_errno INT DEFAULT 0;
  DECLARE v_msg TEXT;

  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    GET DIAGNOSTICS CONDITION 1 v_errno = MYSQL_ERRNO, v_msg = MESSAGE_TEXT;
    CALL sp_log_error('PROCEDURE','sp_cita_medicamento_eliminar','cita_medicamento', v_errno, v_msg);
    RESIGNAL;
  END;

  DELETE FROM cita_medicamento
  WHERE cita_id = p_cita_id AND medicamento_id = p_medicamento_id;
END//

DELIMITER ;