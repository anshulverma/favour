describe 'common util method tests', ->
  it 'isUndefined test', ->
    assert.equal common.isUndefined({}.abc), true
    assert.equal common.isUndefined('str'), false

  it 'keys test', ->
    obj =
      key1: 'a'
      key2: 'b'
    assert.deepEqual common.keys(obj), ['key1', 'key2']

  describe 'default options tests', ->
    defaultOptions =
      key1: 'val1'
      key2: 'val2'
      key3: 'val3'

    it 'empty options', ->
      assert.deepEqual common.defaults({}, defaultOptions), defaultOptions

    it 'pre-populated options', ->
      options =
        key1: 'a'
        key2: 'b'
        key3: 'c'
      assert.deepEqual common.defaults(options, defaultOptions), options

    it 'partly populated options', ->
      options = key2: 'a'

  describe 'clone tests', ->
    it 'cloning null', ->
      assert.isNull common.clone null

    it 'cloning undefined', ->
      wrapper = -> common.clone {}.x
      assert.throws wrapper, 'cannot clone undefined value'

    describe 'array clone tests', ->
      it 'simple array clone', ->
        arr = [1, 2, 3]
        assert.deepEqual common.clone(arr), arr
        assert.notEqual common.clone(arr), arr

      it 'mixed array clone tests', ->
        arr = [1, 'a', {x: 'y'}]
        assert.deepEqual common.clone(arr), arr
        assert.notEqual common.clone(arr), arr

      it 'self referencing array cloning', ->
        arr = [1, 'a']
        arr.push arr
        assert.deepEqual common.clone(arr), arr

      it 'array with undefined value', ->
        wrapper = -> common.clone ['a', {}.x]
        assert.throws wrapper, 'cannot clone undefined value'

    describe 'object clone test', ->
      it 'simple object clone', ->
        obj =
          a: 1
          b: 2
          c: 3
        assert.deepEqual common.clone(obj), obj
        assert.notEqual common.clone(obj), obj

      it 'mixed object clone tests', ->
        obj =
          a: 1
          b: 'str'
          c:
            key: 'val'
        assert.deepEqual common.clone(obj), obj
        assert.notEqual common.clone(obj), obj

      it 'self referencing object cloning', ->
        obj =
          a: 1
          b: 2
          c: 3
        obj.self = obj
        assert.deepEqual common.clone(obj), obj

      it 'object with undefined value', ->
        wrapper = ->
          common.clone
            key1: 'val1'
            key2: {}.x
        assert.throws wrapper, 'cannot clone undefined value'

    describe 'primitive clone tests', ->
      it 'string clone test', ->
        assert.equal common.clone('test'), 'test'

      it 'number clone test', ->
        assert.equal common.clone(10), 10

      it 'boolean clone test', ->
        assert.equal common.clone(true), true
        assert.equal common.clone(false), false

      it 'date clone test', ->
        date = new Date "2014-08-24T12:41:00.123Z"
        assert.notEqual common.clone(date), date
        assert.equal do common.clone(date).getTime, do date.getTime
