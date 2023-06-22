import { Request, Response } from 'express'

import {
  connectToDatabase,
  collections,
  closeDatabaseConnection,
} from './server'

import { createMessage } from '../utils/message'

export async function createCandidate(req: Request, res: Response) {
    const client = await connectToDatabase()

    try {
        const candidate = collections.candidate

        if (!candidate) {
        return res.status(500).send(createMessage('A coleção candidate não foi encontrada.'))
        }

        const computeCandidate = { 
            partyId: req.body.partyId,
            name: req.body.name,
            code: req.body.code,
            role: req.body.role
        }

        const result = await candidate?.insertOne(computeCandidate)
        res.send(result)
    } catch (error) {
        res.status(500).send(createMessage('Erro ao criar candidato no banco de dados.'))
    } finally {
        if (client) {
            await closeDatabaseConnection(client)
        }
    }
}

export async function getCandidates(req: Request, res: Response) {
    const client = await connectToDatabase();
  
    try {
      const candidateCollection = collections.candidate;
      const partyCollection = collections.party;
  
      if (!candidateCollection || !partyCollection) {
        return res.status(500).send(createMessage('As coleções candidate ou party não foram encontradas.'));
      }
  
      const candidates = await candidateCollection.find().toArray();
  
      const candidatePromises = candidates.map(async (candidate) => {
        const partyId = candidate.partyId;
        const party = await partyCollection.findOne({ _id: partyId });
  
        return {
          ...candidate,
          party,
        };
      });
  
      const candidatesWithParty = await Promise.all(candidatePromises);
  
      res.send(candidatesWithParty);
    } catch (error) {
      res.status(500).send(createMessage('Erro ao buscar candidatos no banco de dados.'));
    } finally {
      if (client) {
        await closeDatabaseConnection(client);
      }
    }
  }
  