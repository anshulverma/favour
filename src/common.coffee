isUndefined = (value) ->
  typeof value is 'undefined'

keys = Object.keys

defaults = (orig, properties) ->
  obj = new Object
  for prop, value of properties
    obj[prop] = value if isUndefined obj[prop]
  obj

module.exports.isUndefined = isUndefined
module.exports.keys        = keys
module.exports.defaults    = defaults
