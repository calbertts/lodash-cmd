import * as std from 'std'
import * as os from 'os'
import * as _ from 'lodash.min.js'
import { parseCommandLineOpts } from 'minimist.js'

const _ = globalThis._;

const args = parseCommandLineOpts(scriptArgs)
args._.shift()

let file = std.in
if (args.file) {
  file = std.open(args.file, 'r')
}

let jsonFromURL
if (args.url) {
  const request = std.urlGet(args.url, {full: true})
  if (request.status === 200) {
    if (request.response.startsWith('HTTP')) {
      const preData = request.response.split('\n\r')
      preData.shift()
      jsonFromURL = preData.join('')
    } else {
      jsonFromURL = request.response
    }
  }
}

let method
if (args._.length >= 1) {
  if (args._[0]) {
    method = args._.shift()
  }
} else {
  console.log(`\n  A method parameter is required, see: _ --help\n`)
  std.exit(1)
}

function isEmptyFile(file) {
  if (os.isatty(file)) {
    try {
      file.seek(0, std.SEEK_END)
    } catch(err) { return true }
    if (file.tell() === 0) {
      return true
    } else {
      file.seek(0, std.SEEK_SET)
      return false
    }
  } else {
    return false
  }
}

function process(rawJSON) {
  try {
    const json = std.evalScript(rawJSON)
    const finalArgs = args._.map(arg => std.evalScript(arg, {backtrace_barrier: true}))

    print(JSON.stringify(_[method].apply(null, [ json, ...finalArgs ])))
  } catch(err) {
    print(`\n  Error parsing JSON: ${err}\n`)
  }
}

if (!isEmptyFile(file)) {
  let line = file.getline()
  let rawJSON = ''

  while(line) {
    if (line.trim() === '')
      std.exit()

    rawJSON += line
    line = file.getline()
  }

  process(rawJSON)
} else if (jsonFromURL) {
  try {
    const json = JSON.parse(jsonFromURL)
    print(JSON.stringify(_[method](json), null, 2))
  } catch(err) {
    print(`\n  Error parsing JSON from URL\n`)
  }
} else {
  process(args._.shift())
  //console.log(`\n  No JSON was found\n`)
  //std.exit(1)
}

