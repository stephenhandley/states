(function() {
  var camelize, capitalize, onEnterCallbackName, onExitCallbackName, states,
    __indexOf = Array.prototype.indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  capitalize = function(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
  };

  camelize = function(string) {
    var token;
    string = string.toLowerCase().replace(/\s/g, '_');
    return ((function() {
      var _i, _len, _ref, _results;
      _ref = string.split('_');
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        token = _ref[_i];
        _results.push(capitalize(token));
      }
      return _results;
    })()).join('');
  };

  onExitCallbackName = function(state) {
    return "onExit" + (camelize(state));
  };

  onEnterCallbackName = function(state) {
    return "onEnter" + (camelize(state));
  };

  states = function(instance, states) {
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
    instance['states'] = function() {
      return this._possibleStates;
    };
    instance['state'] = function(newState) {
      var enterCallbackName, exitCallbackName, oldState;
      if (newState == null) newState = null;
      if (newState) {
        if (__indexOf.call(this._possibleStates, newState) >= 0) {
          oldState = this._state;
          exitCallbackName = onExitCallbackName(oldState);
          if (exitCallbackName in this) this[exitCallbackName]();
          enterCallbackName = onEnterCallbackName(newState);
          if (enterCallbackName in this) this[enterCallbackName]();
          return this._state = newState;
        } else {
          throw "Invalid state: " + newState;
        }
      } else {
        return this._state;
      }
    };
    instance['onExitState'] = function(state, callback) {
      if (__indexOf.call(this._possibleStates, state) >= 0) {
        return this[onExitCallbackName(state)] = callback;
      } else {
        throw "Invalid state: " + state;
      }
    };
    return instance['onEnterState'] = function(state, callback) {
      if (__indexOf.call(this._possibleStates, state) >= 0) {
        return this[onEnterCallbackName(state)] = callback;
      } else {
        throw "Invalid state: " + state;
      }
    };
  };

  module.exports = states;

}).call(this);
