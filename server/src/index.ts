import * as express from 'express'
import * as cors from 'cors'

import { Request } from 'express'

import { createVote, getVotesPerCandidate } from './services/vote'
import { createParty, getCandidatesWithParty } from './services/party'
import { createCandidate } from './services/candidate'

const app = express()
const port = 8000

app.use(express.json()) 
app.use(cors<Request>())

app.post('/voting', createVote)
app.get('/analytics', getVotesPerCandidate)

app.post('/party-create', createParty)
app.get('/candidates', getCandidatesWithParty)

app.post('/candidate-create', createCandidate)

app.listen(port, () => {
  console.log(`App listening at http://localhost:${port}`)
})
