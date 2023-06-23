import * as cors from 'cors'
import * as express from 'express'

import { createParty, getCandidatesWithParty } from './services/party'
import { createVote, getVotes } from './services/vote'

import { Request } from 'express'
import { createCandidate } from './services/candidate'
import { json } from 'body-parser'
import { mongoSetup } from './services/server'

const setup = async () => {
  await mongoSetup()

  const app = express()
  const port = 8000

  app.use(json())
  app.use(cors<Request>())

  app.use((req, res, next) => {
    console.info(`${req.method} ${req.path}`)

    next()
  })

  const apiRouter = express.Router()

  apiRouter.post('/vote', createVote)
  apiRouter.get('/results', getVotes)
  apiRouter.get('/candidates', getCandidatesWithParty)

  apiRouter.post('/party', createParty)
  apiRouter.post('/candidate', createCandidate)

  app.use('/api', apiRouter)

  app.listen(port, () => {
    console.log(`App listening at http://localhost:${port}`)
  })
}

setup()
