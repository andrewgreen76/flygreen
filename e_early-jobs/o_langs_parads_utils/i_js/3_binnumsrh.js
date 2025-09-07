let inq_cnt = 0, u = 100, l = 2, a = 52;

function div_n_srh( u , l , ref ) {
    console.log("\nInquiry count : " + ++inq_cnt);
    console.log("Answer : " + a);
    console.log("Guess : " + ref);

    // special case : 
    if (a==ref) {
	console.log("\nWELL DONE !\n");
	return; 
    }
    // general case : 
    else if(a>ref) div_n_srh( u , ref , Math.floor((u-ref)/2)+ref );
    else div_n_srh( ref , l , Math.floor((ref-l)/2)+l );
}

div_n_srh( u , l , Math.floor((u-l)/2)+l );
