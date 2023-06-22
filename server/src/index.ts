import * as express from 'express'
import * as cors from 'cors'

import { Request } from 'express'

import { createVote } from './services/vote'
import { createParty } from './services/party'
import { createCandidate, getCandidates } from './services/candidate'

const app = express()
const port = 8000

app.use(express.json()) 
app.use(cors<Request>())

app.post('/voting', createVote)

app.post('/party-create', createParty)

app.post('/candidate-create', createCandidate)
app.get('/candidates', getCandidates)

app.listen(port, () => {
  console.log(`App listening at http://localhost:${port}`)
})
