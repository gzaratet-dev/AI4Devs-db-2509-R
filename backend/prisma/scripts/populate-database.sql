-- ============================================
-- Script SQL para poblar la base de datos
-- Sistema de Reclutamiento - Datos de Ejemplo
-- ============================================
-- 
-- INSTRUCCIONES:
-- 1. Abrir pgAdmin
-- 2. Conectarse a la base de datos LTIdb
-- 3. Abrir Query Tool
-- 4. Ejecutar este script completo
-- 
-- NOTA: Este script elimina datos existentes antes de insertar nuevos
-- ============================================

-- Limpiar datos existentes (en orden inverso de dependencias)
DELETE FROM "Interview" WHERE id > 0;
DELETE FROM "Application" WHERE id > 0;
DELETE FROM "InterviewStep" WHERE id > 0;
DELETE FROM "Position" WHERE id > 0;
DELETE FROM "Employee" WHERE id > 0;
DELETE FROM "InterviewFlow" WHERE id > 0;
DELETE FROM "InterviewType" WHERE id > 0;
DELETE FROM "Education" WHERE id > 0;
DELETE FROM "WorkExperience" WHERE id > 0;
DELETE FROM "Resume" WHERE id > 0;
DELETE FROM "Candidate" WHERE id > 0;
DELETE FROM "Company" WHERE id > 0;

-- Resetear secuencias
ALTER SEQUENCE "Company_id_seq" RESTART WITH 1;
ALTER SEQUENCE "Employee_id_seq" RESTART WITH 1;
ALTER SEQUENCE "InterviewFlow_id_seq" RESTART WITH 1;
ALTER SEQUENCE "InterviewType_id_seq" RESTART WITH 1;
ALTER SEQUENCE "InterviewStep_id_seq" RESTART WITH 1;
ALTER SEQUENCE "Position_id_seq" RESTART WITH 1;
ALTER SEQUENCE "Candidate_id_seq" RESTART WITH 1;
ALTER SEQUENCE "Application_id_seq" RESTART WITH 1;
ALTER SEQUENCE "Interview_id_seq" RESTART WITH 1;
ALTER SEQUENCE "Education_id_seq" RESTART WITH 1;
ALTER SEQUENCE "WorkExperience_id_seq" RESTART WITH 1;
ALTER SEQUENCE "Resume_id_seq" RESTART WITH 1;

-- ============================================
-- 1. COMPANIES (Empresas)
-- ============================================

INSERT INTO "Company" ("name") VALUES
('TechCorp Solutions'),
('InnovateHub'),
('Digital Dynamics'),
('CloudSoft Systems'),
('DataFlow Analytics');

-- ============================================
-- 2. INTERVIEW TYPES (Tipos de Entrevista)
-- ============================================

INSERT INTO "InterviewType" ("name", "description") VALUES
('Técnica', 'Evaluación de habilidades técnicas y conocimientos de programación'),
('HR', 'Entrevista de recursos humanos para evaluar fit cultural'),
('Final', 'Entrevista final con el equipo directivo'),
('Pair Programming', 'Sesión de programación en pareja para evaluar habilidades prácticas'),
('System Design', 'Evaluación de diseño de sistemas y arquitectura');

-- ============================================
-- 3. INTERVIEW FLOWS (Flujos de Entrevista)
-- ============================================

INSERT INTO "InterviewFlow" ("description") VALUES
('Flujo estándar para desarrolladores junior'),
('Flujo completo para desarrolladores senior'),
('Flujo rápido para posiciones urgentes'),
('Flujo para posiciones de liderazgo técnico'),
('Flujo para posiciones de DevOps');

-- ============================================
-- 4. INTERVIEW STEPS (Pasos de Entrevista)
-- ============================================

-- Flujo 1: Desarrolladores Junior (3 pasos)
INSERT INTO "InterviewStep" ("interviewFlowId", "interviewTypeId", "name", "orderIndex") VALUES
(1, 2, 'Entrevista HR Inicial', 1),
(1, 1, 'Entrevista Técnica Básica', 2),
(1, 3, 'Entrevista Final', 3);

-- Flujo 2: Desarrolladores Senior (5 pasos)
INSERT INTO "InterviewStep" ("interviewFlowId", "interviewTypeId", "name", "orderIndex") VALUES
(2, 2, 'Entrevista HR Inicial', 1),
(2, 1, 'Entrevista Técnica Avanzada', 2),
(2, 4, 'Pair Programming Session', 3),
(2, 5, 'System Design Interview', 4),
(2, 3, 'Entrevista Final con CTO', 5);

-- Flujo 3: Posiciones Urgentes (2 pasos)
INSERT INTO "InterviewStep" ("interviewFlowId", "interviewTypeId", "name", "orderIndex") VALUES
(3, 2, 'Entrevista HR', 1),
(3, 1, 'Entrevista Técnica', 2);

-- Flujo 4: Liderazgo Técnico (4 pasos)
INSERT INTO "InterviewStep" ("interviewFlowId", "interviewTypeId", "name", "orderIndex") VALUES
(4, 2, 'Entrevista HR', 1),
(4, 5, 'System Design Avanzado', 2),
(4, 1, 'Entrevista Técnica de Liderazgo', 3),
(4, 3, 'Entrevista Final con Directivos', 4);

-- Flujo 5: DevOps (4 pasos)
INSERT INTO "InterviewStep" ("interviewFlowId", "interviewTypeId", "name", "orderIndex") VALUES
(5, 2, 'Entrevista HR', 1),
(5, 1, 'Entrevista Técnica DevOps', 2),
(5, 4, 'Hands-on Lab Session', 3),
(5, 3, 'Entrevista Final', 4);

-- ============================================
-- 5. EMPLOYEES (Empleados)
-- ============================================

INSERT INTO "Employee" ("companyId", "name", "email", "role", "isActive") VALUES
-- TechCorp Solutions
(1, 'María González', 'maria.gonzalez@techcorp.com', 'Tech Lead', true),
(1, 'Carlos Ruiz', 'carlos.ruiz@techcorp.com', 'Senior Developer', true),
(1, 'Ana Martínez', 'ana.martinez@techcorp.com', 'HR Manager', true),
(1, 'Pedro Sánchez', 'pedro.sanchez@techcorp.com', 'CTO', true),

-- InnovateHub
(2, 'Laura Fernández', 'laura.fernandez@innovatehub.com', 'Engineering Manager', true),
(2, 'David López', 'david.lopez@innovatehub.com', 'Senior Developer', true),
(2, 'Sofía Ramírez', 'sofia.ramirez@innovatehub.com', 'Recruiter', true),

-- Digital Dynamics
(3, 'Javier Torres', 'javier.torres@digitaldynamics.com', 'Tech Lead', true),
(3, 'Carmen Jiménez', 'carmen.jimenez@digitaldynamics.com', 'HR Specialist', true),

-- CloudSoft Systems
(4, 'Roberto Morales', 'roberto.morales@cloudsoft.com', 'DevOps Lead', true),
(4, 'Elena Castro', 'elena.castro@cloudsoft.com', 'Senior Developer', true),

-- DataFlow Analytics
(5, 'Miguel Herrera', 'miguel.herrera@dataflow.com', 'Data Engineer Lead', true),
(5, 'Isabel Vega', 'isabel.vega@dataflow.com', 'Recruiter', true);

-- ============================================
-- 6. CANDIDATES (Candidatos)
-- ============================================

INSERT INTO "Candidate" ("firstName", "lastName", "email", "phone", "address") VALUES
('Juan', 'Pérez', 'juan.perez@email.com', '612345678', 'Calle Mayor 123, Madrid'),
('María', 'García', 'maria.garcia@email.com', '623456789', 'Avenida Libertad 45, Barcelona'),
('Carlos', 'Rodríguez', 'carlos.rodriguez@email.com', '634567890', 'Plaza España 12, Valencia'),
('Ana', 'López', 'ana.lopez@email.com', '645678901', 'Calle Gran Vía 78, Madrid'),
('Pedro', 'Martínez', 'pedro.martinez@email.com', '656789012', 'Avenida Diagonal 234, Barcelona'),
('Laura', 'Sánchez', 'laura.sanchez@email.com', '667890123', 'Calle Colón 56, Sevilla'),
('David', 'Fernández', 'david.fernandez@email.com', '678901234', 'Plaza Mayor 89, Bilbao'),
('Sofía', 'González', 'sofia.gonzalez@email.com', '689012345', 'Avenida de la Constitución 12, Málaga');

-- ============================================
-- 7. EDUCATION (Educación de Candidatos)
-- ============================================

INSERT INTO "Education" ("candidateId", "institution", "title", "startDate", "endDate") VALUES
-- Juan Pérez
(1, 'Universidad Politécnica de Madrid', 'Grado en Ingeniería Informática', '2015-09-01', '2019-06-30'),
(1, 'Universidad Politécnica de Madrid', 'Máster en Ingeniería de Software', '2019-09-01', '2021-06-30'),

-- María García
(2, 'Universidad de Barcelona', 'Grado en Ingeniería de Sistemas', '2016-09-01', '2020-06-30'),

-- Carlos Rodríguez
(3, 'Universidad Politécnica de Valencia', 'Grado en Ingeniería Informática', '2014-09-01', '2018-06-30'),
(3, 'Universidad Politécnica de Valencia', 'Máster en Inteligencia Artificial', '2018-09-01', '2020-06-30'),

-- Ana López
(4, 'Universidad Complutense de Madrid', 'Grado en Ingeniería Informática', '2017-09-01', '2021-06-30'),

-- Pedro Martínez
(5, 'Universidad de Barcelona', 'Grado en Ingeniería de Software', '2015-09-01', '2019-06-30'),
(5, 'Universidad de Barcelona', 'Máster en Cloud Computing', '2019-09-01', '2021-06-30'),

-- Laura Sánchez
(6, 'Universidad de Sevilla', 'Grado en Ingeniería Informática', '2016-09-01', '2020-06-30'),

-- David Fernández
(7, 'Universidad del País Vasco', 'Grado en Ingeniería de Sistemas', '2014-09-01', '2018-06-30'),

-- Sofía González
(8, 'Universidad de Málaga', 'Grado en Ingeniería Informática', '2017-09-01', '2021-06-30');

-- ============================================
-- 8. WORK EXPERIENCE (Experiencia Laboral)
-- ============================================

INSERT INTO "WorkExperience" ("candidateId", "company", "position", "description", "startDate", "endDate") VALUES
-- Juan Pérez
(1, 'StartupTech', 'Desarrollador Junior Full Stack', 'Desarrollo de aplicaciones web con React y Node.js', '2021-07-01', '2023-06-30'),
(1, 'WebSolutions', 'Desarrollador Full Stack', 'Desarrollo y mantenimiento de aplicaciones web empresariales', '2023-07-01', NULL),

-- María García
(2, 'DevCompany', 'Desarrolladora Frontend', 'Desarrollo de interfaces de usuario con React y TypeScript', '2020-07-01', '2022-12-31'),
(2, 'TechStart', 'Desarrolladora Frontend Senior', 'Liderazgo de equipo frontend y arquitectura de aplicaciones', '2023-01-01', NULL),

-- Carlos Rodríguez
(3, 'DataCorp', 'Data Engineer', 'Desarrollo de pipelines de datos y sistemas ETL', '2020-07-01', '2022-12-31'),
(3, 'AnalyticsPro', 'Senior Data Engineer', 'Diseño de arquitecturas de datos y machine learning', '2023-01-01', NULL),

-- Ana López
(4, 'MobileApps', 'Desarrolladora Mobile', 'Desarrollo de aplicaciones móviles iOS y Android', '2021-07-01', NULL),

-- Pedro Martínez
(5, 'CloudServices', 'DevOps Engineer', 'Gestión de infraestructura cloud y CI/CD', '2019-07-01', '2022-06-30'),
(5, 'CloudTech', 'Senior DevOps Engineer', 'Arquitectura cloud y automatización de despliegues', '2022-07-01', NULL),

-- Laura Sánchez
(6, 'SoftwareCorp', 'Desarrolladora Backend', 'Desarrollo de APIs REST y microservicios', '2020-07-01', NULL),

-- David Fernández
(7, 'EnterpriseSoft', 'Desarrollador Full Stack', 'Desarrollo de sistemas empresariales', '2018-07-01', '2021-12-31'),
(7, 'TechGiant', 'Desarrollador Senior Full Stack', 'Desarrollo de plataformas escalables', '2022-01-01', NULL),

-- Sofía González
(8, 'StartupHub', 'Desarrolladora Junior', 'Desarrollo de aplicaciones web', '2021-07-01', NULL);

-- ============================================
-- 9. RESUMES (Currículums)
-- ============================================

INSERT INTO "Resume" ("candidateId", "filePath", "fileType", "uploadDate") VALUES
(1, 'uploads/2025-11-16-juan-perez-cv.pdf', 'application/pdf', '2025-11-16 10:00:00'),
(2, 'uploads/2025-11-16-maria-garcia-cv.pdf', 'application/pdf', '2025-11-16 10:15:00'),
(3, 'uploads/2025-11-16-carlos-rodriguez-cv.pdf', 'application/pdf', '2025-11-16 10:30:00'),
(4, 'uploads/2025-11-16-ana-lopez-cv.pdf', 'application/pdf', '2025-11-16 10:45:00'),
(5, 'uploads/2025-11-16-pedro-martinez-cv.pdf', 'application/pdf', '2025-11-16 11:00:00'),
(6, 'uploads/2025-11-16-laura-sanchez-cv.pdf', 'application/pdf', '2025-11-16 11:15:00'),
(7, 'uploads/2025-11-16-david-fernandez-cv.pdf', 'application/pdf', '2025-11-16 11:30:00'),
(8, 'uploads/2025-11-16-sofia-gonzalez-cv.pdf', 'application/pdf', '2025-11-16 11:45:00');

-- ============================================
-- 10. POSITIONS (Posiciones de Trabajo)
-- ============================================

INSERT INTO "Position" (
    "companyId", 
    "interviewFlowId", 
    "title", 
    "description", 
    "status", 
    "isVisible", 
    "location", 
    "jobDescription", 
    "requirements", 
    "responsibilities", 
    "salaryMin", 
    "salaryMax", 
    "employmentType", 
    "benefits", 
    "companyDescription", 
    "applicationDeadline", 
    "contactInfo"
) VALUES
-- TechCorp Solutions
(1, 2, 'Desarrollador Full Stack Senior', 
 'Buscamos desarrollador senior con experiencia en React y Node.js',
 'open', true, 'Madrid, España (Híbrido)',
 'Desarrollar y mantener aplicaciones web escalables usando tecnologías modernas',
 '5+ años de experiencia, React, Node.js, TypeScript, PostgreSQL',
 'Desarrollo de features, code reviews, mentoría a desarrolladores junior',
 55000, 75000, 'full-time',
 'Seguro médico, teletrabajo flexible, formación continua, stock options',
 'TechCorp Solutions es una empresa líder en desarrollo de software empresarial',
 '2025-12-31 23:59:59',
 'recruiting@techcorp.com - Tel: +34 91 123 4567'),

(1, 1, 'Desarrollador Full Stack Junior', 
 'Oportunidad para desarrollador junior con ganas de aprender',
 'open', true, 'Madrid, España (Presencial)',
 'Desarrollar aplicaciones web bajo supervisión de desarrolladores senior',
 'Conocimientos en JavaScript, React básico, ganas de aprender',
 'Desarrollo de componentes, testing, documentación',
 30000, 40000, 'full-time',
 'Seguro médico, formación continua, plan de carrera',
 'TechCorp Solutions ofrece un ambiente de aprendizaje y crecimiento',
 '2025-12-15 23:59:59',
 'recruiting@techcorp.com - Tel: +34 91 123 4567'),

-- InnovateHub
(2, 2, 'Engineering Manager', 
 'Liderazgo técnico para equipo de desarrollo',
 'open', true, 'Barcelona, España (Remoto)',
 'Gestionar equipo de ingeniería y definir arquitectura técnica',
 '8+ años experiencia, liderazgo técnico, arquitectura de sistemas',
 'Gestión de equipo, definición de roadmap técnico, code reviews',
 70000, 90000, 'full-time',
 'Seguro médico premium, trabajo remoto, equity, vacaciones ilimitadas',
 'InnovateHub es una startup tecnológica en rápido crecimiento',
 '2025-12-20 23:59:59',
 'jobs@innovatehub.com - Tel: +34 93 234 5678'),

(2, 1, 'Desarrollador Frontend', 
 'Desarrollador frontend con experiencia en React',
 'open', true, 'Barcelona, España (Híbrido)',
 'Desarrollar interfaces de usuario modernas y responsivas',
 '3+ años experiencia, React, TypeScript, CSS avanzado',
 'Desarrollo de componentes, optimización de rendimiento, testing',
 40000, 55000, 'full-time',
 'Seguro médico, teletrabajo, formación, eventos tech',
 'InnovateHub valora la innovación y el trabajo en equipo',
 '2025-12-10 23:59:59',
 'jobs@innovatehub.com - Tel: +34 93 234 5678'),

-- Digital Dynamics
(3, 4, 'Tech Lead - Backend', 
 'Liderazgo técnico en desarrollo backend',
 'open', true, 'Valencia, España (Híbrido)',
 'Liderar desarrollo de arquitectura backend y mentoría',
 '7+ años experiencia, Node.js, microservicios, liderazgo',
 'Arquitectura técnica, code reviews, mentoría, decisiones técnicas',
 65000, 85000, 'full-time',
 'Seguro médico, teletrabajo, formación, bonus por objetivos',
 'Digital Dynamics se especializa en soluciones digitales innovadoras',
 '2025-12-25 23:59:59',
 'careers@digitaldynamics.com - Tel: +34 96 345 6789'),

-- CloudSoft Systems
(4, 5, 'DevOps Engineer Senior', 
 'Ingeniero DevOps con experiencia en cloud',
 'open', true, 'Madrid, España (Remoto)',
 'Gestionar infraestructura cloud y pipelines CI/CD',
 '5+ años experiencia, AWS/Azure, Kubernetes, Terraform',
 'Infraestructura como código, monitoreo, automatización',
 50000, 70000, 'full-time',
 'Seguro médico, trabajo remoto, certificaciones pagadas',
 'CloudSoft Systems es líder en soluciones cloud',
 '2025-12-18 23:59:59',
 'hr@cloudsoft.com - Tel: +34 91 456 7890'),

-- DataFlow Analytics
(5, 2, 'Data Engineer Senior', 
 'Ingeniero de datos con experiencia en big data',
 'open', true, 'Barcelona, España (Híbrido)',
 'Desarrollar pipelines de datos y sistemas de procesamiento',
 '5+ años experiencia, Python, Spark, Kafka, data lakes',
 'Diseño de pipelines, optimización, arquitectura de datos',
 55000, 75000, 'full-time',
 'Seguro médico, teletrabajo, formación, bonus',
 'DataFlow Analytics es especialista en análisis de datos',
 '2025-12-22 23:59:59',
 'recruiting@dataflow.com - Tel: +34 93 567 8901'),

-- Posición cerrada (para testing)
(1, 1, 'Desarrollador Backend (Cerrada)', 
 'Posición ya cubierta',
 'closed', false, 'Madrid, España',
 'Posición cerrada',
 'N/A',
 'N/A',
 NULL, NULL, 'full-time',
 'N/A',
 'Posición de ejemplo cerrada',
 '2025-11-01 23:59:59',
 'N/A');

-- ============================================
-- 11. APPLICATIONS (Aplicaciones)
-- ============================================

INSERT INTO "Application" ("positionId", "candidateId", "applicationDate", "status", "notes") VALUES
-- Aplicaciones a posiciones abiertas
(1, 1, '2025-11-16 09:00:00', 'in_progress', 'Candidato con excelente perfil técnico'),
(1, 2, '2025-11-16 09:30:00', 'pending', 'Revisando CV'),
(1, 3, '2025-11-16 10:00:00', 'in_progress', 'En proceso de entrevistas'),

(2, 4, '2025-11-16 10:15:00', 'pending', 'Candidato junior con potencial'),
(2, 5, '2025-11-16 10:30:00', 'pending', 'Esperando revisión inicial'),

(3, 6, '2025-11-16 11:00:00', 'in_progress', 'Candidato con experiencia en liderazgo'),
(3, 7, '2025-11-16 11:15:00', 'pending', 'Revisando perfil'),

(4, 1, '2025-11-16 11:30:00', 'accepted', 'Candidato aceptado, esperando inicio'),
(4, 2, '2025-11-16 11:45:00', 'rejected', 'No cumple con los requisitos mínimos'),

(5, 3, '2025-11-16 12:00:00', 'in_progress', 'En proceso de entrevistas técnicas'),
(5, 4, '2025-11-16 12:15:00', 'pending', 'Revisando aplicación'),

(6, 5, '2025-11-16 12:30:00', 'in_progress', 'Candidato con experiencia en DevOps'),
(6, 6, '2025-11-16 12:45:00', 'pending', 'Revisando perfil'),

(7, 7, '2025-11-16 13:00:00', 'in_progress', 'Candidato con experiencia en data engineering'),
(7, 8, '2025-11-16 13:15:00', 'pending', 'Revisando aplicación');

-- ============================================
-- 12. INTERVIEWS (Entrevistas)
-- ============================================

INSERT INTO "Interview" (
    "applicationId", 
    "interviewStepId", 
    "employeeId", 
    "interviewDate", 
    "result", 
    "score", 
    "notes"
) VALUES
-- Entrevistas para Application 1 (Juan Pérez - Desarrollador Full Stack Senior)
(1, 1, 3, '2025-11-20 10:00:00', 'passed', 8, 'Excelente comunicación y fit cultural'),
(1, 2, 2, '2025-11-22 14:00:00', 'passed', 9, 'Muy buenos conocimientos técnicos'),
(1, 3, 1, '2025-11-25 11:00:00', 'pending', NULL, 'Pendiente de realizar'),

-- Entrevistas para Application 3 (Carlos Rodríguez - Desarrollador Full Stack Senior)
(3, 1, 3, '2025-11-21 10:00:00', 'passed', 7, 'Buen perfil, necesita mejorar comunicación'),
(3, 2, 2, '2025-11-23 15:00:00', 'pending', NULL, 'Programada para el 23 de noviembre'),

-- Entrevistas para Application 6 (Laura Sánchez - Engineering Manager)
(6, 1, 7, '2025-11-20 11:00:00', 'passed', 9, 'Excelente liderazgo y visión técnica'),
(6, 2, 6, '2025-11-22 16:00:00', 'passed', 8, 'Buen conocimiento de arquitectura'),
(6, 3, 5, '2025-11-24 10:00:00', 'pending', NULL, 'Pendiente entrevista técnica de liderazgo'),

-- Entrevistas para Application 8 (María García - Desarrollador Frontend - Aceptada)
(8, 1, 7, '2025-11-18 10:00:00', 'passed', 9, 'Excelente perfil'),
(8, 2, 6, '2025-11-19 14:00:00', 'passed', 9, 'Muy buenas habilidades técnicas'),
(8, 3, 5, '2025-11-20 11:00:00', 'passed', 10, 'Candidato ideal, oferta extendida'),

-- Entrevistas para Application 9 (Carlos Rodríguez - Tech Lead Backend)
(9, 1, 9, '2025-11-21 10:00:00', 'passed', 8, 'Buen perfil técnico'),
(9, 2, 8, '2025-11-23 15:00:00', 'pending', NULL, 'Pendiente system design'),

-- Entrevistas para Application 11 (Pedro Martínez - DevOps Engineer Senior)
(11, 1, 11, '2025-11-20 10:00:00', 'passed', 8, 'Buen conocimiento de cloud'),
(11, 2, 10, '2025-11-22 14:00:00', 'pending', NULL, 'Pendiente hands-on lab'),

-- Entrevistas para Application 13 (David Fernández - Data Engineer Senior)
(13, 1, 13, '2025-11-21 10:00:00', 'passed', 7, 'Buen perfil, necesita más experiencia'),
(13, 2, 12, '2025-11-23 15:00:00', 'pending', NULL, 'Pendiente entrevista técnica');

-- ============================================
-- VERIFICACIÓN DE DATOS INSERTADOS
-- ============================================

-- Mostrar resumen de datos insertados
SELECT 'Companies' as "Tabla", COUNT(*) as "Registros" FROM "Company"
UNION ALL
SELECT 'Employees', COUNT(*) FROM "Employee"
UNION ALL
SELECT 'InterviewTypes', COUNT(*) FROM "InterviewType"
UNION ALL
SELECT 'InterviewFlows', COUNT(*) FROM "InterviewFlow"
UNION ALL
SELECT 'InterviewSteps', COUNT(*) FROM "InterviewStep"
UNION ALL
SELECT 'Candidates', COUNT(*) FROM "Candidate"
UNION ALL
SELECT 'Education', COUNT(*) FROM "Education"
UNION ALL
SELECT 'WorkExperience', COUNT(*) FROM "WorkExperience"
UNION ALL
SELECT 'Resumes', COUNT(*) FROM "Resume"
UNION ALL
SELECT 'Positions', COUNT(*) FROM "Position"
UNION ALL
SELECT 'Applications', COUNT(*) FROM "Application"
UNION ALL
SELECT 'Interviews', COUNT(*) FROM "Interview";

-- ============================================
-- CONSULTAS DE EJEMPLO PARA VERIFICAR RELACIONES
-- ============================================

-- Ver aplicaciones con información completa
SELECT 
    a.id as "Application ID",
    c."firstName" || ' ' || c."lastName" as "Candidate",
    p.title as "Position",
    co.name as "Company",
    a.status as "Status",
    a."applicationDate"
FROM "Application" a
JOIN "Candidate" c ON a."candidateId" = c.id
JOIN "Position" p ON a."positionId" = p.id
JOIN "Company" co ON p."companyId" = co.id
ORDER BY a."applicationDate" DESC;

-- Ver entrevistas programadas
SELECT 
    i.id as "Interview ID",
    c."firstName" || ' ' || c."lastName" as "Candidate",
    p.title as "Position",
    its.name as "Interview Step",
    it.name as "Interview Type",
    e.name as "Interviewer",
    i."interviewDate",
    i.result as "Result"
FROM "Interview" i
JOIN "Application" a ON i."applicationId" = a.id
JOIN "Candidate" c ON a."candidateId" = c.id
JOIN "Position" p ON a."positionId" = p.id
JOIN "InterviewStep" its ON i."interviewStepId" = its.id
JOIN "InterviewType" it ON its."interviewTypeId" = it.id
JOIN "Employee" e ON i."employeeId" = e.id
ORDER BY i."interviewDate" ASC;

-- Ver posiciones abiertas con número de aplicaciones
SELECT 
    p.id,
    p.title,
    co.name as "Company",
    p.location,
    p.status,
    COUNT(a.id) as "Applications Count"
FROM "Position" p
JOIN "Company" co ON p."companyId" = co.id
LEFT JOIN "Application" a ON p.id = a."positionId"
WHERE p.status = 'open' AND p."isVisible" = true
GROUP BY p.id, p.title, co.name, p.location, p.status
ORDER BY "Applications Count" DESC;

-- ============================================
-- FIN DEL SCRIPT
-- ============================================

