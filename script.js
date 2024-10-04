import express from "express";
import { PrismaClient, Prisma } from "@prisma/client";
import bodyParser from "body-parser";
import ErrorHandler, { handleError } from "./helper/Error.js";

const app = express();
const prisma = new PrismaClient();
const PORT = 3000;

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

app.post("/createStudent", async (req, res, next) => {
  try {
    const student = await prisma.student.create({
      data: req.body,
    });
    res.json(student);
  } catch (err) {
    // console.log(err);
    if(err instanceof  Prisma.PrismaClientKnownRequestError) {
      next(new ErrorHandler( 400, "student not created"));
    }
    next(err);
  } finally {
    await prisma.$disconnect();
  }
});

app.get("/students", async (req, res) => {
  try {
    const students = await prisma.student.findMany({
      include: {
        StudentInfo: true,
        StudentSubjects: true,
      },
    });
    res.json(students);
  } catch (err) {
    console.log(err);
  } finally {
    await prisma.$disconnect();
  }
});

app.get("/students/:id", async (req, res, next) => {
  try {
    const students = await prisma.student.findFirst({
      where: {
        student_id: req.params.id,
      },
      include: {
        StudentInfo: {
          include: {
            class: true,
            school: true,
          },
        },
        StudentSubjects: true,
      },
    });
    if (students === null) {
      throw new ErrorHandler(404, "student not foumd");
    }
    res.json(students);
  } catch (err) {
    console.log(err);
    next(err);
  } finally {
    await prisma.$disconnect();
  }
});

app.post("/createClass", async (req, res) => {
  try {
    const classData = await prisma.class.create({
      data: req.body,
    });
    res.json(classData);
  } catch (err) {
    console.log(err);
  } finally {
    await prisma.$disconnect();
  }
});

app.post("/createSchool", async (req, res) => {
  try {
    const school = await prisma.school.create({
      data: req.body,
    });
    res.json(school);
  } catch (err) {
    console.log(err);
  } finally {
    await prisma.$disconnect();
  }
});

app.post("/createStudentInfo", async (req, res) => {
  try {
    const studentInfo = await prisma.studentInfo.create({
      data: req.body,
    });
    res.json(studentInfo);
  } catch (err) {
    console.log(err);
  } finally {
    await prisma.$disconnect();
  }
});

app.get("/studentInfo/:id", async (req, res) => {
  try {
    const student = await prisma.studentInfo.findUnique({
      where: {
        student_id: req.params.id,
        connect: {
          studentSubjects: true,
        },
      },
      include: {
        student: true,
        class: true,
        school: true,
      },
    });
    res.json(student);
  } catch (err) {
    console.log(err);
  } finally {
    await prisma.$disconnect();
  }
});

app.post("/createSubject", async (req, res) => {
  try {
    const subject = await prisma.subjects.create({
      data: req.body,
    });
    res.json(subject);
  } catch (err) {
    console.log(err);
  } finally {
    await prisma.$disconnect();
  }
});

app.post("/subjectToStudent", async (req, res) => {
  try {
    const response = await prisma.studentSubjects.createMany({
      data: req.body.subject_id.map((subject) => ({
        student_id: req.body.student_id,
        subject_id: subject,
      })),
    });
    res.json(response);
  } catch (err) {
    console.log(err);
  } finally {
    await prisma.$disconnect();
  }
});

// app.post("/example", async (req, res) => {
//   try {
//     console.log(req.body.subjects);
//     const response = await prisma.studentInfo.create({
//       data: {
//         ...req.body.info,
//         studentSubjects: {
//           create: req.body.subjects.map((subject) => {
//             connect: {
//               student_id: req.body.info.student_id;
//               subject_id: subject
//             }
//           })
//         }
//       }
//     });
//     res.json(response);
//   } catch (err) {
//     console.log(err);
//   } finally {
//     await prisma.$disconnect();
//   }
// })

app.post("/createNotes", async (req, res) => {
  try {
    const notes = await prisma.notes.create({
      data: req.body,
    });
    res.json(notes);
  } catch (err) {
    console.log(err);
  } finally {
    await prisma.$disconnect();
  }
});

app.post("/createTest", async (req, res) => {
  try {
    const testPaper = await prisma.testPaper.create({
      data: req.body,
    });
    res.json(testPaper);
  } catch (err) {
    console.log(err);
  } finally {
    await prisma.$disconnect();
  }
});

app.post("/testToStudent", async (req, res) => {
  try {
    const response = await prisma.testPaperStudents.create({
      data: req.body,
    });
    res.json(response);
  } catch (err) {
    console.log(err);
  }
});

app.use(handleError);

app.listen(PORT, () => {
  console.log("Server is running on http://localhost:3000");
});
