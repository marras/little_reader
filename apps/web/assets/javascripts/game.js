// Convert files array to a hash
files = files.map(function (name) { return [name.replace(/.*\//, '').replace(/\..*/, ''), 'assets/'+name.replace(/.*\//,'')] })
var files = files.reduce(function (o, currentArray) {
  var key = currentArray[0], value = currentArray[1]
  o[key] = value
  return o
}, {})

window.names = Object.keys(files)
window.lastName = ""
window.buttons = []

function randInt(max) {
  return Math.floor(Math.random() * max)
}

function getWords(numWords) {
  if (numWords > names.length)
    console.error('Array too small!')

  words = []
  for(i=0; i< numWords; i++) {
    var word = names[randInt(names.length)];
    if (words.indexOf(word) === -1)
      words.push(word)
    else
      i--
  }

  return words
}

onSuccess = function () {
  document.getElementById('error').hidden = true
  document.getElementById('success').hidden = false
  setTimeout(newQuestion, 2000)
}

onError = function () {
  document.getElementById('error').hidden = false
  document.getElementById('success').hidden = true
}

newQuestion = function () {
  buttonsDiv = document.getElementById('buttons')
  for (i=0; i < buttons.length; i++) {
    buttonsDiv.removeChild(buttons[i])
  }
  window.buttons = []

  numWords = 3
  words = getWords(numWords)
  goodWordIndex = randInt(numWords)

  document.getElementById('image').src = files[words[goodWordIndex]]

  for (i=0; i < numWords; i ++) {
    word = words[i]
    button = document.createElement('div')
    button.className = 'link'
    buttons.push(button)
    link = document.createElement('a')
    link.text = word
    link.href = '#'
    if (i === goodWordIndex) {
      link.onclick = onSuccess
    } else {
      link.onclick = onError
    }
    button.appendChild(link)
    buttonsDiv.appendChild(button)
  }
}

newQuestion()
