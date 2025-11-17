# Scripts SQL para Poblar la Base de Datos

Este directorio contiene scripts SQL para gestionar los datos de ejemplo del sistema de reclutamiento.

## 📁 Archivos Disponibles

### 1. `populate-database.sql`
Script principal para poblar la base de datos con datos de ejemplo completos.

**Contenido:**
- ✅ 5 Empresas
- ✅ 13 Empleados
- ✅ 5 Tipos de Entrevista
- ✅ 5 Flujos de Entrevista
- ✅ 20 Pasos de Entrevista
- ✅ 8 Candidatos
- ✅ 9 Registros de Educación
- ✅ 12 Experiencias Laborales
- ✅ 8 Currículums
- ✅ 8 Posiciones de Trabajo
- ✅ 13 Aplicaciones
- ✅ 18 Entrevistas

### 2. `clean-database.sql`
Script para limpiar completamente la base de datos y resetear las secuencias.

**⚠️ ADVERTENCIA:** Este script elimina TODOS los datos de todas las tablas.

### 3. `useful-queries.sql`
Colección de consultas SQL útiles para analizar y verificar los datos.

**Incluye consultas para:**
- Resumen general del sistema
- Aplicaciones y candidatos
- Posiciones y empresas
- Entrevistas programadas
- Empleados y entrevistadores
- Flujos de entrevista
- Perfiles de candidatos
- Estadísticas y métricas

## 🚀 Cómo Usar en pgAdmin

### Opción 1: Poblar la Base de Datos (Primera Vez)

1. **Abrir pgAdmin**
   - Iniciar pgAdmin 4
   - Conectarse al servidor PostgreSQL

2. **Conectarse a la Base de Datos**
   - Expandir el servidor
   - Expandir "Databases"
   - Click derecho en `LTIdb` → "Query Tool"

3. **Ejecutar el Script**
   - Abrir el archivo `populate-database.sql`
   - Copiar todo el contenido
   - Pegar en el Query Tool
   - Presionar `F5` o click en "Execute" (▶️)

4. **Verificar los Datos**
   - Al final del script se ejecutan consultas de verificación
   - Deberías ver un resumen con el conteo de registros insertados

### Opción 2: Limpiar y Repoblar

Si ya tienes datos y quieres empezar de nuevo:

1. **Limpiar la Base de Datos**
   - Abrir `clean-database.sql` en Query Tool
   - Ejecutar el script (`F5`)
   - Verificar que todas las tablas muestren 0 registros

2. **Poblar de Nuevo**
   - Seguir los pasos de la Opción 1

### Opción 3: Ejecutar Consultas Útiles

1. **Abrir Consultas**
   - Abrir `useful-queries.sql` en Query Tool
   - Seleccionar la consulta que necesites
   - Ejecutar (`F5`)

2. **Consultas Más Útiles:**
   - **Ver todas las aplicaciones:** Buscar "Todas las aplicaciones con información completa"
   - **Ver entrevistas programadas:** Buscar "Próximas entrevistas programadas"
   - **Ver posiciones abiertas:** Buscar "Posiciones abiertas con estadísticas"
   - **Ver estadísticas:** Buscar "Tasa de conversión por posición"

## 📊 Datos de Ejemplo Incluidos

### Empresas
- TechCorp Solutions
- InnovateHub
- Digital Dynamics
- CloudSoft Systems
- DataFlow Analytics

### Candidatos
- 8 candidatos con perfiles completos
- Educación universitaria
- Experiencia laboral variada
- Currículums subidos

### Posiciones
- Desarrollador Full Stack Senior
- Desarrollador Full Stack Junior
- Engineering Manager
- Desarrollador Frontend
- Tech Lead - Backend
- DevOps Engineer Senior
- Data Engineer Senior

### Flujos de Entrevista
- Flujo estándar para desarrolladores junior (3 pasos)
- Flujo completo para desarrolladores senior (5 pasos)
- Flujo rápido para posiciones urgentes (2 pasos)
- Flujo para posiciones de liderazgo técnico (4 pasos)
- Flujo para posiciones de DevOps (4 pasos)

## 🔍 Verificación de Datos

Después de ejecutar `populate-database.sql`, puedes verificar que todo se insertó correctamente ejecutando:

```sql
-- Ver resumen de registros
SELECT 'Company' as "Tabla", COUNT(*) as "Registros" FROM "Company"
UNION ALL
SELECT 'Employee', COUNT(*) FROM "Employee"
UNION ALL
SELECT 'Candidate', COUNT(*) FROM "Candidate"
UNION ALL
SELECT 'Position', COUNT(*) FROM "Position"
UNION ALL
SELECT 'Application', COUNT(*) FROM "Application"
UNION ALL
SELECT 'Interview', COUNT(*) FROM "Interview";
```

**Resultados Esperados:**
- Company: 5
- Employee: 13
- Candidate: 8
- Position: 8
- Application: 13
- Interview: 18

## ⚠️ Notas Importantes

1. **Orden de Ejecución:**
   - Los scripts están diseñados para ejecutarse en el orden correcto
   - No ejecutes solo partes del script, ejecuta todo completo

2. **Foreign Keys:**
   - El script respeta todas las relaciones y foreign keys
   - Si hay un error, verifica que las migraciones estén aplicadas

3. **Secuencias:**
   - Los scripts resetean las secuencias automáticamente
   - Los IDs empezarán desde 1 después de limpiar

4. **Datos Únicos:**
   - Los emails y nombres son únicos
   - Si intentas ejecutar el script dos veces sin limpiar, habrá errores de constraint único

## 🐛 Troubleshooting

### Error: "relation does not exist"
**Solución:** Asegúrate de que las migraciones estén aplicadas:
```bash
cd backend
npx prisma migrate deploy
```

### Error: "duplicate key value violates unique constraint"
**Solución:** Limpia la base de datos primero ejecutando `clean-database.sql`

### Error: "foreign key constraint fails"
**Solución:** Verifica que ejecutaste el script completo, no solo una parte

### Error: "column does not exist"
**Solución:** Verifica que el schema de Prisma esté actualizado y las migraciones aplicadas

## 📝 Personalización

Si quieres agregar más datos de ejemplo:

1. **Editar `populate-database.sql`**
2. **Agregar más INSERT statements** siguiendo el mismo patrón
3. **Respetar las foreign keys** (usar IDs existentes)
4. **Mantener constraints únicos** (emails, nombres únicos)

## 🔗 Relaciones Verificadas

El script valida que todas las relaciones funcionen correctamente:
- ✅ Company → Employee
- ✅ Company → Position
- ✅ Position → InterviewFlow
- ✅ InterviewFlow → InterviewStep
- ✅ InterviewType → InterviewStep
- ✅ Position → Application
- ✅ Candidate → Application
- ✅ Application → Interview
- ✅ InterviewStep → Interview
- ✅ Employee → Interview

## 📚 Próximos Pasos

Después de poblar la base de datos:

1. **Explorar los datos** usando `useful-queries.sql`
2. **Probar la aplicación** con datos reales
3. **Desarrollar nuevas features** usando los datos de ejemplo
4. **Crear reportes** basados en las consultas útiles

---

**¿Necesitas ayuda?** Revisa los comentarios en los scripts SQL o consulta la documentación del proyecto.

