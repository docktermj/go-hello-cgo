#ifndef _GREETER2_H
#define _GREETER2_H

struct Greetee {
    const char *name;
    int year;
};

int greet2(struct Greetee *g, char *out);

#endif
