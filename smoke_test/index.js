const asserter = require('./assert')
const requester = require('./requester')
const state = require('./state')
const util = require('./util')
const log = require('./logger')

const hostname = 'localhost'
const port = 4000
const api_path = '/api'

const gloss = require('./data/gloss') // 1 gloss
const gloss_set = require('./data/gloss_set') // 3 glosses
const gloss_set_bulk = require('./data/gloss_set_bulk') // 6 glosses

const r = (method, path, body) => {
  log.step(method, path)

  const req = requester(hostname, port, api_path)
  return req(method, path, body)
}

r('DELETE', '/gloss/all')
.then(res => {
  asserter(res)
  .ok_status()

  return r('GET', '/gloss')
})
.then(res => {
  asserter(res)
  .ok_status()
  .body_length(0)

  return r('POST', '/gloss', gloss)
})
.then(res => {
  const exp_keys = util.concat_keys(gloss, ['id', 'key'])

  asserter(res)
  .ok_status()
  .keys_equal(exp_keys)

  state['gloss_1'] = res.body

  return r('GET', `/gloss/${res.body.id}`)
})
.then(res => {
  const exp_gloss = state['gloss_1']

  asserter(res)
  .ok_status()
  .body_equals(exp_gloss)

  return r('POST', '/gloss-set', gloss_set)
})
.then(res => {
  const a = asserter(res)
  .ok_status()
  .body_length(1)

  const list = util.first_value(res.body)
  const act_gloss_set = list.map(({text, language}) => ({text, language}))

  a.members_equal(act_gloss_set, gloss_set)

  const first_key = util.first_key(res.body)
  return r('GET', `/gloss-set/${first_key}`)
})
.then(res => {
  const a = asserter(res)
  .ok_status()
  .body_length(1)

  const list = util.first_value(res.body)
  const act_gloss_set = list.map(({text, language}) => ({text, language}))

  a.members_equal(act_gloss_set, gloss_set)

  return r('POST', '/gloss-set/bulk', gloss_set_bulk)
})
.then(res => {
  asserter(res)
  .ok_status()

  return r('GET', '/gloss-set', gloss_set)
})
.then(res => {
  asserter(res)
  .ok_status()
  .body_length(4)

  return r('GET', '/gloss')
})
.then(res => {
  asserter(res)
  .ok_status()
  .body_length(10)

  return r('DELETE', '/gloss/all')
})
.then(res => {
  asserter(res)
  .ok_status()
  .body_equals({count: 10})
})
.then(log.success)
.catch(log.error)
