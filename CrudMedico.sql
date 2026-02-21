-- REVIEW 1 Mysql 2
-- Jeison Cristancho

-- Todos los procedimientos cuentan con manejo de errores, se captura el error y se registra en la tabla de log de errores.


-- Tabla MEDICO (Agregar Datos)
DROP PROCEDURE IF EXISTS sp_medico_insertar//
CREATE PROCEDURE sp_medico_insertar(
  IN p_medico_id VARCHAR(10),
  IN p_nombre VARCHAR(120),
  IN p_especialidad_id INT,
  IN p_facultad_id INT
)
BEGIN
  DECLARE v_errno INT DEFAULT 0;
  DECLARE v_msg TEXT;

  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    GET DIAGNOSTICS CONDITION 1 v_errno = MYSQL_ERRNO, v_msg = MESSAGE_TEXT;
    CALL sp_log_error('PROCEDURE','sp_medico_insertar','medico', v_errno, v_msg);
    RESIGNAL;
  END;

  INSERT INTO medico(medico_id, nombre, especialidad_id, facultad_id)
  VALUES (p_medico_id, p_nombre, p_especialidad_id, p_facultad_id);
END//


-- Tabla MEDICO (Consultar Datos)

DROP PROCEDURE IF EXISTS sp_medico_consultar//
CREATE PROCEDURE sp_medico_consultar(IN p_medico_id VARCHAR(10))
BEGIN
  DECLARE v_errno INT DEFAULT 0;
  DECLARE v_msg TEXT;

  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    GET DIAGNOSTICS CONDITION 1 v_errno = MYSQL_ERRNO, v_msg = MESSAGE_TEXT;
    CALL sp_log_error('PROCEDURE','sp_medico_consultar','medico', v_errno, v_msg);
    RESIGNAL;
  END;

  SELECT * FROM medico WHERE medico_id = p_medico_id;
END//

-- Tabla MEDICO (Actualizar Datos)

DROP PROCEDURE IF EXISTS sp_medico_actualizar//
CREATE PROCEDURE sp_medico_actualizar(
  IN p_medico_id VARCHAR(10),
  IN p_nombre VARCHAR(120),
  IN p_especialidad_id INT,
  IN p_facultad_id INT
)
BEGIN
  DECLARE v_errno INT DEFAULT 0;
  DECLARE v_msg TEXT;

  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    GET DIAGNOSTICS CONDITION 1 v_errno = MYSQL_ERRNO, v_msg = MESSAGE_TEXT;
    CALL sp_log_error('PROCEDURE','sp_medico_actualizar','medico', v_errno, v_msg);
    RESIGNAL;
  END;

  UPDATE medico
  SET nombre = p_nombre,
      especialidad_id = p_especialidad_id,
      facultad_id = p_facultad_id
  WHERE medico_id = p_medico_id;
END//

-- Tabla MEDICO (Eliminar Datos)

DROP PROCEDURE IF EXISTS sp_medico_eliminar//
CREATE PROCEDURE sp_medico_eliminar(IN p_medico_id VARCHAR(10))
BEGIN
  DECLARE v_errno INT DEFAULT 0;
  DECLARE v_msg TEXT;

  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    GET DIAGNOSTICS CONDITION 1 v_errno = MYSQL_ERRNO, v_msg = MESSAGE_TEXT;
    CALL sp_log_error('PROCEDURE','sp_medico_eliminar','medico', v_errno, v_msg);
    RESIGNAL;
  END;

  DELETE FROM medico WHERE medico_id = p_medico_id;
END//