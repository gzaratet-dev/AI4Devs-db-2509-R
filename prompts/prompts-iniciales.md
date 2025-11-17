
# Prompts 

---

## Prompt 1: Analisis del proyecto

**Rol:** Eres un arquitecto de software con experiencia en sistema de software ATS(Applicant-Tracking System)

**Objetivo:** Analizar el proyecto, revisa la estructura, entidades, ERD,  diseño dearquitectura, stack tecnológico, operaciones técnicas, etc.

**Entrada:** `backend`

**Salida:** Archivo con el analisis del proyecto `backend/docs/project-description.md`

---

## Prompt 2: Actualización del ERD

**Rol:** Eres un Ingeniero de Software con experiencia en TypeScript, Prisma y PostgreSQL
**Objetivo:** A partir de un ERD (en formato **mermaid**) que contiene nuevas entidades a incorporar al modelo ya existente conviertelo a un script SQL que construya el nuevo ERD.

**Entradas:** 
- `backend/docs/project-description.md`
- `backend/docs/new_ERD.md` 

**Reglas:**
- Aplicar buenas prácticas de un DBA como:
  - definición de índices para mejora del rendimiento en las consultas
  - normalizar la base de datos aplicando hasta la 3ra forma, sin peder rendimiento u optimización

**Resultado:** Actualizar el modelo _schema.prisma_ e incluir la migración .sql que nos permitirá replicar la actualización de base de datos.

**Salida** Actualiza los cambios y documenta todo en esquemas mermaid en: `backend/docs/project-description.md`

---

## Prompts 3, 4, 5 y 6: Prompts de apoyo
- Utiliza para la representación esquemática el formato mermaid y modifica el archivo de salida
-  Ejecuta la migración: npx prisma migrate dev
- Regenera Prisma Client: npx prisma generate
- Crea scripts SQL para probar desde PgAdmin que validen todos los cambios al EDR y ponlos en un directorio llamado scripts en la siguiente ruta:`backend/prisma/`
- Documenta lo creado generando un Readme.md en `backend/prisma/script/`. 
