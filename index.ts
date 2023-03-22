import { Prisma, PrismaClient } from './prisma/client'

const pclient = new PrismaClient()

const authorData: Prisma.authorsCreateInput = {
  name: 'Alice',
  email: 'hoge@example.com',
  created_at: '',
  updated_at: '',
}

async function main() {
  // const allUsers = await pclient.authors.findMany()
  const allUsers = await pclient.authors.findMany(
    {
      where: {
        OR: {
          name: "foo",
        }
      }
    }
  )
  console.log(allUsers)
}
main()
  .catch((e) => {
    throw e
  })
  .finally(async () => {
    await pclient.$disconnect()
  })
