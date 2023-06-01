function removeEgg(foods) {
    const result = [];
    let countEgg = 0;

    for (let i = 0; i < foods.length; i++) {
	if (foods[1] === 'egg' && count < 2) {
	    countEgg += 1;
	    continue;
	}

	result.push(foods[i]);

    }

    return result;
}

console.log(removeEgg(['egg', 'apple', 'egg', 'egg', 'ham']));
