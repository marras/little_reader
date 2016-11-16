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

      // Capitalization probability: 0 at first, 0.5 max
      let probCapitalLetters = 0.5 * level / (level + 1)
      let capitalize = Math.random() < probCapitalLetters

      let words = []
      for(let i=0; i< numWords; i++) {
        var word = names[randInt(names.length)];

        if (words.indexOf(word) === -1 && word != goodWord) {
          if (capitalize) word = word.toUpperCase()
          words.push(word)
        } else
          i--
      }

      let goodIndex = randInt(numWords)
      window.goodWord = words[goodIndex]
      return { words, goodWord: window.goodWord }
    },
  }
}
