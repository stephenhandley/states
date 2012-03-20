capitalize = (string)->
  string.charAt(0).toUpperCase() + string.slice(1)

camelize = (string)->
  string = string.toLowerCase().replace(/\s/g, '_')
  (capitalize(token) for token in string.split('_')).join('')
  
module.exports = camelize