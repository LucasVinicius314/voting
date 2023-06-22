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
      return res
        .status(500)
        .send(createMessage('A coleção vote não foi encontrada.'))
    }

    const { cpf } = req.body

    // Verificar se o voto já foi computado para o CPF
    const existingVote = await vote?.findOne({ cpf })
    if (existingVote) {
      return res
        .status(400)
        .send(createMessage('Já existe um voto para esse CPF.'))
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

export async function getVotes(req: Request, res: Response) {
  const client = await connectToDatabase();

  try {
    const voteCollection = collections.vote;
    const candidateCollection = collections.candidate;
    const partyCollection = collections.party;

    if (!voteCollection || !candidateCollection || !partyCollection) {
      return res.status(500).send(createMessage('As coleções vote, candidate ou party não foram encontradas.'));
    }

    const candidates = await candidateCollection.find().toArray();

    const presidentCandidatePromises = candidates
      .filter(candidate => candidate.role === 'president')
      .map(async (candidate) => {
        const partyId = candidate.partyId;
        const party = await partyCollection.findOne({ _id: partyId });

        const presidentVotes = await voteCollection.countDocuments({ presidentId: candidate._id });

        return {
          primaryLabel: candidate.name,
          secondaryLabel: party?.name || '',
          value: presidentVotes,
        };
      });

    const mayorCandidatePromises = candidates
      .filter(candidate => candidate.role === 'mayor')
      .map(async (candidate) => {
        const partyId = candidate.partyId;
        const party = await partyCollection.findOne({ _id: partyId });

        const mayorVotes = await voteCollection.countDocuments({ mayorId: candidate._id });

        return {
          primaryLabel: candidate.name,
          secondaryLabel: party?.name || '',
          value: mayorVotes,
        };
      });

    const presidentCandidateVotes = await Promise.all(presidentCandidatePromises);
    const mayorCandidateVotes = await Promise.all(mayorCandidatePromises);

    const presidentVoteCount = presidentCandidateVotes.reduce((total, candidate) => total + candidate.value, 0);
    const mayorVoteCount = mayorCandidateVotes.reduce((total, candidate) => total + candidate.value, 0);

    res.json({
      presidentVoteResults: {
        voteCount: presidentVoteCount,
        votesByCandidate: presidentCandidateVotes,
      },
      mayorVoteResults: {
        voteCount: mayorVoteCount,
        votesByCandidate: mayorCandidateVotes,
      },
    });
  } catch (error) {
    res.status(500).send(createMessage('Erro ao buscar votos por candidato no banco de dados.'));
  } finally {
    if (client) {
      await closeDatabaseConnection(client);
    }
  }
}
