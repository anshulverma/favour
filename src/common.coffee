{checkDefined} = require 'node-preconditions'

isUndefined = (value) ->
  typeof value is 'undefined'

keys = Object.keys

defaults = (orig, defaultProperties) ->
  obj = clone orig
  for prop, value of defaultProperties
    obj[prop] = value if isUndefined obj[prop]
  obj

clone = (obj) ->
  cloner = new Cloner
  cloner.clone obj

class Cloner
  constructor: () ->
    @visitedObjects = []

  clone: (obj) ->
    checkDefined obj, 'cannot clone undefined values'
    type = instanceType obj
    return obj if ~@visitedObjects.indexOf(obj) or type in PRIMITIVE_TYPES
    @visitedObjects.push obj
    switch type
      when 'date'
        new Date do obj.getTime
      when 'array'
        cloned = []
        for item in obj
          cloned.push @clone item
        cloned
      when 'object'
        cloned = new Object
        for prop, value of obj
          cloned[prop] = @clone value
        cloned

INSTANCE_TYPES =
  BOOLEAN   : 'boolean'
  NUMBER    : 'number'
  STRING    : 'string'
  DATE      : 'date'
  ARRAY     : 'array'
  OBJECT    : 'object'
  NULL      : 'null'
  UNDEFINED : 'undefined'

PRIMITIVE_TYPES = [
                    INSTANCE_TYPES.BOOLEAN
                    INSTANCE_TYPES.NUMBER
                    INSTANCE_TYPES.STRING
                    INSTANCE_TYPES.NULL
                  ]

instanceType = (obj) ->

  switch
    when obj is null then INSTANCE_TYPES.NULL
    when obj instanceof Date then INSTANCE_TYPES.DATE
    when obj instanceof Array then INSTANCE_TYPES.ARRAY
    when typeof obj in
        [
          INSTANCE_TYPES.BOOLEAN
          INSTANCE_TYPES.NUMBER
          INSTANCE_TYPES.STRING
          INSTANCE_TYPES.UNDEFINED
          INSTANCE_TYPES.OBJECT
        ]
      typeof obj

module.exports.isUndefined = isUndefined
module.exports.keys        = keys
module.exports.defaults    = defaults
module.exports.clone       = clone
