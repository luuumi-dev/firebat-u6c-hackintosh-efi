// ue200reset: software "replug" of the TP-Link UE200 (2357:0602) via USBDeviceReEnumerate.
// build: clang -o ue200reset ue200reset.c -framework IOKit -framework CoreFoundation
#include <CoreFoundation/CoreFoundation.h>
#include <IOKit/IOKitLib.h>
#include <IOKit/IOCFPlugIn.h>
#include <IOKit/usb/IOUSBLib.h>
#include <stdio.h>

int main(void)
{
   CFMutableDictionaryRef m = IOServiceMatching(kIOUSBDeviceClassName);
   int vid = 0x2357, pid = 0x0602;
   CFNumberRef v = CFNumberCreate(NULL, kCFNumberIntType, &vid), p = CFNumberCreate(NULL, kCFNumberIntType, &pid);
   CFDictionarySetValue(m, CFSTR(kUSBVendorID), v);
   CFDictionarySetValue(m, CFSTR(kUSBProductID), p);
   io_service_t svc = IOServiceGetMatchingService(kIOMainPortDefault, m);
   if (!svc) { fprintf(stderr, "UE200 not enumerated\n"); return 2; }
   IOCFPlugInInterface **plug = NULL; SInt32 score;
   if (IOCreatePlugInInterfaceForService(svc, kIOUSBDeviceUserClientTypeID, kIOCFPlugInInterfaceID, &plug, &score) || !plug) {
      fprintf(stderr, "plugin failed\n"); return 3;
   }
   IOUSBDeviceInterface **dev = NULL;
   (*plug)->QueryInterface(plug, CFUUIDGetUUIDBytes(kIOUSBDeviceInterfaceID), (LPVOID *)&dev);
   (*plug)->Release(plug);
   if (!dev) { fprintf(stderr, "no device interface\n"); return 4; }
   IOReturn r = (*dev)->USBDeviceOpenSeize(dev);
   if (r) fprintf(stderr, "open: 0x%x\n", r);
   r = (*dev)->USBDeviceReEnumerate(dev, 0);
   printf("reenumerate -> 0x%x\n", r);
   (*dev)->USBDeviceClose(dev);
   (*dev)->Release(dev);
   return r ? 5 : 0;
}
