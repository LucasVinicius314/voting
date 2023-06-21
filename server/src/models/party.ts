import { ObjectId } from "mongodb";

export type Party = {
  partyName: string,
  partyId?: ObjectId,
}
