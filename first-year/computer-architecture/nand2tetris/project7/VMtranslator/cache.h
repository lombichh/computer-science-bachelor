// struct used to create the list of calls
typedef struct call_node {
    char function_name[256];
    int args_num;
    struct call_node *next;
} call_node;

// add a new call to the calls_list cache
call_node *add_call_to_cache(call_node *calls_list, call_node call);

// returns true if call is in calls_list cache, false otherwise
int is_call_in_cache(call_node *calls_list, call_node call);