SELECT
    s.id                         AS raw_sw_id,
    s.name                       AS raw_sw_nombre,
    man.name                     AS raw_fabricante,
    cat.name                     AS raw_categoria,
    s.is_valid                   AS raw_es_valido,
    CAST(s.date_mod AS CHAR)     AS raw_fecha_mod,
    CAST(s.date_creation AS CHAR)AS raw_fecha_creacion,
    'GLPI_Softwares'             AS etl_source_system,
    NOW()                        AS etl_load_date
FROM glpi_softwares s
LEFT JOIN glpi_manufacturers man ON s.manufacturers_id = man.id
LEFT JOIN glpi_softwarecategories cat ON s.softwarecategories_id = cat.id
WHERE s.is_deleted = 0;















