import { Prisma, PrismaClient } from "@prisma/client";
import { Decimal } from "@prisma/client/runtime";

const main = async () => {
    const db = new PrismaClient();

    const deleted = await db.jsonSerialize.deleteMany();
    console.log(`Delete ${JSON.stringify(deleted)}`);

    console.log("Create")
    const create = await db.jsonSerialize.createMany({
        data: [
            { value: Prisma.DbNull },
            { value: Prisma.JsonNull },
            { value: false },
            { value: true },
            { value: 0 },
            { value: 0.0000 },
            { value: 1 },
            { value: -1 },
            { value: Number.MAX_VALUE },
            { value: Number.MIN_VALUE },
            { value: Number.MAX_SAFE_INTEGER },
            { value: Number.MIN_SAFE_INTEGER },
            { value: "" },
            { value: "ฟกด๑๒" },
            { value: "qwerty1234" },
            { value: "QWERTY@456" },
            { value: (new Decimal("1111111111111111.333333333333333333333333333333333333333333")).toJSON() },
            { value: (new Decimal("1111111111111111.333333333333333333333333333333333333333333")).toString() },
            { value: BigInt("1234567890").toString() },
            {
                value: {
                    true: true,
                    false: false,
                    0: 0,
                    1: 1
                }
            },
        ]
    });
    console.log(`Create ${JSON.stringify(create, undefined, 2)}`);

    console.log("FindMany");
    const find = await db.jsonSerialize.findMany();
    console.log(JSON.stringify(find, undefined, 2));

    // find string
    const queries: Prisma.JsonNullableFilter[] = [
        { string_contains: "Q" },
        { string_contains: "w" },
        { string_contains: "ฟ" },
        { gte: 1 },
        { lte: 1 },
        { lt: "0" },
        { gt: "0" },
        { equals: true }
    ];

    const queriesResult = await Promise.all(
        queries.map(
            async (value) => {
                const result = await db.jsonSerialize.findMany({
                    where: { value }
                });

                return [value, result];
            }
        )
    );

    queriesResult.forEach(i => {
        console.log("----------------");
        console.log(JSON.stringify(i[0]));
        console.log(i[1]);
    });


};


main();