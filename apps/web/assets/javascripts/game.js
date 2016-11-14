// Convert files array to a hash
window.names = Object.keys(files)
window.lastName = ""
window.buttons = []

function randInt(max) {
  return Math.floor(Math.random() * max)
}

function getWords(numWords) {
  if (numWords > names.length) {
    console.error('Array too small!')
    return
  }

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

gainLife = function () {
  life = document.createElement('img')
  life.src = 'assets/heart.png'
  life.width = 32
  life.height = 32
  document.getElementById('lives').appendChild(life)
}

loseLife = function () {
  lives = document.getElementById('lives')
  life = lives.children[0]
  if (!life) {
    document.getElementById('end').hidden = false
  }

  lives.removeChild(life)
}

onSuccess = function () {
  document.getElementById('error').hidden = true
  document.getElementById('success').hidden = false
  document.getElementById('image').onload = function() {
    document.getElementById('success').hidden = true
  }
  gainLife()
  newQuestion()
}

onError = function () {
  document.getElementById('error').hidden = false
  document.getElementById('success').hidden = true

  loseLife()
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

document.getElementById('error').onclick = function () {
  document.getElementById('error').hidden = true
}

newQuestion()
