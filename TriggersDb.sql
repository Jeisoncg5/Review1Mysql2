--  Validar pacient

CREATE TRIGGER trg_validar_paciente_insert
BEFORE INSERT ON paciente
FOR EACH ROW
BEGIN
    IF NEW.nombre IS NULL OR TRIM(NEW.nombre) = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El nombre del paciente no puede estar vacio';
    END IF;

    IF NEW.telefono IS NULL OR TRIM(NEW.telefono) = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El telefono del paciente no puede estar vacio';
    END IF;
END$$

-- Validar paciente al actualizar

CREATE TRIGGER trg_validar_paciente_update
BEFORE UPDATE ON paciente
FOR EACH ROW
BEGIN
    IF NEW.nombre IS NULL OR TRIM(NEW.nombre) = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El nombre del paciente no puede estar vacio';
    END IF;

    IF NEW.telefono IS NULL OR TRIM(NEW.telefono) = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El telefono del paciente no puede estar vacio';
    END IF;
END$$


-- Validar que la fecha de la cita no sea futura al insertar 

CREATE TRIGGER trg_validar_cita_insert
BEFORE INSERT ON cita
FOR EACH ROW
BEGIN
    IF NEW.fecha > CURDATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La fecha de la cita no puede ser futura';
    END IF;
END$$



-- Validar que la fecha de la cita no sea futura al actualizar

CREATE TRIGGER trg_validar_cita_update
BEFORE UPDATE ON cita
FOR EACH ROW
BEGIN
    IF NEW.fecha > CURDATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La fecha de la cita no puede ser futura';
    END IF;
END$$

DELIMITER ;