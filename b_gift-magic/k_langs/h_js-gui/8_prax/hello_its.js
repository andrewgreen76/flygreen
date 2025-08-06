const readline = require('readline');

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function waitForWord(targetWord) {
  rl.question('Enter a word: ', (input) => {
    if (input.toLowerCase() === targetWord.toLowerCase()) {
      console.log(`You entered the correct word: ${targetWord}!`);
      rl.close();
    } else {
      console.log('Try again.');
      waitForWord(targetWord); // Recursive call to continue the loop
    }
  });
}

// Example usage: waiting for the word "hello"
waitForWord('hello');
