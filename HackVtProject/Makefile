a.out: test.o
	cc test.o greenhttp.o -o a.out -std=gnu99

test.o: test.c greenhttp.o
	cc -o test.o -c test.c -ansi -pedantic -Wall -std=gnu99

libtest: lib
	cc testlib.c -static greenhttp.a -o libtest.out -ansi -pedantic -Wall -Wextra -Werror -std=gnu99

#warning: Using 'gethostbyname' in statically linked applications 
#requires at runtime the shared libraries from the glibc version used 
#for linking. Aka: If you dont have the right version of glibc installed
#on your system when using any static library given to by someone (you 
#mean you didn't compile your own?) it might fail miserably.
lib: greenhttp.o
	ar rcs greenhttp.a greenhttp.o

greenhttp.o: greenhttp.c greenhttp.h
	cc -o greenhttp.o -c greenhttp.c -ansi -pedantic -Wall -std=gnu99

clean:
	rm greenhttp.o test.o a.out

#Please double check your code with this before pushing!
#valgrind --tool=memcheck --track-origins=yes --leak-check=full ./a.out