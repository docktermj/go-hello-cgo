package main

/*
#cgo CFLAGS: -g -Wall
#include <stdlib.h>
#include <stdio.h>
#include "fillbuffer.h"
#include "greeter.h"
#include "greeter2.h"
*/
import "C"
import (
	"fmt"
	"unsafe"
)

// Values updated via "go install -ldflags" parameters.

var programName string = "unknown"
var buildVersion string = "0.0.0"
var buildIteration string = "0"

func regreet() {
	name := C.CString("Gopher2")
	defer C.free(unsafe.Pointer(name))

	year := C.int(2018)

	g := C.struct_Greetee{
		name: name,
		year: year,
	}

	ptr := C.malloc(C.sizeof_char * 1024)
	defer C.free(unsafe.Pointer(ptr))

	size := C.greet2(&g, (*C.char)(ptr))

	b := C.GoBytes(ptr, size)
	fmt.Println(string(b))
}

func main() {

	fmt.Printf("Hello, world! from %s (main) version %s-%s\n", programName, buildVersion, buildIteration)

	name := C.CString("Gopher")
	defer C.free(unsafe.Pointer(name))

	year := C.int(2018)

	ptr := C.malloc(C.sizeof_char * 1024)
	defer C.free(unsafe.Pointer(ptr))

	size := C.greet(name, year, (*C.char)(ptr))

	b := C.GoBytes(ptr, size)
	fmt.Println(string(b))

	fmt.Println("and")

	regreet()

	// Test byte buffers and function callbacks.

	anint := C.int(2018)
	message := C.CString("Mike's message")
	bufferSize := 5000

	// Allocate a buffer.

	stringBuffer := make([]byte, bufferSize)
	//	stringBuffer := C.malloc(C.size_t(bufferSize))
	//	defer C.free(stringBuffer)

	// Make a pointer to the string buffer.

	stringBufferPointer := (*C.char)(unsafe.Pointer(&stringBuffer[0]))
	stringBufferLen := C.ulong(bufferSize)

	//	C.fillbuffer(anint, message, (*C.char)(unsafe.Pointer(&stringBuffer[0])), &stringBufferLen)
	C.fillbuffer(anint, message, (**C.char)(unsafe.Pointer(stringBufferPointer)), &stringBufferLen)
	fmt.Println(string(stringBuffer))
	fmt.Println(stringBufferLen)

}
