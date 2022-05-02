#include "fillbuffer.h"
#include <stdio.h>

int fillbuffer(int anint, char *message, char **responseBuf, size_t *bufSize, void *(*resizeFunc)(void *ptr, size_t newSize)) {

  int bufferLength;

  // Doesn't work.

//  bufLen = sprintf(*responseBuf, "In C.fillbuffer:  anint: %d;  message: %s", anint, message);

  // Does work.

  char *responseBuf2 = responseBuf;
  bufferLength = sprintf(responseBuf2, "In C.fillbuffer:  anint: %d;  message: %s", anint, message);
  *bufSize = (size_t)bufferLength;

  // Try resizing buffer.

  void *ptr;
  size_t newSize = 5000;

  // *resizeFunc(*ptr, newSize);

  bufferLength = sprintf((char *)ptr, "#2 In C.fillbuffer:  anint: %d;  message: %s", anint, message);
  *bufSize = (size_t)bufferLength;

  return 0;

}
