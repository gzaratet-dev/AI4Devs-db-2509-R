-- ============================================
-- Consultas Útiles para el Sistema de Reclutamiento
-- ============================================
-- 
-- Este archivo contiene consultas SQL útiles para
-- analizar y verificar los datos del sistema
-- ============================================

-- ============================================
-- 1. RESUMEN GENERAL DEL SISTEMA
-- ============================================

-- Vista general de todas las entidades
SELECT 
    'Company' as "Entidad", COUNT(*) as "Total" FROM "Company"
UNION ALL
SELECT 'Employee', COUNT(*) FROM "Employee"
UNION ALL
SELECT 'Candidate', COUNT(*) FROM "Candidate"
UNION ALL
SELECT 'Position', COUNT(*) FROM "Position"
UNION ALL
SELECT 'Application', COUNT(*) FROM "Application"
UNION ALL
SELECT 'Interview', COUNT(*) FROM "Interview"
UNION ALL
SELECT 'InterviewFlow', COUNT(*) FROM "InterviewFlow"
UNION ALL
SELECT 'InterviewType', COUNT(*) FROM "InterviewType"
UNION ALL
SELECT 'InterviewStep', COUNT(*) FROM "InterviewStep";

-- ============================================
-- 2. APLICACIONES Y CANDIDATOS
-- ============================================

-- Todas las aplicaciones con información completa
SELECT 
    a.id as "App ID",
    c."firstName" || ' ' || c."lastName" as "Candidato",
    c.email as "Email",
    p.title as "Posición",
    co.name as "Empresa",
    a.status as "Estado",
    a."applicationDate" as "Fecha Aplicación",
    COUNT(i.id) as "Entrevistas Realizadas"
FROM "Application" a
JOIN "Candidate" c ON a."candidateId" = c.id
JOIN "Position" p ON a."positionId" = p.id
JOIN "Company" co ON p."companyId" = co.id
LEFT JOIN "Interview" i ON a.id = i."applicationId"
GROUP BY a.id, c."firstName", c."lastName", c.email, p.title, co.name, a.status, a."applicationDate"
ORDER BY a."applicationDate" DESC;

-- Aplicaciones por estado
SELECT 
    status as "Estado",
    COUNT(*) as "Cantidad",
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM "Application"), 2) as "Porcentaje"
FROM "Application"
GROUP BY status
ORDER BY "Cantidad" DESC;

-- Candidatos con más aplicaciones
SELECT 
    c.id,
    c."firstName" || ' ' || c."lastName" as "Candidato",
    c.email,
    COUNT(a.id) as "Aplicaciones",
    STRING_AGG(DISTINCT p.title, ', ') as "Posiciones Aplicadas"
FROM "Candidate" c
LEFT JOIN "Application" a ON c.id = a."candidateId"
LEFT JOIN "Position" p ON a."positionId" = p.id
GROUP BY c.id, c."firstName", c."lastName", c.email
HAVING COUNT(a.id) > 0
ORDER BY "Aplicaciones" DESC;

-- ============================================
-- 3. POSICIONES Y EMPRESAS
-- ============================================

-- Posiciones abiertas con estadísticas
SELECT 
    p.id,
    p.title as "Posición",
    co.name as "Empresa",
    p.location as "Ubicación",
    p.status as "Estado",
    p."salaryMin" as "Salario Mín",
    p."salaryMax" as "Salario Máx",
    COUNT(a.id) as "Aplicaciones",
    COUNT(CASE WHEN a.status = 'in_progress' THEN 1 END) as "En Proceso",
    COUNT(CASE WHEN a.status = 'accepted' THEN 1 END) as "Aceptadas"
FROM "Position" p
JOIN "Company" co ON p."companyId" = co.id
LEFT JOIN "Application" a ON p.id = a."positionId"
WHERE p.status = 'open' AND p."isVisible" = true
GROUP BY p.id, p.title, co.name, p.location, p.status, p."salaryMin", p."salaryMax"
ORDER BY "Aplicaciones" DESC;

-- Empresas con más posiciones
SELECT 
    co.id,
    co.name as "Empresa",
    COUNT(p.id) as "Posiciones Totales",
    COUNT(CASE WHEN p.status = 'open' THEN 1 END) as "Posiciones Abiertas",
    COUNT(DISTINCT e.id) as "Empleados"
FROM "Company" co
LEFT JOIN "Position" p ON co.id = p."companyId"
LEFT JOIN "Employee" e ON co.id = e."companyId"
GROUP BY co.id, co.name
ORDER BY "Posiciones Totales" DESC;

-- ============================================
-- 4. ENTREVISTAS
-- ============================================

-- Próximas entrevistas programadas
SELECT 
    i.id as "Interview ID",
    c."firstName" || ' ' || c."lastName" as "Candidato",
    p.title as "Posición",
    its.name as "Paso de Entrevista",
    it.name as "Tipo de Entrevista",
    e.name as "Entrevistador",
    e.role as "Rol Entrevistador",
    i."interviewDate" as "Fecha y Hora",
    i.result as "Resultado",
    i.score as "Puntuación"
FROM "Interview" i
JOIN "Application" a ON i."applicationId" = a.id
JOIN "Candidate" c ON a."candidateId" = c.id
JOIN "Position" p ON a."positionId" = p.id
JOIN "InterviewStep" its ON i."interviewStepId" = its.id
JOIN "InterviewType" it ON its."interviewTypeId" = it.id
JOIN "Employee" e ON i."employeeId" = e.id
WHERE i."interviewDate" >= CURRENT_DATE
ORDER BY i."interviewDate" ASC;

-- Entrevistas por resultado
SELECT 
    i.result as "Resultado",
    COUNT(*) as "Cantidad",
    AVG(i.score) as "Puntuación Promedio",
    MIN(i.score) as "Puntuación Mínima",
    MAX(i.score) as "Puntuación Máxima"
FROM "Interview" i
WHERE i.result IS NOT NULL
GROUP BY i.result
ORDER BY "Cantidad" DESC;

-- Progreso de aplicaciones en el proceso de entrevistas
SELECT 
    a.id as "App ID",
    c."firstName" || ' ' || c."lastName" as "Candidato",
    p.title as "Posición",
    COUNT(i.id) as "Entrevistas Completadas",
    COUNT(its.id) as "Total Pasos en Flujo",
    ROUND(COUNT(i.id) * 100.0 / NULLIF(COUNT(its.id), 0), 2) as "Progreso %"
FROM "Application" a
JOIN "Candidate" c ON a."candidateId" = c.id
JOIN "Position" p ON a."positionId" = p.id
JOIN "InterviewFlow" if ON p."interviewFlowId" = if.id
LEFT JOIN "InterviewStep" its ON if.id = its."interviewFlowId"
LEFT JOIN "Interview" i ON a.id = i."applicationId" AND its.id = i."interviewStepId"
WHERE a.status = 'in_progress'
GROUP BY a.id, c."firstName", c."lastName", p.title
HAVING COUNT(its.id) > 0
ORDER BY "Progreso %" DESC;

-- ============================================
-- 5. EMPLEADOS Y ENTREVISTADORES
-- ============================================

-- Empleados activos por empresa
SELECT 
    co.name as "Empresa",
    e.name as "Empleado",
    e.email as "Email",
    e.role as "Rol",
    COUNT(i.id) as "Entrevistas Realizadas"
FROM "Employee" e
JOIN "Company" co ON e."companyId" = co.id
LEFT JOIN "Interview" i ON e.id = i."employeeId"
WHERE e."isActive" = true
GROUP BY co.name, e.name, e.email, e.role
ORDER BY co.name, "Entrevistas Realizadas" DESC;

-- Entrevistadores más activos
SELECT 
    e.name as "Entrevistador",
    e.role as "Rol",
    co.name as "Empresa",
    COUNT(i.id) as "Total Entrevistas",
    COUNT(CASE WHEN i.result = 'passed' THEN 1 END) as "Aprobadas",
    COUNT(CASE WHEN i.result = 'failed' THEN 1 END) as "Rechazadas",
    COUNT(CASE WHEN i.result = 'pending' THEN 1 END) as "Pendientes",
    ROUND(AVG(i.score), 2) as "Puntuación Promedio"
FROM "Employee" e
JOIN "Company" co ON e."companyId" = co.id
LEFT JOIN "Interview" i ON e.id = i."employeeId"
WHERE e."isActive" = true
GROUP BY e.name, e.role, co.name
HAVING COUNT(i.id) > 0
ORDER BY "Total Entrevistas" DESC;

-- ============================================
-- 6. FLUJOS DE ENTREVISTA
-- ============================================

-- Flujos de entrevista con sus pasos
SELECT 
    if.id as "Flow ID",
    if.description as "Descripción del Flujo",
    its."orderIndex" as "Orden",
    its.name as "Nombre del Paso",
    it.name as "Tipo de Entrevista",
    it.description as "Descripción del Tipo"
FROM "InterviewFlow" if
JOIN "InterviewStep" its ON if.id = its."interviewFlowId"
JOIN "InterviewType" it ON its."interviewTypeId" = it.id
ORDER BY if.id, its."orderIndex";

-- Posiciones por flujo de entrevista
SELECT 
    if.description as "Flujo de Entrevista",
    COUNT(p.id) as "Posiciones Usando Este Flujo",
    STRING_AGG(p.title, ', ') as "Posiciones"
FROM "InterviewFlow" if
LEFT JOIN "Position" p ON if.id = p."interviewFlowId"
GROUP BY if.id, if.description
ORDER BY "Posiciones Usando Este Flujo" DESC;

-- ============================================
-- 7. CANDIDATOS Y PERFILES
-- ============================================

-- Candidatos con educación completa
SELECT 
    c.id,
    c."firstName" || ' ' || c."lastName" as "Candidato",
    c.email,
    COUNT(DISTINCT e.id) as "Títulos Obtenidos",
    STRING_AGG(DISTINCT e.title, ', ') as "Títulos",
    COUNT(DISTINCT we.id) as "Experiencias Laborales",
    STRING_AGG(DISTINCT we.company, ', ') as "Empresas Anteriores"
FROM "Candidate" c
LEFT JOIN "Education" e ON c.id = e."candidateId"
LEFT JOIN "WorkExperience" we ON c.id = we."candidateId"
GROUP BY c.id, c."firstName", c."lastName", c.email
ORDER BY "Títulos Obtenidos" DESC, "Experiencias Laborales" DESC;

-- Candidatos con más experiencia
SELECT 
    c.id,
    c."firstName" || ' ' || c."lastName" as "Candidato",
    COUNT(we.id) as "Experiencias",
    MIN(we."startDate") as "Primera Experiencia",
    MAX(COALESCE(we."endDate", CURRENT_DATE)) as "Última Experiencia",
    EXTRACT(YEAR FROM AGE(MAX(COALESCE(we."endDate", CURRENT_DATE)), MIN(we."startDate"))) as "Años de Experiencia"
FROM "Candidate" c
JOIN "WorkExperience" we ON c.id = we."candidateId"
GROUP BY c.id, c."firstName", c."lastName"
ORDER BY "Años de Experiencia" DESC;

-- ============================================
-- 8. ESTADÍSTICAS Y MÉTRICAS
-- ============================================

-- Tasa de conversión por posición
SELECT 
    p.title as "Posición",
    COUNT(a.id) as "Total Aplicaciones",
    COUNT(CASE WHEN a.status = 'accepted' THEN 1 END) as "Aceptadas",
    COUNT(CASE WHEN a.status = 'rejected' THEN 1 END) as "Rechazadas",
    ROUND(COUNT(CASE WHEN a.status = 'accepted' THEN 1 END) * 100.0 / NULLIF(COUNT(a.id), 0), 2) as "Tasa Conversión %"
FROM "Position" p
LEFT JOIN "Application" a ON p.id = a."positionId"
GROUP BY p.id, p.title
HAVING COUNT(a.id) > 0
ORDER BY "Tasa Conversión %" DESC;

-- Tiempo promedio en cada etapa del proceso
SELECT 
    its.name as "Paso de Entrevista",
    COUNT(i.id) as "Entrevistas Realizadas",
    AVG(EXTRACT(EPOCH FROM (i."interviewDate" - a."applicationDate")) / 86400) as "Días Promedio desde Aplicación"
FROM "InterviewStep" its
JOIN "Interview" i ON its.id = i."interviewStepId"
JOIN "Application" a ON i."applicationId" = a.id
GROUP BY its.id, its.name
ORDER BY "Días Promedio desde Aplicación" ASC;

-- ============================================
-- FIN DE CONSULTAS
-- ============================================

