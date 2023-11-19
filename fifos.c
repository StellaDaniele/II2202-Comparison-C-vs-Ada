#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#define FIFO_NAME "myfifo"
#define BUFFER_SIZE 256

int main() {
    int fifo_fd;
    pid_t pid;
    char buffer[BUFFER_SIZE];

    // Create the named pipe (FIFO)
    if (mkfifo(FIFO_NAME, 0666) == -1) {
        perror("mkfifo");
        exit(EXIT_FAILURE);
    }

    // Fork a child process
    pid = fork();

    if (pid == -1) {
        perror("fork");
        exit(EXIT_FAILURE);
    } else if (pid > 0) {
        // Parent process
        printf("Parent process writing to the named pipe\n");

        // Open the named pipe for writing
        fifo_fd = open(FIFO_NAME, O_WRONLY);
        if (fifo_fd == -1) {
            perror("open");
            exit(EXIT_FAILURE);
        }

        write(fifo_fd, "Hello from the parent process", sizeof("Hello from the parent process"));

        close(fifo_fd);

        // Wait for the child to finish
        wait(NULL);
    } else {
        // Child process
        printf("Child process reading from the named pipe\n");

        // Open the named pipe for reading
        fifo_fd = open(FIFO_NAME, O_RDONLY);
        if (fifo_fd == -1) {
            perror("open");
            exit(EXIT_FAILURE);
        }

        read(fifo_fd, buffer, BUFFER_SIZE);
        printf("Message from parent: %s\n", buffer);

        close(fifo_fd);
    }

    // Remove the named pipe (FIFO)
    if (unlink(FIFO_NAME) == -1) {
        perror("unlink");
        exit(EXIT_FAILURE);
    }

    return 0;
}
