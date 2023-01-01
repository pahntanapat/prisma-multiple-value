# Prisma Multiple Value  

Try store different value type in one table

See [prisma/schema.prisma] for detail

## 1. Numerous nullable columns

```prisma
model manyNullableColumns {
    id           String   @id @default(uuid()) @db.Uuid
    valueBoolean Boolean?
    valueBigInt  BigInt?
    valueString  String?
    valueDecimal Decimal?
}
```

## 2. Serialization

### 2.1. String serialization

```prisma
enum valueType {
    integer
    float
    decimal
    boolean
    bigint
    string
    range // [0,1] (-1,5)
    fraction
}

model stringSerialize {
    id        String    @id @default(uuid()) @db.Uuid
    // value
    value     String?
    valueType valueType
}
```

### 2.2. JSON serialization

```prisma
model jsonSerialize {
    id    String @id @default(uuid()) @db.Uuid
    // value
    value Json?  @db.JsonB
}
```

## 3. Relation tables

These consists of holder table(s), store table(s), and join table(s).

### Holder table

```prisma
model stringHolder {
    id                        String                     @id @default(uuid()) @db.Uuid
    value                     String
    storeValueToStringHolder  storeValue1ToStringHolder?
    storeValue2ToStringHolder storeValue2ToStringHolder?
}

model decimalHolder {
    id                         String                       @id @default(uuid()) @db.Uuid
    value                      Decimal
    storeValueToDecimalHolder  storeValue1ToDecimalHolder[]
    storeValue2ToDecimalHolder storeValue2ToDecimalHolder?
}

model rangeHolder {
    id                      String                     @id @default(uuid()) @db.Uuid
    upperboundValue         Decimal?
    includedUpperbound      Boolean
    lowerboundValue         Decimal?
    includeLowerbound       Boolean
    storeValueToRangeHolder storeValue1ToRangeHolder[]
}
```

### Store table

```prisma
// The table to store value
model storeValue1 {
    id                        String                      @id @default(uuid()) @db.Uuid
    // other columns here
    storeValueToStringHolder  storeValue1ToStringHolder?
    storeValueToDecimalHolder storeValue1ToDecimalHolder?
    storeValueToRangeHolder   storeValue1ToRangeHolder[]
}

model storeValue2 {
    id                        String                       @id @default(uuid()) @db.Uuid
    // other columns here
    storeValueToStringHolder  storeValue2ToStringHolder?
    storeValueToDecimalHolder storeValue2ToDecimalHolder[]
}
```



### Join table

```prisma
model storeValue1ToStringHolder {
    // strict 1:1
    storeValueId   String       @unique @db.Uuid
    storeValue     storeValue1  @relation(fields: [storeValueId], references: [id])
    ///
    stringHolderId String       @unique @db.Uuid
    stringHolder   stringHolder @relation(fields: [stringHolderId], references: [id])
}

model storeValue1ToDecimalHolder {
    // strict 1:1
    storeValueId    String        @unique @db.Uuid
    storeValue      storeValue1   @relation(fields: [storeValueId], references: [id])
    ///
    decimalHolderId String        @unique @db.Uuid
    decimalHolder   decimalHolder @relation(fields: [decimalHolderId], references: [id])
}

model storeValue2ToStringHolder {
    // strict 1:1
    storeValueId   String       @unique @db.Uuid
    storeValue     storeValue2  @relation(fields: [storeValueId], references: [id])
    ///
    stringHolderId String       @unique @db.Uuid
    stringHolder   stringHolder @relation(fields: [stringHolderId], references: [id])
}

// example of 1:M  one holder has many value e.g. like a list
model storeValue1ToRangeHolder {
    // many storeValue to only one valueHolder
    storeValueId  String      @db.Uuid
    storeValue    storeValue1 @relation(fields: [storeValueId], references: [id])
    ///
    rangeHolderId String      @unique @db.Uuid
    rangeHolder   rangeHolder @relation(fields: [rangeHolderId], references: [id])
}

model storeValue2ToDecimalHolder {
    // many storeValue to one ValueHolder
    storeValueId    String        @db.Uuid
    storeValue      storeValue2   @relation(fields: [storeValueId], references: [id])
    ///
    decimalHolderId String        @unique @db.Uuid
    decimalHolder   decimalHolder @relation(fields: [decimalHolderId], references: [id])
}

// many to many is not recommended

```
