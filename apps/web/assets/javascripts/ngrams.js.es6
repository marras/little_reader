const randInt = (max) => Math.floor(Math.random() * max)

const NGrams = function(names) {
  return {
    getWeighted: () => {
    },

    getRandomWords: (numWords, level = 0) => {
      if (numWords + 1 > names.length) {
        console.error('Array too small!')
        return
      }

      let words = []
      for(let i=0; i< numWords; i++) {
        var word = names[randInt(names.length)];

        if (words.indexOf(word) === -1 && word != goodWord)
          words.push(word)
        else
          i--
      }

      let goodIndex = randInt(numWords)
      window.goodWord = words[goodIndex]
      return { words, goodWord: window.goodWord }
    },
  }
}
