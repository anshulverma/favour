{checkNumberType, checkContains} = require 'node-preconditions'
{isUndefined, keys} = require './common'

REPO_HANDLERS = {
  any: () ->
  git: (cwd, maxDepth) ->
  hg: () ->
  svn: () ->
}

getRoot = (cwd, options) ->
  defaults options,
    maxDepth: 5
    type: 'any'
  checkNumberType options.maxDepth
  checkContains options.type, keys REPO_HANDLERS
  REPO_HANDLERS[options.type] cwd, options.maxDepth
