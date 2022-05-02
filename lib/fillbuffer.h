#ifndef _FILLBUFFER_H
#define _FILLBUFFER_H

#include <stddef.h>
int fillbuffer(int anint, char *message, char **responseBuf, size_t *bufSize, void *(*resizeFunc)(void *ptr, size_t newSize));
#endif
