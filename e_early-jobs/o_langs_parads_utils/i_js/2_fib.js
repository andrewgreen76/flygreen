console.log(10/4);

for( let i=0, a=0, b=1 ; i<10 ; i++ ){
    console.log("\ni : " + i + "\n|");
    console.log("a : " + a);
    console.log("b : " + b);

    let c=a+b;
    a=b;
    b=c;
}
