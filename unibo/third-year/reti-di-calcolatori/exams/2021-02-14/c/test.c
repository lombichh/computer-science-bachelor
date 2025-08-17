#include <fcntl.h>
#include <rpc/rpc.h>
#include <stdio.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <dirent.h>
#include <string.h>

int main(int argc, char *argv[]) {
    DIR *img_folder;
    struct dirent *img;
    char img_fullpath[256];

    if ((img_folder = opendir("img_folder")) != NULL) {
        while ((img = readdir(img_folder)) != NULL) {
            if (strcmp(img->d_name, ".") != 0 && strcmp(img->d_name, "..") != 0) {
                img_fullpath[0] = '\0';
                strcat(img_fullpath, "img_folder");
                strcat(img_fullpath, "/");
                strcat(img_fullpath, img->d_name);

                if (remove(img_fullpath) == 0) printf("Immagine %s eliminata con successo\n", img_fullpath);
            }
        }
    }
}