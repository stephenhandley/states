root = exports ? window

{camelize} = require('./string')

root.states = (instance, states)->
  instance._possibleStates = states
  instance._state = states[0]
  
  for state in states
    do (state, instance)->
      instance["is#{camelize(state)}"] = ()->
        this._state is state

  instance['state'] = (newState = null)-> 
    if newState
      # set state
      if newState in this._possibleStates
        oldState = this._state
        
        # if event handler defined for leaving old state, call it
        exitCallbackName = "onExit#{camelize(oldState)}"
        if exitCallbackName of this
          this[exitCallbackName]()
        
        # if event handler defined for entering new state, call it
        enterCallbackName = "onEnter#{camelize(newState)}"
        if enterCallbackName of this
          this[enterCallbackName]()
          
        this._state = newState
                
      else
        throw("Invalid state: #{newState}")
        
    else
      # return existing state
      this._state
    