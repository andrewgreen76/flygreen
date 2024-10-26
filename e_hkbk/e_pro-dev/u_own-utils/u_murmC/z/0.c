
struct mytype{
  char b;
};

typedef struct{
  char b;
} mytype2;

void main(){
  struct mytype bob;
  bob.b = 'a';
  
  mytype2 alice; // storage size of 'alice' isn't known 
  alice.b = 'c';
}
