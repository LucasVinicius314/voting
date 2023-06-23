import { Request, Response } from 'express'
import { collections, connectToDatabase } from './server'

import { ObjectId } from 'mongodb'
import { createMessage } from '../utils/message'

export async function createCandidate(req: Request, res: Response) {
  const client = await connectToDatabase()

  try {
    const candidate = collections.candidate

    if (!candidate) {
      return res
        .status(500)
        .send(createMessage('A coleção candidate não foi encontrada.'))
    }

    const result = await candidate?.insertOne({
      _id: new ObjectId(),
      partyId: new ObjectId(req.body.partyId),
      name: req.body.name,
      code: req.body.code,
      role: req.body.role,
    })
    res.send(result)
  } catch (error) {
    res
      .status(500)
      .send(createMessage('Erro ao criar candidato no banco de dados.'))
  } finally {
    client.close()
  }
}
