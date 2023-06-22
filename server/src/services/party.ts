import { Request, Response } from 'express'

import {
  connectToDatabase,
  collections,
  closeDatabaseConnection,
} from './server'

import { createMessage } from '../utils/message'

export async function createParty(req: Request, res: Response) {
  const client = await connectToDatabase()

  try {
    const party = collections.party

    if (!party) {
      return res
        .status(500)
        .send(createMessage('A coleção party não foi encontrada.'))
    }

    const computeParty = {
      name: req.body.name,
      acronym: req.body.acronym,
    }

    const result = await party?.insertOne(computeParty)
    res.send(result)
  } catch (error) {
    res
      .status(500)
      .send(createMessage('Erro ao criar partido no banco de dados.'))
  } finally {
    if (client) {
      await closeDatabaseConnection(client)
    }
  }
}

export async function getCandidatesWithParty(req: Request, res: Response) {
  const client = await connectToDatabase()

  try {
    const candidateCollection = collections.candidate
    const partyCollection = collections.party

    if (!candidateCollection || !partyCollection) {
      return res
        .status(500)
        .send(createMessage('As coleções não foram encontradas.'))
    }

    const candidates = await candidateCollection.find({}).toArray()
    const parties = await partyCollection.find({}).toArray()

    const partiesWithCandidates = parties.map((party) => {
      const partyCandidates = candidates.filter(
        (candidate) => candidate.partyId.toString() === party._id.toString()
      )

      return {
        ...party,
        candidates: partyCandidates,
      }
    })

    res.send(partiesWithCandidates)
  } catch (error) {
    res
      .status(500)
      .send(createMessage('Erro ao buscar candidatos no banco de dados.'))
  } finally {
    if (client) {
      await closeDatabaseConnection(client)
    }
  }
}
