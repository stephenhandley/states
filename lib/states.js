(function() {
  var camelize, root,
    __indexOf = Array.prototype.indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  root = typeof exports !== "undefined" && exports !== null ? exports : window;

  camelize = require('./string').camelize;

  root.states = function(instance, states) {
    var state, _fn, _i, _len;
    instance._possibleStates = states;
    instance._state = states[0];
    _fn = function(state, instance) {
      return instance["is" + (camelize(state))] = function() {
        return this._state === state;
      };
    };
    for (_i = 0, _len = states.length; _i < _len; _i++) {
      state = states[_i];
      _fn(state, instance);
    }
    return instance['state'] = function(newState) {
      var enterCallbackName, exitCallbackName, oldState;
      if (newState == null) newState = null;
      if (newState) {
        if (__indexOf.call(this._possibleStates, newState) >= 0) {
          oldState = this._state;
          exitCallbackName = "onExit" + (camelize(oldState));
          if (exitCallbackName in this) this[exitCallbackName]();
          enterCallbackName = "onEnter" + (camelize(newState));
          if (enterCallbackName in this) this[enterCallbackName]();
          return this._state = newState;
        } else {
          throw "Invalid state: " + newState;
        }
      } else {
        return this._state;
      }
    };
  };

}).call(this);
