import * as dotenv from 'dotenv'
import * as fs from 'fs'
import * as mongoDB from 'mongodb'

import { Candidate } from '../models/candidate'
import { Party } from '../models/party'
import { Vote } from '../models/vote'

export const collections: {
  vote?: mongoDB.Collection<Vote>
  candidate?: mongoDB.Collection<Candidate>
  party?: mongoDB.Collection<Party>
} = {}

function checkEnvFile() {
  const envFilePath = './.env'

  try {
    fs.accessSync(envFilePath, fs.constants.F_OK)
    return true
  } catch (error) {
    return false
  }
}

export async function mongoSetup() {
  dotenv.config()
  const envFileExists = checkEnvFile()

  if (!envFileExists) {
    console.log('.env file does not exist. Error connecting to to database.')
    return
  }

  const client = new mongoDB.MongoClient(process.env.MONGO_URI)

  try {
    await client.connect()

    const db = client.db(process.env.DB_NAME)

    collections.vote = db.collection<Vote>(process.env.COLLECTION_NAME_VOTE)

    collections.candidate = db.collection<Candidate>(
      process.env.COLLECTION_NAME_CANDIDATE
    )

    collections.party = db.collection<Party>(process.env.COLLECTION_NAME_PARTY)

    console.log(
      `Successfully connected to database: ${db.databaseName} and collections: ${collections.vote.collectionName} - ${collections.candidate.collectionName} - ${collections.party.collectionName}`
    )
  } catch (error) {
    console.error(`Error to connecting to database.`, error)

    throw error
  }
}

export async function connectToDatabase(): Promise<mongoDB.MongoClient> {
  return new mongoDB.MongoClient(process.env.MONGO_URI).connect()
}
