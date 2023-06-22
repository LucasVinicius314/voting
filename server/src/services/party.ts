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
        return res.status(500).send(createMessage('A coleção party não foi encontrada.'))
        }

        const computeParty = { 
            name: req.body.name,
            acronym: req.body.acronym
        }

        const result = await party?.insertOne(computeParty)
        res.send(result)
    } catch (error) {
        res.status(500).send(createMessage('Erro ao criar partido no banco de dados.'))
    } finally {
        if (client) {
        await closeDatabaseConnection(client)
        }
    }
}