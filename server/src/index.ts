import * as express from 'express'
import * as cors from 'cors'

import { Request } from 'express'

import { createVote, getVotes } from './services/vote'
import { createParty, getCandidatesWithParty } from './services/party'
import { createCandidate } from './services/candidate'

const app = express()
const port = 8000

app.use(express.json()) 
app.use(cors<Request>())

app.post('/api/voting', createVote)
app.get('/api/results', getVotes)
app.post('/api/party', createParty)
app.get('/api/candidates', getCandidatesWithParty)
app.post('/api/candidate', createCandidate)

app.listen(port, () => {
  console.log(`App listening at http://localhost:${port}`)
})
