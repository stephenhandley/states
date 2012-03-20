{exec} = require 'child_process'

task('build', 'Build project from src/*.coffee to lib/*.js', ->
  exec('coffee --compile --output lib/ src/', (error, stdout, stderr)->
    if error
      console.log(error)
      throw error
    console.log("Build successful")
  )
)

task('spec', 'Run spec', ->
  invoke('build')
  exec('./node_modules/vows/bin/vows spec/spec.coffee --spec', (error, stdout, stderr) ->
    console.log stdout
  )
)