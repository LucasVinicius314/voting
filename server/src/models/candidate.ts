import { ObjectId } from "mongodb";

export type Candidate = {
  candidateName: string,
  partyId?: ObjectId,
  candidateId?: ObjectId
}
