common = require '../src/common'

describe 'common util method tests', ->
  it 'isUndefined test', ->
    assert.equal common.isUndefined({}.abc), true
    assert.equal common.isUndefined('str'), false
