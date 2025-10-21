SELECT
    gc.id                             AS raw_computer_id,
    s.id                              AS raw_sw_id,
    sv.id                             AS raw_swver_id,
    s.name                            AS raw_sw_nombre,
    sv.name                           AS raw_version,
    CAST(isv.date_install AS CHAR) AS raw_fecha_instalacion,
    isv.is_deleted                    AS raw_isv_deleted,
    'GLPI_Computer_Software'          AS etl_source_system,
    NOW()                             AS etl_load_date
FROM glpi_items_softwareversions isv
JOIN glpi_softwareversions sv ON sv.id = isv.softwareversions_id
JOIN glpi_softwares s ON s.id = sv.softwares_id
JOIN glpi_computers gc ON isv.items_id = gc.id AND isv.itemtype = 'Computer'
WHERE isv.is_deleted = 0 AND gc.is_deleted = 0 AND s.is_deleted = 0;


