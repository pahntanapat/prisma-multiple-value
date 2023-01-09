import { Decimal } from "@prisma/client/runtime";

const main = async () => {
    console.log(`${new Decimal(Number.NEGATIVE_INFINITY)}, ${(new Decimal(Number.NEGATIVE_INFINITY)) < (new Decimal(0))}`);
    console.log(`${(new Decimal(Number.NEGATIVE_INFINITY)).minus(new Decimal(0))}`);
    console.log(`${(new Decimal(Number.NEGATIVE_INFINITY)).minus(new Decimal(Number.NEGATIVE_INFINITY))}`);
    console.log(`${(new Decimal(Number.NEGATIVE_INFINITY)).minus(new Decimal(Number.POSITIVE_INFINITY))}`);
};

main();