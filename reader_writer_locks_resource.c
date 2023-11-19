#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

pthread_rwlock_t myRWLock = PTHREAD_RWLOCK_INITIALIZER;

void* readerThread(void* arg) {
    pthread_rwlock_rdlock(&myRWLock);
    // Read from shared resource
    // ...
    pthread_rwlock_unlock(&myRWLock);
    pthread_exit(NULL);
}

void* writerThread(void* arg) {
    pthread_rwlock_wrlock(&myRWLock);
    // Write to shared resource
    // ...
    pthread_rwlock_unlock(&myRWLock);
    pthread_exit(NULL);
}

int main() {
    pthread_t threads[NUM_THREADS];
    // Create threads and perform shared resource access
    // ...
    return 0;
}
