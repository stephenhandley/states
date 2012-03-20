# capitalize("something") 
# <br/>
# <i>"Something"</i>
capitalize = (string)->
  string.charAt(0).toUpperCase() + string.slice(1)

# camelize("SPACE SEPARATED AND CAPITALIZED")
# <br/>
# <i>"SpaceSeparatedAndCapitalized"</i>
camelize = (string)->
  string = string.toLowerCase().replace(/\s/g, '_')
  (capitalize(token) for token in string.split('_')).join('')
 
# export camelize at top level 
module.exports = camelize