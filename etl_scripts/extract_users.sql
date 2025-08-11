SELECT 
    u.id AS raw_glpi_user_id,
    u.name AS raw_username,
    u.realname AS raw_lastname,    -- Asumiendo 'realname' es apellido
    u.firstname AS raw_firstname,
    ue.email AS raw_email,
    u.phone AS raw_phone,
    u.mobile AS raw_mobile,
    u.is_active AS raw_is_active,
    u.comment AS raw_comment -- Ejemplo, si quieres migrar comentarios o notas
FROM 
    db_glpi.glpi_users u
LEFT JOIN 
    db_glpi.glpi_useremails ue ON ue.users_id = u.id AND ue.is_default = 1
WHERE u.is_deleted = 0; -- Opcional: excluir usuarios eliminados lógicamente en GLPI 