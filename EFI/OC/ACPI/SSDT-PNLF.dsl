/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20251212 (64-bit version)
 * Copyright (c) 2000 - 2025 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of /Users/Shared/EFI/EFI/OC/ACPI/SSDT-PNLF.aml
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x00000095 (149)
 *     Revision         0x02
 *     Checksum         0xEA
 *     OEM ID           "ZPSS"
 *     OEM Table ID     "PNLF"
 *     OEM Revision     0x00000000 (0)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20240927 (539232551)
 */
DefinitionBlock ("", "SSDT", 2, "ZPSS", "PNLF", 0x00000000)
{
    External (_SB_.PCI0.GP17.VGA_, DeviceObj)

    Device (\_SB.PCI0.GP17.VGA.PNLF)
    {
        Name (_HID, EisaId ("APP0002"))  // _HID: Hardware ID
        Name (_CID, "backlight")  // _CID: Compatible ID
        Name (_UID, 0x13)  // _UID: Unique ID
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            If (_OSI ("Darwin"))
            {
                Return (0x0B)
            }
            Else
            {
                Return (Zero)
            }
        }
    }
}

