#include "fillbuffer.h"
#include <stdio.h>

// int fillbuffer(int anint, char *message, char **responseBuf, size_t *bufSize, void *(*resizeFunc)(void *ptr, size_t newSize)) {

int fillbuffer(int anint, char *amessage, char **responseBuf, size_t *bufSize, void *(*resizeFunc)(void *ptr, size_t newSize)) {
  int bufferLength;

  // Doesn't work.

//  bufLen = sprintf(*responseBuf, "In C.fillbuffer:  anint: %d;  amessage: %s", anint, amessage);

  // Does work.

  char *responseBuf2 = responseBuf;
  bufferLength = sprintf(responseBuf2, "In C.fillbuffer:  anint: %d;  amessage: %s", anint, amessage);
  *bufSize = (size_t)bufferLength;

  void *ptr;
  size_t newSize = 5000;

//  *resizeFunc(*ptr, newSize);

  bufferLength = sprintf((char *)ptr, "#2 In C.fillbuffer:  anint: %d;  amessage: %s", anint, amessage);
  *bufSize = (size_t)bufferLength;

  return 0;

}
