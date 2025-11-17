-- Migration: Add Recruitment System Entities
-- Description: Adds Company, Employee, Position, InterviewFlow, InterviewStep, InterviewType, Application, and Interview entities
-- Normalization: 3NF applied - all entities are normalized with proper foreign keys
-- Indexes: Added for performance optimization on foreign keys and frequently queried fields

-- ============================================
-- 1. CREATE NEW TABLES
-- ============================================

-- Company Table
CREATE TABLE "Company" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,

    CONSTRAINT "Company_pkey" PRIMARY KEY ("id")
);

-- Employee Table
CREATE TABLE "Employee" (
    "id" SERIAL NOT NULL,
    "companyId" INTEGER NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "role" VARCHAR(100) NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "Employee_pkey" PRIMARY KEY ("id")
);

-- InterviewFlow Table
CREATE TABLE "InterviewFlow" (
    "id" SERIAL NOT NULL,
    "description" VARCHAR(500) NOT NULL,

    CONSTRAINT "InterviewFlow_pkey" PRIMARY KEY ("id")
);

-- InterviewType Table
CREATE TABLE "InterviewType" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "description" TEXT,

    CONSTRAINT "InterviewType_pkey" PRIMARY KEY ("id")
);

-- InterviewStep Table
CREATE TABLE "InterviewStep" (
    "id" SERIAL NOT NULL,
    "interviewFlowId" INTEGER NOT NULL,
    "interviewTypeId" INTEGER NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "orderIndex" INTEGER NOT NULL,

    CONSTRAINT "InterviewStep_pkey" PRIMARY KEY ("id")
);

-- Position Table
CREATE TABLE "Position" (
    "id" SERIAL NOT NULL,
    "companyId" INTEGER NOT NULL,
    "interviewFlowId" INTEGER NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "description" TEXT,
    "status" VARCHAR(50) NOT NULL,
    "isVisible" BOOLEAN NOT NULL DEFAULT true,
    "location" VARCHAR(255),
    "jobDescription" TEXT,
    "requirements" TEXT,
    "responsibilities" TEXT,
    "salaryMin" DECIMAL(10,2),
    "salaryMax" DECIMAL(10,2),
    "employmentType" VARCHAR(50),
    "benefits" TEXT,
    "companyDescription" TEXT,
    "applicationDeadline" TIMESTAMP(3),
    "contactInfo" VARCHAR(500),

    CONSTRAINT "Position_pkey" PRIMARY KEY ("id")
);

-- Application Table
CREATE TABLE "Application" (
    "id" SERIAL NOT NULL,
    "positionId" INTEGER NOT NULL,
    "candidateId" INTEGER NOT NULL,
    "applicationDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "status" VARCHAR(50) NOT NULL,
    "notes" TEXT,

    CONSTRAINT "Application_pkey" PRIMARY KEY ("id")
);

-- Interview Table
CREATE TABLE "Interview" (
    "id" SERIAL NOT NULL,
    "applicationId" INTEGER NOT NULL,
    "interviewStepId" INTEGER NOT NULL,
    "employeeId" INTEGER NOT NULL,
    "interviewDate" TIMESTAMP(3) NOT NULL,
    "result" VARCHAR(50),
    "score" INTEGER,
    "notes" TEXT,

    CONSTRAINT "Interview_pkey" PRIMARY KEY ("id")
);

-- ============================================
-- 2. CREATE UNIQUE CONSTRAINTS
-- ============================================

-- Company name must be unique
CREATE UNIQUE INDEX "Company_name_key" ON "Company"("name");

-- Employee email must be unique
CREATE UNIQUE INDEX "Employee_email_key" ON "Employee"("email");

-- InterviewType name must be unique
CREATE UNIQUE INDEX "InterviewType_name_key" ON "InterviewType"("name");

-- InterviewStep: unique combination of interviewFlowId and orderIndex
CREATE UNIQUE INDEX "InterviewStep_interviewFlowId_orderIndex_key" ON "InterviewStep"("interviewFlowId", "orderIndex");

-- ============================================
-- 3. ADD FOREIGN KEY CONSTRAINTS
-- ============================================

-- Employee -> Company
ALTER TABLE "Employee" ADD CONSTRAINT "Employee_companyId_fkey" 
    FOREIGN KEY ("companyId") REFERENCES "Company"("id") 
    ON DELETE RESTRICT ON UPDATE CASCADE;

-- Position -> Company
ALTER TABLE "Position" ADD CONSTRAINT "Position_companyId_fkey" 
    FOREIGN KEY ("companyId") REFERENCES "Company"("id") 
    ON DELETE RESTRICT ON UPDATE CASCADE;

-- Position -> InterviewFlow
ALTER TABLE "Position" ADD CONSTRAINT "Position_interviewFlowId_fkey" 
    FOREIGN KEY ("interviewFlowId") REFERENCES "InterviewFlow"("id") 
    ON DELETE RESTRICT ON UPDATE CASCADE;

-- InterviewStep -> InterviewFlow
ALTER TABLE "InterviewStep" ADD CONSTRAINT "InterviewStep_interviewFlowId_fkey" 
    FOREIGN KEY ("interviewFlowId") REFERENCES "InterviewFlow"("id") 
    ON DELETE RESTRICT ON UPDATE CASCADE;

-- InterviewStep -> InterviewType
ALTER TABLE "InterviewStep" ADD CONSTRAINT "InterviewStep_interviewTypeId_fkey" 
    FOREIGN KEY ("interviewTypeId") REFERENCES "InterviewType"("id") 
    ON DELETE RESTRICT ON UPDATE CASCADE;

-- Application -> Position
ALTER TABLE "Application" ADD CONSTRAINT "Application_positionId_fkey" 
    FOREIGN KEY ("positionId") REFERENCES "Position"("id") 
    ON DELETE RESTRICT ON UPDATE CASCADE;

-- Application -> Candidate
ALTER TABLE "Application" ADD CONSTRAINT "Application_candidateId_fkey" 
    FOREIGN KEY ("candidateId") REFERENCES "Candidate"("id") 
    ON DELETE RESTRICT ON UPDATE CASCADE;

-- Interview -> Application
ALTER TABLE "Interview" ADD CONSTRAINT "Interview_applicationId_fkey" 
    FOREIGN KEY ("applicationId") REFERENCES "Application"("id") 
    ON DELETE RESTRICT ON UPDATE CASCADE;

-- Interview -> InterviewStep
ALTER TABLE "Interview" ADD CONSTRAINT "Interview_interviewStepId_fkey" 
    FOREIGN KEY ("interviewStepId") REFERENCES "InterviewStep"("id") 
    ON DELETE RESTRICT ON UPDATE CASCADE;

-- Interview -> Employee
ALTER TABLE "Interview" ADD CONSTRAINT "Interview_employeeId_fkey" 
    FOREIGN KEY ("employeeId") REFERENCES "Employee"("id") 
    ON DELETE RESTRICT ON UPDATE CASCADE;

-- ============================================
-- 4. CREATE INDEXES FOR PERFORMANCE
-- ============================================

-- Company indexes
CREATE INDEX "Company_name_idx" ON "Company"("name");

-- Employee indexes
CREATE INDEX "Employee_companyId_idx" ON "Employee"("companyId");
CREATE INDEX "Employee_email_idx" ON "Employee"("email");
CREATE INDEX "Employee_isActive_idx" ON "Employee"("isActive");
CREATE INDEX "Employee_role_idx" ON "Employee"("role");

-- InterviewFlow indexes
CREATE INDEX "InterviewFlow_description_idx" ON "InterviewFlow"("description");

-- InterviewType indexes
CREATE INDEX "InterviewType_name_idx" ON "InterviewType"("name");

-- InterviewStep indexes
CREATE INDEX "InterviewStep_interviewFlowId_idx" ON "InterviewStep"("interviewFlowId");
CREATE INDEX "InterviewStep_interviewTypeId_idx" ON "InterviewStep"("interviewTypeId");
CREATE INDEX "InterviewStep_orderIndex_idx" ON "InterviewStep"("orderIndex");

-- Position indexes
CREATE INDEX "Position_companyId_idx" ON "Position"("companyId");
CREATE INDEX "Position_interviewFlowId_idx" ON "Position"("interviewFlowId");
CREATE INDEX "Position_status_idx" ON "Position"("status");
CREATE INDEX "Position_isVisible_idx" ON "Position"("isVisible");
CREATE INDEX "Position_applicationDeadline_idx" ON "Position"("applicationDeadline");
CREATE INDEX "Position_title_idx" ON "Position"("title");

-- Application indexes
CREATE INDEX "Application_positionId_idx" ON "Application"("positionId");
CREATE INDEX "Application_candidateId_idx" ON "Application"("candidateId");
CREATE INDEX "Application_status_idx" ON "Application"("status");
CREATE INDEX "Application_applicationDate_idx" ON "Application"("applicationDate");
-- Composite index for common query: find applications by position and candidate
CREATE INDEX "Application_positionId_candidateId_idx" ON "Application"("positionId", "candidateId");

-- Interview indexes
CREATE INDEX "Interview_applicationId_idx" ON "Interview"("applicationId");
CREATE INDEX "Interview_interviewStepId_idx" ON "Interview"("interviewStepId");
CREATE INDEX "Interview_employeeId_idx" ON "Interview"("employeeId");
CREATE INDEX "Interview_interviewDate_idx" ON "Interview"("interviewDate");
CREATE INDEX "Interview_result_idx" ON "Interview"("result");
-- Composite index for common query: find interviews by application and step
CREATE INDEX "Interview_applicationId_interviewStepId_idx" ON "Interview"("applicationId", "interviewStepId");

-- ============================================
-- 5. UPDATE EXISTING TABLES WITH NEW INDEXES
-- ============================================

-- Candidate indexes (if not already exist)
CREATE INDEX IF NOT EXISTS "Candidate_email_idx" ON "Candidate"("email");
CREATE INDEX IF NOT EXISTS "Candidate_lastName_firstName_idx" ON "Candidate"("lastName", "firstName");

-- Education indexes (if not already exist)
CREATE INDEX IF NOT EXISTS "Education_candidateId_idx" ON "Education"("candidateId");
CREATE INDEX IF NOT EXISTS "Education_startDate_idx" ON "Education"("startDate");

-- WorkExperience indexes (if not already exist)
CREATE INDEX IF NOT EXISTS "WorkExperience_candidateId_idx" ON "WorkExperience"("candidateId");
CREATE INDEX IF NOT EXISTS "WorkExperience_startDate_idx" ON "WorkExperience"("startDate");
CREATE INDEX IF NOT EXISTS "WorkExperience_company_idx" ON "WorkExperience"("company");

-- Resume indexes (if not already exist)
CREATE INDEX IF NOT EXISTS "Resume_candidateId_idx" ON "Resume"("candidateId");
CREATE INDEX IF NOT EXISTS "Resume_uploadDate_idx" ON "Resume"("uploadDate");

