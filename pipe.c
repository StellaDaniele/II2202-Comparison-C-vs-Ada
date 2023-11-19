#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#define BUFFER_SIZE 256

int main() {
    int pipe_fd[2]; // 0 for reading, 1 for writing
    pid_t pid;
    char buffer[BUFFER_SIZE];

    // Create a pipe
    if (pipe(pipe_fd) == -1) {
        perror("pipe");
        exit(EXIT_FAILURE);
    }

    // Fork a child process
    pid = fork();

    if (pid == -1) {
        perror("fork");
        exit(EXIT_FAILURE);
    } else if (pid > 0) {
        // Parent process
        close(pipe_fd[0]); // Close the reading end

        printf("Parent process writing to the pipe\n");
        write(pipe_fd[1], "Hello from the parent process", sizeof("Hello from the parent process"));

        close(pipe_fd[1]); // Close the writing end

        // Wait for the child to finish
        wait(NULL);
    } else {
        // Child process
        close(pipe_fd[1]); // Close the writing end

        printf("Child process reading from the pipe\n");
        read(pipe_fd[0], buffer, BUFFER_SIZE);
        printf("Message from parent: %s\n", buffer);

        close(pipe_fd[0]); // Close the reading end
    }

    return 0;
}
