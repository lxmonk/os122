#include "user.h"

int
main() {
    int pids[3];
    int ppid = getpid();
    int cpid, i;

    for (i = 0; i < 3; i++) {
        if ((cpid = fork()) == 0) {
            signal(4, &sig4);
            loop_child();
        }
        pids[i] = cpid;
    }

    loop_parent();
    return 0;
}

void
loop_child() {
    for (;;) {
        sleep(1);
    }
}

void
loop_parent() {
    int alive = 3;
    char buf;

    while (alive>0) {
        cprintf("Enter a child id (0-2): ");
        gets(&buf, 1);		/* we got here */
    }
}

void
sig4() {
    cprintf("ouch %d\n", getpid());
}
