// jQuery dla ubogich
window.$ = (...args) => document.querySelector(args)

// Convert files array to a hash
window.names = Object.keys(files)
window.goodWord = ""
window.buttons = []
window.level = 20
window.learningCurve = 0.0

var generator = NGrams(window.names)

var gainLife = function () {
  let life = document.createElement('img')
  life.src = 'assets/heart.png'
  life.width = 32
  life.height = 32
  document.getElementById('lives').appendChild(life)
}

var loseLife = function () {
  let lives = document.getElementById('lives')
  let life = lives.children[0]
  if (!life) {
    document.getElementById('end').hidden = false
  }

  lives.removeChild(life)
}

var onSuccess = function () {
  document.getElementById('error').hidden = true
  document.getElementById('success').hidden = false
  document.getElementById('image').onload = function() {
    document.getElementById('success').hidden = true
  }
  gainLife()
  level++
  newQuestion()
}

var onError = function () {
  document.getElementById('error').hidden = false
  document.getElementById('success').hidden = true

  loseLife()
}

var newQuestion = function () {
  $('#level span').innerHTML = level // display level info

  let buttonsDiv = document.getElementById('buttons')
  for (let i=0; i < buttons.length; i++) {
    buttonsDiv.removeChild(buttons[i])
  }
  window.buttons = []

  let numWords = 3 + level / 5
  const { words, goodWord } = generator.getRandomWords(numWords, level)

  document.getElementById('image').src = files[goodWord]

  words.forEach((word) => {
    let button = document.createElement('div')
    button.className = 'link'
    buttons.push(button)

    let link = document.createElement('a')
    link.text = word
    link.href = '#'
    link.onclick = (word === goodWord) ? onSuccess : onError

    button.appendChild(link)
    buttonsDiv.appendChild(button)
  })
}

document.getElementById('error').onclick = function () {
  document.getElementById('error').hidden = true
}

newQuestion()
