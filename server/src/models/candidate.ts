import { IntegerType, ObjectId } from "mongodb";

export type Candidate = {
  _id: ObjectId,
  partyId: ObjectId,
  name: string,
  code: IntegerType,
  role: string,
}
