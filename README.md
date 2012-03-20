# Description:

Simple state handling for js in node/browser.

# Installation:
```
npm install states
```

# Usage

```js
// require
states = require('states') 

obj = {
  name: 'duh',
  job: 'duh'
}

// initialize
states(obj, ["starting", "working", "not doing a damn thing", "finished"]) 

// returns current state (initially the first element of the array passed above)
obj.state() // "starting"

// defines helpers for checking current state
obj.isStarting()          // true
obj.isWorking()           // false
obj.isNotDoingADamnThing  // false
obj.isFinished()          // false

// can define (optional) state event handlers explicitly
obj.onExitState('starting', function() {
  console.log('bye')
});

// or implicitly based on naming convention of onEnter{CamelizedStateName}, onExit{CamelizedStateName}
obj.onEnterNotDoingADamnThing = function() {
  console.log('OH NO')
};

// sets current state, calls callbacks if they're defined on obj
obj.state('not doing a damn thing')

// returns list of possible states
obj.states() // [ 'starting', 'working', 'not doing a damn thing', 'finished' ]
```

results in 

```
'bye'
'OH NO' 
```

# Examples

Quick example in JavaScript

```js
states = require('states')

function Simple() {
  states(this, ['starting', 'done']);
  
  this.onExitState('starting', function() {
    console.log('exiting starting state');
  });
}

Simple.prototype.test = function() {
  if (this.isStarting()) {
    console.log('it starts in the first state by default.');
  }
  
  this.state('done')
  
  if (this.isDone()) {
    console.log('all done');
  }
}

Simple.prototype.onEnterDone = function() {
  console.log('entering done state');
};

simple = new Simple();
simple.test();
```

outputs

```
it starts in the first state by default.
exiting starting state
entering done state
all done
```

Longer example in CoffeeScript
 

```coffee
states = require('states')

class Barfer
  constructor: ()->
    states(this, [
      'TOTALLY NOT GONNA BARF', 
      'OH NO', 
      'GONNA BARF', 
      'BARFING', 
      'FEELING WAY BETTER'
    ])

  goTimeGottaMakeItHappenOhhhhhYeaaaaahDuffman: ()->
    console.log(this.state())
    console.log("yeah, i swear, i'm #{if this.isBarfing() then '' else ' not'} barfing")

    this.state('OH NO')

    this.state('GONNA BARF')
    if this.isGonnaBarf()
      console.log("i'm not feeling so good")

    this.state('BARFING')

    this.state('FEELING WAY BETTER')
    console.log("i am #{this.state()}")

  onEnterOhNo: ()->
    console.log('oooooooh nooooooooo')

  onExitGonnaBarf: ()->
    console.log('here goes')

  onEnterBarfing: ()->
    console.log('eeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahh')

  onEnterFeelingWayBetter: ()->
    console.log(' - http://eeuauaughhhuauaahh.ytmnd.com')

barfer = new Barfer()
barfer.goTimeGottaMakeItHappenOhhhhhYeaaaaahDuffman()
```

outputs

```
TOTALLY NOT GONNA BARF
yeah, i swear, i'm  not barfing
oooooooh nooooooooo
i'm not feeling so good
here goes
eeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahh
 - http://eeuauaughhhuauaahh.ytmnd.com
i am FEELING WAY BETTER
```

# Specs
```
cake spec
```    