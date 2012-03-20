vows        = require('vows')
assert      = require('assert')
{states}    = require('../src/states')
{camelize}  = require('../src/string')

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
    @entered_was_called = false
    @exited_was_called = false
  
  goTimeGottaMakeItHappenOhhhhhYeaaaaahDuffman: ()->
    this.state('BARFING')
  
  onEnterBarfing: ()->
    @entered_was_called = true

  onExitTotallyNotGonnaBarf: ()->
    @exited_was_called = true

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
  
    'should properly transition to new state': (topic)->
      topic.goTimeGottaMakeItHappenOhhhhhYeaaaaahDuffman()
      assert.equal(topic.state(), 'BARFING')
    
    'should call the exit handler on the old state if its defined': (topic)->
      assert.equal(topic.exited_was_called, true)
    
    'should call the enter handler on the new state if its defined': (topic)->
      assert.equal(topic.entered_was_called, true)
      
    'should properly transition between states without enter or exit handlers': (topic)->
      topic.state('OH NO')
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
    
    'should setup is{stateName} for each state': (topic)->
      topic.state(topic._possibleStates[0])
      for state in topic._possibleStates
        topic.state(state)
        for otherState in topic._possibleStates
          isInState = topic["is#{camelize(otherState)}"]()
          assert.equal(isInState, state is otherState)
    
) 

exports.test_utils = vow