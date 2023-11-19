#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

#define NUM_THREADS 5

pthread_mutex_t myMutex = PTHREAD_MUTEX_INITIALIZER;

void* sharedResourceAccess(void* arg) {
    pthread_mutex_lock(&myMutex);
    // Critical section: Access shared resource
    // ...
    pthread_mutex_unlock(&myMutex);
    pthread_exit(NULL);
}

int main() {
    pthread_t threads[NUM_THREADS];
    // Create threads and perform shared resource access
    // ...
    return 0;
}
