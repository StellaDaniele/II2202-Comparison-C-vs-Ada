#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

void *thread_function(void *arg) {
    int thread_arg = *((int *)arg);
    printf("Hello from thread %d\n", thread_arg);
    pthread_exit(NULL);
}

int main() {
    pthread_t thread_id;
    int thread_arg = 1;

    if (pthread_create(&thread_id, NULL, thread_function, &thread_arg) != 0) {
        fprintf(stderr, "Error creating thread\n");
        exit(EXIT_FAILURE);
    }

    // Wait for the thread to finish
    pthread_join(thread_id, NULL);

    printf("Main thread exiting\n");

    return 0;
}
