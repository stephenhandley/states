# **states** lets you add a simple state machine to Javascript objects
#

#### Helpers (private)

# import camelize helper
camelize = require('./camelize')

# get the name for the exit callback called for a given state
onExitCallbackName = (state)->
  "onExit#{camelize(state)}"
 
# get the name for the enter callback called for a given state 
onEnterCallbackName = (state)->
  "onEnter#{camelize(state)}"

#### Exported (public)

# states({obj}, ["a", "list", "of", "states"])
states = (instance, states)->
  instance._possibleStates = states
  
  # start in the first state
  instance._state = states[0]
  
  # setup {obj}.is{CamelizedStateName}() helpers that return true if in that state
  for state in states
    do (state, instance)->
      instance["is#{camelize(state)}"] = ()->
        this._state is state
  
  # {obj}.states() returns list of possible states
  instance['states'] = ()->
    this._possibleStates
  
  # {obj}.state({state}) sets the state to newState if passed, otherwise returns the current state name
  instance['state'] = (newState = null)-> 
    if newState
      # state has been passed, set it
      if newState in this._possibleStates
        oldState = this._state
        
        # if event handler defined for leaving old state, call it
        exitCallbackName = onExitCallbackName(oldState)
        if exitCallbackName of this
          this[exitCallbackName]()
        
        # if event handler defined for entering new state, call it
        enterCallbackName = onEnterCallbackName(newState) 
        if enterCallbackName of this
          this[enterCallbackName]()
          
        this._state = newState
                
      else
        # error thrown on invalid states
        throw("Invalid state: #{newState}")
        
    else
      # state wasn't passed, return existing state
      this._state
  
  # {obj}.onExitState({state}, {callback}) attaches event handler that's called when {state} is exited
  instance['onExitState'] = (state, callback)->
    if state in this._possibleStates
      this[onExitCallbackName(state)] = callback
    else
      throw("Invalid state: #{state}")
  
  # {obj}.onEnterState({state}, {callback}) attaches event handler that's called when {state} in entered
  instance['onEnterState'] = (state, callback)->
    if state in this._possibleStates
      this[onEnterCallbackName(state)] = callback
    else
      throw("Invalid state: #{state}")

# export top level states function  
module.exports = states
    