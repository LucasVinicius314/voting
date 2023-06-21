import * as express from 'express'
import * as cors from 'cors'

import { Request } from 'express'
import { createVote } from './services/vote'

const app = express()
const port = 8000

app.use(express.json()) 
app.use(cors<Request>())

app.post('/votacao', createVote)

app.listen(port, () => {
  console.log(`App listening at http://localhost:${port}`)
})
