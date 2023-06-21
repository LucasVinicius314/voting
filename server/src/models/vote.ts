import { Double, ObjectId, Timestamp } from "mongodb";

export type Vote = {
  presidentId: ObjectId,
  presidentPartyId: ObjectId,
  mayorId: ObjectId,
  mayorPartyId: ObjectId,
  cpf: string,
  gender: string,
  latitude: Double,
  longitude: Double,
  birthDate: Timestamp,
  id?: ObjectId
}
