import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();


async function main() {
    const user = await prisma.user.create({
        data: {
            email: "abc@gmail.com",
            name: "example2",
        }
    })
    console.log(user);
}
main().catch(e => console.log(e.message))