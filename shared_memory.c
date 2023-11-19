#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/ipc.h>
#include <sys/shm.h>

#define SHM_SIZE 1024

int main() {
    int shmid;
    key_t key = 1234;  // Unique key for the shared memory segment

    // Create a shared memory segment
    if ((shmid = shmget(key, SHM_SIZE, IPC_CREAT | 0666)) < 0) {
        perror("shmget");
        exit(EXIT_FAILURE);
    }

    // Attach the shared memory segment
    char *shm_ptr = shmat(shmid, NULL, 0);
    if (shm_ptr == (char *)-1) {
        perror("shmat");
        exit(EXIT_FAILURE);
    }

    // Fork a child process
    pid_t pid = fork();

    if (pid == -1) {
        perror("fork");
        exit(EXIT_FAILURE);
    } else if (pid > 0) {
        // Parent process
        printf("Parent process writing to shared memory\n");
        snprintf(shm_ptr, SHM_SIZE, "Hello from the parent process");
        wait(NULL); // Wait for the child to finish
    } else {
        // Child process
        sleep(1); // Wait for the parent to write to shared memory
        printf("Child process reading from shared memory: %s\n", shm_ptr);

        // Detach the shared memory segment
        if (shmdt(shm_ptr) == -1) {
            perror("shmdt");
            exit(EXIT_FAILURE);
        }
    }

    // Remove the shared memory segment (optional)
    if (shmctl(shmid, IPC_RMID, NULL) == -1) {
        perror("shmctl");
        exit(EXIT_FAILURE);
    }

    return 0;
}
