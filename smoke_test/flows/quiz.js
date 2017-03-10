const asserter = require('../assert')
const requester = require('../requester')
const log = require('../logger')
const config = require('../config')

const data_path = '../../sample_data'
const gloss_set_bulk = require(data_path + '/gloss_set_bulk') // 6 glosses

const r = requester(
  config.hostname,
  config.port,
  config.api_path
)

log.flow('Quiz')

module.exports =
r('POST', '/gloss-set/bulk', gloss_set_bulk)
.then(res => {
  asserter(res)
  .ok_status()

  // TODO: start quizing
})
.then(log.success)
.catch(log.error)
