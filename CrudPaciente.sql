-- CRUD de la BASE DE DATOS CLINICA 
-- REVIEW 1 Mysql 2
-- Jeison Cristancho


-- Todos los procedimientos cuentan con manejo de errores, se captura el error y se registra en la tabla de log de errores.
-- Tabla PACIENTE (Agregar Datos) 

DROP PROCEDURE IF EXISTS sp_paciente_insertar//
CREATE PROCEDURE sp_paciente_insertar(
  IN p_paciente_id VARCHAR(10),
  IN p_nombre VARCHAR(120),
  IN p_telefono VARCHAR(30)
)
BEGIN
  DECLARE v_errno INT DEFAULT 0;
  DECLARE v_msg TEXT;

  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    GET DIAGNOSTICS CONDITION 1 v_errno = MYSQL_ERRNO, v_msg = MESSAGE_TEXT;
    CALL sp_log_error('PROCEDURE','sp_paciente_insertar','paciente', v_errno, v_msg);
    RESIGNAL;
  END;

  INSERT INTO paciente(paciente_id, nombre, telefono)
  VALUES (p_paciente_id, p_nombre, p_telefono);
END//


-- Tabla PACIENTE (Consultar Datos)

DROP PROCEDURE IF EXISTS sp_paciente_consultar//
CREATE PROCEDURE sp_paciente_consultar(IN p_paciente_id VARCHAR(10))
BEGIN
  DECLARE v_errno INT DEFAULT 0;
  DECLARE v_msg TEXT;

  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    GET DIAGNOSTICS CONDITION 1 v_errno = MYSQL_ERRNO, v_msg = MESSAGE_TEXT;
    CALL sp_log_error('PROCEDURE','sp_paciente_consultar','paciente', v_errno, v_msg);
    RESIGNAL;
  END;

  SELECT * FROM paciente WHERE paciente_id = p_paciente_id;
END//

-- Tabla PACIENTE (Actualizar Datos)

DROP PROCEDURE IF EXISTS sp_paciente_actualizar//
CREATE PROCEDURE sp_paciente_actualizar(
  IN p_paciente_id VARCHAR(10),
  IN p_nombre VARCHAR(120),
  IN p_telefono VARCHAR(30)
)
BEGIN
  DECLARE v_errno INT DEFAULT 0;
  DECLARE v_msg TEXT;

  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    GET DIAGNOSTICS CONDITION 1 v_errno = MYSQL_ERRNO, v_msg = MESSAGE_TEXT;
    CALL sp_log_error('PROCEDURE','sp_paciente_actualizar','paciente', v_errno, v_msg);
    RESIGNAL;
  END;

  UPDATE paciente
  SET nombre = p_nombre,
      telefono = p_telefono
  WHERE paciente_id = p_paciente_id;
END//

-- Tabla PACIENTE (Eliminar Datos)

DROP PROCEDURE IF EXISTS sp_paciente_eliminar//
CREATE PROCEDURE sp_paciente_eliminar(IN p_paciente_id VARCHAR(10))
BEGIN
  DECLARE v_errno INT DEFAULT 0;
  DECLARE v_msg TEXT;

  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    GET DIAGNOSTICS CONDITION 1 v_errno = MYSQL_ERRNO, v_msg = MESSAGE_TEXT;
    CALL sp_log_error('PROCEDURE','sp_paciente_eliminar','paciente', v_errno, v_msg);
    RESIGNAL;
  END;

  DELETE FROM paciente WHERE paciente_id = p_paciente_id;
END//