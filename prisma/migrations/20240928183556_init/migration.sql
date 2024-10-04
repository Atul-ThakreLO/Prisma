-- CreateTable
CREATE TABLE "Class" (
    "class_id" TEXT NOT NULL,
    "class_name" TEXT NOT NULL,

    CONSTRAINT "Class_pkey" PRIMARY KEY ("class_id")
);

-- CreateTable
CREATE TABLE "School" (
    "school_id" TEXT NOT NULL,
    "school_name" TEXT NOT NULL,

    CONSTRAINT "School_pkey" PRIMARY KEY ("school_id")
);

-- CreateTable
CREATE TABLE "Subjects" (
    "subject_id" TEXT NOT NULL,
    "subject_name" TEXT NOT NULL,
    "class_id" TEXT NOT NULL,

    CONSTRAINT "Subjects_pkey" PRIMARY KEY ("subject_id")
);

-- CreateTable
CREATE TABLE "Student" (
    "student_id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,

    CONSTRAINT "Student_pkey" PRIMARY KEY ("student_id")
);

-- CreateTable
CREATE TABLE "StudentInfo" (
    "id" TEXT NOT NULL,
    "student_name" TEXT NOT NULL,
    "mobile" TEXT NOT NULL,
    "student_id" TEXT NOT NULL,
    "class_id" TEXT NOT NULL,
    "school_id" TEXT NOT NULL,

    CONSTRAINT "StudentInfo_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "StudentFeesPaid" (
    "id" TEXT NOT NULL,
    "student_id" TEXT NOT NULL,
    "class_id" TEXT NOT NULL,
    "school_id" TEXT NOT NULL,
    "amount" DECIMAL(65,30) NOT NULL,
    "date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "StudentFeesPaid_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "StudentSubjects" (
    "student_id" TEXT NOT NULL,
    "subject_id" TEXT NOT NULL,

    CONSTRAINT "StudentSubjects_pkey" PRIMARY KEY ("student_id","subject_id")
);

-- CreateTable
CREATE TABLE "Notes" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "url" TEXT NOT NULL,
    "subject_id" TEXT NOT NULL,

    CONSTRAINT "Notes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Papers" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "url" TEXT NOT NULL,
    "subject_id" TEXT NOT NULL,

    CONSTRAINT "Papers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TestPaper" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "subject_id" TEXT NOT NULL,

    CONSTRAINT "TestPaper_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TestPaperStudents" (
    "student_id" TEXT NOT NULL,
    "test_paper_id" TEXT NOT NULL,
    "marks" DECIMAL(65,30) NOT NULL,

    CONSTRAINT "TestPaperStudents_pkey" PRIMARY KEY ("student_id","test_paper_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Student_email_key" ON "Student"("email");

-- CreateIndex
CREATE UNIQUE INDEX "StudentInfo_student_id_key" ON "StudentInfo"("student_id");

-- AddForeignKey
ALTER TABLE "Subjects" ADD CONSTRAINT "Subjects_class_id_fkey" FOREIGN KEY ("class_id") REFERENCES "Class"("class_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StudentInfo" ADD CONSTRAINT "StudentInfo_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "Student"("student_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StudentInfo" ADD CONSTRAINT "StudentInfo_class_id_fkey" FOREIGN KEY ("class_id") REFERENCES "Class"("class_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StudentInfo" ADD CONSTRAINT "StudentInfo_school_id_fkey" FOREIGN KEY ("school_id") REFERENCES "School"("school_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StudentFeesPaid" ADD CONSTRAINT "StudentFeesPaid_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "Student"("student_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StudentFeesPaid" ADD CONSTRAINT "StudentFeesPaid_class_id_fkey" FOREIGN KEY ("class_id") REFERENCES "Class"("class_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StudentFeesPaid" ADD CONSTRAINT "StudentFeesPaid_school_id_fkey" FOREIGN KEY ("school_id") REFERENCES "School"("school_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StudentSubjects" ADD CONSTRAINT "StudentSubjects_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "Student"("student_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StudentSubjects" ADD CONSTRAINT "StudentSubjects_subject_id_fkey" FOREIGN KEY ("subject_id") REFERENCES "Subjects"("subject_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Notes" ADD CONSTRAINT "Notes_subject_id_fkey" FOREIGN KEY ("subject_id") REFERENCES "Subjects"("subject_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Papers" ADD CONSTRAINT "Papers_subject_id_fkey" FOREIGN KEY ("subject_id") REFERENCES "Subjects"("subject_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TestPaper" ADD CONSTRAINT "TestPaper_subject_id_fkey" FOREIGN KEY ("subject_id") REFERENCES "Subjects"("subject_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TestPaperStudents" ADD CONSTRAINT "TestPaperStudents_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "Student"("student_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TestPaperStudents" ADD CONSTRAINT "TestPaperStudents_test_paper_id_fkey" FOREIGN KEY ("test_paper_id") REFERENCES "TestPaper"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
