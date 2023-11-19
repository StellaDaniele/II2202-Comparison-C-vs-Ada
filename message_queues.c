#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/msg.h>

#define MESSAGE_SIZE 256

// Define a structure for the message
struct msg_buffer {
    long msg_type;
    char msg_text[MESSAGE_SIZE];
};

int main() {
    int msgid;
    pid_t pid;
    struct msg_buffer message;

    // Create a unique key for the message queue
    key_t key = ftok("/tmp", 'a');
    if (key == -1) {
        perror("ftok");
        exit(EXIT_FAILURE);
    }

    // Create or open the message queue
    msgid = msgget(key, IPC_CREAT | 0666);
    if (msgid == -1) {
        perror("msgget");
        exit(EXIT_FAILURE);
    }

    // Fork a child process
    pid = fork();

    if (pid == -1) {
        perror("fork");
        exit(EXIT_FAILURE);
    } else if (pid > 0) {
        // Parent process (sender)
        printf("Parent process sending message to the queue\n");

        // Set the message type to 1
        message.msg_type = 1;

        // Input the message
        printf("Enter message: ");
        fgets(message.msg_text, MESSAGE_SIZE, stdin);

        // Send the message to the queue
        if (msgsnd(msgid, &message, sizeof(message.msg_text), 0) == -1) {
            perror("msgsnd");
            exit(EXIT_FAILURE);
        }

        // Wait for the child to finish
        wait(NULL);
    } else {
        // Child process (receiver)
        sleep(1); // Wait for the parent to send the message

        // Receive the message from the queue
        if (msgrcv(msgid, &message, sizeof(message.msg_text), 1, 0) == -1) {
            perror("msgrcv");
            exit(EXIT_FAILURE);
        }

        printf("Child process received message: %s", message.msg_text);
    }

    // Remove the message queue
    if (msgctl(msgid, IPC_RMID, NULL) == -1) {
        perror("msgctl");
        exit(EXIT_FAILURE);
    }

    return 0;
}
