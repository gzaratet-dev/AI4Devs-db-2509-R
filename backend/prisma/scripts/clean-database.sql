-- ============================================
-- Script SQL para limpiar la base de datos
-- Sistema de Reclutamiento
-- ============================================
-- 
-- INSTRUCCIONES:
-- 1. Abrir pgAdmin
-- 2. Conectarse a la base de datos LTIdb
-- 3. Abrir Query Tool
-- 4. Ejecutar este script
-- 
-- ADVERTENCIA: Este script elimina TODOS los datos de las tablas
-- ============================================

-- Desactivar temporalmente las restricciones de foreign key
SET session_replication_role = 'replica';

-- Eliminar datos en orden inverso de dependencias
DELETE FROM "Interview";
DELETE FROM "Application";
DELETE FROM "InterviewStep";
DELETE FROM "Position";
DELETE FROM "Employee";
DELETE FROM "InterviewFlow";
DELETE FROM "InterviewType";
DELETE FROM "Education";
DELETE FROM "WorkExperience";
DELETE FROM "Resume";
DELETE FROM "Candidate";
DELETE FROM "Company";

-- Reactivar las restricciones de foreign key
SET session_replication_role = 'origin';

-- Resetear todas las secuencias a 1
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

-- Verificar que las tablas están vacías
SELECT 
    'Company' as "Tabla", COUNT(*) as "Registros" FROM "Company"
UNION ALL
SELECT 'Employee', COUNT(*) FROM "Employee"
UNION ALL
SELECT 'InterviewType', COUNT(*) FROM "InterviewType"
UNION ALL
SELECT 'InterviewFlow', COUNT(*) FROM "InterviewFlow"
UNION ALL
SELECT 'InterviewStep', COUNT(*) FROM "InterviewStep"
UNION ALL
SELECT 'Candidate', COUNT(*) FROM "Candidate"
UNION ALL
SELECT 'Education', COUNT(*) FROM "Education"
UNION ALL
SELECT 'WorkExperience', COUNT(*) FROM "WorkExperience"
UNION ALL
SELECT 'Resume', COUNT(*) FROM "Resume"
UNION ALL
SELECT 'Position', COUNT(*) FROM "Position"
UNION ALL
SELECT 'Application', COUNT(*) FROM "Application"
UNION ALL
SELECT 'Interview', COUNT(*) FROM "Interview";

-- Mensaje de confirmación
SELECT 'Base de datos limpiada exitosamente. Todas las secuencias han sido reseteadas.' as "Estado";

