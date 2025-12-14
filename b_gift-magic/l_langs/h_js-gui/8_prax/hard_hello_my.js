let matchwords = ["exit" , "quit"];

//////////////////////////////////////////////////////////////////////////////

const ifce_read = require('readline');

const rl = ifce_read.createInterface({
  input: process.stdin,
  output: process.stdout
});

//////////////////////////////////////////////////////////////////////////////

function check4quit(targetWord) {
  rl.question('Enter a word: ', (input) => {
    if (input.toLowerCase() === targetWord.toLowerCase()) {
      console.log(`You entered the correct word: ${targetWord}!`);
      rl.close();
    } else {
      console.log('Try again.');
      check4quit(targetWord); // RECURSIVE CALL TO CONTINUE THE LOOP
    }
  });
}

// Example usage: waiting for the word "hello"
check4quit('hello');
