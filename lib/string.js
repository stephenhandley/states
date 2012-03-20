(function() {
  var capitalize, root;

  root = typeof exports !== "undefined" && exports !== null ? exports : window;

  capitalize = function(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
  };

  root.camelize = function(string) {
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

}).call(this);
