import * as express from 'express'
import * as cors from 'cors'

import { Request } from 'express'

const app = express()
const port = 8000

app.use(express.json()) 
app.use(cors<Request>())


app.listen(port, () => {
  console.log(`App listening at http://localhost:${port}`)
})
