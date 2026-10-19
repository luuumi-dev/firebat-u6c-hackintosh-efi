/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20251212 (64-bit version)
 * Copyright (c) 2000 - 2025 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of /Users/Shared/build/antigravity/scratch/rdna3-driver/hardware/efi_firebat_u6c_simplify/EFI/OC/ACPI/SSDT-RMNE.aml
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x000000F0 (240)
 *     Revision         0x02
 *     Checksum         0x37
 *     OEM ID           "ZPSS"
 *     OEM Table ID     "RMNE"
 *     OEM Revision     0x00001000 (4096)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20240927 (539232551)
 */
DefinitionBlock ("", "SSDT", 2, "ZPSS", "RMNE", 0x00001000)
{
    Device (RMNE)
    {
        Name (_ADR, Zero)  // _ADR: Address
        Name (_HID, "NULE0000")  // _HID: Hardware ID
        Name (MAC, Buffer (0x06)
        {
             0xB4, 0x81, 0xC1, 0x24, 0x07, 0xC6               // ...$..
        })
        Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
        {
            If ((Arg2 == Zero))
            {
                Return (Buffer (One)
                {
                     0x03                                             // .
                })
            }

            Return (Package (0x0A)
            {
                "built-in", 
                Buffer (One)
                {
                     0x01                                             // .
                }, 

                "IOName", 
                "ethernet", 
                "name", 
                Buffer (0x09)
                {
                    "ethernet"
                }, 

                "model", 
                Buffer (0x15)
                {
                    "RM-NullEthernet-1001"
                }, 

                "device_type", 
                Buffer (0x09)
                {
                    "ethernet"
                }
            })
        }

        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            If (_OSI ("Darwin"))
            {
                Return (0x0F)
            }
            Else
            {
                Return (Zero)
            }
        }
    }
}

