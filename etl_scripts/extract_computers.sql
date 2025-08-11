SELECT
    -- Campos directos de glpi_computers (gc)
    CAST(gc.id AS CHAR) AS raw_glpi_id,
    gc.uuid AS raw_glpi_uuid,
    gc.name AS raw_nombre_activo,
    gc.serial AS raw_numero_serie,
    gc.otherserial AS raw_otro_numero_serie,
    CASE 
        WHEN gc.name LIKE 'EFPM%' OR gc.name LIKE 'eFpm%'THEN 'FONDO DE PRESTACIONES'
        WHEN gc.name LIKE 'ESALA%' OR gc.name LIKE '%DESPACHO%'THEN 'DESPACHO'
        WHEN gc.name LIKE 'EFINANCIERA%' THEN 'FINANCIERA'
        WHEN gc.name LIKE '%COBERTURA%'  THEN 'COBERTURA'
        WHEN gc.name LIKE '%ESCALAFON%' THEN 'ESCALAFON'
        WHEN gc.name LIKE '%CALIDAD%' THEN 'CALIDAD EDUCATIVA'
        WHEN gc.name LIKE '%SAC%' OR gc.name  THEN 'SAC'
        WHEN gc.name LIKE '%PLANEACION%' OR gc.name  THEN 'PLANEACIÓN'
        WHEN gc.name LIKE '%JURIDICA%' THEN 'JURIDICA'
        WHEN gc.name LIKE '%ALMACEN%' THEN 'ALMACEN'
        WHEN gc.name LIKE '%EUDAG%' THEN 'UDAG'
        WHEN gc.name LIKE '%EGESDOCU%' THEN 'GESTIÓN DOCUMENTAL'
        WHEN gc.name LIKE '%ETALENTOH%' THEN 'TALENTO HUMANO'
        WHEN gc.name LIKE '%EINSPECCION%' THEN 'INSPECCIÓN Y VIGILANCIA'
        WHEN gc.name LIKE '%NOMINA%' THEN 'NOMINA EDUCACIÓN'
        WHEN gc.name LIKE 'EHOJAVIDA%' OR gc.name LIKE 'EHLABORALES%'  THEN 'HISTORIAS LABORALES'
        WHEN gc.name LIKE '%EUDAG%' OR gc.name LIKE 'EUNIDADES%' THEN 'UDAG'
        WHEN gc.name LIKE '%EADMTIVA%'  THEN 'ADMINISTRATIVA Y FINANCIERA'
        WHEN gc.name LIKE '%EBSST%'  THEN 'BIENESTAR SEGURIDAD Y SALUD EN EN EL TRABAJO'
        WHEN gc.name LIKE '%SISE%' OR gc.name LIKE '%KALI%' OR  gc.name LIKE '%LAPTOP%' OR gc.name LIKE '%DESKTOP%' OR gc.name LIKE '%DOCKER%' THEN 'SERVICIOS INFORMÁTICOS DEL SECTOR EDUCATIVO'
        WHEN gc.name LIKE '%EPAE%'  THEN 'PAE'
        ELSE gc.name
    END AS raw_comentario,
    CAST(gc.date_mod AS CHAR) AS raw_fecha_modificacion_glpi,
    CAST(gc.date_creation AS CHAR) AS raw_fecha_creacion_glpi,
    gc.contact AS raw_contacto_nombre,
    gc.contact_num AS raw_contacto_numero,
    gc.ticket_tco AS raw_ticket_tco,
    CAST(gc.last_inventory_update AS CHAR) AS raw_ultima_actualizacion_inventario,
    CAST(gc.last_boot AS CHAR) AS raw_ultimo_arranque,
    gc.is_dynamic AS raw_es_inventario_dinamico,

    -- Entidad
    CAST(gc.entities_id AS CHAR) AS raw_glpi_entities_id,
    ent.completename AS raw_entidad_nombre_completo,
    gc.is_recursive AS raw_entidad_es_recursiva,

    -- Fabricante
    man.name AS raw_fabricante_nombre,

    -- Modelo
    modc.name AS raw_modelo_nombre,
    modc.product_number AS raw_modelo_numero_producto,
    modc.weight AS raw_modelo_peso,
    modc.required_units AS raw_modelo_unidades_rack,

    -- Tipo de Computadora
    ct.name AS raw_tipo_computadora_nombre,

    -- Estado del Activo en GLPI
    st.name AS raw_estado_glpi_nombre,

    -- Ubicación
    loc.completename AS raw_ubicacion_nombre_completo,

    -- Usuario Técnico Asignado
    CAST(ut.id AS CHAR) AS raw_usuario_tecnico_glpi_id,
    ut.name AS raw_usuario_tecnico_username_glpi,
    ut.firstname AS raw_usuario_tecnico_nombre,
    ut.realname AS raw_usuario_tecnico_apellido,
    ute.email AS raw_usuario_tecnico_email,

    -- Grupo Técnico Asignado
    CAST(gt.id AS CHAR) AS raw_grupo_tecnico_glpi_id,
    gt.completename AS raw_grupo_tecnico_nombre_completo,

    -- Usuario Principal Asignado
    CAST(u.id AS CHAR) AS raw_usuario_principal_glpi_id,
    u.name AS raw_usuario_principal_username_glpi,
    u.firstname AS raw_usuario_principal_nombre,
    u.realname AS raw_usuario_principal_apellido,
    ue.email AS raw_usuario_principal_email,

    -- Grupo Principal Asignado
    CAST(g.id AS CHAR) AS raw_grupo_principal_glpi_id,
    g.completename AS raw_grupo_principal_nombre_completo,

    -- Sistema Operativo
    os.name AS raw_sistema_operativo_nombre,
    osv.name AS raw_sistema_operativo_version,
    osa.name AS raw_sistema_operativo_arquitectura,
    osk.name AS raw_sistema_operativo_kernel,
    ose.name AS raw_sistema_operativo_edicion,
    CAST(ios.install_date AS CHAR) AS raw_so_fecha_instalacion,
    ios.license_number AS raw_so_numero_licencia,
    ios.licenseid AS raw_so_id_licencia,

    -- Red (Subconsultas para IP y MAC principales)
    (SELECT ipa.name 
     FROM glpi_networkports np
     JOIN glpi_ipaddresses ipa ON np.id = ipa.items_id AND ipa.itemtype = 'NetworkPort'
     WHERE np.items_id = gc.id AND np.itemtype = 'Computer' AND np.is_deleted = 0 AND ipa.is_deleted = 0
     ORDER BY np.id, ipa.id 
     LIMIT 1
    ) AS raw_ip_principal,
    (SELECT np.mac FROM glpi_networkports np WHERE np.items_id = gc.id AND np.itemtype = 'Computer' AND np.is_deleted = 0 ORDER BY np.id LIMIT 1) AS raw_mac_principal,

    -- Detalles de Hardware (Subconsultas para RAM y Disco)
    (SELECT CAST(SUM(idm.size) AS CHAR) FROM glpi_items_devicememories idm WHERE idm.items_id = gc.id AND idm.itemtype = 'Computer' AND idm.is_deleted = 0) AS raw_ram_total_mb,
    (SELECT CAST(SUM(idh.capacity) AS CHAR) FROM glpi_items_deviceharddrives idh WHERE idh.items_id = gc.id AND idh.itemtype = 'Computer' AND idh.is_deleted = 0) AS raw_disco_total_gb,

    -- Información Financiera (Infocoms)
    info.buy_date AS raw_infocom_fecha_compra,
    info.use_date AS raw_infocom_fecha_puesta_uso,
    info.warranty_duration AS raw_infocom_duracion_garantia,
    info.warranty_info AS raw_infocom_info_garantia,
    CAST(sup.id AS CHAR) AS raw_infocom_proveedor_glpi_id,
    sup.name AS raw_infocom_proveedor_nombre,
    info.order_number AS raw_infocom_numero_pedido,
    info.delivery_number AS raw_infocom_numero_entrega,
    info.immo_number AS raw_infocom_numero_immo,
    info.value AS raw_infocom_valor,
    info.warranty_value AS raw_infocom_valor_garantia,
    CAST(bud.id AS CHAR) AS raw_infocom_presupuesto_glpi_id,
    bud.name AS raw_infocom_presupuesto_nombre,
    info.order_date AS raw_infocom_fecha_pedido,
    info.delivery_date AS raw_infocom_fecha_entrega,
    info.inventory_date AS raw_infocom_fecha_inventario_fisico,
    info.warranty_date AS raw_infocom_fecha_fin_garantia,
    info.decommission_date AS raw_infocom_fecha_baja,

    -- Autoupdate System
    aus.name AS raw_sistema_actualizacion_auto_nombre,

    -- GLPI Agent Info (si aplica)
    agent.name AS raw_agente_glpi_nombre,
    agent.version AS raw_agente_glpi_version,
    CAST(agent.last_contact AS CHAR) AS raw_agente_glpi_ultimo_contacto,

    -- URL de referencia a GLPI
    CONCAT('http://172.19.0.214/glpi/front/computer.form.php?id=', gc.id) AS raw_glpi_url_referencia,
    
    'GLPI_Computers' AS etl_source_system,
    NOW() AS etl_load_date
FROM
    glpi_computers gc
LEFT JOIN
    glpi_entities ent ON gc.entities_id = ent.id
LEFT JOIN
    glpi_manufacturers man ON gc.manufacturers_id = man.id
LEFT JOIN
    glpi_computermodels modc ON gc.computermodels_id = modc.id
LEFT JOIN
    glpi_computertypes ct ON gc.computertypes_id = ct.id
LEFT JOIN
    glpi_states st ON gc.states_id = st.id
LEFT JOIN
    glpi_locations loc ON gc.locations_id = loc.id
LEFT JOIN
    glpi_users ut ON gc.users_id_tech = ut.id
LEFT JOIN
    glpi_useremails ute ON ut.id = ute.users_id AND ute.is_default = 1
LEFT JOIN
    glpi_groups gt ON gc.groups_id_tech = gt.id
LEFT JOIN
    glpi_users u ON gc.users_id = u.id
LEFT JOIN
    glpi_useremails ue ON u.id = ue.users_id AND ue.is_default = 1
LEFT JOIN
    glpi_groups g ON gc.groups_id = g.id
LEFT JOIN
    glpi_items_operatingsystems ios ON ios.items_id = gc.id AND ios.itemtype = 'Computer' AND ios.is_deleted = 0
LEFT JOIN
    glpi_operatingsystems os ON ios.operatingsystems_id = os.id
LEFT JOIN
    glpi_operatingsystemversions osv ON ios.operatingsystemversions_id = osv.id
LEFT JOIN
    glpi_operatingsystemarchitectures osa ON ios.operatingsystemarchitectures_id = osa.id
LEFT JOIN
    glpi_operatingsystemkernelversions osk ON ios.operatingsystemkernelversions_id = osk.id
LEFT JOIN
    glpi_operatingsystemeditions ose ON ios.operatingsystemeditions_id = ose.id
LEFT JOIN
    glpi_infocoms info ON info.items_id = gc.id AND info.itemtype = 'Computer'
LEFT JOIN
    glpi_suppliers sup ON info.suppliers_id = sup.id
LEFT JOIN
    glpi_budgets bud ON info.budgets_id = bud.id
LEFT JOIN
    glpi_autoupdatesystems aus ON gc.autoupdatesystems_id = aus.id
LEFT JOIN
    glpi_agents agent ON agent.items_id = gc.id AND agent.itemtype = 'Computer'
WHERE
    gc.is_deleted = 0