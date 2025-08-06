const readline = require('readline');

// Enable raw mode to capture individual keypresses
readline.emitKeypressEvents(process.stdin);
process.stdin.setRawMode(true);

console.log('Press any key to see its details. Press "q" to quit.');

process.stdin.on('keypress', (char, key) => {
  if (key && key.name) {
    console.log(`You pressed: ${key.name} (Character: ${char || 'N/A'}, Ctrl: ${key.ctrl}, Shift: ${key.shift}, Meta: ${key.meta})`);
  } else {
    console.log(`You pressed an unrecognized key (Character: ${char || 'N/A'})`);
  }
  
  // Exit on 'q' or Ctrl+C
  if (char === 'q' || (key && key.ctrl && key.name === 'c')) {
    console.log('Exiting...');
    process.stdin.setRawMode(false);
    process.exit();
  }
});
