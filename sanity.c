#include "types.h"
#include "user.h"

void yield();		/* forward decleration. */

static int alive = 3;

void
loop_child() {
    for (;;) {			/* TODO: sleep for 1/2 second?? */
        sleep(500);
    }
}

void
loop_parent(int pids[]) {
    int child;
    char buf[20];
    int do2;

    while (alive > 0) {
        do2 = 1;
        printf(2, "Enter a child id (0-2):\n");
        gets(buf, 20);
        switch(buf[0]) {
        case '0': child = 0; break;
        case '1': child = 1; break;
        case '2': child = 2; break;
        default: /* printf(2, "in default\n"); */ do2 = 0; break;
        }
        if (pids[child] == -1) {
            do2 = 0;
            printf(2, "process already dead.\n");
        }
        if (do2) {
            printf(2, "Which signal to send: \n");
            gets(buf, 20);
            if (buf[1] == 10) {
                switch(buf[0]) {
                case '0': sigsend(pids[child], 0); pids[child] = -1; wait(); break;
                case '1': sigsend(pids[child], 1); break;
                case '2': sigsend(pids[child], 2); break;
                case '3': sigsend(pids[child], 3); break;
                case '4': sigsend(pids[child], 4); break;
                }
            }
        }
        sleep(50);		/* return to the scheduler, so the
                                   process could be notified about
                                   any pending SIGCHLDs. */
    }
    exit();
}

void
mySigChld() {
    alive--;
    /* printf(2, "DEBUG: inside mySigChld. alive=%d\n", alive); */
}
void
sig4() {
    printf(2, "ouch %d\n", getpid());
}

int
main() {
    int pids[3];
    /* int ppid = getpid(); */

    int cpid, i;
    for (i = 0; i < 3; i++) {   /* fixme: 3 */
        if ((cpid = fork()) == 0) {
            /* printf(2, "child %d inside loop: pid=%d\n", i, getpid()); */
            signal(4, &sig4);
            loop_child();
            /* printf(2, "after loop_child (should NEVER print) %d", getpid()); */
        }
        pids[i] = cpid;
    }
    signal(3, &mySigChld);
    loop_parent(pids);
    return 0;
}
