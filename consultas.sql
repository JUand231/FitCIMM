-- =====================================================================
-- FitCIMM - Consultas SQL (Taller de Repaso, seccion 6.1)
-- =====================================================================


-- 1. Listar cada socio con la fecha de fin de su membresia mas reciente y los dias que le restan.
--    (si el socio nunca ha comprado un plan, esas columnas salen en NULL)
SELECT
    s.documento,
    s.nombres,
    s.apellidos,
    mm.fecha_fin            AS fecha_fin_membresia,
    DATEDIFF(mm.fecha_fin, CURDATE()) AS dias_restantes
FROM socio s
LEFT JOIN (
    SELECT id_socio, MAX(fecha_fin) AS fecha_fin
    FROM membresia
    GROUP BY id_socio
) mm ON mm.id_socio = s.id_socio
ORDER BY s.apellidos, s.nombres;


-- 2. Total recaudado por plan en un rango de fechas, de mayor a menor.

SELECT
    p.nombre                AS plan,
    COUNT(m.id_membresia)   AS membresias_vendidas,
    SUM(m.valor_pagado)     AS total_recaudado
FROM membresia m
JOIN plan p ON p.id_plan = m.id_plan
WHERE m.fecha_inicio BETWEEN '2026-01-01' AND '2026-12-31'
GROUP BY p.nombre
ORDER BY total_recaudado DESC;


-- 3. Socios cuya membresia vence dentro de los proximos 5 dias.

SELECT
    s.documento,
    s.nombres,
    s.apellidos,
    s.telefono,
    m.fecha_fin,
    DATEDIFF(m.fecha_fin, CURDATE()) AS dias_restantes
FROM membresia m
JOIN socio s ON s.id_socio = m.id_socio
WHERE m.fecha_fin >= CURDATE()
  AND m.fecha_fin <= DATE_ADD(CURDATE(), INTERVAL 5 DAY)
ORDER BY m.fecha_fin;


-- 4. Cuantos ingresos se registraron por dia durante la ultima semana.

SELECT
    fecha_ingreso,
    COUNT(*) AS total_ingresos
FROM ingreso
WHERE fecha_ingreso >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)
GROUP BY fecha_ingreso
ORDER BY fecha_ingreso;


-- 5. Socios activos que nunca han registrado un ingreso.

SELECT
    s.documento,
    s.nombres,
    s.apellidos
FROM socio s
LEFT JOIN ingreso i ON i.id_socio = s.id_socio
WHERE s.activo = TRUE
  AND i.id_ingreso IS NULL
ORDER BY s.apellidos, s.nombres;
