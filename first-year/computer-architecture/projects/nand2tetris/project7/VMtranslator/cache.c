#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "cache.h"

call_node *add_call_to_cache(call_node *calls_list, call_node call) {
    if (calls_list == NULL) {
        // the cache is empty
        calls_list = (call_node *) malloc(sizeof(call_node));

        strcpy(calls_list->function_name, call.function_name);
        calls_list->args_num = call.args_num;
        calls_list->next = NULL;
    } else {
        // the cache is not empty - iterate and add at the end of the list
        call_node *calls_list_iterator = calls_list;

        while (calls_list_iterator -> next != NULL) {
            calls_list_iterator = calls_list_iterator->next;
        }

        calls_list_iterator->next = (call_node *) malloc(sizeof(call_node));
        strcpy(calls_list_iterator->next->function_name, call.function_name);
        calls_list_iterator->next->args_num = call.args_num;
        calls_list_iterator->next->next = NULL;
    }

    return calls_list;
}

int is_call_in_cache(call_node *calls_list, call_node call) {
    call_node *calls_list_iterator = calls_list;
    int found = 0;

    while (!found && calls_list_iterator != NULL) {
        if (strcmp(calls_list_iterator->function_name, call.function_name) == 0
            && calls_list_iterator->args_num == call.args_num)
            found = 1;
        else calls_list_iterator = calls_list_iterator->next;
    }

    return found;
}