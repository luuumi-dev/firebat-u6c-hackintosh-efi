# Firebat U6C (AMD Ryzen 7 H 255) Hackintosh — OpenCore EFI

[![macOS](https://img.shields.io/badge/macOS-Sonoma%2014.8.x-success?logo=apple&logoColor=white)](https://www.apple.com/macos/sonoma/)
[![OpenCore](https://img.shields.io/badge/OpenCore-1.0.x-blue?logo=dependabot&logoColor=white)](https://github.com/acidanthera/OpenCorePkg)

Fully configured and verified **OpenCore EFI** for the **Firebat U6C** laptop powered by the **AMD Ryzen 7 H 255** (Zen 4 Hawk Point APU) and integrated **AMD Radeon 780M (RDNA 3 / GFX1103)** running **macOS Sonoma 14.8.x**.

---

## 💻 Hardware Specifications

| Component | Model / Specs |
|---|---|
| **Laptop Model** | Firebat U6C |
| **Processor** | AMD Ryzen 7 H 255 (8 Cores / 16 Threads, Zen 4 Hawk Point) |
| **Integrated Graphics** | AMD Radeon 780M (RDNA 3 / GFX1103, 12 CUs) |
| **Display** | 16.0" IPS, 2560x1600 @ 120Hz (eDP native scanout) |
| **RAM** | DDR5 5600MHz |
| **Storage** | 2x M.2 NVMe PCIe 4.0 SSDs (ADATA SX6000LNP + HS-SSD-A4000) |
| **USB Controllers** | AMD Promontory/Hawk Point xHCI (`1022:15b9`, `1022:15ba`, `1022:15c0`, `1022:15c1`) |
| **Touchpad & Keyboard** | I2C HID Multitouch Touchpad + PS/2 Internal Keyboard |
| **Network (Ethernet)** | TP-Link UE200 USB 10/100 Ethernet (Realtek RTL8152B) |
| **Network (Wi-Fi)** | TP-Link TL-WN725N USB Wi-Fi (Realtek RTL8188EUS) / Phone USB Tethering |

---

## 📊 Status of Components

| Feature | Status | Notes |
|---|---|---|
| **UEFI Boot** | ✅ Working | Clean OpenCore 1.0.x bootloader |
| **Display (eDP)** | ✅ Working | Native 2560x1600 @ 120Hz resolution |
| **Keyboard** | ✅ Working | `VoodooPS2Controller.kext` |
| **Touchpad** | ✅ Working | `VoodooI2C.kext` + `VoodooI2CHID.kext` (Gestures supported) |
| **Audio** | ✅ Working | AppleALC / AppleMCEReporterDisabler |
| **Power Management** | ✅ Working | CPU power states handled via VirtualSMC |
| **USB 2.0 / USB 3.0** | ✅ Working | Native AppleUSBXHCIPCI with `SSDT-USB-Reset.aml` |
| **Wired Network (UE200)** | ✅ Working | Auto-reconnected via `ue200watch` daemon |
| **Phone Tethering** | ✅ Working | Native AppleUSBEthernet (iPhone) / `HoRNDIS.kext` (Android) |
| **3D Hardware Acceleration** | ⏳ In Progress | Native RDNA3 Metal driver in active development ([see driver repository](https://github.com/luuumi-dev/amd-rdna3-macos-driver)) |

---

## 🛠️ Key OpenCore Configuration Highlights

### 1. ACPI Patches
* **`SSDT-USB-Reset.aml`**: Disables the problematic internal Sonix webcam on `XHC1.RHUB` on Darwin, eliminating the 60-second `IOUSBHostInterface` hang during boot while leaving `XHC0` (USB ports, card reader, dongles) completely uninhibited.
* **`SSDT-EC.aml`**: Embedded controller fake device for macOS power management.
* **`SSDT-CPUR.aml`**: Injects missing CPU processor objects for modern AMD Zen 4 architectures.
* **`SSDT-RMNE.aml`**: NullEthernet device injecting `en0` for Apple ID and App Store functionality.

### 2. Kernel Extensions (Kexts)
* **`Lilu.kext`** (v1.7.3): Foundation kernel patcher.
* **`AMFIPass.kext`** (v1.4.1): Injected directly after Lilu to bypass AMFI entitlement restrictions on macOS Sonoma 14.4+ for third-party extensions.
* **`VirtualSMC.kext`**: SMC emulation for AMD.
* **`VoodooI2C.kext` & `VoodooI2CHID.kext`**: Multitouch touchpad support.
* **`VoodooPS2Controller.kext`**: Built-in keyboard support.
* **`HoRNDIS.kext`**: USB tethering from Android devices.
* **`RtWlanU.kext`**: Realtek RTL8188EUS wireless support.

### 3. NVRAM & Boot Arguments
```text
boot-args: -v keepsyms=1 debug=0x100 msgbuf=1048576 revpatch=cpuname,sbvmm ipc_control_port_options=0 amfi=0x80 amfi_get_out_of_my_way=1 -amfipassbeta
csr-active-config: <7F 08 00 00> (0x87F - System Integrity Protection fully customized for kernel extensions)
```

---

## 🌐 Network Auto-Recovery Daemon (`ue200watch`)

Included in `tools/ue200/` is an automated watchdog daemon:
* Continuously monitors default gateway connectivity.
* If a packet stall occurs, it programmatically cycles the USB PHY via [`ue200reset.c`](tools/ue200/ue200reset.c) and bounces DHCP.
* Eliminates the need to physically unplug and replug the adapter.

---

## 👥 Credits & Acknowledgments
* **AI Core Engineers:** Anthropic Claude & Google DeepMind Gemini (Antigravity).
* **OpenCore:** [Acidanthera Team](https://github.com/acidanthera).
* **AMD Vanilla Patches:** AMD-OSX community.
