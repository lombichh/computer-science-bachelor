#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <unistd.h>

void main(int argc, char *argv[]) {
	if (argc == 3) {
		char *nomeFile = argv[1];
		char *piano = argv[2];
		
		int pid = fork();
		if (pid == 0) {
			// child
			execl("/bin/grep", "grep", "-c", piano, nomeFile, (char *)0);
			printf("Error in exec\n");
			exit(1);
		} else if (pid > 0) {
			// father
			int status;
			wait(&status);
			printf("Pid: %d -> Stato di terminazione: %d\n", pid, WEXITSTATUS(status));
		} else printf("Error creating child\n");
	} else printf("You should pass 2 arguments\n");
}
