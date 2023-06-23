import { Request, Response } from 'express'
import { collections, connectToDatabase } from './server'

import { ObjectId } from 'mongodb'
import { Party } from '../models/party'
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

    const result = await party?.insertOne({
      _id: new ObjectId(),
      name: req.body.name,
      acronym: req.body.acronym,
      candidates: [],
    })
    res.send(result)
  } catch (error) {
    res
      .status(500)
      .send(createMessage('Erro ao criar partido no banco de dados.'))
  } finally {
    await client.close()
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

    const parties = await partyCollection.find({}).toArray()

    const presidentPartyMap: { [key: string]: Party } = {}
    const mayorPartyMap: { [key: string]: Party } = {}

    for (const party of parties) {
      presidentPartyMap[party._id.toString()] = Object.assign(
        { candidates: [] },
        party
      )
      mayorPartyMap[party._id.toString()] = Object.assign(
        { candidates: [] },
        party
      )
    }

    const presidentCandidates = await candidateCollection
      .find({ role: 'president' })
      .toArray()

    for (const candidate of presidentCandidates) {
      presidentPartyMap[candidate.partyId.toString()].candidates.push(candidate)
    }

    const mayorCandidates = await candidateCollection
      .find({ role: 'mayor' })
      .toArray()

    for (const mayor of mayorCandidates) {
      mayorPartyMap[mayor.partyId.toString()].candidates.push(mayor)
    }

    res.send({
      president: Object.values(presidentPartyMap),
      mayor: Object.values(mayorPartyMap),
    })
  } catch (error) {
    res
      .status(500)
      .send(createMessage('Erro ao buscar candidatos no banco de dados.'))
  } finally {
    await client.close()
  }
}
