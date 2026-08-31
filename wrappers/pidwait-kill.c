// Wait for a process to exit (via pidfd), then kill another process.
// Usage: pidwait-kill <watch_pid> <kill_pid>
#include <poll.h>
#include <signal.h>
#include <stdlib.h>
#include <sys/syscall.h>
#include <unistd.h>

int main(int argc, char *argv[]) {
    if (argc != 3) return 1;
    int pidfd = (int)syscall(SYS_pidfd_open, atoi(argv[1]), 0);
    if (pidfd < 0) return 1;
    struct pollfd pfd = { .fd = pidfd, .events = POLLIN };
    poll(&pfd, 1, -1);
    kill(atoi(argv[2]), SIGKILL);
    return 0;
}
