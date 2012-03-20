camelize = require('./camelize')

onExitCallbackName = (state)->
  "onExit#{camelize(state)}"
  
onEnterCallbackName = (state)->
  "onEnter#{camelize(state)}"

states = (instance, states)->
  instance._possibleStates = states
  instance._state = states[0]
  
  for state in states
    do (state, instance)->
      instance["is#{camelize(state)}"] = ()->
        this._state is state
  
  instance['states'] = ()->
    this._possibleStates

  instance['state'] = (newState = null)-> 
    if newState
      # set state
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
        throw("Invalid state: #{newState}")
        
    else
      # return existing state
      this._state
  
  instance['onExitState'] = (state, callback)->
    if state in this._possibleStates
      this[onExitCallbackName(state)] = callback
    else
      throw("Invalid state: #{state}")
    
  instance['onEnterState'] = (state, callback)->
    if state in this._possibleStates
      this[onEnterCallbackName(state)] = callback
    else
      throw("Invalid state: #{state}")
    
module.exports = states
    