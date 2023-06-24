import { Double, ObjectId, Timestamp } from "mongodb";

export type Vote = {
  _id: ObjectId
  presidentId: ObjectId,
  mayorId: ObjectId,
  cpf: string,
  gender: string,
  latitude: Double,
  longitude: Double,
  createdAt: Timestamp,
  birthDate: Timestamp,
}
