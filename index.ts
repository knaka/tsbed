import { Prisma, PrismaClient } from './prisma/client'

const prisma = new PrismaClient()

const authorData: Prisma.authorsCreateInput = {
  name: 'Alice',
  created_at: '',
  updated_at: '',
}

async function main() {
  const allUsers = await prisma.authors.findMany()
  console.log(allUsers)
}
main()
  .catch((e) => {
    throw e
  })
  .finally(async () => {
    await prisma.$disconnect()
  })
