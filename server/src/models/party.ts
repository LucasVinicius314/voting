import { Candidate } from './candidate'
import { ObjectId } from 'mongodb'

export type Party = {
  _id: ObjectId
  name: string
  acronym: string
  candidates: Candidate[]
}
