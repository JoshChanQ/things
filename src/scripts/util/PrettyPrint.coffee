# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
], (
) ->

  'use strict'

  prettyprint = (object, depth, embedded) ->
    if depth > 2
      return object
    typeof(depth) == "number" || (depth = 0)
    typeof(embedded) == "boolean" || (embedded = false)
    newline = false
    spacer = (depth) ->
      spaces = ""
      for i in [0..depth - 1]
        spaces += "  "
        return spaces
    pretty = ""
    if typeof(object) == "undefined"
      pretty += "undefined"
    else if typeof(object) == "boolean" || typeof(object) == "number"
      pretty += object.toString()
    else if typeof(object) == "string"
      pretty += "\"" + object + "\""
    else if object  == null
      pretty += "null"
    else if object instanceof(Array)
      if object.length > 0
        if embedded
          newline = true
        content = ""
        for k, item of object
          content += pp(item, depth + 1) + ",\n" + spacer(depth + 1)
        content = content.replace(/,\n\s*$/, "").replace(/^\s*/,"")
        pretty += "[ " + content + "\n" + spacer(depth) + "]"
      else
        pretty += "[]"
    else if (typeof(object) == "object")
      if Object.keys(object).length > 0
        if (embedded)
          newline = true
        content = ""
        for key of object
          content += spacer(depth + 1) + key.toString() + ": " + pp(object[key], depth + 2, true) + ",\n"

        content = content.replace(/,\n\s*$/, "").replace(/^\s*/,"")
        pretty += "{ " + content + "\n" + spacer(depth) + "}"
      else
        pretty += "{}"
    else
      pretty += object.toString()
    return (if newline then "\n" + spacer(depth) else "") + pretty
