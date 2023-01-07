-- CreateEnum
CREATE TYPE "valueType" AS ENUM ('integer', 'float', 'decimal', 'boolean', 'bigint', 'string', 'range', 'fraction');

-- CreateTable
CREATE TABLE "manyNullableColumns" (
    "id" UUID NOT NULL,
    "valueBoolean" BOOLEAN,
    "valueBigInt" BIGINT,
    "valueString" TEXT,
    "valueDecimal" DECIMAL(65,30),

    CONSTRAINT "manyNullableColumns_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "stringSerialize" (
    "id" UUID NOT NULL,
    "value" TEXT,
    "valueType" "valueType" NOT NULL,

    CONSTRAINT "stringSerialize_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "jsonSerialize" (
    "id" UUID NOT NULL,
    "value" JSONB,

    CONSTRAINT "jsonSerialize_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "stringHolder" (
    "id" UUID NOT NULL,
    "value" TEXT NOT NULL,

    CONSTRAINT "stringHolder_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "bigintHolder" (
    "id" UUID NOT NULL,
    "value" BIGINT NOT NULL,

    CONSTRAINT "bigintHolder_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "decimalHolder" (
    "id" UUID NOT NULL,
    "value" DECIMAL(65,30) NOT NULL,

    CONSTRAINT "decimalHolder_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "booleanHolder" (
    "id" UUID NOT NULL,
    "value" BOOLEAN NOT NULL,

    CONSTRAINT "booleanHolder_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "strictBooleanHolder" (
    "id" UUID NOT NULL,

    CONSTRAINT "strictBooleanHolder_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "nullableBooleanHolder" (
    "id" UUID NOT NULL,
    "value" BOOLEAN,

    CONSTRAINT "nullableBooleanHolder_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "rangeHolder" (
    "id" UUID NOT NULL,
    "upperboundValue" DECIMAL(65,30),
    "includedUpperbound" BOOLEAN NOT NULL,
    "lowerboundValue" DECIMAL(65,30),
    "includeLowerbound" BOOLEAN NOT NULL,

    CONSTRAINT "rangeHolder_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "storeValue1" (
    "id" UUID NOT NULL,

    CONSTRAINT "storeValue1_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "storeValue2" (
    "id" UUID NOT NULL,

    CONSTRAINT "storeValue2_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "storeValue1ToStringHolder" (
    "storeValueId" UUID NOT NULL,
    "stringHolderId" UUID NOT NULL
);

-- CreateTable
CREATE TABLE "storeValue1ToDecimalHolder" (
    "storeValueId" UUID NOT NULL,
    "decimalHolderId" UUID NOT NULL
);

-- CreateTable
CREATE TABLE "storeValue2ToStringHolder" (
    "storeValueId" UUID NOT NULL,
    "stringHolderId" UUID NOT NULL
);

-- CreateTable
CREATE TABLE "storeValue1ToRangeHolder" (
    "storeValueId" UUID NOT NULL,
    "rangeHolderId" UUID NOT NULL
);

-- CreateTable
CREATE TABLE "storeValue2ToDecimalHolder" (
    "storeValueId" UUID NOT NULL,
    "decimalHolderId" UUID NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "storeValue1ToStringHolder_storeValueId_key" ON "storeValue1ToStringHolder"("storeValueId");

-- CreateIndex
CREATE UNIQUE INDEX "storeValue1ToStringHolder_stringHolderId_key" ON "storeValue1ToStringHolder"("stringHolderId");

-- CreateIndex
CREATE UNIQUE INDEX "storeValue1ToDecimalHolder_storeValueId_key" ON "storeValue1ToDecimalHolder"("storeValueId");

-- CreateIndex
CREATE UNIQUE INDEX "storeValue1ToDecimalHolder_decimalHolderId_key" ON "storeValue1ToDecimalHolder"("decimalHolderId");

-- CreateIndex
CREATE UNIQUE INDEX "storeValue2ToStringHolder_storeValueId_key" ON "storeValue2ToStringHolder"("storeValueId");

-- CreateIndex
CREATE UNIQUE INDEX "storeValue2ToStringHolder_stringHolderId_key" ON "storeValue2ToStringHolder"("stringHolderId");

-- CreateIndex
CREATE UNIQUE INDEX "storeValue1ToRangeHolder_rangeHolderId_key" ON "storeValue1ToRangeHolder"("rangeHolderId");

-- CreateIndex
CREATE UNIQUE INDEX "storeValue2ToDecimalHolder_decimalHolderId_key" ON "storeValue2ToDecimalHolder"("decimalHolderId");

-- AddForeignKey
ALTER TABLE "storeValue1ToStringHolder" ADD CONSTRAINT "storeValue1ToStringHolder_storeValueId_fkey" FOREIGN KEY ("storeValueId") REFERENCES "storeValue1"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "storeValue1ToStringHolder" ADD CONSTRAINT "storeValue1ToStringHolder_stringHolderId_fkey" FOREIGN KEY ("stringHolderId") REFERENCES "stringHolder"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "storeValue1ToDecimalHolder" ADD CONSTRAINT "storeValue1ToDecimalHolder_storeValueId_fkey" FOREIGN KEY ("storeValueId") REFERENCES "storeValue1"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "storeValue1ToDecimalHolder" ADD CONSTRAINT "storeValue1ToDecimalHolder_decimalHolderId_fkey" FOREIGN KEY ("decimalHolderId") REFERENCES "decimalHolder"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "storeValue2ToStringHolder" ADD CONSTRAINT "storeValue2ToStringHolder_storeValueId_fkey" FOREIGN KEY ("storeValueId") REFERENCES "storeValue2"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "storeValue2ToStringHolder" ADD CONSTRAINT "storeValue2ToStringHolder_stringHolderId_fkey" FOREIGN KEY ("stringHolderId") REFERENCES "stringHolder"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "storeValue1ToRangeHolder" ADD CONSTRAINT "storeValue1ToRangeHolder_storeValueId_fkey" FOREIGN KEY ("storeValueId") REFERENCES "storeValue1"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "storeValue1ToRangeHolder" ADD CONSTRAINT "storeValue1ToRangeHolder_rangeHolderId_fkey" FOREIGN KEY ("rangeHolderId") REFERENCES "rangeHolder"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "storeValue2ToDecimalHolder" ADD CONSTRAINT "storeValue2ToDecimalHolder_storeValueId_fkey" FOREIGN KEY ("storeValueId") REFERENCES "storeValue2"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "storeValue2ToDecimalHolder" ADD CONSTRAINT "storeValue2ToDecimalHolder_decimalHolderId_fkey" FOREIGN KEY ("decimalHolderId") REFERENCES "decimalHolder"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
