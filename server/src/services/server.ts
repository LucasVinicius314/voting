import * as mongoDB from 'mongodb'
import * as dotenv from 'dotenv'
import * as fs from 'fs'

export const collections: {
  vote?: mongoDB.Collection
  candidate?: mongoDB.Collection
  party?: mongoDB.Collection
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

export async function connectToDatabase() {
  dotenv.config()
  const envFileExists = checkEnvFile()

  if (!envFileExists) {
    console.log('.env file does not exist. Error to connect to database')
    return null
  }
  
  const client: mongoDB.MongoClient = new mongoDB.MongoClient(
    process.env.MONGO_URI
  )

  try {
    await client.connect()

    const db: mongoDB.Db = client.db(process.env.DB_NAME)
    const voteCollection: mongoDB.Collection = db.collection(
      process.env.COLLECTION_NAME_VOTE
    )
    collections.vote = voteCollection

    const candidateCollection: mongoDB.Collection = db.collection(
      process.env.COLLECTION_NAME_CANDIDATE
    )
    collections.candidate = candidateCollection

    const partyCollection: mongoDB.Collection = db.collection(
        process.env.COLLECTION_NAME_PARTY
      )
      collections.party = partyCollection

    console.log(
      `Successfully connected to database: ${db.databaseName} and collections: ${voteCollection.collectionName} - ${candidateCollection.collectionName} - ${partyCollection.collectionName}`
    )

    return client
  } catch (error) {
    console.log(`Error to connect database.`)
    client.close()
    return null
  }
}

export async function closeDatabaseConnection(client: mongoDB.MongoClient) {
  try {
    if (client) {
      await client.close()
      console.log('Database connection closed.')
    }
  } catch (error) {
    console.log('Error closing database connection.')
  }
}