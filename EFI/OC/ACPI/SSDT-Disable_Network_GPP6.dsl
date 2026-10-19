/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20251212 (64-bit version)
 * Copyright (c) 2000 - 2025 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of /Users/Shared/EFI/EFI/OC/ACPI/SSDT-Disable_Network_GPP6.aml
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x000000D4 (212)
 *     Revision         0x02
 *     Checksum         0xBF
 *     OEM ID           "ZPSS"
 *     OEM Table ID     "DNET"
 *     OEM Revision     0x00000000 (0)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20240927 (539232551)
 */
DefinitionBlock ("", "SSDT", 2, "ZPSS", "DNET", 0x00000000)
{
    External (_SB_.PCI0.GPP6.WLAN, DeviceObj)

    Method (\_SB.PCI0.GPP6.WLAN._DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
    {
        If ((!Arg2 || (_OSI ("Darwin") == Zero)))
        {
            Return (Buffer (One)
            {
                 0x03                                             // .
            })
        }

        Return (Package (0x0A)
        {
            "name", 
            Buffer (0x09)
            {
                "#network"
            }, 

            "IOName", 
            "#display", 
            "class-code", 
            Buffer (0x04)
            {
                 0xFF, 0xFF, 0xFF, 0xFF                           // ....
            }, 

            "vendor-id", 
            Buffer (0x04)
            {
                 0xFF, 0xFF, 0x00, 0x00                           // ....
            }, 

            "device-id", 
            Buffer (0x04)
            {
                 0xFF, 0xFF, 0x00, 0x00                           // ....
            }
        })
    }
}

