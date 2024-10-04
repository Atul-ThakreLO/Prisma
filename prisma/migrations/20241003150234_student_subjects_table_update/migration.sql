/*
  Warnings:

  - A unique constraint covering the columns `[student_id,subject_id]` on the table `StudentSubjects` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "StudentSubjects_student_id_subject_id_key" ON "StudentSubjects"("student_id", "subject_id");
