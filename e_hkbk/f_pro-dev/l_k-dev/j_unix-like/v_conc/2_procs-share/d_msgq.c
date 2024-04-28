#include <stdio.h>
#include <stdlib.h>
#include <mqueue.h>

int main() {
    mqd_t mq;
    struct mq_attr attr;
    attr.mq_maxmsg = 10;
    attr.mq_msgsize = 20;

    mq = mq_open("/example_queue", O_CREAT | O_RDWR, 0666, &attr);

    mq_send(mq, "Hello, message queue!", 20, 0);

    mq_close(mq);
    mq_unlink("/example_queue");

    return 0;
}
