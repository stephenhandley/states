vows        = require('vows')
assert      = require('assert')
states      = require('../src/states')
camelize    = require('../src/camelize')

class Barfer
  constructor: ()->
    states(this, [
      'TOTALLY NOT GONNA BARF', 
      'OH NO', 
      'GONNA BARF', 
      'BARFING', 
      'BLOWING CHUNKS', 
      'BARFBARFBARF', 
      'FEELING WAY BETTER'
    ])    
    
    @exitedGonnaBarf = false
    @enteredBarfing = false
    
    @enteredOhNo = false
    @exitedOhNo = false
  
    this.onEnterState('OH NO', ()->
      @enteredOhNo = true
    )
    
    this.onExitState('OH NO', () ->
      @exitedOhNo = true
    )
  
  goTimeGottaMakeItHappenOhhhhhYeaaaaahDuffman: ()->
    this.state('GONNA BARF')
    this.state('BARFING')
  
  onExitGonnaBarf: ()->
    @exitedGonnaBarf = true
    
  onEnterBarfing: ()->
    @enteredBarfing = true

  no: ()->
    this.state('NEVER GONNA GIVE YOU UP')

  ahhh: ()->
    this.state('FEELING WAY BETTER')

vow = vows.describe('states')

vow.addBatch(
  'A class with states':
    topic: new Barfer()
      
    'should begin in the first state': (topic)->
      assert.equal(topic.state(), topic._possibleStates[0])
      
    'should return a list of states': (topic)->
      assert.deepEqual(topic.states(), topic._possibleStates)
  
    'should properly transition to new state': (topic)->
      topic.goTimeGottaMakeItHappenOhhhhhYeaaaaahDuffman()
      assert.equal(topic.state(), 'BARFING')
    
    'should call the exit handler on the old state if its defined': (topic)->
      assert.equal(topic.exitedGonnaBarf, true)
    
    'should call the enter handler on the new state if its defined': (topic)->
      assert.equal(topic.enteredBarfing, true)
      
    'should also call explicitly added enter/exit callbacks': (topic)->
      topic.state('OH NO')
      assert.equal(topic.enteredOhNo, true)
      topic.state('BARFING')
      assert.equal(topic.exitedOhNo, true)
      
    'should properly transition between states without enter or exit handlers': (topic)->      
      destinationState = 'FEELING WAY BETTER'
      topic.state(destinationState)
      assert.equal(topic.isFeelingWayBetter(), true)
    
    'should raise an error and stay in current state when set with nonexistent state': (topic)->
      startState = 'BARFBARFBARF'
      topic.state(startState)
      
      invalidState = 'THIS DOES NOT EXIST'
      try
        topic.state(invalidState)
        assert.equal('THIS SHOULD NOT GET CALLED', 'WTF')
      catch error
        assert.equal(topic.state(), startState)
        assert.equal(error, "Invalid state: #{invalidState}")
    
    'should raise an error when adding event handler to nonexistent state': (topic)->
      invalidState = 'THIS DOES NOT EXIST'
      try 
        topic.onEnterState(invalidState, ()->)
        assert.equal('THIS SHOULD NOT GET CALLED', 'WTF')
      catch error
        assert.equal(error, "Invalid state: #{invalidState}")
      
      try 
        topic.onExitState(invalidState, ()->)
        assert.equal('THIS SHOULD NOT GET CALLED', 'WTF')
      catch error
        assert.equal(error, "Invalid state: #{invalidState}")
      
    
    'should setup is{stateName} for each state': (topic)->
      topic.state(topic._possibleStates[0])
      for state in topic._possibleStates
        topic.state(state)
        for otherState in topic._possibleStates
          isInState = topic["is#{camelize(otherState)}"]()
          assert.equal(isInState, state is otherState)
    
) 

exports.test_utils = vow