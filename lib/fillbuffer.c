#include "fillbuffer.h"
#include <stdio.h>

// int fillbuffer(int anint, char *message, char **responseBuf, size_t *bufSize, void *(*resizeFunc)(void *ptr, size_t newSize)) {

void fillbuffer(int anint, char *amessage, char **responseBuf, size_t *bufSize) {
  int bufLen;
  bufLen = sprintf(**responseBuf, "In C.fillbuffer:  anint: %d;  amessage: %s", anint, amessage);
  *bufSize = (size_t)bufLen;
}
