import { Request, Response } from 'express'

import {
  connectToDatabase,
  collections,
  closeDatabaseConnection,
} from './server'

import { createMessage } from '../utils/message'

export async function createVote(req: Request, res: Response) {
    const client = await connectToDatabase()

    try {
        const vote = collections.vote

        if (!vote) {
        return res.status(500).send(createMessage('A coleção vote não foi encontrada.'))
        }

        const { cpf } = req.body

        // Verificar se o voto já foi computado para o CPF
        const existingVote = await vote?.findOne({ cpf })
        if (existingVote) {
            return res.status(400).send(createMessage('Já existe um voto para esse CPF.'))
        }

        const computeVote = { 
            presidentId: req.body.presidentId,
            mayorId: req.body.presidentId,
            cpf: req.body.cpf,
            gender: req.body.gender,
            latitude: req.body.latitude,
            longitude: req.body.longitude,
            birthDate: req.body.birthDate,
        }

        const result = await vote?.insertOne(computeVote)
        res.send(result)
    } catch (error) {
        res.status(500).send(createMessage('Erro ao criar voto no banco de dados.'))
    } finally {
        if (client) {
        await closeDatabaseConnection(client)
        }
    }
}