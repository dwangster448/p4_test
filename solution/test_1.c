#include "types.h"
#include "stat.h"
#include "user.h"
#include "pstat.h"
#include "test_helper.h"

 //#include <stdio.h>

int
main(int argc, char* argv[])
{
    struct pstat ps;
    printf(1, "test_1 LINE 13\n");
    int my_idx = find_my_stats_index(&ps);
    printf(1, "test_1 LINE 14\n");
    ASSERT(my_idx != -1, "Could not get process stats from pgetinfo");

    ASSERT(ps.inuse[my_idx], "My slot in the ptable is not in use!");

    ASSERT(ps.tickets[my_idx] == DEFAULT_TICKETS, "My ticekts (%d) does not match \
            the default number of tickets (%d)", ps.tickets[my_idx], DEFAULT_TICKETS);

    test_passed();

    exit();
}
