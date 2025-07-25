#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <time.h>
#include <sys/stat.h>

int main(int argc, char *argv[]) {
    struct stat sb;
    char *filename = NULL;

    if (argc != 2) {
        printf("Usage: ./program filename\n");
        exit(EXIT_FAILURE);
    }

    filename = argv[1];

    if (stat(filename, &sb) == -1) {
        perror("stat");
        exit(EXIT_FAILURE);
    }

    printf("Inode number: %lu\n", sb.st_ino);
    printf("User ID of owner: %u\n", sb.st_uid);
    printf("Group ID of owner: %u\n", sb.st_gid);
    printf("Total file size: %lu bytes\n", sb.st_size);
    printf("Last status change:       %s", ctime(&sb.st_ctime));
    printf("Last file access:         %s", ctime(&sb.st_atime));
    printf("Last file modification:   %s", ctime(&sb.st_mtime));

    exit(EXIT_SUCCESS);
}
