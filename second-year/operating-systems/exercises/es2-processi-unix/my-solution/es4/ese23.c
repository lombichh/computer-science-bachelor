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
		for (int numFile = 0; numFile < numFiles; numFile++) {
			int pidChild = fork();
			if (pidChild == 0) {
				// child
				char fileName[20];
				strcpy(fileName, dir1);
				strcat(fileName, "/");
				strcat(fileName, argv[3 + numFile]);

				int pidGrandchild = fork();
				if (pidGrandchild == 0) {
					// grandchild -> copy
					execl("/bin/cp", "cp", fileName, dir2, (char *)0);
					exit(1);
				} else if (pidGrandchild > 0) {
					// child -> rename
					int status;
					wait(&status);
					if (WEXITSTATUS(status) == 1) exit(1);
					else {
						char strMyPid[10];
						sprintf(strMyPid, "%d", getpid());

						char fileNewName[20];
						strcpy(fileNewName, dir1);
						strcat(fileNewName, "/");
						strcat(fileNewName, strMyPid);

						execl("/bin/mv", "mv", fileName, fileNewName, (char *)0);
						exit(1);
					}
				} else printf("Error creating grandchild\n");
			} else if (pidChild > 0) {
				// father
				int status;
				wait(&status);
				if (WEXITSTATUS(status) == 1) printf("Error in exec\n");
			} else printf("Error creating child\n");
		}
	} else printf("You should pass at least 3 arguments\n");
}
