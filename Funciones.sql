-- FUNCIONES BAES DE DATOS CLINICA 
-- REVIEW 1 Mysql 2
-- Jeison Cristancho


-- Numero de doctores por especialidad (Cuenta con manejo de errores ..Mirar Registro..)

DROP FUNCTION IF EXISTS fn_num_doctores_por_especialidad//
CREATE FUNCTION fn_num_doctores_por_especialidad(p_especialidad VARCHAR(120))
RETURNS INT
DETERMINISTIC
BEGIN
  DECLARE total INT DEFAULT 0;
  DECLARE v_errno INT DEFAULT 0;
  DECLARE v_msg TEXT;

  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    GET DIAGNOSTICS CONDITION 1 v_errno = MYSQL_ERRNO, v_msg = MESSAGE_TEXT;
    INSERT INTO error_log(objeto_tipo, objeto_nombre, tabla_nombre, codigo_error, mensaje)
    VALUES ('FUNCTION','fn_num_doctores_por_especialidad','medico/especialidad', v_errno, v_msg);
    RETURN -1;
  END;

  SELECT COUNT(*) INTO total
  FROM medico m
  JOIN especialidad e ON e.especialidad_id = m.especialidad_id
  WHERE e.nombre = p_especialidad;

  RETURN total;
END//


-- Numero de pacientes por medico (No Cuenta con manejo de errores ..Esta si esta bien.. Mirar si se puede agregar manejo de errores..)

DROP FUNCTION IF EXISTS fn_total_pacientes_por_medico//
CREATE FUNCTION fn_total_pacientes_por_medico(p_medico_id VARCHAR(10))
RETURNS INT
DETERMINISTIC
BEGIN
  DECLARE total INT DEFAULT 0;
  SELECT COUNT(DISTINCT c.paciente_id) INTO total
  FROM cita c
  WHERE c.medico_id = p_medico_id;
  RETURN total;
END//

-- Numero de pacientes por sede (No Cuenta con manejo de errores ..Esta Tambien esta bien.. Mirar Despues si se puede agregar manejo de errores..)


DROP FUNCTION IF EXISTS fn_total_pacientes_por_sede//
CREATE FUNCTION fn_total_pacientes_por_sede(p_sede VARCHAR(120))
RETURNS INT
DETERMINISTIC
BEGIN
  DECLARE total INT DEFAULT 0;
  SELECT COUNT(DISTINCT c.paciente_id) INTO total
  FROM cita c
  JOIN sede s ON s.sede_id = c.sede_id
  WHERE s.nombre = p_sede;
  RETURN total;
END//