/* execve.c */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <assert.h>

int main(int argc, char *argv[])
{
	char *newargv[] = { NULL, "hello", "world", NULL };
	char *newenviron[] = { NULL };

	assert(argc == 2);  /* argv[1] identifies
			       program to exec */
	newargv[0] = argv[1];

	execve(argv[1], newargv, newenviron);
	perror("execve");   /* execve() only returns on error */
	exit(EXIT_FAILURE);
}

