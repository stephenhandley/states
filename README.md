Description:
------------

    simple state handling for js in node/browser 

Installation:
-------------

    npm install states

Usage:
------
    In CoffeeScript
    `
    {states} = require('states')

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
    `
    
    outputs
    
    `
    TOTALLY NOT GONNA BARF
    yeah, i swear, i'm  not barfing
    oooooooh nooooooooo
    i'm not feeling so good
    here goes
    eeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahheeuauaughhhuauaahh
     - http://eeuauaughhhuauaahh.ytmnd.com
    i am FEELING WAY BETTER
    `

Specs
------
    cake spec
    