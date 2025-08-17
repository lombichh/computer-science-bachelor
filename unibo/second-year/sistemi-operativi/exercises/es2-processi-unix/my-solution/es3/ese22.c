#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <unistd.h>
#include <string.h>

void main(int argc, char *argv[]) {
	if (argc >= 4) {
		char *dir1 = argv[1];
		char *dir2 = argv[2];
		
		int numFiles = argc - 3;
		int numTerminatedChilds = 0;
		for (int numFile = 0; numFile < numFiles; numFile++) {
			int pid = fork();
			if (pid == 0) {
				// child
				char fileName[20];
				strcpy(fileName, dir1);
				strcat(fileName, "/");
				strcat(fileName, argv[3 + numFile]);
				
				int myPid = getpid();
				if (myPid % 2 == 0) {
					// even -> copy file in dir2
					execl("/bin/cp", "cp", fileName, dir2, (char *)0);
					exit(1);
				} else {
					// odd -> remove file
					execl("/bin/rm", "rm", fileName, (char *)0);
					exit(1);
				}
			} else if (pid > 0) {
				// father
				int status;
				wait(&status);
				if (WEXITSTATUS(status) == 1) printf("Error in exec\n");
				else {
					numTerminatedChilds++;
					if (numTerminatedChilds == numFiles) execl("/bin/ls", "ls", dir2, (char *)0);
				}
			} else printf("Error creating child\n");
		}
	} else printf("You should pass at least 3 arguments\n");
}
