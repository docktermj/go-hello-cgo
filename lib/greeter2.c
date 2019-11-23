#include "greeter2.h"
#include <stdio.h>

int greet2(struct Greetee *g, char *out) {
    int n;

    n = sprintf(out, "Greetings3, %s from %d! We come in peace :)", g->name, g->year);

    return n;
}
