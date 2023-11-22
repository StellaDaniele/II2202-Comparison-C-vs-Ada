#include <stdio.h>
#include <stdlib.h>

struct My_Type {
    int data;
};

void useMemory() {
    // Memory is dynamically allocated
    struct My_Type *mem = (struct My_Type *)malloc(sizeof(struct My_Type));
    
    if (mem != NULL) {
        mem->data = 42;
        printf("Data: %d\n", mem->data);
        // Memory needs to be explicitly freed
        //free(mem);
    } else {
        // Handle allocation failure
        printf("Memory allocation failed\n");
    }
}

int main() {
    useMemory();
    return 0;
}