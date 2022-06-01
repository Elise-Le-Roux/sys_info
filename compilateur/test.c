int f1(int a, int b) {
    int c = a;
    return c;
}

int main() {
    int a = 3 + 1 ;
    int b = 0 ;
    int d;
    int e = 0;
    
    while ( a < 10 ) {
        a = a + 1 ;
        b = b + 3 ;
        while (e < 2) {
            e = e + 1;
        }
    }
    
    d = f1(a , b);
    
    printf ( a ) ;
    printf ( b ) ;

    printf ( d ) ;
    printf ( e ) ;
    return b ;
}

